#include "..\..\objectGenerator\vehicleXPManagement.sqf" 

params ["_enemyGroup", "_transportVehicle", "_destinationPos"];

//spawn enemyGroup
_currentEnemyGroup = [_enemyGroup, [0,0], east, ""] call doGenerateEnemyGroup;

//spawn enemy vehicle
//_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0,worldSize],selectRandom [0,worldSize],500], east, ""] call doGenerateEnemyGroup;
//[baseEnemyGroup, selectRandom baseEnemyUnarmedChopperGroup, getPos player] execVM 'enemyManagement\behaviorEngine\doParadrop.sqf'; 

_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0-random 200,worldSize+ random 200],selectRandom [0- random 200,worldSize+ random 200]], east, ""] call doGenerateEnemyGroup;
_heli = vehicle (leader _vehicleTransportGroup);

//Add Experience
//Add eventhandler killedssssssss
_vehicleFromGroup = vehicle (leader _vehicleTransportGroup);

[_vehicleFromGroup] call addVehicleXPSetup;


//enable groups
_vehicleTransportGroup enableDynamicSimulation false;
_currentEnemyGroup enableDynamicSimulation false;

//Place enemy in vehicle
{
	_x assignAsCargo _heli;
	_x moveIncargo _heli;
} 
forEach (units _currentEnemyGroup);

//Go to landing pos
wp1 = _vehicleTransportGroup addWaypoint [_destinationPos, 20];
wp1 setwaypointtype"MOVE"; 
wp1 setWaypointBehaviour "CARELESS";
wp1 setWaypointCombatMode "BLUE";
wp1 setWaypointSpeed "FULL";
wp1 setWaypointCompletionRadius 150;


waitUntil {[(getPos _heli)#0,(getPos _heli)#1,0] distance _destinationPos < 400};


//drop group
{
	_unit = _x;
	sleep 0.1;
	_parachute = "B_parachute_02_F" createVehicle [0,0,0];
	moveOut _unit;
	_parachute setPosASL (getPosASL _unit);
	_unit attachTo [_parachute, [0, 0, -1.3]];
} forEach (units _currentEnemyGroup); 


//Attack specific pos
[_currentEnemyGroup, _destinationPos] call doAttack; 

//back to map border
wp2 = _vehicleTransportGroup addWaypoint [[selectRandom [0,worldSize],selectRandom [0,worldSize]], 25];
wp2 setwaypointtype"MOVE"; 

sleep 1000;
deleteVehicle _heli;


