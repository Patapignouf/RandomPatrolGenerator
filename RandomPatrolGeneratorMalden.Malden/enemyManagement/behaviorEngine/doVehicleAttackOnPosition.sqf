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

		//Clean vehicle
		[_unit] spawn {
			params ["_unit"];
			sleep 600;
			deleteVehicle _unit;
		};

		[_unit] remoteExec ["removeAllActions", 0, true];
	};
}];

_killedForExp = _vehicleFromGroup addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	if (isPlayer _instigator) then 
	{
		[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
		[_unit, "HandleDamage"] remoteExec ["removeAllEventHandlers", 0, true];
	}; 
	//Clean vehicle
	[_unit] spawn {
		params ["_unit"];
		sleep 600;
		deleteVehicle _unit;
	};

	[_unit] remoteExec ["removeAllActions", 0, true];
}];

//Add sabotage on vehicle 
//Engineer only
[
	_vehicleFromGroup, 
	"Sabotage the vehicle", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
	"(_this distance _target < 5) && (_this getVariable 'role' == 'engineer') && (({alive _x} count (crew _target))==0)",		// Condition for the action to be shown
	"_caller distance _target < 5",		// Condition for the action to progress
	{
		// Action start code
	}, 
	{
		// Action on going code
	},  
	{
		// Action successfull code
		params ["_object","_caller","_ID","_objectParams","_progress","_maxProgress"];
		
		//Reward player
		[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _caller];

		//Destroy the vehicle
		[_object, "HandleDamage"] remoteExec ["removeAllEventHandlers", 0, true];
		_killedForExp = _object getVariable ["EHKilledForXP", 0];
		[_object, ["Killed", _killedForExp]] remoteExec ["removeEventHandler", 0, true];
		
		//destroy vehicle
		[_object] spawn {
			params ["_object"];
			sleep 10;
			_object setVehicleArmor 0;

			//Clean vehicle
			sleep 600;
			deleteVehicle _object;
		};
	}, 
	{
		// Action failed code
	}, 
	[],  
	15,
	5, 
	true, 
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

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