//Init params
params ["_thisAvailablePosition","_thisTargetPosition","_thisAvailableInfantryGroups","_thisAvailableVehicleGroups","_thisDifficulty", ["_vehicleProb", 0.5]];

//Ex : [AvalaibleInitAttackPositions, initCityLocation,[baseEnemyGroup,baseEnemyATGroup],baseEnemyVehicleGroup, missionDifficultyParam] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 


currentAttackGroup = objNull;
currentPosition = [];
if (isServer) then
{
	_numberOfVehicleSpawned = 0;
	_waveHaveVehicle = random 1 < _vehicleProb;
	diag_log format ["Avalaible spawn position %1", _thisAvailablePosition ];
	for [{_k = 0}, {_k < (count _thisAvailablePosition)}, {_k = _k + 1}] do 
	{
		for [{_j = 0}, {_j < _thisDifficulty}, {_j = _j + 1}] do 
		{
			//Case Infantry
			currentAttackGroup = selectRandom _thisAvailableInfantryGroups;
			currentPosition = selectRandom _thisAvailablePosition;

			//Check distance from nearest player
			//[TEMPHOTFIX] not a clean fix to enemy spawn near player
			_players = allPlayers apply {[_x distance currentPosition,_x]};
			_players sort true;
			
			if (((_players apply {_x#1})#0) distance currentPosition >= 300) then 
			{
				_currentGroup =	[currentAttackGroup, ([currentPosition,1,60,10,0] call BIS_fnc_findSafePos), east, ""] call doGenerateEnemyGroup;
				diag_log format ["Create group : %1 at position %2 and assault to position %3", _currentGroup, getPos (leader _currentGroup), _thisTargetPosition];

				//Assault for infantry
				[_currentGroup, _thisTargetPosition] call doAttack;
				_currentGroup setFormation "DIAMOND";
				diag_log format ["Group %1 ready to assault", _j];

				//Clean unit after a long
				if (count units _currentGroup != 0) then 
				{
					(units _currentGroup) apply {
						[_x] spawn 
						{
							params ["_thisUnit"];
							sleep 3600;
							deleteVehicle _thisUnit;
						};
					};
				};

			} else 
			{
				diag_log format ["doAmbush : Spawn on %2 near players %1 blocked", getPos ((_players apply {_x#1})#0), currentPosition];
			};


			//Case vehicle
			if (_waveHaveVehicle && count _thisAvailableVehicleGroups != 0 && _numberOfVehicleSpawned<=_thisDifficulty) then 
			{
				currentAttackVehicleGroup = selectRandom _thisAvailableVehicleGroups;
				currentPosition = selectRandom _thisAvailablePosition;

				//Check distance from nearest player
				//[TEMPHOTFIX] not a clean fix to enemy spawn near player
				_players = allPlayers select {alive _x} apply {[_x distance currentPosition,_x]};
				_players sort true;
				
				if (((_players apply {_x#1})#0) distance currentPosition >= 300) then 
				{
					currentVehicleGroup =[[currentAttackVehicleGroup], ([currentPosition, 0, 60, 10, 0, 0.25, 0, [], [currentPosition, currentPosition]] call BIS_fnc_findSafePos), east, ""] call doGenerateEnemyGroup;
					diag_log format ["Create group : %1 at position %2 and assault to position %3", currentVehicleGroup, getPos (leader currentVehicleGroup), _thisTargetPosition];

					//Assault for vehicle
					currentVehicleGroup setBehaviour "SAFE";
					_numberOfVehicleSpawned = _numberOfVehicleSpawned + 1;
					
					//70% Chance of reducing vehicle speed to match infantry speed
					if (random 100 < 70) then 
					{
						(vehicle leader currentVehicleGroup) limitSpeed 20; //limit speed of vehicle
					};

					[currentVehicleGroup, _thisTargetPosition] call BIS_fnc_taskAttack;

					//Check if it is a transport vehicle
					//Put infantry inside
					_vehicleAsset = vehicle (leader currentVehicleGroup);
					private _transportSlots = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicleAsset >> "transportSoldier");
					if (_transportSlots > 0) then 
					{
						_groupToGetIn = [selectRandom _thisAvailableInfantryGroups, ([currentPosition,1,60,10,0] call BIS_fnc_findSafePos), east, ""] call doGenerateEnemyGroup;
						if (count units _groupToGetIn != 0) then 
						{
							//Put infantry inside the vehicle
							(units _groupToGetIn) apply {
								[_x, _vehicleAsset] spawn 
								{
									params ["_thisUnit", "_vehicleAsset"];
									_thisUnit moveInCargo _vehicleAsset;

									//Check if he's inside 
									if (vehicle _thisUnit != _vehicleAsset) then 
									{
										deleteVehicle _thisUnit;
									};
								};
							};
						};


						//Script unit leave vehicle in the area
						[_vehicleAsset, _thisTargetPosition, 150] spawn {
							params ["_veh", "_tPos", "_dist"];

							//Wait unit finishing enter the vehicle
							sleep 2;

							//Prepare cargo passengers to get out
							private _units = ((fullCrew [_veh, "cargo", true]) apply {_x select 0}) ; //Get passengers in cargo
							private _grp = objNull;
							//systemChat format ["_passengers %1,%2", _passengers , count _passengers];

							if (count _units != 0) then 
							{
								_grp 	= group (_units select 0); //Select the group of passengers

								// Wait until the vehicle is at the desired distance, or is destroyed/empty
								//systemChat format ["Ambush vehicle init %1,%2,%3", vehicle _veh, count _units, _grp];

								waitUntil {
									sleep 2; 	
									(isNull _veh) || {!alive _veh} || {(_veh distance2D _tPos) <= _dist}
								};

								//systemChat "Ambush vehicle pass 1";


								if (isNull _veh || {!alive _veh}) exitWith { };

								//systemChat "Ambush vehicle pass 2";

								// 4. Action: Disembark order
								// Force the vehicle to stop or slow down a bit (optional, via a SAD waypoint or by clearing tasks)
								(_veh) limitSpeed 20; 
								sleep 1;

								(_veh) limitSpeed 10; 
								sleep 1;

								(_veh) limitSpeed 5; 
								sleep 1;

								(_veh) limitSpeed 0; 
								sleep 3;


								// Clean disembark order (the AI dismounts from the vehicle)
								{
									_x leaveVehicle _veh;
								} forEach _units;
								
								// Safety: Force a physical getOut if the AI takes too long to react
								// (Leave a short delay for 'leaveVehicle' to initialize)
								sleep 1;
								{
									if (vehicle _x isEqualTo _veh) then {
										unassignVehicle _x;
										_x action ["GetOut", _veh];
									};
								} forEach _units;

								//systemChat "Ambush vehicle dismount";
								(_veh) limitSpeed 20; //restore speed
								sleep 1;

								// 5. Action: Create an attack waypoint for the infantry group
								// Ensure the group is fully unlinked from the vehicle
								_grp leaveVehicle _veh;
								
								// Delete any existing waypoints from the group
								for [{idX = count (waypoints _grp) - 1}, {idX >= 0}, {idX = idX - 1}] do {
									deleteWaypoint [_grp, idX];
								};

								// Add a "SAD" (Search and Destroy) waypoint on the target position
								private _wp = _grp addWaypoint [_tPos, 0];
								_wp setWaypointType "SAD";
								_wp setWaypointBehaviour "COMBAT";
								_wp setWaypointSpeed "FULL";

								// Optional: Make the vehicle move elsewhere or leave it in place
								// driver _veh commandMove (getPos _veh); // Stop the vehicle for example


							};
						};
						
					};
				} else 
				{
					diag_log format ["doAmbush : Spawn on %1 near players %2 blocked", getPos ((_players apply {_x#1})#0), currentPosition];
				};
			};
		};
	};
};