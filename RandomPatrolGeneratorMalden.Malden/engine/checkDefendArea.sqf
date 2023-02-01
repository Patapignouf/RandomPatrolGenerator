params ["_thisTrigger"];

//Count independent and blufor player
_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);

//Check if there's IA on the area on the beginning
while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
};

//Generate enemy attack wave
AvalaibleInitAttackPositions = [];
AvalaibleInitAttackPositions = [getPos _thisTrigger, 550, 800, missionDifficultyParam+1] call getListOfPositionsAroundTarget;
_handleAttackGeneration = [AvalaibleInitAttackPositions, getPos _thisTrigger, [baseEnemyGroup,baseEnemyATGroup], baseEnemyVehicleGroup, round((missionDifficultyParam-0.5)/2)+1] execVM 'enemyManagement\doAmbush.sqf'; 
waitUntil {isNull _handleAttackGeneration};
_nearestCity = nearestLocations [getPos _thisTrigger, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
[format ["Opfor attack has begun on %1, be ready", text _nearestCity]] remoteExec ["hint",0,true];
sleep 500;

//Check if there's opfor on the area after the attack
while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
};

//Complete mission if there's few opfor on the area
_thisObjectiveToComplete = _thisTrigger getVariable "associatedTask";
[_thisObjectiveToComplete] execVM 'engine\completeObjective.sqf'; 

//Manage Completed Objective
_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
_completedObjectives pushBack _thisObjectiveToComplete;
missionNamespace setVariable ["completedObjectives", _completedObjectives, true];	