#include "..\..\objectGenerator\vehicleManagement.sqf"

params ["_thisTrigger"];

//diag_log format ["Log : checkDefendArea , _thisTrigger = %1 , getPos _thisTrigger = %2 , associatedTask = %3", _thisTrigger, getPos _thisTrigger, _thisTrigger getVariable "associatedTask"];

//Count independent and blufor player
_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);

//diag_log format ["Log : checkDefendArea , _nbBluePlayer = %1, _nbIndPlayer = %2, _nbOpfor = %3", _nbBluePlayer, _nbIndPlayer, _nbOpfor];

//Check if there's IA on the area on the beginning
while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
	//diag_log format ["Log : checkDefendArea , _nbBluePlayer = %1, _nbIndPlayer = %2, _nbOpfor = %3", _nbBluePlayer, _nbIndPlayer, _nbOpfor];
};

//Generate enemy attack wave
AvalaibleInitAttackPositions = [];
AvalaibleInitAttackPositions = [getPos _thisTrigger, 550, 800, round (missionDifficultyParam/2)] call getListOfPositionsAroundTarget;
_handleAttackGeneration = [AvalaibleInitAttackPositions, getPos _thisTrigger, [baseEnemyGroup,baseEnemyATGroup], baseEnemyVehicleGroup, missionDifficultyParam+1] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
waitUntil {isNull _handleAttackGeneration};

//diag_log format ["Log : checkDefendArea , enemy generation completed"];

//Show a message for the opfor reinforcement
_thisObjectiveToComplete = _thisTrigger getVariable ["associatedTask", []];
if (!([_thisObjectiveToComplete,[]] call BIS_fnc_areEqual)) then 
{

	_nearestCity = nearestLocations [getPos _thisTrigger, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
	//[format ["Opfor attack has begun on %1, be ready", text _nearestCity]] remoteExec ["hint",0,true];
	_textToSpeech = format ["Opfor attack has begun on %1, be ready", text _nearestCity];
	[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", 0, true];
};

_thisFOBCheck = _thisTrigger getVariable ["isFOBAssociated", false];
if (_thisFOBCheck) then 
{
	_textToSpeech = format ["An opfor reinforcement is coming to %1, be ready to defend the FOB</t>", mapGridPosition (getPos _thisTrigger)];
	[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", 0, true];
};

//Wait enemy reinforcement
sleep 500;

_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);

//Check if there's opfor on the area after the attack
while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
};

//Check tasks
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
if (_thisFOBCheck) then 
{
	//Hint players for cleared FOB
	[format ["The FOB at position %1 has been cleared", mapGridPosition (getPos _thisTrigger)]] remoteExec ["hint", 0, true];	

	//Add this FOB to cleared FOB
	_OpforFOBCleared = missionNamespace getVariable ["OpforFOBCleared", 0];
	missionNamespace setVariable ["OpforFOBCleared", _OpforFOBCleared+1, true];	
};
