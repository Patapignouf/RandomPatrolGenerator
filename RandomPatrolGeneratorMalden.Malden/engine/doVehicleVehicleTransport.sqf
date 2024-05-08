params ["_transportVehicle", "_destinationPos"];

//spawn enemy vehicle
//_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0,worldSize],selectRandom [0,worldSize],500], east, ""] call doGenerateEnemyGroup;

_vehicleTransportGroup = [[_transportVehicle], [selectRandom [0,worldSize],selectRandom [0,worldSize]], blufor, ""] call doGenerateEnemyGroup;
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
[_heli, [format ["Set transport destination"],{
		params ["_object","_caller","_ID","_thisParams"];

		_vehicleTransportGroup = _thisParams#0;
		
		[_vehicleTransportGroup] spawn {
				params ["_vehicleTransportGroup"];
				//Click on map to Halo spawn
				selectedHaloLoc = [0,0,0];
				openMap true;
				uiSleep 0.5;
				["<t color='#ffffff' size='.8'>Click on map to select a transport destination<br /></t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					//Display information
					_textToSpeech = format ["We are ready to take off, let's go !"];
					[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >Helicopter crew</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", blufor, true];

					//Go to landing pos
					_lzSafePos = [selectedHaloLoc, 0, 250, 10, 0, 0.25, 0, [], [selectedHaloLoc, selectedHaloLoc]] call BIS_fnc_findSafePos;
					_lz =  createVehicle ["Land_HelipadEmpty_F", _lzSafePos, [], 0, "NONE"];
					_tempWaypoint = _vehicleTransportGroup addWaypoint [_lzSafePos, -1];
					_tempWaypoint setwaypointtype"TR UNLOAD"; 
					_tempWaypoint setWaypointBehaviour "CARELESS";
					_tempWaypoint setWaypointCombatMode "BLUE";
					_tempWaypoint setWaypointSpeed "FULL";
					_tempWaypoint setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"]; 
				};
			};
	},[_vehicleTransportGroup],1.5,true,false,"","_target distance _this <5"]] remoteExec ["addAction", 0, true];

