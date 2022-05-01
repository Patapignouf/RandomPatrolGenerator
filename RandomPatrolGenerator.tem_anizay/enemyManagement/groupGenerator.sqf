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

	//Return spawned group
	_currentGroupPatrol
};
