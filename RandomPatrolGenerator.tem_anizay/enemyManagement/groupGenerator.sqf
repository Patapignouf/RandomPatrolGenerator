//private _generateCivDialogs = compile preprocessFileLineNumbers "enemyManagement\manageHostileCivilian.sqf";

doGenerateEnemyGroup = 
{
	//Get parameters
	params ["_thisGroupToSpawn","_thisSpawnPosition","_thisFaction","_thisGroupType"];

	//Group spawn
	_currentGroupPatrol = [_thisSpawnPosition, _thisFaction, _thisGroupToSpawn,[],[],[],[],[], random 360] call BIS_fnc_spawnGroup;

	//Optimize IA 
	_currentGroupPatrol enableDynamicSimulation true;
	

	//Intel Synchronization
	_missionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];
	_missionEnemyInfo pushBack [_thisGroupType,_thisSpawnPosition, _currentGroupPatrol];
	missionNamespace setVariable ["MissionEnemyInfo", _missionEnemyInfo, true];

	//Manage civilian specific feature
	if (_thisFaction == civilian) then 
	{
		{		
			//Manage hostile civilian
			//20 % chance not to be hostile at all
			if (round (random 4 )!= 0) then 
			{
				[_x] execVM "enemyManagement\manageHostileCivilian.sqf";
			};

			//Add eventhandler civKilled
			_x addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				[_unit] remoteExec ["removeAllActions", 0, true];

				if (isPlayer _killer) then 
				{
					//Add civ killed counter
					_tempCivKilled = missionNamespace getVariable "civKilled";
					_tempCivKilled = _tempCivKilled + 1;
					missionNamespace setVariable ["civKilled", _tempCivKilled, true];

					//If number of killed civ reach max civ killed number then end mission
					if (missionNamespace getVariable "civKilled" > missionNamespace getVariable "maxCivKilled") then 
					{
						diag_log "END MISSION";
						if (isMultiplayer) then {
							['CIV_DEAD'] remoteExec ["BIS_fnc_endMissionServer", 2];
						} else {
							['CIV_DEAD'] remoteExec ["BIS_fnc_endMission", 2];
						}; 
					};

					diag_log format ["Civilian has been killed by : %1 on side %2", name _killer, side _killer];
					[[format ["Civilian has been killed by : %1", name _killer],side _killer], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
				}; 
			}];
		} foreach (units _currentGroupPatrol);
	};




	//Return spawned group
	_currentGroupPatrol
};
