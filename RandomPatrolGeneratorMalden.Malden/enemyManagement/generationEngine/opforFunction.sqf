doGenerateFOBOrDestroyer = {
	//50% chance to generate destroyer or FOB
	if (random 100 <50) then 
	{
		_destroyerProb = 100;
		if (missionNameSpace getVariable ["enableDestroyerFOB", 1] == 1) then 
		{
			_destroyerProb = 50; 
		};
		if (missionNameSpace getVariable ["enableDestroyerFOB", 1] == 2) then 
		{
			_destroyerProb = 0; 
		};

		if (random 100 < (0+_destroyerProb)) then 
		{
			[] execVM 'enemyManagement\generationEngine\generateOpforFOB.sqf';

		} else 
		{
			//Add opfor destroyer
			_resultSearchLoc =  [] call searchLocationWithWaterDepth;
			if (_resultSearchLoc#1) then 
			{
				_pos = _resultSearchLoc#0;
				if (400 < initBlueforLocation distance _pos) then //Spawn at least at 400m from blufor
				{
					[_pos] execVM 'enemyManagement\generationEngine\generateDestroyer.sqf';
				};
			};
		};	
	};
};



generateFortifyArea = {
	/*
    fn_fortifyTown.sqf
    Fortifies a town adapting to its environment:
      - detects roads entering the area and blocks them
        (alternating: full barricade or chicane checkpoint with bunker)
      - garrisons buildings closest to the access points (upper floors prioritized)
      - checks that bunkers, static weapons, and guards do not spawn inside walls

    Execute on SERVER side only. Requires Arma 3 2.00+ (getRoadInfo).

    Parameters:
        0: ARRAY   - Town center [x,y] or [x,y,z]
        1: GROUP   - (optional) group of units to place (default: grpNull)
        2: NUMBER  - (optional) zone radius in meters (default: 150)
        3: STRING  - (optional) checkpoint static weapon, "" for none (default: "B_G_HMG_02_high_F")
        4: BOOL    - (optional) debug markers (default: false)
        5: BOOL    - (optional) true = deletes existing fortification and rebuilds it (default: false)

    Anti-duplicate:
        Each fortification is registered (missionNamespace variable "fortifyTown_zones").
        If the script is called again at roughly the same location (centers closer than half
        of the largest radius), NOTHING is recreated: the script returns existing objects
        and does not touch the provided group. A zone where all objects have been deleted
        (deleteVehicle) is no longer considered existing.

    Returns:
        ARRAY - all fortification objects (cleanup: { deleteVehicle _x } forEach _ret)

    Example:
        private _objs = [_basePosition, _outpostUnits, 150] call compile preprocessFileLineNumbers "fn_fortifyTown.sqf";
	*/

	if (!isServer) exitWith { [] };

	params [
		["_pos", [0,0,0], [[]]],
		["_group", grpNull, [grpNull]],
		["_radius", 150, [0]],
		["_staticClass", "B_G_HMG_02_high_F", [""]],
		["_debug", false, [false]],
		["_replace", false, [false]]
	];

	_pos = [_pos select 0, _pos select 1, 0];

	// ---------------------------------------------------------------------------
	// Anti-duplicate: atomic verification + registration (isNil = non-interruptible).
	// _objects is registered immediately by reference: it fills up as construction proceeds.
	// ---------------------------------------------------------------------------
	private _objects  = [];
	private _existing = [];

	isNil {
		// Ignore ghost zones where all objects have been deleted
		private _zones = (missionNamespace getVariable ["fortifyTown_zones", []]) select {
			count ((_x select 2) select { !isNull _x }) > 0
		};

		private _idx = _zones findIf {
			(_pos distance2D (_x select 0)) < (((_x select 1) max _radius) * 0.5)
		};

		if (_idx != -1) then {
			_existing = _zones select _idx;
			if (_replace) then {
				{
					{ deleteVehicle _x } forEach (crew _x); // static weapon gunners
					deleteVehicle _x;
				} forEach (_existing select 2);
				_zones deleteAt _idx;
				_existing = [];
			};
		};

		if (_existing isEqualTo []) then { _zones pushBack [_pos, _radius, _objects] };
		missionNamespace setVariable ["fortifyTown_zones", _zones];
	};

	if !(_existing isEqualTo []) exitWith { _existing select 2 };

	private _units = if (isNull _group) then { [] } else { (units _group) select { alive _x } };

	// ---------------------------------------------------------------------------
	// Local functions
	// ---------------------------------------------------------------------------

	// Lightweight object placed on the ground, without simulation (remains destructible)
	private _fnc_place = {
		params ["_class", "_p", "_dir"];
		if (surfaceIsWater _p) exitWith { objNull };
		private _o = createVehicle [_class, _p, [], 0, "CAN_COLLIDE"];
		_o setDir _dir;
		_o setPosATL [_p select 0, _p select 1, 0];
		_o setVectorUp (surfaceNormal _p);
		_o enableSimulationGlobal false;
		_objects pushBack _o;
		_o
	};

	// Takes the next available unit from the group
	private _fnc_take = {
		if (_units isEqualTo []) then { objNull } else { _units deleteAt 0 };
	};

	// Places a unit in a fixed position (stays in place but can shoot/turn)
	private _fnc_post = {
		params ["_p", "_dir"];
		private _u = call _fnc_take;
		if (isNull _u) exitWith {};
		_u setPos _p;
		_u setDir _dir;
		_u setUnitPos selectRandom ["UP","UP","MIDDLE"];
		_u disableAI "PATH";
		// setDir alone is often overwritten by AI: we also force looking outward
		_u doWatch ((_p getPos [100, _dir]) vectorAdd [0, 0, 1.5]);
	};

	// Clear position? Nothing above (roof, balcony) and no wall / object / building
	// within a radius _r: 1 vertical ray + 8 horizontal rays at 1.2 m from the ground.
	// Objects already placed by the script also count as obstacles.
	private _fnc_isFree = {
		params ["_p", "_r"];
		if (surfaceIsWater _p) exitWith { false };

		private _from = ATLToASL [_p select 0, _p select 1, 1.2];
		if (count (lineIntersectsSurfaces [_from, _from vectorAdd [0,0,5], objNull, objNull, true, 1, "GEOM", "NONE"]) > 0) exitWith { false };

		private _free = true;
		for "_a" from 0 to 315 step 45 do {
			private _to = _from vectorAdd [_r * sin _a, _r * cos _a, 0];
			if (count (lineIntersectsSurfaces [_from, _to, objNull, objNull, true, 1, "GEOM", "NONE"]) > 0) exitWith { _free = false };
		};
		_free
	};

	// Searches for the 1st clear position around _base (directions and distances tested in order)
	// Returns [] if nothing is valid
	private _fnc_findFree = {
		params ["_base", "_dirs", "_dists", "_r"];
		private _res = [];
		{
			private _d = _x;
			{
				private _p = _base getPos [_d, _x];
				if ([_p, _r] call _fnc_isFree) exitWith { _res = _p };
			} forEach _dirs;
			if (count _res > 0) exitWith {};
		} forEach _dists;
		_res
	};

	// Orients the bunker so its OPEN side faces toward the inside of the town
	// (the guard then looks outward, facing the sandbag wall).
	// Detection: 4 horizontal rays of 2 m from the center at 0.8 m from the ground;
	// the only side without obstacles is the opening. The location was already validated as clear
	// for 2.5 m, so only the bunker walls can be hit.
	private _fnc_orientBunker = {
		params ["_b", "_out"];
		private _fallbackOffset = 0; // set 180 if detection fails and the bunker is reversed
		private _atl = getPosATL _b;
		private _c   = ATLToASL [_atl select 0, _atl select 1, 0.8];

		private _open = [];
		{
			private _a  = _out + _x;
			private _to = _c vectorAdd [2 * sin _a, 2 * cos _a, 0];
			if (count (lineIntersectsSurfaces [_c, _to, objNull, objNull, true, 1, "GEOM", "NONE"]) == 0) then {
				_open pushBack _x;
			};
		} forEach [0, 90, 180, 270];

		// _open = offset (relative to _out) of the open side with the current dir
		private _newDir = if (count _open == 1) then {
			_out + 180 - (_open select 0)
		} else {
			_out + _fallbackOffset
		};
		_b setDir _newDir;
		_b setVectorUp (surfaceNormal _atl);
	};

	// Guard set back behind the barricade line, on a clear position
	private _fnc_postBehind = {
		params ["_rp", "_out"];
		private _p = [_rp, [_out + 180, _out + 150, _out + 210], [4, 6, 8], 0.8] call _fnc_findFree;
		if (count _p > 0) then { [_p, _out] call _fnc_post };
	};

	// ---------------------------------------------------------------------------
	// 1. Access road detection (outer ring, spaced at least 50 m apart)
	// ---------------------------------------------------------------------------
	private _entries = [];
	{
		private _info = getRoadInfo _x;
		if (_info isEqualTo [] || { _info select 2 } || { _info select 8 }) then { continue }; // pedestrian / bridge

		private _rp = getPosATL _x;
		if (_rp distance2D _pos < _radius * 0.75) then { continue };
		if (_entries findIf { (_x select 0) distance2D _rp < 50 } != -1) then { continue };

		// [position, road direction, width]
		_entries pushBack [_rp, (_info select 6) getDir (_info select 7), (_info select 1) max 3];
	} forEach (_pos nearRoads _radius);

	// Sorted by angle around the center: barricade / checkpoint alternation is thus balanced
	_entries = _entries apply { [_pos getDir (_x select 0), _x] };
	_entries sort true;
	_entries = _entries apply { _x select 1 };

	// ---------------------------------------------------------------------------
	// 2. Road blocking
	// ---------------------------------------------------------------------------
	{
		_x params ["_rp", "_rdir", "_w"];
		private _out    = _pos getDir _rp;      // "outward" direction
		private _across = _rdir + 90;           // perpendicular to the road
		private _half   = _w / 2;
		private _isCP   = (_forEachIndex mod 2 == 1) && { _w >= 5 };

		if (_isCP) then {
			// Chicane (2 offset blocks)
			{
				_x params ["_lat", "_along"];
				private _p = (_rp getPos [_lat, _across]) getPos [_along, _rdir];
				["Land_HBarrier_3_F", _p, _rdir] call _fnc_place;
			} forEach [[-(_half - 1.5), 0], [_half - 1.5, 8]];

			// Bunker: test both road shoulders at multiple distances, 2.5 m clear radius.
			// If no location is clear, no bunker (guard is posted back).
			private _bp = [_rp, [_across, _across + 180], [_half + 2.5, _half + 4, _half + 6, _half + 8], 2.5] call _fnc_findFree;
			if (count _bp > 0) then {
				private _bunker = ["Land_BagBunker_Small_F", _bp, _out] call _fnc_place;
				[_bunker, _out] call _fnc_orientBunker;
				[_bp, _out] call _fnc_post;
			} else {
				[_rp, _out] call _fnc_postBehind;
			};
			[_rp, _out] call _fnc_postBehind;

			// Static weapon: preferably opposite side to the bunker, 2 m clear radius.
			// Placed after the bunker, so it counts as an obstacle.
			if (_staticClass != "" && { count _units > 0 }) then {
				private _sp = [_rp, [_across + 180, _across], [_half + 2.5, _half + 4, _half + 6, _half + 8], 2] call _fnc_findFree;
				if (count _sp > 0) then {
					private _gun = createVehicle [_staticClass, _sp, [], 0, "CAN_COLLIDE"];
					_gun setDir _out;
					_gun setPosATL [_sp select 0, _sp select 1, 0];
					_objects pushBack _gun;
					(call _fnc_take) moveInGunner _gun;
				};
			};
		} else {
			// Full barricade: row of blocks across the road + razor wire in front
			private _n = (ceil (_w / 4.8)) max 1;
			for "_k" from 0 to (_n - 1) do {
				private _p = _rp getPos [(_k - (_n - 1) / 2) * 4.8, _across];
				["Land_HBarrier_5_F", _p, _rdir] call _fnc_place;
				["Land_Razorwire_F", _p getPos [3, _out], _rdir] call _fnc_place;
			};
			[_rp, _out] call _fnc_postBehind;
		};

		if (_debug) then {
			private _m = createMarker [format ["fort_%1_%2", _pos, _forEachIndex], _rp];
			_m setMarkerType (["mil_box", "mil_triangle"] select _isCP);
			_m setMarkerColor "ColorRed";
		};
	} forEach _entries;

	// ---------------------------------------------------------------------------
	// 3. Building garrison (closest to access points first)
	// ---------------------------------------------------------------------------
	if (_units isEqualTo []) exitWith { _objects };

	private _entryPos = _entries apply { _x select 0 };
	private _buildings = (nearestObjects [_pos, ["House"], _radius * 0.9, true]) select {
		alive _x && { count (_x buildingPos -1) > 0 }
	};

	private _sorted = _buildings apply {
		private _b = _x;
		[selectMin (_entryPos apply { _x distance2D _b }), _b]
	};
	_sorted sort true;

	private _perBuilding = 2;
	{
		if (_units isEqualTo []) exitWith {};
		private _b = _x select 1;

		// Positions sorted by descending altitude (upper floors / roofs first)
		private _bpos = (_b buildingPos -1) apply { [_x select 2, _x] };
		_bpos sort false;

		for "_k" from 0 to ((_perBuilding min count _bpos) - 1) do {
			private _u = call _fnc_take;
			if (isNull _u) exitWith {};
			_u setPos ((_bpos select _k) select 1);
			_u setDir (_pos getDir _b);
			_u setUnitPos selectRandom ["UP","UP","MIDDLE"];
			_u disableAI "PATH";
		};
	} forEach _sorted;

	// ---------------------------------------------------------------------------
	// 4. Group settings
	// ---------------------------------------------------------------------------
	if (!isNull _group) then {
		_group setBehaviour "AWARE";
		_group setCombatMode "RED";
		_group enableDynamicSimulation true;
		(units _group) apply { _objects pushBack _x }; //Add units to objects returned

	};

	_objects
};


spawnOccupiedCity = {
    params ["_trg"];

    // Déjà actif ? On sort. Verrou "busy" pour éviter les chevauchements.
    if (_trg getVariable ["spawned", false]) exitWith {};
    _trg setVariable ["spawned", true];
    _trg setVariable ["busy", true];

    private _pos      = getPos _trg;
    private _groups   = [];
    private _objects  = [];
    private _cleared  = _trg getVariable ["cleared", false];

    if (!_cleared) then {
        // Garnison
        private _nb = missionNamespace getVariable ["ambientOpforNumberOfGroups", 1];
        for "_i" from 1 to _nb do {
            private _grp = [selectRandom EnemyWaveLevel_6, _pos, east, "DefenseInfantry"] call doGenerateEnemyGroup;
            private _groupAfterGarrison = [_grp, getPos leader _grp, selectRandom [100, 150, 200], false] call doGarrison;

			//Add groups generated (garrison and patrol to saved groups)
			if (count _groupAfterGarrison != 0) then 
			{
				_groupAfterGarrison apply {_groups pushBackUnique _x}; 
			};
        };

        // Fortification
        private _outpost = [selectRandom EnemyWaveLevel_6, _pos, east, "DefenseInfantry"] call doGenerateEnemyGroup;
        _groups pushBack _outpost;

        private _before = [_pos, _outpost, 200] call generateFortifyArea;
        _objects append _before;
    };

    // Caisse de ravitaillement (sauf si déjà volée)
    if (!(_trg getVariable ["supplyTaken", false])) then {
        private _road = [_pos, 200] call BIS_fnc_nearestRoad;
        if (!isNull _road) then {
            private _box = createVehicle ["Land_PaperBox_open_full_F", getPos _road, [], 0, "NONE"];
            clearWeaponCargoGlobal _box;
            clearMagazineCargoGlobal _box;
            clearItemCargoGlobal _box;
            clearBackpackCargoGlobal _box;

            [
                _box,
                localize "STR_STEAL_SUPPLY",
                "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",
                "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",
                "(_this distance _target < 3)",
                "true",
                { params ["_target", "_caller"]; _caller playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1"; },
                {},
                {
                    params ["_object", "_caller"];
                    [500] call doIncrementVehicleSpawnCounter;
                    [] call shopRelatedReward;
                    deleteVehicle _object;
                },
                {},
                [], 5, 1000, false, false
            ] remoteExec ["BIS_fnc_holdActionAdd", 0, _box]; // JIP lié à l'objet

            _trg setVariable ["box", _box];
        };
    };

    _trg setVariable ["groups", _groups];
    _trg setVariable ["objects", _objects];
    _trg setVariable ["busy", false];
};


despawnOccupiedCity = {
    params ["_trg"];

    if (!(_trg getVariable ["spawned", false])) exitWith {};
    waitUntil { !(_trg getVariable ["busy", false]) };

    private _groups  = _trg getVariable ["groups", []];
    private _objects = _trg getVariable ["objects", []];
    private _box     = _trg getVariable ["box", objNull];

    // Zone nettoyée par les joueurs ? On ne la fera pas revenir.
    private _alive = 0;
    { _alive = _alive + ({ alive _x } count units _x) } forEach _groups;
    if (count _groups > 0 && { _alive == 0 }) then { _trg setVariable ["cleared", true] };

    // Caisse déjà volée (objet supprimé) ? Elle ne reviendra pas.
    if (isNull _box && { !isNil { _trg getVariable "box" } }) then {
        _trg setVariable ["supplyTaken", true];
    };

    // Suppression
    { { deleteVehicle _x } forEach (units _x); deleteGroup _x } forEach _groups;
    { { deleteVehicle _x } forEach (crew _x); deleteVehicle _x } forEach _objects;
    if (!isNull _box) then { deleteVehicle _box };

    _trg setVariable ["groups", []];
    _trg setVariable ["objects", []];
    _trg setVariable ["box", nil];
    _trg setVariable ["spawned", false];
};