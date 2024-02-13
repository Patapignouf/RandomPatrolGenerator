params ["_airAttackVehicleClass", "_destinationPos"];


//spawn enemyGroup
_vehicleAirAttackGroup = [[_airAttackVehicleClass], [selectRandom [0,worldSize],selectRandom [0,worldSize],10000], east, ""] call doGenerateEnemyGroup;

//enable groups
_vehicleAirAttackGroup enableDynamicSimulation false;

//Add Experience
//Add eventhandler killed
(leader (_vehicleAirAttackGroup)) addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	if (isPlayer _instigator) then 
	{
		[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
	}; 
}];


//Attack to position
wp2 = _vehicleAirAttackGroup addWaypoint [_destinationPos, 100];
wp2 setwaypointtype"MOVE"; 

//TEMP feature - In the future there will be a dynamic side quest assignement
//50% chance to setup the side mission 
if (random 100 < 50) then 
{
	[[format ["%1%2","_sideQuestPlane", random 10000],"DestroyPlane", getPos leader (_vehicleAirAttackGroup), vehicle leader _vehicleAirAttackGroup], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 0];
};