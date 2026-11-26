params ["_enemyGroup", "_transportVehicle", "_destinationParadropPos"];


//spawn enemyGroup
private _currentEnemyGroup = [_enemyGroup, [0,0], east, ""] call doGenerateEnemyGroup;

//spawn enemy vehicle
//Setup final destination pos at the opposite of the init pos 
private _futurePos = [_destinationParadropPos] call getEdgePoints;
private _initPos = _futurePos#0;
private _finalDestinationPos = _futurePos#1;

//  systemChat str _destinationParadropPos;

//_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0,worldSize],selectRandom [0,worldSize],500], east, ""] call doGenerateEnemyGroup;
//[baseEnemyGroup, selectRandom baseEnemyUnarmedChopperGroup, getPos player] execVM 'enemyManagement\behaviorEngine\doParadrop.sqf'; 

// _vehicleTransportGroup = [[_transportVehicle], [selectRandom [0-random 200,worldSize+ random 200],selectRandom [0- random 200,worldSize+ random 200]], east, ""] call doGenerateEnemyGroup;
_vehicleTransportGroup = [[_transportVehicle], [_initPos#0, _initPos#1, 500], east, ""] call doGenerateEnemyGroup;

private _heli = vehicle (leader _vehicleTransportGroup);

//Add Experience
//Add eventhandler killed
_vehicleFromGroup = vehicle (leader _vehicleTransportGroup);

[_vehicleFromGroup] call addVehicleXPSetup;

//Prepare group cleaning
if (count units _currentEnemyGroup != 0) then 
{
	(units _currentEnemyGroup) apply {
		[_x] spawn 
		{
			params ["_thisUnit"];
			sleep 3600;
			deleteVehicle _thisUnit;
		};
	};
};

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
wp1 = _vehicleTransportGroup addWaypoint [_destinationParadropPos, 0];
wp1 setwaypointtype"MOVE"; 
wp1 setWaypointBehaviour "AWARE";
wp1 setWaypointCombatMode "BLUE";
wp1 setWaypointSpeed "FULL";
wp1 setWaypointCompletionRadius 150;

wp2 = _vehicleTransportGroup addWaypoint [_finalDestinationPos, 0];
wp2 setwaypointtype"MOVE"; 
wp2 setWaypointBehaviour "AWARE";
wp2 setWaypointCombatMode "BLUE";
wp2 setWaypointSpeed "FULL";
wp2 setWaypointCompletionRadius 150;

_heli flyInHeight [150, true];	// helicopter will hover at 150m altitude

_vehicleTransportGroup setCurrentWaypoint wp1;

// systemChat str (_destinationParadropPos);

sleep 3;

waitUntil {[(getPos _heli)#0,(getPos _heli)#1,0] distance _destinationParadropPos < 400};

//set second waypoint as active wp
_vehicleTransportGroup setCurrentWaypoint wp2;


//Do paradrop units
[_currentEnemyGroup, _destinationParadropPos] spawn 
{
	params ["_currentEnemyGroup", "_destinationParadropPos"];
	{
		_unit = _x;
		sleep 0.1;

		//Protect unit from damage with vehicle
		_unit allowDamage false;

		_unit addBackpack "B_Parachute";

		//Eject with parachute
		_unit action ["GetOut", vehicle _unit];

		unassignVehicle _unit;

		sleep 0.5;

		//Make unit normal again
		[_unit] spawn 
		{
			params ["_thisUnit"];

			sleep 5;
			_thisUnit allowDamage true;
		};

	} forEach (units _currentEnemyGroup);

	[_currentEnemyGroup, _destinationParadropPos] call BIS_fnc_taskAttack;
};



sleep 300;
deleteVehicle _heli;



