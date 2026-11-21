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

	private _fortifiedZone = missionNamespace getVariable ["fortifyTown_zones", []];
	if (count _fortifiedZone != 0) then 
	{
		{
			//Remove fortified zone
			if ((getPos _trg) distance (_x#0) < 100) then 
			 {
				//systemChat format ["Fortified area %1 removed", getPos _trg];
				_fortifiedZone = _fortifiedZone - [_x];
			 };
		} foreach _fortifiedZone;
		missionNamespace setVariable ["fortifyTown_zones", _fortifiedZone];
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



// ============================================================
//  Auto-grouping of isolated units + unlock + attack order
//  Place in initServer.sqf (server only)
// ============================================================
doManageAggressiveMonsters = {

	if (!isServer) exitWith {};

	// --- Settings ---
	private _interval = 30;    // seconds between each check
	private _maxSize  = 10;    // maximum group size
	private _maxDist  = 1500;  // max distance to the nearest player to receive the attack order

	[_interval, _maxSize, _maxDist] spawn {
		params ["_interval", "_maxSize", "_maxDist"];

		// Moves all units of a group into a new OPFOR group, keeping its waypoints
		private _fnc_convertToEast = {
			params ["_oldGrp"];

			private _units = units _oldGrp select {alive _x};
			private _newGrp = createGroup [east, true];
			
			(_units) apply {_x enableSimulationGlobal true; _x addRating (rating _x)};

			_units joinSilent _newGrp;


			// Copy waypoints (index 0 is the automatic start waypoint, skip it)
			private _wps = waypoints _oldGrp;
			for "_i" from 1 to (count _wps - 1) do {
				private _wp  = _wps select _i;
				private _new = _newGrp addWaypoint [waypointPosition _wp, 0];
				_new setWaypointType (waypointType _wp);
				_new setWaypointBehaviour (waypointBehaviour _wp);
				_new setWaypointCombatMode (waypointCombatMode _wp);
				_new setWaypointSpeed (waypointSpeed _wp);
				_new setWaypointFormation (waypointFormation _wp);
				_new setWaypointTimeout (waypointTimeout _wp);
				_new setWaypointCompletionRadius (waypointCompletionRadius _wp);
				private _statements = waypointStatements _wp;
				if (count _statements == 2) then {
					_new setWaypointStatements _statements;
				};
			};

			// Remove the old (now empty) group
			if (count units _oldGrp == 0) then {deleteGroup _oldGrp};

			_newGrp
		};

		// Unlocks a unit (works for local and remote units)
		private _fnc_unlockUnit = {
			params ["_unit"];

			if (local _unit) then {
				_unit enableAI "PATH";
				_unit doFollow (leader _unit);
				_unit setUnitPos "AUTO";
			} else {
				// Unit is local to another machine (e.g. headless client)
				[_unit, "PATH"] remoteExec ["enableAI", _unit];
				[_unit, leader _unit] remoteExec ["doFollow", _unit];
				[_unit, "AUTO"] remoteExec ["setUnitPos", _unit];
			};
		};

		while {true} do {
			sleep _interval;

			// Safety check: doAttack must exist
			if (isNil "doAttack") then {
				diag_log "[AutoGroup] ERROR: function doAttack is not defined.";
				continue;
			};

			// Alive human players (headless clients excluded)
			private _players = (allPlayers - entities "HeadlessClient_F") select {alive _x};

			// AI groups that are neither BLUFOR nor civilian (no player inside, not empty)
			private _groups = allGroups select {
				private _alive = units _x select {alive _x};
				(count _alive > 0)
				&& {!(side _x in [west, civilian, sideLogic, sideEmpty, sideUnknown])}
				&& {({isPlayer _x} count _alive) == 0}
			};

			{
				private _grp = _x;
				if (isNull _grp) then {continue};

				// ---------- 0) Make sure the group is OPFOR ----------
				if (side _grp != east) then {
					_grp = [_grp] call _fnc_convertToEast;
				};

				private _members = units _grp select {alive _x};
				if (count _members == 0) then {continue};

				// ---------- 1) Merge isolated units ----------
				if (count _members == 1) then {
					private _unit = _members select 0;

					// Candidates: other isolated AI units (any side except BLUFOR/civilian)
					private _candidates = allUnits select {
						alive _x
						&& {!isPlayer _x}
						&& {_x != _unit}
						&& {!(side group _x in [west, civilian, sideLogic, sideEmpty, sideUnknown])}
						&& {count (units group _x select {alive _x}) == 1}
					};

					// Sort by distance, closest first
					_candidates = [_candidates, [], {_unit distance _x}, "ASCEND"] call BIS_fnc_sortBy;

					// Take at most (_maxSize - 1) units
					private _toJoin = _candidates select [0, _maxSize - 1];

					if (count _toJoin > 0) then {
						private _oldGroups = _toJoin apply {group _x};
						_toJoin joinSilent _grp;

						// Clean up groups that became empty
						{
							if (!isNull _x && {count units _x == 0}) then {deleteGroup _x};
						} forEach (_oldGroups arrayIntersect _oldGroups);
					};
				};

				// ---------- 2) Unlock all units of the group ----------
				{
					[_x] call _fnc_unlockUnit;
				} forEach (units _grp select {alive _x});

				// ---------- 3) Attack order ----------
				// A group already has a mission if it has more than the start waypoint
				if (count (waypoints _grp) > 1) then {continue};

				if (count _players == 0) then {continue};

				private _leader = leader _grp;
				if (isNull _leader) then {continue};

				// Nearest player
				private _sorted  = [_players, [], {_leader distance _x}, "ASCEND"] call BIS_fnc_sortBy;
				private _nearest = _sorted select 0;

				// Too far: no mission
				if (_leader distance _nearest > _maxDist) then {continue};

				[_grp, getPosATL _nearest] call doAttack;
				(units _grp) apply {_x enableSimulationGlobal true; _x addRating (rating _x)};

			} forEach _groups;
		};
	};
};


/*
    ============================================================================
    generateTurretBunker
    ----------------------------------------------------------------------------
    Finds a good defensive spot around a position, spawns a manned turret there
    (through doGenerateEnemyGroup) and surrounds it with sandbags.

    VARIETY
        - 11 different layouts (including round mini bunkers), picked among
          those compatible with the turret type
        - 6 wall styles, picked (weighted) per bunker among those available in
          the running game: SAND and GREEN sandbags, sandbags mixed with small
          Hesco, pure HESCO and HESCO_WALL. Each style mixes several segment
          lengths, so no two walls are identical
        - small random jitter on every segment (position and heading)
        - 0 to 2 props behind the bunker, picked in a pool (sack piles, crates,
          barrels, jerrycans, pallets, ammo / support boxes matching the turret
          side); never placed behind AT turrets (back-blast)

    SIZE ADAPTATION
        - the turret bounding box defines the bunker radius / wall extents
        - walls are a single layer, to keep the object count low

    PERFORMANCE
        - object dimensions are measured once, then cached in missionNamespace
          ("generateTurretBunker_dims")
        - cheap filters run before expensive ones in the position search
        - low object count: single-layer walls, one row, 0 to 2 props
        - walls and props have their simulation (physics) disabled: they become
          static, indestructible decor (walls stay simulated only if
          _destructible is true)
        - objects are planned first (pure math), then created in one pass

    PARAMETERS
        0: ARRAY | OBJECT | STRING | GROUP | LOCATION
                          - Center of the area to defend (position, object,
                            marker name, group or location). Mandatory: an
                            invalid position aborts instead of spawning at [0,0].
        1: STRING         - Turret classname (e.g. "O_HMG_01_high_F")
        2: STRING | SIDE  - (optional) Turret side. Accepts "opfor"/"east",
                            "blufor"/"west", "independent"/"indfor"/"greenfor",
                            "civilian", or a SIDE value.            [default: "opfor"]
        3: NUMBER         - (optional) Search radius in meters       [default: 150]
        4: NUMBER         - (optional) Firing direction 0-360.
                            -1 = facing away from the center         [default: -1]
        5: STRING         - (optional) Force a layout, "" = random   [default: ""]
                            Available layouts:
                              "HORSESHOE"        open front, 240 deg arc
                              "RING_ENTRANCE"    full ring with a rear entrance
                              "FLANKS"           two side arcs, front and rear open
                              "REAR_CRESCENT"    light cover behind the turret
                              "U_SHAPE"          straight walls: left, rear, right
                              "L_SHAPE"          straight walls: rear + one side
                              "CHEVRON"          V-shaped wall behind the turret
                              "WINGS"            two straight side walls only
                              "MINI_BUNKER"      round mini bunker, 2 layers, firing
                                                 opening at the front
                              "FORT_RING"        round mini bunker with a front
                                                 opening and a rear entrance
        6: BOOL           - (optional) Keep sandbags destructible. Costs more
                            performance (simulation stays enabled)  [default: false]

    RETURN
        GROUP - The group created by doGenerateEnemyGroup (grpNull on failure).
                Extra data stored on the group (getVariable):
                    "bunkerReady"  : true once the turret is placed and the
                                     sandbags are built
                    "bunkerTurret" : the turret object
                    "bunkerWalls"  : array of sandbag / prop objects
                    "bunkerLayout" : name of the layout used

    EXAMPLES
        private _grp = [getPos player, "O_HMG_01_high_F"] call generateTurretBunker;
        private _grp = [getMarkerPos "base", "B_Mortar_01_F", "blufor", 300] call generateTurretBunker;
        private _grp = [_pos, "O_static_AT_F", "opfor", 200, 90, "WINGS"] call generateTurretBunker;

    NOTES
        - Must run on the server.
        - Requires doGenerateEnemyGroup to be defined:
              [[className], position, side, "Turret"] call doGenerateEnemyGroup
          and to return the created group.
        - doGenerateEnemyGroup may create its units with a delay. The function
          handles it: from a scheduled environment it waits (max 10 s) and
          returns once everything is built; from an unscheduled one it returns
          the group immediately and finishes in the background (check the
          "bunkerReady" variable on the group).
        - Set generateTurretBunker_debug = true (missionNamespace) to trace
          every step in the RPT.
    ============================================================================
*/
generateTurretBunker = {
    params [
        ["_center",       [],       [[], objNull, "", grpNull, locationNull]],
        ["_className",    "",       [""]],
        ["_side",         "opfor",  ["", east]],
        ["_radius",       150,      [0]],
        ["_dir",          -1,       [0]],
        ["_layout",       "",       [""]],
        ["_destructible", false,    [true]]
    ];

    // Logging helpers: errors are always logged, traces only in debug mode
    private _debug    = missionNamespace getVariable ["generateTurretBunker_debug", false];
    private _logError = { diag_log format ["[generateTurretBunker] ERROR: %1", _this] };
    private _trace    = { if (_debug) then { diag_log format ["[generateTurretBunker] %1", _this] } };

    if (_debug) then {
        diag_log format ["[generateTurretBunker] start: center=%1 className=%2 side=%3 radius=%4 dir=%5 layout=%6", _center, _className, _side, _radius, _dir, _layout];
    };

    if (!isServer) exitWith { "must run on the server (isServer is false)" call _logError; grpNull };
    if (_className isEqualTo "") exitWith { "empty turret classname" call _logError; grpNull };
    if (isNil "doGenerateEnemyGroup") exitWith { "doGenerateEnemyGroup is not defined" call _logError; grpNull };

    // ------------------------------------------------------------------------
    // Input normalization
    // ------------------------------------------------------------------------
    // Resolve the center to a position (object, marker, group, location or array)
    switch (typeName _center) do {
        case "OBJECT":   { _center = getPosATL _center };
        case "STRING":   { _center = getMarkerPos _center };
        case "GROUP":    { _center = getPosATL (leader _center) };
        case "LOCATION": { _center = locationPosition _center };
    };

    // Refuse invalid positions instead of silently spawning everything at [0,0]
    // (anything within 1 m of the map origin is considered invalid too)
    if ((count _center) < 2 || {([_center # 0, _center # 1, 0] distance2D [0, 0, 0]) < 1}) exitWith {
        format ["invalid center position (not a world position?): %1", _center] call _logError;
        grpNull
    };
    _center = [_center # 0, _center # 1, 0];

    // Convert the side parameter to a SIDE value (defaults to east)
    private _sideObj = east;
    if (_side isEqualType east) then {
        _sideObj = _side;
    } else {
        switch (toLower _side) do {
            case "blufor";
            case "west":        { _sideObj = west };
            case "independent";
            case "indfor";
            case "greenfor";
            case "resistance":  { _sideObj = independent };
            case "civilian":    { _sideObj = civilian };
            default             { _sideObj = east };
        };
    };

    // ------------------------------------------------------------------------
    // Object dimensions (measured once per classname, then cached)
    // Returns [sizeX, sizeY, sizeZ, turretType] or [] if the class is invalid
    // ------------------------------------------------------------------------
    private _dimsCache = missionNamespace getVariable ["generateTurretBunker_dims", createHashMap];
    missionNamespace setVariable ["generateTurretBunker_dims", _dimsCache];

    private _fnGetDims = {
        params ["_cls"];

        private _d = _dimsCache getOrDefault [_cls, []];
        if (_d isEqualTo []) then {
            private _o = createVehicleLocal [_cls, [0, 0, 0], [], 0, "CAN_COLLIDE"];
            if (!isNull _o) then {
                private _b = boundingBoxReal _o;

                // Turret category, used to pick compatible layouts
                private _kind = "MG";
                if (_o isKindOf "StaticMortar") then {
                    _kind = "MORTAR";
                } else {
                    if (_o isKindOf "StaticATWeapon") then {
                        _kind = "AT";
                    } else {
                        if (_o isKindOf "StaticAAWeapon") then { _kind = "AA" };
                    };
                };

                _d = [
                    (_b # 1 # 0) - (_b # 0 # 0),
                    (_b # 1 # 1) - (_b # 0 # 1),
                    (_b # 1 # 2) - (_b # 0 # 2),
                    _kind
                ];
                _dimsCache set [_cls, _d];
                deleteVehicle _o;
            };
        };
        _d
    };

    // --- Turret ---
    private _td = [_className] call _fnGetDims;
    if (_td isEqualTo []) exitWith {
        format ["could not measure class '%1' (invalid classname?)", _className] call _logError;
        grpNull
    };
    private _width  = _td # 0;
    private _length = _td # 1;
    private _height = _td # 2;
    private _type   = _td # 3;

    // Footprint radius of the turret (clamped to avoid absurd values)
    private _baseR = (((_width max _length) / 2) max 0.8) min 5;

    // ------------------------------------------------------------------------
    // Wall style: one set of segments per bunker. Styles are picked (weighted)
    // among those whose classes exist in the running game.
    //   [styleName, styleWeight, [[classname, classWeight], ...]]
    // ------------------------------------------------------------------------
    private _styles = [
        ["SAND",        4, [["Land_BagFence_Long_F", 3], ["Land_BagFence_Short_F", 1.2]]],
        ["GREEN",       2, [["Land_BagFence_01_long_green_F", 3], ["Land_BagFence_01_short_green_F", 1.2]]],
        ["SAND_HESCO",  2, [["Land_BagFence_Long_F", 3], ["Land_BagFence_Short_F", 1.5], ["Land_HBarrier_1_F", 1]]],
        ["GREEN_HESCO", 1, [["Land_BagFence_01_long_green_F", 3], ["Land_BagFence_01_short_green_F", 1.5], ["Land_HBarrier_1_F", 1]]],
        ["HESCO",       1, [["Land_HBarrier_3_F", 3], ["Land_HBarrier_1_F", 1], ["Land_HBarrier_5_F", 1.5]]],
        ["HESCO_WALL",  1, [["Land_HBarrierWall4_F", 2], ["Land_HBarrier_3_F", 2], ["Land_HBarrier_1_F", 1]]]
    ];

    // Keep only the classes that exist, and the styles that still have some
    private _availStyles  = [];
    private _availWeights = [];
    {
        _x params ["_sName", "_sWeight", "_sClasses"];
        private _existing = _sClasses select { isClass (configFile >> "CfgVehicles" >> (_x # 0)) };
        if ((count _existing) > 0) then {
            _availStyles  pushBack [_sName, _existing];
            _availWeights pushBack _sWeight;
        };
    } forEach _styles;

    if (_availStyles isEqualTo []) exitWith { "no usable wall class found" call _logError; grpNull };

    // Weighted pick of a style (cumulative weights, no dependency on newer commands)
    private _styleIdx = 0;
    private _totalW   = 0;
    { _totalW = _totalW + _x } forEach _availWeights;
    private _roll = random _totalW;
    {
        _roll = _roll - _x;
        if (_roll <= 0) exitWith { _styleIdx = _forEachIndex };
    } forEach _availWeights;

    private _styleName = (_availStyles # _styleIdx) # 0;
    private _style     = (_availStyles # _styleIdx) # 1;

    // Pieces: [classname, length, thickness, height, extraRotation]
    private _pieces  = [];
    private _weights = [];
    {
        _x params ["_cls", "_wt"];
        private _d = [_cls] call _fnGetDims;
        if !(_d isEqualTo []) then {
            _pieces pushBack [
                _cls,
                (_d # 0) max (_d # 1),                  // length = longest axis
                (_d # 0) min (_d # 1),                  // thickness
                _d # 2,                                 // height
                [0, 90] select ((_d # 1) > (_d # 0))    // rotate 90 if the long axis is Y
            ];
            _weights pushBack _wt;
        };
    } forEach _style;

    if (_pieces isEqualTo []) exitWith { "no usable wall class found" call _logError; grpNull };

    private _maxDepth = selectMax (_pieces apply { _x # 2 });
    private _maxLen   = selectMax (_pieces apply { _x # 1 });

    // ------------------------------------------------------------------------
    // Bunker dimensions
    // ------------------------------------------------------------------------
    private _ringR  = _baseR + (_maxDepth / 2) + 0.4;   // inner bunker radius / half width
    private _clearR = (_ringR * 1.5) + _maxLen;         // free space required around the site


    // ------------------------------------------------------------------------
    // Layout selection
    // ------------------------------------------------------------------------
    private _allLayouts = [
        "HORSESHOE", "RING_ENTRANCE", "FLANKS",
        "REAR_CRESCENT", "U_SHAPE", "L_SHAPE", "CHEVRON", "WINGS",
        "MINI_BUNKER", "FORT_RING"
    ];

    // Layouts compatible with each turret type
    // (front stays open for guns, rear stays open for the AT back-blast)
    private _pool = [];
    switch (_type) do {
        case "MORTAR": { _pool = ["RING_ENTRANCE", "MINI_BUNKER", "FORT_RING", "HORSESHOE", "U_SHAPE", "CHEVRON"] };
        case "AT":     { _pool = ["FLANKS", "WINGS"] };
        case "AA":     { _pool = ["MINI_BUNKER", "FORT_RING", "HORSESHOE", "U_SHAPE", "CHEVRON"] };
        default        { _pool = ["MINI_BUNKER", "FORT_RING", "HORSESHOE", "U_SHAPE", "L_SHAPE", "CHEVRON", "REAR_CRESCENT", "FLANKS"] };
    };

    _layout = toUpper _layout;
    if !(_layout in _allLayouts) then { _layout = selectRandom _pool };

    // Shapes are expressed in turret-local coordinates:
    //   ["ARC",  startAngle, endAngle]  angles relative to the turret front (0 = front, clockwise)
    //   ["LINE", [x1, y1], [x2, y2]]    x = right, y = forward, in meters
    private _hw     = _ringR;   // half width of the bunker
    private _rMul   = 1;        // radius multiplier for the round "mini bunker" layouts
    private _shapes = [];
    switch (_layout) do {
        case "HORSESHOE": {
            _shapes = [["ARC", 60, 300]];
        };
        case "RING_ENTRANCE": {
            _shapes = [["ARC", 0, 165], ["ARC", 195, 360]];
        };
        case "FLANKS": {
            _shapes = [["ARC", 40, 125], ["ARC", 235, 320]];
        };
        case "REAR_CRESCENT": {
            _shapes = [["ARC", 110, 250]];
        };
        case "U_SHAPE": {
            _shapes = [
                ["LINE", [-_hw, 0.5 * _hw], [-_hw, -_hw]],
                ["LINE", [-_hw, -_hw],      [_hw, -_hw]],
                ["LINE", [_hw, -_hw],       [_hw, 0.5 * _hw]]
            ];
        };
        case "L_SHAPE": {
            private _s = selectRandom [-1, 1];   // random side for the lateral wall
            _shapes = [
                ["LINE", [-_hw, -_hw],      [_hw, -_hw]],
                ["LINE", [_s * _hw, -_hw],  [_s * _hw, 0.5 * _hw]]
            ];
        };
        case "CHEVRON": {
            _shapes = [
                ["LINE", [-1.4 * _hw, 0.2 * _hw], [0, -1.3 * _hw]],
                ["LINE", [0, -1.3 * _hw],         [1.4 * _hw, 0.2 * _hw]]
            ];
        };
        case "MINI_BUNKER": {
            // Round mini bunker: almost closed ring, only a firing opening at the front
            _rMul   = 1.15;
            _shapes = [["ARC", 35, 325]];
        };
        case "FORT_RING": {
            // Round mini bunker with two openings: front (firing) and rear (entrance)
            _rMul   = 1.2;
            _shapes = [["ARC", 25, 155], ["ARC", 205, 335]];
        };
        case "WINGS": {
            _shapes = [
                ["LINE", [-_hw, 0.6 * _hw], [-_hw, -0.8 * _hw]],
                ["LINE", [_hw, 0.6 * _hw],  [_hw, -0.8 * _hw]]
            ];
        };
    };

    // Round layouts need a bit more room around the turret
    _ringR = _ringR * _rMul;


    // ------------------------------------------------------------------------
    // Supplies placed behind the bunker (never behind AT: back-blast area)
    // ------------------------------------------------------------------------
    private _supplyBoxes = switch (_sideObj) do {
        case west:        { ["Box_NATO_Ammo_F", "Box_NATO_AmmoOrd_F", "Box_NATO_Support_F"] };
        case independent: { ["Box_IND_Ammo_F",  "Box_IND_AmmoOrd_F",  "Box_IND_Support_F"] };
        case east:        { ["Box_East_Ammo_F", "Box_East_AmmoOrd_F", "Box_East_Support_F"] };
        default           { [] };
    };
    private _propPool = (
        ["Land_Sacks_heap_F", "Land_Sack_F", "Land_CratesWooden_F", "Land_MetalBarrel_F",
         "Land_CanisterFuel_F", "Land_Pallet_F", "Land_CratesShabby_F"] + _supplyBoxes
    ) select { isClass (configFile >> "CfgVehicles" >> _x) };

    // Props: classnames
    private _props = [];
    if ((_type != "AT") && {(count _propPool) > 0}) then {
        for "_k" from 1 to (selectRandom [0, 1, 1, 2]) do {
            _props pushBack (selectRandom _propPool);
        };
    };

    // ------------------------------------------------------------------------
    // 1) Find the best defensive position
    //    Cheap filters first, expensive scoring only for surviving candidates
    // ------------------------------------------------------------------------
    private _blockTypes = [
        "TREE", "SMALL TREE", "BUILDING", "HOUSE", "ROCK", "ROCKS", "WALL",
        "FENCE", "ROAD", "MAIN ROAD", "TRACK", "TRAIL", "BUNKER", "FORTRESS",
        "RUIN", "HIDE"
    ];
    private _compass = [0, 45, 90, 135, 180, 225, 270, 315];

    private _bestPos   = [];
    private _bestScore = -1e6;

    for "_i" from 1 to 45 do {
        private _p = _center getPos [_radius * sqrt (random 1), random 360];

        // --- Cheap filters ---
        if (surfaceIsWater _p) then { continue };
        if ((acos ((surfaceNormal _p) # 2)) > 10) then { continue };   // max slope ~10 deg
        if (isOnRoad _p) then { continue };

        // --- Medium filters ---
        private _wet = false;
        { if (surfaceIsWater (_p getPos [_clearR, _x])) exitWith { _wet = true } } forEach [0, 90, 180, 270];
        if (_wet) then { continue };

        if (count (nearestTerrainObjects [_p, _blockTypes, _clearR, false, true]) > 0) then { continue };
        if (count (nearestObjects [_p, ["AllVehicles", "Static", "Thing"], _clearR]) > 0) then { continue };

        // --- Scoring (expensive) ---
        private _hSum = 0;
        private _open = 0;
        private _eye  = (AGLToASL _p) vectorAdd [0, 0, 1.6];
        {
            _hSum = _hSum + getTerrainHeightASL (_p getPos [40, _x]);

            // Count directions with a clear line of sight over 80 m
            private _to = (AGLToASL (_p getPos [80, _x])) vectorAdd [0, 0, 1.6];
            if (!(terrainIntersectASL [_eye, _to]) && {!(lineIntersects [_eye, _to])}) then {
                _open = _open + 1;
            };
        } forEach _compass;

        // Height advantage over the surroundings (positive = high ground)
        private _advantage = (((getTerrainHeightASL _p) - (_hSum / 8)) max -5) min 8;

        // A bit of randomness so placements stay varied
        private _score = (_advantage * 2) + (_open * 2) + (random 2);

        if (_score > _bestScore) then {
            _bestScore = _score;
            _bestPos   = _p;
        };
    };

    // Fallback: nearest empty position if nothing valid was found
    if (_bestPos isEqualTo []) then {
        private _fallback = _center findEmptyPosition [0, _radius, _className];
        _bestPos = if (_fallback isEqualTo []) then { _center } else { _fallback };
    };
    _bestPos = [_bestPos # 0, _bestPos # 1, 0];

    // Default facing: away from the defended center
    if (_dir < 0) then {
        _dir = if ((_center distance2D _bestPos) < 3) then { random 360 } else { _center getDir _bestPos };
    };

    format ["position chosen: bestPos=%1 score=%2 layout=%3 type=%4 style=%5", _bestPos, _bestScore, _layout, _type, _styleName] call _trace;

    // ------------------------------------------------------------------------
    // 2) Spawn the turret and its crew
    //    doGenerateEnemyGroup expects an ARRAY of classnames
    // ------------------------------------------------------------------------
    private _grp = [[_className], _bestPos, _sideObj, "Turret"] call doGenerateEnemyGroup;

    if (isNil "_grp") exitWith { "doGenerateEnemyGroup returned nothing (nil)" call _logError; grpNull };
    if !(_grp isEqualType grpNull) exitWith {
        format ["doGenerateEnemyGroup returned a %1 instead of a GROUP: %2", typeName _grp, _grp] call _logError;
        grpNull
    };
    if (isNull _grp) exitWith { "doGenerateEnemyGroup returned grpNull" call _logError; grpNull };

    format ["group created: %1 units=%2", _grp, units _grp] call _trace;
    _grp setVariable ["bunkerReady", false];

    // ------------------------------------------------------------------------
    // 3) Finalization: locate the turret, place it, build the sandbags.
    //    Runs in a scheduled environment (units may be created with a delay).
    //    Everything it needs is passed as an argument, since a spawned script
    //    does not see local variables.
    // ------------------------------------------------------------------------
    private _fnFinalize = {
        params [
            "_grp", "_className", "_bestPos", "_dir", "_layout", "_shapes",
            "_ringR", "_pieces", "_weights", "_maxDepth",
            "_props", "_destructible", "_debug"
        ];

        private _logError = { diag_log format ["[generateTurretBunker] ERROR: %1", _this] };
        private _trace    = { if (_debug) then { diag_log format ["[generateTurretBunker] %1", _this] } };

        // --- Wait (max 10 s) for the turret to exist ---
        private _turret  = objNull;
        private _start   = time;
        private _timeout = _start + 10;
        waitUntil {
            // 1) Turret = vehicle of a group member
            {
                private _veh = vehicle _x;
                if (_veh != _x) exitWith { _turret = _veh };
            } forEach (units _grp);

            // 2) After 2 s: a turret of the right class near the chosen position
            if (isNull _turret && {time > (_start + 2)}) then {
                private _near = nearestObjects [_bestPos, [_className], 15];
                if ((count _near) > 0) then { _turret = _near # 0 };
            };

            if (isNull _turret) then { sleep 0.25 };
            (!isNull _turret) || {time > _timeout}
        };

        if (isNull _turret) exitWith {
            format ["no turret found for group %1 after waiting (units=%2, vehicles=%3)", _grp, units _grp, (units _grp) apply { vehicle _x }] call _logError;
        };
        format ["turret found: %1 at %2", _turret, getPosATL _turret] call _trace;

        // Force the final placement: the turret (and its crew) always end up on
        // the computed position, even if the spawn helper placed it elsewhere
        _turret setDir _dir;
        _turret setPosATL _bestPos;

        // --- Piece statistics ---
        private _lengths     = _pieces apply { _x # 1 };
        private _minLen      = selectMin _lengths;
        private _shortestIdx = _lengths find _minLen;

        // --- Plan the selected layout ---
        // Everything is computed inline (no helper closures): shapes are expanded
        // into paths, then each path is filled with randomly picked segments.
        // Nothing is created here: planning and creation are separate steps.
        private _tPos = getPosATL _turret;
        private _plan = [];
        format ["planning layout %1 around %2 (dir=%3, pieces=%4)", _layout, _tPos, _dir, _pieces apply { _x # 0 }] call _trace;

        // Piece statistics
        private _lengths     = _pieces apply { _x # 1 };
        private _minLen      = selectMin _lengths;
        private _shortestIdx = _lengths find _minLen;

        // Paths:  ["ARC", radius, startAngle, stopAngle]  or  ["LINE", [x1, y1], [x2, y2]]
        private _paths = [];
        {
            if ((_x # 0) == "ARC") then {
                _paths pushBack ["ARC", _ringR, _x # 1, _x # 2];
            } else {
                _paths pushBack ["LINE", _x # 1, _x # 2];
            };
        } forEach _shapes;

        {
            private _path  = _x;
            private _isArc = (_path # 0) == "ARC";

            private _pathR       = 0;        // arc radius
            private _from        = [0, 0];   // line start (turret-local)
            private _ux          = 0;        // line direction (turret-local)
            private _uy          = 0;
            private _lineHeading = 0;        // line heading (world)
            private _cur         = 0;        // arc: current angle / line: current distance
            private _stop        = 0;        // arc: end angle / line: length

            if (_isArc) then {
                _pathR = _path # 1;
                _cur   = _path # 2;
                _stop  = _path # 3;
            } else {
                _from = _path # 1;
                private _to = _path # 2;
                private _dx = (_to # 0) - (_from # 0);
                private _dy = (_to # 1) - (_from # 1);
                _stop = sqrt ((_dx * _dx) + (_dy * _dy));
                if (_stop > 0.01) then {
                    _ux = _dx / _stop;
                    _uy = _dy / _stop;
                };
                _lineHeading = (_dx atan2 _dy) + _dir;
            };

            for "_g" from 1 to 80 do {
                // Remaining length to fill, in meters
                private _remaining = _stop - _cur;
                if (_isArc) then { _remaining = _pathR * (_stop - _cur) * (pi / 180) };
                if (_remaining < (_minLen * 0.5)) exitWith {};

                // Candidate pieces that fit in the remaining length
                private _candidates = [];
                {
                    if ((_x # 1) <= (_remaining + 0.4)) then { _candidates pushBack _forEachIndex };
                } forEach _pieces;

                // Weighted random pick (cumulative weights); if nothing fits, close the gap with the shortest piece.
                // On tight arcs, long pieces are strongly discouraged (their chord angle is too wide,
                // the curve would look like a polygon), so mini bunkers get a round shape.
                private _pickIdx = _shortestIdx;
                if ((count _candidates) > 0) then {
                    private _cw = _candidates apply {
                        private _wEff = _weights # _x;
                        if (_isArc && {(2 * (asin ((((_pieces # _x) # 1) / (2 * _pathR)) min 1))) > 100}) then {
                            _wEff = _wEff * 0.1;
                        };
                        _wEff
                    };

                    private _total = 0;
                    { _total = _total + _x } forEach _cw;

                    private _pickRoll = random _total;
                    _pickIdx = _candidates # 0;
                    {
                        _pickRoll = _pickRoll - (_cw # _forEachIndex);
                        if (_pickRoll <= 0) exitWith { _pickIdx = _candidates # _forEachIndex };
                    } forEach _cw;
                };

                (_pieces # _pickIdx) params ["_cls", "_len", "_depth", "_h", "_prot"];

                private _pos     = [0, 0, 0];
                private _heading = 0;
                private _advance = _len;

                if (_isArc) then {
                    // Angle covered by this segment (chord = segment length)
                    private _span    = (2 * (asin ((_len / (2 * _pathR)) min 1))) max 3;
                    private _bearing = _dir + _cur + (_span / 2);

                    _pos     = _tPos getPos [_pathR, _bearing];
                    _heading = _bearing + _prot;     // outward facing, long axis tangent to the circle
                    _advance = _span;
                } else {
                    // Local position of the segment center, then local -> world
                    private _lx = (_from # 0) + (_ux * (_cur + (_len / 2)));
                    private _ly = (_from # 1) + (_uy * (_cur + (_len / 2)));

                    _pos = [
                        (_tPos # 0) + (_lx * cos _dir) + (_ly * sin _dir),
                        (_tPos # 1) + (_ly * cos _dir) - (_lx * sin _dir),
                        0
                    ];
                    _heading = _lineHeading - 90 + _prot;
                };

                if !(surfaceIsWater _pos) then {
                    // Small random jitter on position and heading
                    _plan pushBack [
                        _cls,
                        [(_pos # 0) + (random 0.16) - 0.08, (_pos # 1) + (random 0.16) - 0.08, 0],
                        _heading + (random 5) - 2.5
                    ];
                };
                _cur = _cur + _advance;
            };
        } forEach _paths;

        format ["planned %1 placements from %2 paths", count _plan, count _paths] call _trace;
        if (_plan isEqualTo []) then {
            format ["empty plan (layout=%1, pieces=%2, paths=%3)", _layout, _pieces, _paths] call _logError;
        };

        // --- Create the objects (single layer) ---
        // Height is set explicitly from the terrain height. setPosASL positions the
        // object's ground reference point (not the model origin), so no offset is
        // needed; the objects are sunk by 6 cm to avoid gaps on uneven ground.
        // Physics / simulation is disabled on every object (static decor, much cheaper).
        private _walls = [];
        {
            _x params ["_cls", "_pos", "_heading"];

            private _w = createVehicle [_cls, [_pos # 0, _pos # 1, 0], [], 0, "CAN_COLLIDE"];
            _w setVectorDirAndUp [[sin _heading, cos _heading, 0], surfaceNormal _pos];
            _w setPosASL [_pos # 0, _pos # 1, (getTerrainHeightASL _pos) - 0.06];

            if (!_destructible) then { _w enableSimulationGlobal false };
            _walls pushBack _w;
        } forEach _plan;

        // --- Supplies behind the bunker (outside the walls, rear sector) ---
        {
            private _propClass = _x;

            private _bearing = _dir + 180 + (random 100) - 50;
            private _dist    = _ringR + _maxDepth + 1 + (random 1.5);
            private _p       = _tPos getPos [_dist, _bearing];

            if !(surfaceIsWater _p) then {
                private _prop = createVehicle [_propClass, [_p # 0, _p # 1, 0], [], 0, "CAN_COLLIDE"];
                _prop setDir (random 360);
                _prop setVectorUp (surfaceNormal _p);
                _prop setPosASL [_p # 0, _p # 1, getTerrainHeightASL _p];

                // Static decor: no physics
                _prop enableSimulationGlobal false;
                _walls pushBack _prop;
            };
        } forEach _props;

        // --- Store useful references on the group ---
        _grp setVariable ["bunkerTurret", _turret];
        _grp setVariable ["bunkerWalls",  _walls];
        _grp setVariable ["bunkerLayout", _layout];
        _grp setVariable ["bunkerReady",  true];

        format ["done: bestPos=%1 turretPos=%2 layout=%3 objects=%4 (%5 s)", _bestPos, getPosATL _turret, _layout, count _walls, time - _start] call _trace;
    };

    private _args = [
        _grp, _className, _bestPos, _dir, _layout, _shapes,
        _ringR, _pieces, _weights, _maxDepth,
        _props, _destructible, _debug
    ];

    if (canSuspend) then {
        // Scheduled environment: wait here, return once everything is built
        _args call _fnFinalize;
    } else {
        // Unscheduled environment: finish in the background
        _args spawn _fnFinalize;
    };

    _grp
};
