//Function to generate vehicle around a position
//Specific parameters for boat
doGenerateVehicleForFOB = 
{
	//Define parameters
	params ["_thisPosition","_thisVehicleList","_thisMinRadius","_thisMaxRadius"];
	
	_vehicleSpawned = [];

	//Define process 
	_shipGoodPosition = [0,0,0];
	{
		//Define current vehicle
		_vehicleClass = _x select 0;
		_isUAV = _x select 1;
		_currentVehicle = objNull;

		switch (true) do {   
			case (_vehicleClass isKindOf "Tank");
			case (_vehicleClass isKindOf "Car"): {
						_kind = "Car";
						_spawnAttempts = 0;
						_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_vehicleClass];
						while {(isNil "_vehicleGoodPosition" || count _vehicleGoodPosition==0) && _spawnAttempts <10} do 
						{
							_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_vehicleClass];
							_spawnAttempts = _spawnAttempts +1;
						};
						if (!isNil "_vehicleGoodPosition" && count _vehicleGoodPosition>0) then 
						{
							diag_log format ["Position to spawn vehicle is not Nil %1",_vehicleGoodPosition];
							_currentVehicle = createVehicle [_vehicleClass, _vehicleGoodPosition , [], 0, "NONE"];
						};
				};   
			case (_vehicleClass isKindOf "Ship"): {
					_kind = "Ship";
					_spawnAttempts = 0;
					//In the specific case of boat, max radius is replaced by 1000 to find water inArea
					if (count _shipGoodPosition == 0 || ([_shipGoodPosition , [0,0,0]] call BIS_fnc_areEqual)) then 
					{
						_shipGoodPosition = [_thisPosition, _thisMinRadius, 1000, 20, 2, 0, 1, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
					}
					else 
					{
						_shipGoodPosition = [_shipGoodPosition, 10, 20, 20, 2, 0, 1, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;	
					};
					while {(isNil "_shipGoodPosition" || count _shipGoodPosition==0) && _spawnAttempts <10} do 
					{
						if (count _shipGoodPosition == 0 || ([_shipGoodPosition , [0,0,0]] call BIS_fnc_areEqual)) then 
						{
							_shipGoodPosition = [_thisPosition, _thisMinRadius, 1000, 20, 2, 0, 1, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
						}
						else 
						{
							_shipGoodPosition = [_shipGoodPosition, 10, 20, 20, 2, 0, 1, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;	
						};
						_spawnAttempts = _spawnAttempts +1;
					};
					if (!isNil "_shipGoodPosition" && count _shipGoodPosition>0 && !([_shipGoodPosition , [0,0,0]] call BIS_fnc_areEqual)) then 
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
						[[_currentVehicle], 'objectGenerator\setUnlimitedFuel.sqf'] remoteExec ['BIS_fnc_execVM', 2];
					};
					if (_isUAV) then 
					{
						_kind = "Plane";
						//WIP
					};   
				};
				default {_kind = "Other";};   
			};
		sleep 2; //Wait vehicle spawn (avoid vehicle crash)

		//Feed vehicle list
		if (!isNull _currentVehicle) then 
		{
			_vehicleSpawned pushback _currentVehicle;
		};

	} forEach _thisVehicleList;
	//Generate boat location on map
	if !([_shipGoodPosition , [0,0,0]] call BIS_fnc_areEqual) then 
	{
		[["Boats","ColorBlue","hd_pickup_noShadow",_shipGoodPosition, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];	
	};
	_vehicleSpawned;
};


doIncrementVehicleSpawnCounter =
{
	//Increment spawn credit counter Vehicle
	bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
	bluforVehicleAvalaibleSpawnCounter = bluforVehicleAvalaibleSpawnCounter + 1;
	missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter, true];
	//Increment spawn credit counter Advanced Vehicle
	bluforAdvancedVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforAdvancedVehicleAvalaibleSpawn";
	bluforAdvancedVehicleAvalaibleSpawnCounter = bluforAdvancedVehicleAvalaibleSpawnCounter + 1;
	missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter, true];
	//Show the counter to blufor
	[format ["Standard vehicle spawn credits : %1\nAdvanced vehicle spawn credits : %2", bluforVehicleAvalaibleSpawnCounter, bluforAdvancedVehicleAvalaibleSpawnCounter]] remoteExec ["hint", blufor, true];
};