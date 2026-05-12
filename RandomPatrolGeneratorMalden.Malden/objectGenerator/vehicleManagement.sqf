//Function to generate vehicle around a position
//Specific parameters for boat
doGenerateVehicleForFOB = 
{
	//Define parameters
	params ["_thisPosition","_thisVehicleList","_thisMinRadius","_thisMaxRadius"];

	_dummyVehicle = "Land_HelipadCircle_F"; // Specific vehicle class which work great with findEmptyPosition
	_vehicleSpawned = [];

	//Define process 
	_shipGoodPosition = [0,0,0];
	{
		//Define current vehicle
		_vehicleClass = _x select 0;
		_isUAV = _x select 1;
		_currentVehicle = objNull;

		switch (true) do {   
			case (_vehicleClass isKindOf "StaticWeapon"):
			{
				_spawnAttempts = 0;
				_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_dummyVehicle];
				while {(isNil "_vehicleGoodPosition" || count _vehicleGoodPosition==0) && _spawnAttempts <10} do 
				{
					_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_dummyVehicle];
					_spawnAttempts = _spawnAttempts +1;
				};
				if (!isNil "_vehicleGoodPosition" && count _vehicleGoodPosition>0) then 
				{
					diag_log format ["Position to spawn vehicle is not Nil %1",_vehicleGoodPosition];
					_currentVehicle = createVehicle [_vehicleClass, _vehicleGoodPosition , [], 0, "NONE"];
				};
			};
			case (_vehicleClass isKindOf "Tank"); 
			case (_vehicleClass isKindOf "Car"): {
						_kind = "Car";
						_spawnAttempts = 0;
						_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_dummyVehicle];
						while {(isNil "_vehicleGoodPosition" || count _vehicleGoodPosition==0) && _spawnAttempts <10} do 
						{
							_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_dummyVehicle];
							_spawnAttempts = _spawnAttempts +1;
						};
						if (!isNil "_vehicleGoodPosition" && count _vehicleGoodPosition>0) then 
						{
							diag_log format ["Position to spawn vehicle is not Nil %1",_vehicleGoodPosition];
							_currentVehicle = createVehicle [_vehicleClass, _vehicleGoodPosition , [], 0, "NONE"];
						};

					if ((missionNameSpace getVariable ["enableSoloCrewTank", 1] == 1) && (_vehicleClass isKindOf "Tank" || _vehicleClass isKindOf "TrackedAPC" || _vehicleClass isKindOf "WheeledAPC")) then 
					{
						//Allow player to control all role of the tank at the same time
						//Script by XallZalls Ultimate Script Collection
						//Origin https://steamcommunity.com/sharedfiles/filedetails/?id=2792607593
						//Dirty fix for dedicated server
						[[_currentVehicle], { 
							params ["_currentVehicle"];  
        
							_currentVehicle call 
							{  
								if (true) then 
								{ 
								_currentVehicle lockTurret [[0], true];  
								_currentVehicle lockTurret [[0,0], true];  
								_currentVehicle lockCargo true;  

								_currentVehicle addMPEventHandler ["MPKilled", 
								{ 
									if (true) then 
									{ 
										_d = driver (_this select 0);  
										_g = gunner (_this select 0);  
										if (!isNull _d) then {deleteVehicle _d};  
										if (!isNull _g) then {_g setDamage 1};  
									};  
								}];  
								
								_currentVehicle addEventHandler ["GetIn", 
								{
									enableSentences false;  
									_tank = _this select 0;  
									_unit = _this select 2; 
									//		hint format ["name %1 enter %2", name _unit, _tank]; 
							
									_unit allowDamage false;
									if (player == _unit) then 
									{
										_unit action ["EngineOn", _tank];  
										_unit action ["MoveToGunner", _tank];  
										_tank lock true;  
										_tank switchCamera "EXTERNAL"; // May disable this line to prevent camera switch 
										_tank addAction [localize "str_action_getout", 
										{  
											_this select 0 removeAction (_this select 2);  
											_this select 1 action ["GetOut", _this select 0];  
										}, "", 3, false, true, "GetOver"];  

										_tank spawn 
										{  
											waitUntil {!isNull gunner _this};
												
											_ai = createAgent 
											[ 
												typeOf gunner _this, [0,0,0], [], 0, "NONE"  
											];  
											_ai allowDamage false;  
											_ai moveInDriver _this;  
										};  
									};

								}];
								
								_currentVehicle addEventHandler ["GetOut", 
								{  
									if (player == _unit) then 
									{
										_tank = _this select 0;  
										_unit = _this select 2;  
										deleteVehicle driver _tank;  
										_unit allowDamage true;  
										_unit action ["EngineOff", _tank];  
										_tank lock false;  
										enableSentences true;  
									};
								}];  
								};  
							}; 
							}] remoteExec ["spawn", 0];
						
					};
				};   
			case (_vehicleClass isKindOf "Ship"): {
					_kind = "Ship";
					_spawnAttempts = 0;
					//In the specific case of boat, max radius is replaced by 1000 to find water inArea

					_shipShorePosition = ([[[_thisPosition, 2000]], [], { !(_this isFlatEmpty  [-1, -1, -1, -1, 0, true] isEqualTo []) }] call BIS_fnc_randomPos);
					_shipGoodPosition = ([[[_shipShorePosition, 30]], [], { !(_this isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []) }] call BIS_fnc_randomPos);

					while {([_shipShorePosition , [0,0]] call BIS_fnc_areEqual) && _spawnAttempts <10} do 
					{
						_shipShorePosition = ([[[_thisPosition, 2000]], [], { !(_this isFlatEmpty  [-1, -1, -1, -1, 0, true] isEqualTo []) }] call BIS_fnc_randomPos);
						_shipGoodPosition = ([[[_shipShorePosition, 30]], [], { !(_this isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []) }] call BIS_fnc_randomPos);
						_spawnAttempts = _spawnAttempts +1;
					};
					if (!isNil "_shipGoodPosition" && count _shipGoodPosition>0 && !([_shipShorePosition , [0,0]] call BIS_fnc_areEqual)) then 
					{
						diag_log format ["Position to spawn vehicle is not Nil %1",_shipGoodPosition];
						_currentVehicle = createVehicle [_vehicleClass, _shipGoodPosition , [], 0, "NONE"];

						//Nudge code from DRO to move boat stuck on beach
						[
							_currentVehicle,
							[
								"Nudge",  
								{  
									_dir = [(_this select 1), (_this select 0)] call BIS_fnc_dirTo;  
									//_nudgePos = [(getPos (_this select 0)), 2, _dir] call dro_extendPos;  
									(_this select 0) setVelocity [(sin _dir)*3, (cos _dir)*3, 0.5];	
								},  
								nil,  
								6,  
								false,  
								false,  
								"",  
								"(_this distance _target < 8) && (vehicle _this == _this)"
							]
						] remoteExec ["addAction", 0, true];
					};
				};    
			case (_vehicleClass isKindOf "Helicopter"): {
					_kind = "Helicopter";
					_spawnAttempts = 0;
					_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_vehicleClass];
					while {(isNil "_vehicleGoodPosition" || count _vehicleGoodPosition==0) && _spawnAttempts <10} do 
					{
						_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_vehicleClass];
						_spawnAttempts = _spawnAttempts +1;
					};
					if (!isNil "_vehicleGoodPosition"&& count _vehicleGoodPosition>0) then 
					{
						diag_log format ["Position to spawn chopper is not Nil %1",_vehicleGoodPosition];
						createVehicle ["Land_HelipadCircle_F", _vehicleGoodPosition , [], 0, "NONE"];
						_currentVehicle = createVehicle [_vehicleClass, [_vehicleGoodPosition select 0,_vehicleGoodPosition select 1]  , [], 0, "NONE"];
					};
				};   
			case (_vehicleClass isKindOf "Plane"): 
				{
					if (_isUAV) then 
					{
						_kind = "UAV";

						//UAV spawn is only avalaible for blufor
						_tempPos = [[_thisPosition select 0, _thisPosition select 1],1,60,10,0] call BIS_fnc_findSafePos;
						_tempPos pushBack ((_thisPosition select 2)+1400); //Set 3 dimension position
						_currentUAVArray = [_tempPos, 0, _vehicleClass, blufor] call BIS_fnc_spawnVehicle;
						_currentVehicle = _currentUAVArray select 0;
						_currentUAVGroup = _currentUAVArray select 2;

						//Set waypoint to current pos to the UAV
						_wp = _currentUAVGroup addWaypoint [_tempPos, 0];

						//Set unlimited fuel to the UAV
						[_currentVehicle, 'objectGenerator\setUnlimitedFuel.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
					};
				};
				default {_kind = "Other";};   
			};
		sleep 2; //Wait vehicle spawn (avoid vehicle crash)

		//Clear vehicle cargo
		clearWeaponCargoGlobal _currentVehicle;
		clearBackpackCargo _currentVehicle;

		//Add ACE keys
		if (isClass (configFile >> "CfgPatches" >> "ace_medical") && !(_vehicleClass isKindOf "StaticWeapon")) then 
		{
			[_currentVehicle] call doAddKeys;
			if (missionNameSpace getVariable ["vehicleLockedDefault", 1] == 1) then 
			{
				_currentVehicle setVehicleLock "LOCKED";
			};
		};

		// hint format ["vehicle faction : %1",(_currentVehicle call BIS_fnc_objectSide)];

		//Feed vehicle list
		if (!isNull _currentVehicle) then 
		{
			_vehicleSpawned pushback _currentVehicle;
		};

		//Generate 3D Icon 
		_vehicleName = getText (configFile >> "cfgVehicles" >> _vehicleClass >> "displayName");
		_vehiclePicture = getText (configFile >> "cfgVehicles" >> _vehicleClass >> "picture");
		[[_vehicleName, (getPos _currentVehicle) vectorAdd [0,0,5],_vehiclePicture , [0,0,1,1]], 'GUI\3DNames\3DTempNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];

	} forEach _thisVehicleList;
	//Generate boat location on map
	if !([_shipGoodPosition , [0,0,0]] call BIS_fnc_areEqual) then 
	{
		[["Boats","ColorBlue","hd_pickup_noShadow",_shipGoodPosition, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];	
	};

	//Add flip vehicle interaction
	[
		_vehicleSpawned#0, 
		"Flip Vehicle", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", 
		"(_this distance _target < 5) && (count crew _target == 0)",		// Condition for the action to be shown
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
			
			[[_object], "engine\doFlipVehicle.sqf"] remoteExec ['BIS_fnc_execVM', 0];

		}, 
		{
			// Action failed code
		}, 
		[],  
		8,
		5, 
		false, 
		false
	] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

	_vehicleSpawned;
};


doIncrementVehicleSpawnCounter =
{
	//Increment spawn credit counter Vehicle
	bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
	bluforVehicleAvalaibleSpawnCounter = bluforVehicleAvalaibleSpawnCounter + 1000;
	missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter, true];

	independentVehicleAvalaibleSpawnCounter = missionNamespace getVariable "independentVehicleAvalaibleSpawn";
	independentVehicleAvalaibleSpawnCounter = independentVehicleAvalaibleSpawnCounter + 1000;
	missionNamespace setVariable ["independentVehicleAvalaibleSpawn", independentVehicleAvalaibleSpawnCounter, true];

	//Show the counter to blufor
	[[format ["Standard vehicle spawn credits : %1", bluforVehicleAvalaibleSpawnCounter], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true]; 
	[[format ["Standard vehicle spawn credits : %1", independentVehicleAvalaibleSpawnCounter], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', independent, true]; 
};

doIncrementAllCredits =
{
	//Vehicle credit increment
	[] call doIncrementVehicleSpawnCounter;

	//Increment
	[[], 
	{
		params ["_unit", "_instigator"];
	 	_unblockCredit = profileNameSpace getVariable ["RPG_UnlockCredit",0];
		profileNameSpace setVariable ["RPG_UnlockCredit",_unblockCredit+1];
	}
	] remoteExec ["spawn", 0]; 

	//Increment fortify credits 
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		[west, 20, false] call ace_fortify_fnc_updateBudget;
		[independent, 20, false] call ace_fortify_fnc_updateBudget;
	};
};

doAddKeys = {
	params ["_vehicle"];

	//Setup keys 
	switch ((getnumber (configfile >> "cfgvehicles" >> typeOf _vehicle >> "side")) call bis_fnc_sideType) do
	{
		case blufor:
			{
				_vehicle addItemCargoGlobal ["ACE_key_west", 2];
			};
		case opfor:
			{
				_vehicle addItemCargoGlobal ["ACE_key_east", 2];
			};
		case civilian:
			{
				_vehicle addItemCargoGlobal ["ACE_key_civ", 2];
			};
		case independent:
			{
				_vehicle addItemCargoGlobal ["ACE_key_indp", 2];
			};
		default
			{
				//Side unknown
			};
	};
};



spawnVehicleOnAicraft = {
	params ["_objectToSpawnClass", "_position"];

	_baseSpawnPlane = _position;

	_objectToSpawn = createVehicle [_objectToSpawnClass,  [_baseSpawnPlane#0, _baseSpawnPlane#1, _baseSpawnPlane#2+100], [], 0, "NONE"];
	_objectToSpawn enableSimulationGlobal false;
	_objectToSpawn allowDamage false;

	_bbr = boundingBoxReal vehicle _objectToSpawn;
	_p1 = _bbr select 0;
	_p2 = _bbr select 1;
	_maxHeight = abs ((_p2 select 2) - (_p1 select 2));

	_objectToSpawn setPosASL [_baseSpawnPlane#0, _baseSpawnPlane#1, _baseSpawnPlane#2];
	_objectToSpawn setDir 90;

	//Add flip vehicle interaction
	[
		_vehicleSpawned#0, 
		"Flip Vehicle", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa", 
		"(_this distance _target < 5) && (count crew _target == 0)",		// Condition for the action to be shown
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
			
			[[_object], "engine\doFlipVehicle.sqf"] remoteExec ['BIS_fnc_execVM', 0];

		}, 
		{
			// Action failed code
		}, 
		[],  
		8,
		5, 
		false, 
		false
	] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

	//Add ACE keys
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		[_vehicle] call doAddKeys;
	};

	//Clear vehicle cargo
	clearWeaponCargoGlobal _currentVehicle;
	clearBackpackCargo _currentVehicle;

	//Repair vehicle
	[_objectToSpawn] spawn {
		params ["_vehicle"];
		_vehicle allowDamage false;
		_vehicle enableSimulationGlobal true;
		waitUntil {(getPos _vehicle)#2<1};
		_vehicle setfuel 1;
		_vehicle setVelocity [0, 0, 0];
		_vehicle setdamage 0;
		_vehicle setDir 90;

		sleep 3;
		_vehicle allowDamage true;
		if (!(alive _vehicle)) then 
		{
			deleteVehicle _vehicle;
		}; 
	};

	//Add custom plane catapult on WWII planes because of heavy bugs on USS Freedom
	if (_objectToSpawn isKindOf "Plane") then 
	{
		if (_warEra == 0) then 
		{
			[_objectToSpawn, [format ["<img size='2' image='\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa'/><t size='1'>Catapult the plane</t>"],{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];

				//Move caller in the player
				_caller moveInAny _object;

				//Start the plane
				_object engineOn true;
				_objectPos = getPos _object;
				_object setPosASL [_objectPos#0, _objectPos#1, _objectPos#2+300];
				_vel = velocity _object;
				_dir = getDir _object;
				_additionalSpeed = 150; // in m/s
				_object setVelocity [
					(_vel select 0) + (sin _dir * _additionalSpeed),
					(_vel select 1) + (cos _dir * _additionalSpeed),
					(_vel select 2) // horizontal only
				];

				//Delete the action 
				[_object, _ID] remoteExec ["removeAction", 0, true];

			},_x,3,true,false,"","(_target distance _this <3) && (_this getVariable 'role' == 'leader' || _this getVariable 'role' == 'pilot')"]] remoteExec ["addAction", 0, true];
		};
	};
};