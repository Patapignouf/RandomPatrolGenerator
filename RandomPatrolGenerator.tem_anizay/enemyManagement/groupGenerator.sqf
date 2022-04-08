doGenerateEnemyGroup = 
{
	//Get parameters
	_thisGroupToSpawn = _this select 0;
	_thisSpawnPosition = _this select 1;
	_thisFaction = _this select 2;
	_thisGroupType = _this select 3;

	//Group spawn
	_currentGroupPatrol = [_thisSpawnPosition, _thisFaction, _thisGroupToSpawn,[],[],[],[],[],180] call BIS_fnc_spawnGroup;

	//Intel Synchronization
	_missionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];
	_missionEnemyInfo pushBack [_thisGroupType,_thisSpawnPosition];
	missionNamespace setVariable ["MissionEnemyInfo", _missionEnemyInfo, true];

	//Return spawned group
	_currentGroupPatrol
};
