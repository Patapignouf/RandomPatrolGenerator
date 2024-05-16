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
	if ((_unit getHit "motor") > 0.7 && !(_unit getVariable ["isAlmostDead", false])) then 
	{


		_unit setVariable ["isAlmostDead", true, true];
		_unit setDamage 1;
		
		if (isPlayer _instigator) then 
		{
			[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
			_killedForExp = _unit getVariable ["EHKilledForXP", 0];
			[_unit, ["Killed", _killedForExp]] remoteExec ["removeEventHandler", 0, true];
		}; 
		sleep 600;
		deleteVehicle _unit;
	};
}];

_killedForExp = _vehicleFromGroup addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if ((_unit getHit "motor") > 0.7 && !(_unit getVariable ["isAlmostDead", false])) then 
	{	
		if (isPlayer _instigator) then 
		{
			[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
			[_unit, "HandleDamage"] remoteExec ["removeAllEventHandlers", 0, true];
		}; 
		sleep 600;
		deleteVehicle _unit;
	};
}];

_vehicleFromGroup setVariable ["EHKilledForXP", _killedForExp, true];

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