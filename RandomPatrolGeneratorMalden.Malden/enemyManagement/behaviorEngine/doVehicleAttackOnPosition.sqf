params ["_airAttackVehicleClass", "_destinationPos"];


//spawn enemyGroup
_vehicleAirAttackGroup = [[_airAttackVehicleClass], [selectRandom [0,worldSize],selectRandom [0,worldSize],10000], east, ""] call doGenerateEnemyGroup;

//enable groups
_vehicleAirAttackGroup enableDynamicSimulation false;

//Add Experience
//Add eventhandler killed
(leader (_vehicleAirAttackGroup)) addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	if (isPlayer _killer) then 
	{
		[[5], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _killer];
	}; 
}];


//Attack to position
wp2 = _vehicleAirAttackGroup addWaypoint [_destinationPos, 100];
wp2 setwaypointtype"MOVE"; 

