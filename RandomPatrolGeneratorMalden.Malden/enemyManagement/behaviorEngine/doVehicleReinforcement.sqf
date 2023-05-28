params ["_enemyGroup", "_transportVehicle", "_destinationPos"];


//spawn enemyGroup
_currentEnemyGroup = [_enemyGroup, [0,0], east, ""] call doGenerateEnemyGroup;

//spawn enemy vehicle
//_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0,worldSize],selectRandom [0,worldSize],500], east, ""] call doGenerateEnemyGroup;

_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0,worldSize],selectRandom [0,worldSize]], east, ""] call doGenerateEnemyGroup;
_heli = vehicle (leader _vehicleTransportGroup);

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
_lz =  createVehicle ["Land_HelipadEmpty_F", ([[[_destinationPos, 300]], []] call BIS_fnc_randomPos), [], 0, "NONE"];
wp1 = _vehicleTransportGroup addWaypoint [_lz, 0];
wp1 setwaypointtype"TR UNLOAD"; 
wp1 setWaypointBehaviour "CARELESS";
wp1 setWaypointCombatMode "BLUE";
wp1 setWaypointSpeed "FULL";
wp1 setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"]; 
waitUntil {isTouchingGround (_heli)};

//Attack specific pos
_currentEnemyGroup leaveVehicle _heli;
[_currentEnemyGroup, _destinationPos] execVM 'enemyManagement\behaviorEngine\doAttack.sqf'; 

//back to map border
wp2 = _vehicleTransportGroup addWaypoint [[selectRandom [0,worldSize],selectRandom [0,worldSize]], 25];
wp2 setwaypointtype"MOVE"; 

sleep 1000;
deleteVehicle _heli;


