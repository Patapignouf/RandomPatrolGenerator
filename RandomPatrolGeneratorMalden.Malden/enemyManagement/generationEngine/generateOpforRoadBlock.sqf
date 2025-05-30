#include "..\..\engine\searchLocation.sqf"

params ["_possibleRoadBlockLocation"];

//Generate Opfor small FOB
//Protect player from nearby spawn
waitUntil {!isNil "initBlueforLocation"};
_trgAOC = createTrigger ["EmptyDetector", initBlueforLocation];
_trgAOC setTriggerArea [200, 200, 0, true];

_spawnAttempts = 0;
_possibleRoadBlock = [_possibleRoadBlockLocation, 1000] call findRoadBlockPosition;
_possibleRoadPosition = _possibleRoadBlock#0;
_possibleRoadDir = _possibleRoadBlock#1;

if (!([_possibleRoadPosition] call isLocationOnMap)) then
{
	//Spawn FOB
	_spawnFOBObjects = [_possibleRoadPosition, _possibleRoadDir, selectRandom avalaibleRoadBlock] call BIS_fnc_ObjectsMapper;
	_OpforFobStandardOpforLocation = nearestObjects [_possibleRoadPosition, ["Sign_Arrow_Large_F"], 100];
	_OpforFobTurretOpforLocation = nearestObjects [_possibleRoadPosition, ["Sign_Arrow_Large_Yellow_F"], 100];

	//Disable gravity on barrier
	//Temp fix to barrier always falling 
	_OpforFobBarrier = nearestObjects [_possibleRoadPosition, ["RoadBarrier_F"], 50];
	{
		[_x, false] remoteExec ["enableSimulationGlobal", 2];
	} foreach _OpforFobBarrier;

	diag_log format ["Display _OpforFobStandardOpforLocation : %1 ",_OpforFobStandardOpforLocation];
	diag_log format ["Display _OpforFobTurretOpforLocation : %1 ",_OpforFobTurretOpforLocation];

	_basicEnemyGroups = [[opFaction, "BASIC"] call getBasicUnitsGroup, [opFaction, "AT"] call getBasicUnitsGroup];

	//Spawn Garrison units
	_opforFOBGarrison = [selectRandom _basicEnemyGroups, _possibleRoadPosition , east, "RoadblockInfantry"] call doGenerateEnemyGroup;
	{
		if (count _OpforFobStandardOpforLocation > 0) then 
		{
			_randomAvalaiblePos = selectRandom _OpforFobStandardOpforLocation;
			_x setPos (getPos _randomAvalaiblePos);
			_x disableAI "PATH";
			_x setDir (getDir _randomAvalaiblePos);
			deleteVehicle _randomAvalaiblePos;
			_OpforFobStandardOpforLocation = _OpforFobStandardOpforLocation - [_randomAvalaiblePos];

			//Make unit anim
			//[_x, "STAND1", "ASIS"] remoteExecCall ["BIS_fnc_ambientAnim"];

			//Disable IA prone
			_x addEventHandler ["AnimStateChanged",
			{
				params ["_unit", "_anim"];
				if (canStand _unit && (behaviour _unit in ["AWARE","COMBAT"])) then {
				_unit setUnitPos "UP";
				};
			}];

		} else 
		{
			_x hideObjectGlobal true;
			deleteVehicle _x;
		};
	} foreach units _opforFOBGarrison;

	//Clean arrows
	{
		deleteVehicle _x;
	} foreach _OpforFobStandardOpforLocation + _OpforFobTurretOpforLocation;
};

deletevehicle _trgAOC;

