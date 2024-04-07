params ["_airAttackVehicleClass", "_destinationPos"];


//spawn enemyGroup
_vehicleAirAttackGroup = [[_airAttackVehicleClass], [selectRandom [0,worldSize],selectRandom [0,worldSize],10000], east, ""] call doGenerateEnemyGroup;

//enable groups
_vehicleAirAttackGroup enableDynamicSimulation false;

//Add Experience
//Add eventhandler killed
_vehicleFromGroup = vehicle (leader _vehicleAirAttackGroup);
_vehicleFromGroup addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
	if (_damage > 0.8 && !(_unit getVariable ["isAlmostDead", false])) then 
	{
		_unit setVariable ["isAlmostDead", true, true];
		_unit setDamage 1;
		
		if (isPlayer _instigator) then 
		{
			[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
		}; 
	};
}];


//Attack to position
wp2 = _vehicleAirAttackGroup addWaypoint [_destinationPos, 100];
wp2 setwaypointtype"MOVE"; 

//TEMP feature - In the future there will be a dynamic side quest assignement
//50% chance to setup the side mission 
if (random 100 < 50) then 
{
	[[format ["%1%2","_sideQuestAirVehicle", random 10000],"DestroyAirVehicle", getPos leader (_vehicleAirAttackGroup), vehicle leader _vehicleAirAttackGroup], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 2];
};