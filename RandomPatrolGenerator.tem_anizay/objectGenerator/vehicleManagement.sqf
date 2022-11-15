//Function to generate vehicle around a position
//Specific parameters for boat
doGenerateVehicleForFOB = 
{
	//Define parameters
	_thisPosition = _this select 0;
	_thisVehicleList = _this select 1;
	_thisMinRadius = _this select 2;
	_thisMaxRadius = _this select 3;

	//Define process 
	_shipGoodPosition = [0,0,0];
	{
		switch (true) do {   
			case (_x isKindOf "Tank");
			case (_x isKindOf "Car"): {
						_kind = "Car";
						_spawnAttempts = 0;
						_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_x];
						while {(isNil "_vehicleGoodPosition" || count _vehicleGoodPosition==0) && _spawnAttempts <10} do 
						{
							_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_x];
							_spawnAttempts = _spawnAttempts +1;
						};
						if (!isNil "_vehicleGoodPosition" && count _vehicleGoodPosition>0) then 
						{
							diag_log format ["Position to spawn vehicle is not Nil %1",_vehicleGoodPosition];
							_currentCar = createVehicle [_x, _vehicleGoodPosition , [], 0, "NONE"];
						};
				};   
			case (_x isKindOf "Ship"): {
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
						_currentBoat = createVehicle [_x, _shipGoodPosition , [], 0, "NONE"];

						//Nudge code from DRO to move boat stuck on beach
						[
							_currentBoat,
							[
								"Nudge",  
								{  
									_dir = [(_this select 1), (_this select 0)] call BIS_fnc_dirTo;  
									_nudgePos = [(getPos (_this select 0)), 2, _dir] call dro_extendPos;  
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
			case (_x isKindOf "Helicopter"): {
					_kind = "Helicopter";
					_spawnAttempts = 0;
					_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_x];
					while {(isNil "_vehicleGoodPosition" || count _vehicleGoodPosition==0) && _spawnAttempts <10} do 
					{
						_vehicleGoodPosition = _thisPosition findEmptyPosition [_thisMinRadius, _thisMaxRadius,_x];
						_spawnAttempts = _spawnAttempts +1;
					};
					if (!isNil "_vehicleGoodPosition"&& count _vehicleGoodPosition>0) then 
					{
						diag_log format ["Position to spawn chopper is not Nil %1",_vehicleGoodPosition];
						createVehicle ["Land_HelipadCircle_F", _vehicleGoodPosition , [], 0, "NONE"];
						_currntHelicopter = createVehicle [_x, [_vehicleGoodPosition select 0,_vehicleGoodPosition select 1]  , [], 0, "NONE"];
					};
				};   
			case (_x isKindOf "Plane"): {_kind = "Plane";};   
			default {_kind = "Other";};   
		};   
		
	} forEach _thisVehicleList;
	//Generate boat location on map
	if !([_shipGoodPosition , [0,0,0]] call BIS_fnc_areEqual) then 
	{
		[["Boats","ColorBlue","hd_pickup_noShadow",_shipGoodPosition, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];	
	};
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