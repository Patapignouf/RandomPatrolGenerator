#include "..\..\objectGenerator\vehicleXPManagement.sqf" 

params ["_airAttackVehicleClass", "_destinationPos"];

//spawn enemyGroup
_vehicleAirAttackGroup = [[_airAttackVehicleClass], [selectRandom [0,worldSize],selectRandom [0,worldSize],10000], east, ""] call doGenerateEnemyGroup;

//enable groups
_vehicleAirAttackGroup enableDynamicSimulation false;

//Add Experience
//Add eventhandler killed
_vehicleFromGroup = vehicle (leader _vehicleAirAttackGroup);
[_vehicleFromGroup] call addVehicleXPSetup;


//Attack to position
wp2 = _vehicleAirAttackGroup addWaypoint [_destinationPos, 100];
wp2 setwaypointtype"MOVE"; 
wp2 setWaypointBehaviour "COMBAT";

//TEMP feature - In the future there will be a dynamic side quest assignement
//50% chance to setup the side mission 
if (random 100 < 50) then 
{
	[[format ["%1%2","_sideQuestAirVehicle", random 10000],"DestroyAirVehicle", getPos leader (_vehicleAirAttackGroup), vehicle leader _vehicleAirAttackGroup], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 2];
};