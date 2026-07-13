#include "..\..\objectGenerator\vehicleManagement.sqf"

params ["_thisTrigger", ["_numberOfWaves", 1]];

//diag_log format ["Log : checkDefendArea , _thisTrigger = %1 , getPos _thisTrigger = %2 , associatedTask = %3", _thisTrigger, getPos _thisTrigger, _thisTrigger getVariable "associatedTask"];

//Define number of waves default value
if (_numberOfWaves == 0 ) then 
{
	_numberOfWaves = missionNameSpace getVariable ["defenseNumberWaves", 1];
};

//Count independent and blufor player
_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);

//diag_log format ["Log : checkDefendArea , _nbBluePlayer = %1, _nbIndPlayer = %2, _nbOpfor = %3", _nbBluePlayer, _nbIndPlayer, _nbOpfor];

[[_thisTrigger] , "GUI\dominationGUI\dominationGUI.sqf"] remoteExec ['BIS_fnc_execVM', 0, true];

//Check if there's IA on the area on the beginning
while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_opforMembers = (allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger;
	_nbOpfor = count (_opforMembers);
	//diag_log format ["Log : checkClearArea , _nbBluePlayer = %1, _nbIndPlayer = %2, _nbOpfor = %3", _nbBluePlayer, _nbIndPlayer, _nbOpfor];
	if (_nbOpfor < 10) then 
	{
		{
			//Display opfor position on map
			[_x] call drawIAPositionOnMap;
		}	foreach _opforMembers;
	};
};

//Setup time of each waves
_timeOfWaves = missionNameSpace getVariable ["defenseTimeWaves", 300];

//SetupInit Difficulty 
missionDifficultyParamModified = missionDifficultyParam;

//Deploy multiples opfor reinforcement waves
for [{_waveCount = 0}, {_waveCount < _numberOfWaves}, {_waveCount = _waveCount + 1}] do
{
	[getPos _thisTrigger, missionDifficultyParamModified, baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, baseEnemyGroup, baseEnemyATGroup, baseEnemyDemoGroup, _waveCount, _timeOfWaves] spawn 
	{
		params ["_triggerPos", "_missionDifficultyParam", "_baseEnemyVehicleGroup", "_baseEnemyLightArmoredVehicleGroup", "_baseEnemyHeavyArmoredVehicleGroup", "_baseEnemyGroup", "_baseEnemyATGroup", "_baseEnemyDemoGroup", "_waveCountInt", "_timeOfWaves"];

		//Wait before incoming wave
		sleep ((_waveCountInt)*_timeOfWaves);
		// sleep (15*_waveCountInt); //Debug only

		//Announce wave number
		if (missionNameSpace getVariable ["defenseAnnounceWaves", 0] == 1 && _waveCountInt != 0) then 
		{
			//systemChat format ["wave number %1, %2", _waveCountInt, (_waveCountInt)*_timeOfWaves]; 
			[[_waveCountInt+1], {params ["_waveCountInt"]; ["STR_RPG_HC_NAME", "STR_RPG_OBJ_DEFEND_WAVE", _waveCountInt] call doDialog}] remoteExec ["spawn", 0]; 
		};

		//Removes vehicles accord to mission settings
		if ((missionNameSpace getVariable ["enableOpforVehicle", 0]) == 0) then 
		{
			_baseEnemyVehicleGroup = [];
			_baseEnemyLightArmoredVehicleGroup = [];
			_baseEnemyHeavyArmoredVehicleGroup = [];
		};

		_baseSelectedVehicle = _baseEnemyVehicleGroup;

		//Armored vehicle management
		if (missionNamespace getVariable ["enableArmoredVehicle", false]) then 
		{
			_baseSelectedVehicle = _baseSelectedVehicle + _baseEnemyLightArmoredVehicleGroup + _baseEnemyHeavyArmoredVehicleGroup;
		};

		//Generate enemy attack wave
		AvalaibleInitAttackPositions = [];
		AvalaibleInitAttackPositions = [_triggerPos, 550, 800, round (_missionDifficultyParam/2)] call getListOfPositionsAroundTarget;
		[AvalaibleInitAttackPositions, _triggerPos, [_baseEnemyGroup,_baseEnemyATGroup, _baseEnemyDemoGroup], _baseSelectedVehicle, _missionDifficultyParam+1] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
	};

	//Increase waves difficulty between each waves
	if ((missionNameSpace getVariable ["defenseIncreaseDifficulty", 1]) == 1) then 
	{
		missionDifficultyParamModified = missionDifficultyParamModified + 1;
	};
};

//diag_log format ["Log : checkDefendArea , enemy generation completed"];

//Show a message for the opfor reinforcement
_thisObjectiveToComplete = _thisTrigger getVariable ["associatedTask", []];
if (!([_thisObjectiveToComplete,[]] call BIS_fnc_areEqual)) then 
{
	_nearestCity = nearestLocations [getPos _thisTrigger, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
	[[_nearestCity], {params ["_nearestCity"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_ENEMY_ATK", text _nearestCity] call doDialog}] remoteExec ["spawn", 0]; 
};

_thisFOBCheck = _thisTrigger getVariable ["isFOBAssociated", false];
if (_thisFOBCheck) then 
{
	[[_thisTrigger], {params ["_thisTrigger"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_ENEMY_REINFORCEMENT_FOB", mapGridPosition (getPos _thisTrigger)] call doDialog}] remoteExec ["spawn", 0]; 
};

//Wait enemy reinforcement
sleep (((_numberOfWaves)*_timeOfWaves)+120);

_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);

//Check if there's opfor on the area after the attack
while {sleep 15; (_nbBluePlayer + _nbIndPlayer != 0 && _nbOpfor > 2)} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);

	_opforMembers = (allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger;
	_nbOpfor = count (_opforMembers);
	//diag_log format ["Log : checkClearArea , _nbBluePlayer = %1, _nbIndPlayer = %2, _nbOpfor = %3", _nbBluePlayer, _nbIndPlayer, _nbOpfor];
	if (_nbOpfor < 10) then 
	{
		{
			//Display opfor position on map
			[_x] call drawIAPositionOnMap;
		}	foreach _opforMembers;
	};
};

//Check tasks
if (!([_thisObjectiveToComplete,[]] call BIS_fnc_areEqual)) then 
{
	//Check if there are players inside the area
	//If not it means that opfor wins
	if (_nbBluePlayer + _nbIndPlayer == 0 && _nbOpfor > 2) then 
	{
		//Objective failed
		_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
		_missionFailedObjectives = _missionFailedObjectives + [_thisObjectiveToComplete]; //needs to be improved
		missionNamespace setVariable ["missionFailedObjectives", _missionFailedObjectives, true];
		
		//Manage task system
		if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
		{
			[_thisObjectiveToComplete#2, "FAILED"] call BIS_fnc_taskSetState;
		};

	} else 
	{
		//Objective complete
		[_thisObjectiveToComplete] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
		[{[50, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];

		//Manage Completed Objective
		_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
		_completedObjectives pushBack _thisObjectiveToComplete;
		missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	

		[] call doIncrementAllCredits;	

		//Call respawn
		if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
		{
			[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
		};
	};
};

//Check FOB clear
if (_thisFOBCheck) then 
{
	//Hint players for cleared FOB
	[[_thisTrigger], {params ["_thisTrigger"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_FOB_CLEARED", mapGridPosition (getPos _thisTrigger)] call doDialog}] remoteExec ["spawn", 0]; 

	//Add this FOB to cleared FOB
	_OpforFOBCleared = missionNamespace getVariable ["OpforFOBCleared", 0];
	missionNamespace setVariable ["OpforFOBCleared", _OpforFOBCleared+1, true];	

	//Give 25 XP for FOB clearing
	[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];

	//Respawn players 
	[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];

	//Give token to players
	[[], 
	{
		params ["_unit", "_instigator"];
	 	_unblockCredit = profileNameSpace getVariable ["RPG_UnlockCredit",0];
		profileNameSpace setVariable ["RPG_UnlockCredit",_unblockCredit+1];
	}
	] remoteExec ["spawn", 0]; 

};

_thisTrigger enableSimulation false;