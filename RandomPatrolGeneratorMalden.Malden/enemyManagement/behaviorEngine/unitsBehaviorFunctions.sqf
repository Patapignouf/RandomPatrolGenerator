doAttack = {
	params ["_thisGroup", "_thisTarget"];

	if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
	{
		if (!isNil "_thisGroup") then
		{
			diag_log "Task ATTACK [LAMBS]!";
			[_thisGroup, _thisTarget] spawn lambs_wp_fnc_taskAssault;;

		};
	} else 
	{
		diag_log "Task ATTACK !";
		[_thisGroup, _thisTarget] call BIS_fnc_taskAttack;
	};
};


doGarrison = {
params ["_thisGroup", "_position", "_distance","_allowCamp"];
	diag_log format ["doGarrison : %1 on position %2", _thisGroup, _position];

	//Test if lambs IA Mod is enabled on the server
	if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
	{
		if (!isNull _thisGroup) then
		{
			//Randomly place IA group in garrison or camp
			if (round (random 3) != 0 && _allowCamp) then 
			{
				diag_log "Task_Camp ! [LAMBS]";
				[_thisGroup, _position, _distance, [], true, true] call lambs_wp_fnc_taskCamp;
			} 
			else 
			{
				diag_log "Task_Garrison ! [LAMBS]";
				[_thisGroup, _position, _distance, [], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
			};
		};
	} else 
	{
		diag_log "Task_Garrison !";
		//Determine building avalaible positions
		_allBuildings = nearestTerrainObjects [_position, ["house", "FORTRESS", "BUNKER"], _distance, false, true];
		_allPositions = [];
		_allBuildings apply {_allPositions append (_x buildingPos -1)};
		//_allPositions = call BIS_fnc_arrayShuffle; 

		diag_log format ["Avalaible _allPositions position %1", _allPositions];

		//Place units in building (garrison)
		_units = units _thisGroup; 
		//if (count _units > count _allPositions) then {_units resize (count _allPositions);};
		{
			//Force unit to go inside a building only if there is a building :p
			if (count _allPositions != 0) then 
			{
				_x disableAI "PATH";
				_tempPosition = selectRandom _allPositions;
				_allPositions = _allPositions - [_tempPosition];
				//[_x, "STAND1", "ASIS"] call BIS_fnc_ambientAnim;
				_x setPos (_tempPosition);

				//80% to leave the position if fired
				if (random 100>80) then 
				{ 
					_x addEventHandler["Fired",
						{
							params ["_unit"];
							_unit enableAI "PATH";
							_unit dofollow leader _unit;
							_unit setUnitPos "AUTO";
							_unit removeEventHandler ["Fired",_thisEventHandler];
						}];
				};
			};
		} foreach _units; 
	};
};

doPatrol = {
	params ["_thisGroup", "_position", "_distance"];

	currentGroup = nil;

	if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
	{
		diag_log "Task_Patrol [LAMBS]!";
		[_thisGroup, _position, _distance] call lambs_wp_fnc_taskPatrol;

	} else 
	{
		diag_log "Task_Patrol !";
		[_thisGroup, _position, _distance] call BIS_fnc_taskPatrol;
	};
};

//Scripted by ZaellixA on https://forums.bohemia.net/forums/topic/231437-ai-surrender-when-some-of-group-dies-video/
//Modified by Pata
doSurrender = {
	params ["_unit"];

	// Give the script to the scheduler
	private _nil = [_unit] spawn {
		// Get the parameters
		_unit = _this select 0; // The unit to surrender

		//Make unit speak 
		_dubbing = [
			"a3\dubbing_f_epa\a_m02\120_bombs\a_m02_120_bombs_ker_0.ogg",
			"a3\dubbing_f_epb\b_out2\65_stop_attack\b_out2_65_stop_attack_lar_0.ogg",
			"a3\dubbing_f_epb\b_out2\65_stop_attack\b_out2_65_stop_attack_lar_2.ogg"


			];
		playSound3D [selectRandom _dubbing, _unit, true, getPosASL _unit, 5, 1, 20, 0, false];

		//Call every players under 80 meters
		[[_unit], {params ["_unit"]; [name _unit, "STR_RPG_HC_SURRENDER_SPEAK"] call doDialog}] remoteExec ["spawn", allPlayers select {_x distance _unit < 80}]; 

		//If lambs is enabled, disable unit task
		if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
		{
			[_unit] call lambs_wp_fnc_taskReset; //reset current task
			_unit setVariable ["lambs_danger_disableAI", true];
		};

		//Heal unit to prevent IA from immediate death and penalize the player 
		if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
		{
			[objNull, _unit] call ace_medical_treatment_fnc_fullHeal;
		} else 
		{
			_unit setDamage 0;
		};

		//remove XP on suppress
		_unit removeAllEventHandlers "Suppressed";

		// Drop weapons
		_wh = "GroundWeaponHolder_Scripted" createVehicle (getPos _unit); // Create a ground weapon holder

		// Drop primary weapon
		_unit action["DropWeapon", _wh, primaryWeapon _unit]; // Drop the primary weapon
		waitUntil {
			uiSleep 0.5; // Wait a bit to save some CPU cycles
			(primaryWeapon _unit) isEqualTo ""; // Wait until main weapon is dropped
		};

		// Drop handgun
		_unit action["DropWeapon", _wh, handgunWeapon _unit]; // Drop the handgun
		waitUntil {
			uiSleep 0.5; // Wait a bit to save some CPU cycles
			(handgunWeapon _unit) isEqualTo ""; // Wait until handgun is dropped
		};

		// Drop secondary weapon
		_unit action["DropWeapon", _wh, secondaryWeapon _unit]; // Drop the secondary weapon
		waitUntil {
			uiSleep 0.5; // Wait a bit to save some CPU cycles
			(secondaryWeapon _unit) isEqualTo ""; // Wait until secondary weapon is dropped
		};

		// Make the unit surrender
		_unit action["Surrender", _unit]; // Surrender
		_unit setCaptive true; // Set as captive

		sleep 3; //Add 3 sec safe for player

		//Add penalty if a player kill a surrender unit
		if (alive _unit) then 
		{
			//Add eventhandler surrender killed
			_unit addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				[_unit] remoteExec ["removeAllActions", 0, true];

				if (isPlayer _instigator) then 
				{
					[[_unit, _instigator], {params ["_unit", "_instigator"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_SURRENDER_KILL", name _unit, name _instigator] call doDialog}] remoteExec ["spawn", side _instigator]; 

					[{[-10, 1] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];
				}; 
			}];

			//Reward HQ repport
			_unit addAction ["<img size='2' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa'/><t size='1'>Report prisoner</t>",{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];

				//Remove action on other clients
				[_object] remoteExec ["removeAllActions", 0, true];

				//Give a feedback to the player
				[[_caller], {params ["_caller"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_SURRENDER_INTEL", name _caller] call doDialog}] remoteExec ["spawn", _caller]; 

				//Reward player
				[{[2, "RPG_ranking_intel_collect"] call doUpdateRank}] remoteExec ["call", _caller];
			},_x,3,true,true,"","_target distance _this <5"];
		};
		
		//Clean unit after 15 minutes
		[_unit] spawn {
			params ["_unit"];
			sleep 900;
			deleteVehicle _unit;
		};
	};
};

drawIAPositionOnMap = {
	params ["_unit"];

	//Draw marker for this specific unit
	_markerName = format ["opforMarker%1", name _unit];
	if !(_markerName in allMapMarkers) then 
	{
		_marker = createMarker [_markerName, getPos _unit]; // Not visible yet.
		_marker setMarkerType "hd_dot"; // Visible.
		_marker setMarkerSize [0.5, 0.5];
		_marker setMarkerColor "ColorRed";

		//Clean marker after unit dies
		[_unit, _markerName] spawn 
		{
			params ["_unit", "_markerName"];
			waitUntil {!alive _unit};
			deleteMarker _markerName;
		};
	};
};