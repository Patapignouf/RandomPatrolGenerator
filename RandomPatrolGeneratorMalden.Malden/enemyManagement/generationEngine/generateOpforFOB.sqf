#include "..\..\engine\searchLocation.sqf"

//Generate Opfor small FOB
//Protect player from nearby spawn
_trgAOC = createTrigger ["EmptyDetector", initBlueforLocation];
_trgAOC setTriggerArea [200, 200, 0, true];

_spawnAttempts = 0;
_OpforFobLocation = [getPos initCityLocation, 400, (aoSize+1500), 30, 0, 0.15, 0, [_trgAOC], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
while {([_OpforFobLocation] call isLocationOnMap) && _spawnAttempts <10} do 
{
	_OpforFobLocation = [getPos initCityLocation, 400, (aoSize+1500), 30, 0, 0.15, 0, [_trgAOC], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
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

	//Spawn Garrison units
	_opforFOBGarrison = [selectRandom EnemyWaveLevel_1 + selectRandom EnemyWaveLevel_1, _OpforFobLocation , east, "DefenseFOBInfantry"] call doGenerateEnemyGroup;
	{
		_randomAvalaiblePos = selectRandom _OpforFobStandardOpforLocation;
		_x setPos (getPos _randomAvalaiblePos);
		_x disableAI "PATH";
		_x setDir (getDir _randomAvalaiblePos);
		deleteVehicle _randomAvalaiblePos;
		_OpforFobStandardOpforLocation = _OpforFobStandardOpforLocation - [_randomAvalaiblePos];
	}
	foreach units _opforFOBGarrison;

	//Spawn turret Units
	_opforFOBGarrisonTurret = [selectRandom EnemyWaveLevel_1, _OpforFobLocation , east, ""] call doGenerateEnemyGroup;
	{
		_randomAvalaiblePos = selectRandom _OpforFobTurretOpforLocation;
		if (!isNil "_randomAvalaiblePos") then 
		{
			_turret = createVehicle ["B_G_HMG_02_high_F", getPosASL _randomAvalaiblePos, [], 0, "NONE"];
			_turret setDir (getDir _randomAvalaiblePos);
			_x moveInAny _turret;
			_x disableAI "MOVE";
			deleteVehicle _randomAvalaiblePos;
			_OpforFobTurretOpforLocation = _OpforFobTurretOpforLocation - [_randomAvalaiblePos];
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
	if (round random 2 == 0) then 
	{
		//33%
		[_objectiveObject] execVM 'engine\objectiveManagement\checkClearArea.sqf';
	} else 
	{
		//66%
		[_objectiveObject] execVM 'engine\objectiveManagement\checkDefendArea.sqf';
	};
};



