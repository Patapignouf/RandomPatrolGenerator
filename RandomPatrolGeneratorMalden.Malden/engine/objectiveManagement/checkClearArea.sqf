#include "..\..\objectGenerator\vehicleManagement.sqf"

params ["_thisTrigger"];

//Count independent and blufor player
_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);


//Add more opfor to the area
_baseRadius = 100;
for [{_i = 0}, {_i < missionDifficultyParam+1}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom EnemyWaveLevel_1;
	currentGroup = [currentRandomGroup, getPos _thisTrigger, east, "DefenseInfantry"] call doGenerateEnemyGroup;
	
	//Spawn group
	[currentGroup, getPos (leader currentGroup), _baseRadius, false] execVM 'enemyManagement\behaviorEngine\doGarrison.sqf';
	_baseRadius = _baseRadius + 20;
};

//Add more opfor to the area
while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
};

//Check tasks
_thisObjectiveToComplete = _thisTrigger getVariable ["associatedTask",[]];
if (!([_thisObjectiveToComplete,[]] call BIS_fnc_areEqual)) then 
{
	[_thisObjectiveToComplete] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
	[[50, "RPG_ranking_objective_complete"], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', 0];

	//Manage Completed Objective
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_completedObjectives pushBack _thisObjectiveToComplete;
	missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
	
	[] call doIncrementVehicleSpawnCounter;	

	//Call respawn
	if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
	{
		[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
	};
};

//Check FOB clear
_thisFOBCheck = _thisTrigger getVariable ["isFOBAssociated", false];
if (_thisFOBCheck) then 
{
	//Hint players for cleared FOB
	[format ["The FOB at position %1 has been cleared",mapGridPosition (getPos _thisTrigger)]] remoteExec ["hint", 0, true];	

	//Add this FOB to cleared FOB
	_OpforFOBCleared = missionNamespace getVariable ["OpforFOBCleared", 0];
	missionNamespace setVariable ["OpforFOBCleared", _OpforFOBCleared+1, true];	
};
