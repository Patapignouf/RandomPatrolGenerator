#include "..\..\engine\searchLocation.sqf"

waitUntil {!isNil"initBlueforLocation"};
waitUntil {(!([initBlueforLocation, [0,0,0]] call BIS_fnc_areEqual))};

//Generate Opfor small FOB
//Protect player from nearby spawn
_trgAOC = createTrigger ["EmptyDetector", initBlueforLocation];
_trgAOC setTriggerArea [400, 400, 0, true];

//Exclude map border from FOB generation
_mapBorder = [
	[-5000, call BIS_fnc_mapSize + 5000,0], [50, -5000,0], //left rectangle
	[-5000, call BIS_fnc_mapSize + 5000,0], [call BIS_fnc_mapSize+5000, call BIS_fnc_mapSize,0], //Top rectangle
	[call BIS_fnc_mapSize, call BIS_fnc_mapSize + 5000,0], [call BIS_fnc_mapSize  +5000, -5000,0], //Right rectangle
	[-5000, 50,0], [call BIS_fnc_mapSize  +5000, -5000,0] //left rectangle
];

_mapBorder pushBack _trgAOC;

_spawnAttempts = 0;
_OpforFobLocation = [initCityLocation, 400, (aoSize+1500), 30, 0, 0.20, 0, [_mapBorder], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
while {([_OpforFobLocation] call isLocationOnMap) && _spawnAttempts <10} do 
{
	_OpforFobLocation = [initCityLocation, 400, (aoSize+1500), 30, 0, 0.20, 0, [_mapBorder], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	_spawnAttempts = _spawnAttempts +1;
};
if (!([_OpforFobLocation] call isLocationOnMap)) then
{
	
	//Spawn FOB
	_spawnFOBObjects = [_OpforFobLocation, (random 360), selectRandom avalaibleEnemyFOB] call BIS_fnc_ObjectsMapper;
	_OpforFobStandardOpforLocation = nearestObjects [_OpforFobLocation, ["Sign_Arrow_Large_F"], 100];
	_OpforFobTurretOpforLocation = nearestObjects [_OpforFobLocation, ["Sign_Arrow_Large_Yellow_F"], 100];
	diag_log format ["Display _OpforFobStandardOpforLocation : %1 ",_OpforFobStandardOpforLocation];
	diag_log format ["Display _OpforFobTurretOpforLocation : %1 ",_OpforFobTurretOpforLocation];

	_basicEnemyGroups = [[opFaction, "BASIC"] call getBasicUnitsGroup, [opFaction, "AT"] call getBasicUnitsGroup];

	//Spawn Garrison units
	for [{_i = 0}, {_i <= 2}, {_i = _i + 1}] do
	{
		_opforFOBGarrison = [selectRandom _basicEnemyGroups, _OpforFobLocation , east, "DefenseFOBInfantry"] call doGenerateEnemyGroup;
		{
			_randomAvalaiblePos = selectRandom _OpforFobStandardOpforLocation;
			_x setPosASL (getPosASL _randomAvalaiblePos);
			_x disableAI "PATH";
			_x setDir (getDir _randomAvalaiblePos);
			//[_x, "STAND1", "ASIS"] remoteExecCall ["BIS_fnc_ambientAnim"]; //make unit anim
			deleteVehicle _randomAvalaiblePos;
			_OpforFobStandardOpforLocation = _OpforFobStandardOpforLocation - [_randomAvalaiblePos];
		} foreach units _opforFOBGarrison;
	};


	//Spawn turret Units
	_opforFOBGarrisonTurret = [selectRandom _basicEnemyGroups, _OpforFobLocation , east, ""] call doGenerateEnemyGroup;
	{
		_randomAvalaiblePos = selectRandom _OpforFobTurretOpforLocation;
		if (!isNil "_randomAvalaiblePos") then 
		{
			_turret = createVehicle ["B_G_HMG_02_high_F", getPosATL _randomAvalaiblePos, [], 0, "CAN_COLLIDE"];
			_turret setDir (getDir _randomAvalaiblePos);
			_x moveInAny _turret;
			_x disableAI "PATH";
			deleteVehicle _randomAvalaiblePos;
			_OpforFobTurretOpforLocation = _OpforFobTurretOpforLocation - [_randomAvalaiblePos];
		} else 
		{
			//Clean unit without turret
			deleteVehicle _x;
		};
	}
	foreach units _opforFOBGarrisonTurret;

	//Clean arrows
	{
		deleteVehicle _x;
	} foreach _OpforFobStandardOpforLocation + _OpforFobTurretOpforLocation;
	
	//Set check area
	_objectiveObject = createTrigger ["EmptyDetector", _OpforFobLocation]; //create a trigger area created at object with variable name my_object
	_objectiveObject setTriggerArea [200, 200, 0, false];
	_objectiveObject setVariable ["isFOBAssociated", true, true];

	//Randomize if enemy FOB will received reinforcement
	if (random 100 < 50) then 
	{
		//50%
		[_objectiveObject] execVM 'engine\objectiveManagement\checkClearArea.sqf';
	} else 
	{
		//50%
		[_objectiveObject, 1] execVM 'engine\objectiveManagement\checkDefendArea.sqf';
	};

	if (random 100 < 50) then 
	{
		[[format ["%1%2","_sideQuestFOB", random 10000],"AttackFOB", _OpforFobLocation, objNull], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 2];

		//Locate on map
		if (missionNameSpace getVariable ["enableObjectiveExactLocation", 0] != 0) then 
		{
			[["FOB", "ColorRed", "b_hq", _OpforFobLocation, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
		};
	};
};

deletevehicle _trgAOC;

