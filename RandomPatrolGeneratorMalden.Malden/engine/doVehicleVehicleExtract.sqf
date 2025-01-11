params ["_transportVehicle", "_destinationPos"];

//spawn enemy vehicle
//_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0,worldSize],selectRandom [0,worldSize],500], east, ""] call doGenerateEnemyGroup;

_tempPos = [selectRandom [_destinationPos#0-2000 ,_destinationPos#0+2000],selectRandom [_destinationPos#1-2000 ,_destinationPos#1+2000]];

_vehicleTransportGroup = [[_transportVehicle], _tempPos, blufor, ""] call doGenerateEnemyGroup;
_heli = vehicle (leader _vehicleTransportGroup);

//enable groups
_vehicleTransportGroup enableDynamicSimulation false;

//Go to landing pos
_lzSafePos = [_destinationPos, 0, 250, 10, 0, 0.25, 0, [], [_destinationPos, _destinationPos]] call BIS_fnc_findSafePos;
_lz =  createVehicle ["Land_HelipadEmpty_F", _lzSafePos, [], 0, "NONE"];
wp1 = _vehicleTransportGroup addWaypoint [_lzSafePos, -1];
wp1 setwaypointtype"TR UNLOAD"; 
wp1 setWaypointBehaviour "CARELESS";
wp1 setWaypointCombatMode "BLUE";
wp1 setWaypointSpeed "FULL";
wp1 setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"]; 

//Waiting for heli to land
waitUntil {isTouchingGround (_heli)};

//Add action to take off
[_heli, [format ["Extract"],{
		params ["_object","_caller","_ID","_thisParams"];
		
		[{["STR_RPG_CHOPPER_NAME", "STR_RPG_HC_CREW_READY_TO_TAKE_OFF"] call doDialog}] remoteExec ["call", blufor];

		//Delete extract actions
		_object setVariable ["helicopterReady", true, true];
		[_object] remoteExec ["removeAllActions", 0, true];
	},[],1.5,true,true,"","_target distance _this <5"]] remoteExec ["addAction", 0, true];

//Wait for chopper to be ready and with players
waitUntil {_heli getVariable ["helicopterReady", false] == true};


//Go to blufor base
_lzPos = initBlueforLocation findEmptyPosition [30, 300,"Land_HelipadCircle_F"];
wp2 = _vehicleTransportGroup addWaypoint [_lzPos, -1];
wp2 setwaypointtype"MOVE"; 

_lz =  createVehicle ["Land_HelipadEmpty_F", _lzPos, [], 0, "NONE"];
wp1 = _vehicleTransportGroup addWaypoint [_lzPos, -1];
wp1 setwaypointtype"TR UNLOAD"; 
wp1 setWaypointBehaviour "CARELESS";
wp1 setWaypointCombatMode "BLUE";
wp1 setWaypointSpeed "FULL";
wp1 setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"]; 

//Waiting for crew to dismount
waitUntil {isTouchingGround (_heli)};
sleep 600;

//back to map border
wp2 = _vehicleTransportGroup addWaypoint [[selectRandom [0,worldSize],selectRandom [0,worldSize]], 25];
wp2 setwaypointtype"MOVE"; 

sleep 1000;
deleteVehicle _heli;


