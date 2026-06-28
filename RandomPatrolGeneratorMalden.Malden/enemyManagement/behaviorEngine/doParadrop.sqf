#include "..\..\objectGenerator\vehicleXPManagement.sqf" 

params ["_enemyGroup", "_transportVehicle", "_destinationPos"];


//spawn enemyGroup
_currentEnemyGroup = [_enemyGroup, [0,0], east, ""] call doGenerateEnemyGroup;

//spawn enemy vehicle
//Setup final destination pos at the opposite of the init pos 
_futurePos =[_destinationPos] call getEdgePoints;
_initPos = _futurePos#0;
_finalDestinationPos = _futurePos#1;

//_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0,worldSize],selectRandom [0,worldSize],500], east, ""] call doGenerateEnemyGroup;
//[baseEnemyGroup, selectRandom baseEnemyUnarmedChopperGroup, getPos player] execVM 'enemyManagement\behaviorEngine\doParadrop.sqf'; 

// _vehicleTransportGroup = [[_transportVehicle], [selectRandom [0-random 200,worldSize+ random 200],selectRandom [0- random 200,worldSize+ random 200]], east, ""] call doGenerateEnemyGroup;
_vehicleTransportGroup = [[_transportVehicle], [_initPos#0, _initPos#1, 500], east, ""] call doGenerateEnemyGroup;

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
wp1 = _vehicleTransportGroup addWaypoint [_destinationPos, 0];
wp1 setwaypointtype"MOVE"; 
wp1 setWaypointBehaviour "AWARE";
wp1 setWaypointCombatMode "BLUE";
wp1 setWaypointSpeed "FULL";
wp1 setWaypointCompletionRadius 100;

wp2 = _vehicleTransportGroup addWaypoint [_finalDestinationPos, 0];
wp2 setwaypointtype"MOVE"; 
wp2 setWaypointBehaviour "AWARE";
wp2 setWaypointCombatMode "BLUE";
wp2 setWaypointSpeed "FULL";
wp2 setWaypointCompletionRadius 100;

_heli flyInHeight [150, true];	// helicopter will hover at 150m altitude

_vehicleTransportGroup setCurrentWaypoint wp1;


waitUntil {[(getPos _heli)#0,(getPos _heli)#1,0] distance _destinationPos < 400};


//drop group
// {
// 	_unit = _x;
// 	sleep 0.1;
// 	_parachute = "B_parachute_02_F" createVehicle [0,0,0];
// 	moveOut _unit;
// 	_parachute setPosASL (getPosASL _unit);
// 	_unit attachTo [_parachute, [0, 0, -1.3]];

// 	//Remove parachute after one minute of falling to prevent parachute stuck in buildings/trees
// 	[_parachute] spawn {
// 		params ["_parachute"];
// 		sleep 60;
// 		deleteVehicle _parachute;
// 	};

// } forEach (units _currentEnemyGroup); 


//Delete waypoint
// { deleteWaypoint _x } forEachReversed waypoints _vehicleTransportGroup; 
//back to map border
// _vehicleTransportGroup move [selectRandom [0,worldSize],selectRandom [0,worldSize]];

//Do paradrop units
[_currentEnemyGroup, _destinationPos] spawn 
{
	params ["_currentEnemyGroup", "_destinationPos"];
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

	[_currentEnemyGroup, _destinationPos] call BIS_fnc_taskAttack;
};



sleep 300;
deleteVehicle _heli;



