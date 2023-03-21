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
	if (_thisGroupType != "") then
	{
		_missionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];
		_missionEnemyInfo pushBack [_thisGroupType,_thisSpawnPosition, _currentGroupPatrol];
		missionNamespace setVariable ["MissionEnemyInfo", _missionEnemyInfo, true];
	};
	
	//Set IA Skills
	[_currentGroupPatrol, missionIASkill] call doSetGroupSkills;

	//Manage civilian specific feature
	if (_thisFaction == civilian) then 
	{
		{		
			//Manage hostile civilian
			// 20% chance not to be hostile at all
			if (round (random 4 )== 0) then 
			{
				[_x] execVM "enemyManagement\behaviorEngine\manageHostileCivilian.sqf";
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


doSetGroupSkills = 
{
	params ["_thisGroup", "_thisSkillLevel"];

	switch (_thisSkillLevel) do
	{
		case 0:
			{
				 {
					_unit = _x;
					_unit setSkill ["aimingAccuracy", random [0.25, 0.30, 0.35]];
					_unit setSkill ["aimingShake", random [0.06, 0.08, 0.1]];
					_unit setSkill ["aimingSpeed", random [0.1, 0.15, 0.20]];
					_unit setSkill ["spotDistance", random [0.5, 0.6, 0.7]];
					_unit setSkill ["spotTime", random [0.2, 0.3, 0.4]];
					_unit setSkill ["general", random [0.6, 0.65, 0.7]];	
					_unit setSkill ["courage", random [0.2, 0.25, 0.3]];
					_unit setSkill ["reloadSpeed", random [0.2, 0.3, 0.3]];
				 } forEach (units _thisGroup);
			};
		case 1:
			{
				 {
					_unit = _x;
					_unit setSkill ["aimingAccuracy", random [0.50, 0.55, 0.60]];
					_unit setSkill ["aimingShake", random [0.06, 0.08, 0.1]];
					_unit setSkill ["aimingSpeed", random [0.25, 0.30, 0.35]];
					_unit setSkill ["spotDistance", random [0.7, 0.75, 0.8]];
					_unit setSkill ["spotTime", random [0.3, 0.4, 0.5]];
					_unit setSkill ["general", random [0.7, 0.75, 0.8]];	
					_unit setSkill ["courage", random [0.3, 0.4, 0.5]];
					_unit setSkill ["reloadSpeed", random [0.2, 0.3, 0.3]];
				 } forEach (units _thisGroup);
			};
		case 2:
			{
				 {
					_unit = _x;
					_unit setSkill ["aimingAccuracy", random [0.50, 0.55, 0.60]];
					_unit setSkill ["aimingShake", random [0.10, 0.15, 0.2]];
					_unit setSkill ["aimingSpeed", random [0.40, 0.45, 0.50]];
					_unit setSkill ["spotDistance", random [0.75, 0.8, 0.85]];
					_unit setSkill ["spotTime", random [0.4, 0.45, 0.5]];
					_unit setSkill ["general", random [0.8, 0.85, 0.88]];	
					_unit setSkill ["courage", random [0.4, 0.5, 0.6]];
					_unit setSkill ["reloadSpeed", random [0.3, 0.4, 0.5]];
				 } forEach (units _thisGroup);
			};
		case 3:
			{
				 {
					_unit = _x;
					_unit setSkill ["aimingAccuracy", random [0.70, 0.80, 0.90]];
					_unit setSkill ["aimingShake", random [0.10, 0.15, 0.20]];
					_unit setSkill ["aimingSpeed", random [0.50, 0.60, 0.70]];
					_unit setSkill ["spotDistance", random [0.75, 0.8, 0.9]];
					_unit setSkill ["spotTime", random [0.4, 0.5, 0.55]];
					_unit setSkill ["general", random [0.75, 0.8, 0.85]];	
					_unit setSkill ["courage", random [0.4, 0.45, 0.5]];
					_unit setSkill ["reloadSpeed", random [0.3, 0.4, 0.5]];
				 } forEach (units _thisGroup);
			};
	};
};