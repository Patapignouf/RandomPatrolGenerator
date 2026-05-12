//Get parameters
params ["_thisUnit", "_hostileTransformProba"];

//Loop on the unit until it become hostile
while {alive _thisUnit && (side _thisUnit == civilian) && !(_thisUnit getVariable ["ace_isHandcuffed", false])} do {
	sleep (10 + (random 30));

	//Check for nearby player units
	_entities = _thisUnit nearEntities 30;
	_targets = [];
	{
		if (side _x == blufor || side _x == independent) then {

			//Check if players have weapons in hand
			//(Show hostility)
			if (currentWeapon _x != "") then 
			{
				_targets pushBack _x;
			};
		};
	} forEach _entities;

	//Detect if at least one player is nearby
	if (count _targets > 0) then 
	{
		//parameters % chance to become hostile
		if (random 100 < _hostileTransformProba) then 
		{
			//Hostile civilian can call reinforcement
			if (missionNameSpace getVariable ["hostileCivCanCallReinforcement", 1] == 1) then 
			{
				_canCallReinforcement = missionNameSpace getVariable ["civilianCallOpforReinforcement", true];

				if (_canCallReinforcement) then 
				{
					_AvalaibleInitAttackPositions = [getPos _thisUnit, 800, 1400, 1] call getListOfPositionsAroundTarget;

					if ( count _AvalaibleInitAttackPositions != 0) then
					{
						//Alert players
						[[_thisUnit], {params ["_unit"]; [name _unit, "STR_RPG_HC_CALL_REINFORCEMENT_OPFOR"] call doDialog}] remoteExec ["spawn", allPlayers select {_x distance _thisUnit < 80}]; 

						//Tell spotted players he has been spotted 
						[[format ["You have been spotted by an hostile civilian"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _targets];

						//Generate opfor
						_handleCivGeneration = [_AvalaibleInitAttackPositions, getPos _thisUnit, [baseEnemyGroup, baseEnemyATGroup], [], missionDifficultyParam] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
						waitUntil {isNull _handleCivGeneration};

						//Disable reinforcement during 120 seconds
						[] spawn {
							//Disable opfor reinforcement
							missionNameSpace setVariable ["civilianCallOpforReinforcement", false, true];
							sleep 120;
							//Enable opfor reinforcement
							missionNameSpace setVariable ["civilianCallOpforReinforcement", true, true];
						};
					};
				};
			};

			//Randomize time before becoming hostile	
			sleep (10 + random (120));

			//RemoveAll specific stuff from this civilian
			[_thisUnit] remoteExec ["removeAllEventHandlers", 0, true];
			_thisUnit removeAllMPEventHandlers "mpkilled"; 
			_thisUnit removeAllEventHandlers "Killed";
			[_thisUnit] remoteExec ["removeAllActions", 0, true];
			[_thisUnit, ""] remoteExec ["switchMove"];
			
			//Join enemy group
			_tempGroup = createGroup east;
			[_thisUnit] joinSilent _tempGroup;

			//If lambs is enabled, disable unit task
			if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
			{
				[_tempGroup] call lambs_wp_fnc_taskReset; //reset current task
			};
			
			//Manage loadout
			//Setup date
			switch (round (random 3)) do
			{
				case 0:
				{
					_thisUnit addVest "V_BandollierB_rgr";
					_thisUnit addWeapon "hgun_Rook40_F"; //Inspire by DRO waiting for RPG version ;)
					_thisUnit addMagazines ["16Rnd_9x21_Mag", 3];
				};
				case 1:
				{
					_thisUnit addVest "V_BandollierB_rgr";
					_thisUnit addWeapon "hgun_PDW2000_F"; //Inspire by DRO waiting for RPG version ;)
					_thisUnit addMagazines ["30Rnd_9x21_Mag", 3];
				};
				case 2:
				{
					_thisUnit addVest "V_BandollierB_rgr";
					_thisUnit addWeapon "sgun_HunterShotgun_01_F"; //Inspire by DRO waiting for RPG version ;)
					_thisUnit addMagazines ["2Rnd_12Gauge_Pellets", 10];
				};
				case 3:
				{
					_thisUnit addVest "V_BandollierB_rgr";
					_thisUnit addWeapon "sgun_HunterShotgun_01_sawedoff_F"; //Inspire by DRO waiting for RPG version ;)
					_thisUnit addMagazines ["2Rnd_12Gauge_Pellets", 10];
				};
				default
				{
					//No Stuff
				};
			};

			//Add eventhandler killed
			_thisUnit addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];

				if (isPlayer _instigator) then 
				{
					_distance = _instigator distance _unit;

					//Store kill distance
					[[_distance], 
					{
						params ["_distance"];
						_infantryKillRange = player getVariable ["RPG_ranking_infantry_killRange", 0];

						if (_infantryKillRange < _distance) then 
						{
							player setVariable ["RPG_ranking_infantry_killRange", _distance, true];
						};
					}] remoteExec ["spawn", _instigator]; 


					if (_distance<100 || _distance>5000) then {_distance = nil};
					[[_distance], {params ["_distance"]; [1, "RPG_ranking_infantry_kill", _distance] call doUpdateRank}] remoteExec ["spawn", _instigator]; 
				} else {
					//Debug IA killed log
					diag_log format ["The IA %1 has been killed by %2", name _unit, name _instigator];
				}; 
				
				//Garbage collect unit  
				[_unit] spawn 
				{
					params ["_unit"];
					//Fix ACE locking place in vehicle when an IA dies
					sleep 20;
					moveOut _unit;

					//Free some memory usage by cleaning the corpse
					sleep 300;
					deleteVehicle _unit;
				};
			}];
		};
	};
};