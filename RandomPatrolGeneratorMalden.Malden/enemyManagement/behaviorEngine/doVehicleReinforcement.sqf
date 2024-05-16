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
_randomPosAroundDest = [[[_destinationPos, 400]], []] call BIS_fnc_randomPos;
_lzPos = _randomPosAroundDest findEmptyPosition [0, 150,"Land_HelipadCircle_F"];
_lz =  createVehicle ["Land_HelipadEmpty_F", _lzPos, [], 0, "NONE"];
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


//Add Experience
//Add eventhandler killed
_vehicleFromGroup = vehicle (leader _vehicleTransportGroup);
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

//back to map border
wp2 = _vehicleTransportGroup addWaypoint [[selectRandom [0,worldSize],selectRandom [0,worldSize]], 25];
wp2 setwaypointtype"MOVE"; 

sleep 1000;
deleteVehicle _heli;


