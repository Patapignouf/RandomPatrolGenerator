params ["_thisAvailableOpforGroup","_thisAvailableOpforCars","_thisAvailableOpforLightArmoredVehicle","_thisAvailableOpforHeavyArmoredVehicle","_thisAvailableCivGroup","_thisAvailablePosition","_thisDifficulty", "_thisObjective"];

currentRandomGroup = objNull;
currentGroup = objNull;
diag_log format ["Begin generation AO %1",_thisAvailablePosition];

//Try to find position with building if avalaible
_tempAvailablePosition = getPos (nearestBuilding _thisAvailablePosition);
if (_tempAvailablePosition distance _thisAvailablePosition < 200) then 
{
	_thisAvailablePosition = _tempAvailablePosition;
};

//Generate enemy infantry on AO
diag_log format ["Infantry generation start on AO %1",_thisAvailablePosition];
_baseRadius = 60;
for [{_i = 0}, {_i < _thisDifficulty+4}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom _thisAvailableOpforGroup;
	currentGroup = [currentRandomGroup, _thisAvailablePosition, east, "DefenseInfantry"] call doGenerateEnemyGroup;

	//Add intel to enemy
	if ((typeName _thisObjective) == "ARRAY") then 
	{
		{
			_x setVariable ["associatedObjective", _thisObjective];
			_x addEventHandler ["Killed", {
						params ["_unit", "_killer", "_instigator", "_useEffects"];
						[_unit] remoteExec ["removeAllActions", 0, true];
						
						//get objective associated to the unit
						_objective = _unit getVariable "associatedObjective";
						
						//Add search for intel action
						[
							_unit, 
							"Search for intel", 
							"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
							"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
							"_this distance _target < 2",						// Condition for the action to be shown
							"_caller distance _target < 2",						// Condition for the action to progress
							{
								// Action start code
							}, 
							{
								// Action on going code
							},  
							{
								// Action successfull code
								params ["_object","_caller","_ID","_objectiveParam","_progress","_maxProgress"];

								//Remove this action
								[_object] remoteExec ["removeAllActions", 0, true];

								//25% chance to give intel to the player
								if ((round (random 3))==0 && !([format ["%1%2",_objectiveParam # 0 # 2 ,"_Intel"]] call BIS_fnc_taskExists)) then 
								{
									//Search the nearestLocation from the intel
									_side = side _caller;
									_objective = _objectiveParam # 0;
									_thisObject = _objective # 0; //Object associated to the objective (can be a trigger)
									_thisObjectiveType = _objective # 1;
									_thisObjectiveCode = _objective # 2;
									_nearestLoc = nearestLocations [getPos (_thisObject), ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
									_currentObjectiveDescription = "";

									//Display custom dialogs according to the enemy position
									switch (_thisObjectiveType) do
										{
											case "supply":
												{	
													_currentObjectiveDescription = format ["The supply %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), getPos _thisObject];
												};
											case "ammo":
												{
													_currentObjectiveDescription = format ["The %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), getPos _thisObject];
												};
											case "hvt":
												{
													_currentObjectiveDescription = format ["The enemy HVT %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), getPos _thisObject];
												};
											case "vip":
												{
													_currentObjectiveDescription = format ["The friendly VIP %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), getPos _thisObject];
												};
											case "steal":
												{
													_currentObjectiveDescription = format ["The %1 to steal is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), getPos _thisObject];
												};
											case "informant":
												{
													_currentObjectiveDescription = format ["The informant %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), getPos _thisObject];
												};
											case "clearArea":
												{
													_opforCount = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisObject);
													if (_opforCount >0) then 
													{
														_currentObjectiveDescription = format ["There %2 enemies in %1, you have to clear the location...", text _nearestLoc, _opforCount];
													} else 
													{
														_currentObjectiveDescription = format ["There no more enemy in %1, congratulation guys", text _nearestLoc, _opforCount];
													};
												};
											case "defendArea":
												{
													_opforCount = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisObject);
													if (_opforCount >0) then 
													{
														_currentObjectiveDescription = format ["There %2 enemies in %1, you have to clear the location...", text _nearestLoc, _opforCount];
													} else 
													{
														_currentObjectiveDescription = format ["There no more enemy in %1, congratulation guys", text _nearestLoc, _opforCount];
													};
												};
											case "collectIntel":
												{
													_currentObjectiveDescription = format ["The intel %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), getPos _thisObject];
												};
											case "captureFlag":
												{
													_currentObjectiveDescription = format ["The flag to capture %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), getPos _thisObject];
												};
											default { hint "default" };
										};

										//Create child task associated to main task
										[_side, [format ["%1%2",_thisObjectiveCode ,"_Intel"], _thisObjectiveCode], [_currentObjectiveDescription, "Updated intel", "cookiemarker2_intel"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
										[format ["%1%2",_thisObjectiveCode ,"_Intel"],"documents"] call BIS_fnc_taskSetType;
									} else 
									{
										//Display no intel found message
										[1,["No intel found", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
									};
							}, 
							{
								// Action failed code
							}, 
							[_objective],  
							3,
							1000, 
							true, 
							false
						] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
					}];
		} foreach (units currentGroup);
	} else 
	{
		diag_log format ["generatePOI : _thisObjective is null"];
	};

	//Spawn group
	[currentGroup, getPos (leader currentGroup), _baseRadius, false] execVM 'enemyManagement\behaviorEngine\doGarrison.sqf';
	_baseRadius = _baseRadius + 30;
};


diag_log format ["Light vehicle generation start on AO %1",_thisAvailablePosition];
//Generate enemy light vehicle on AO
for [{_i = 0}, {_i < round((_thisDifficulty-0.5)/2)+1}, {_i = _i + 1}] do 
{
	//Generate light vehicle
	if (count _thisAvailableOpforCars != 0) then 
	{
		_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
		{
			_currentEnemyCars = [[selectRandom _thisAvailableOpforCars], _safeVehicleSpawn, east, "Car"] call doGenerateEnemyGroup;
		};
	};
};

diag_log format ["Heavy vehicle generation start on AO %1",_thisAvailablePosition];
//Generate heavy enemy light vehicle on AO
for [{_i = 0}, {_i < round((_thisDifficulty-0.5)/2) + 1}, {_i = _i + 1}] do 
{
	//Generate heavy vehicle
	if (count _thisAvailableOpforLightArmoredVehicle != 0 && enableArmoredVehicle) then 
	{
		//Light armored vehicle spawn chance 33%
		if (round random 2 == 0) then 
		{
			_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
			{
				_currentEnemyCars = [[selectRandom _thisAvailableOpforLightArmoredVehicle], _safeVehicleSpawn, east, "LightArmored"] call doGenerateEnemyGroup;
			};
		};

		//Heavy armored vehicle spawn chance 33%
		if (count _thisAvailableOpforHeavyArmoredVehicle != 0 && round random 2 == 0) then 
		{
			_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
			{
				_currentEnemyCars = [[selectRandom _thisAvailableOpforHeavyArmoredVehicle], _safeVehicleSpawn, east, "HeavyArmored"] call doGenerateEnemyGroup;
			};
		};
	};
};

diag_log format ["Civilian generation start on AO %1",_thisAvailablePosition];
//Add chance to spawn civilian 33%
if (round (random 3) == 0 && count _thisAvailableCivGroup > 0) then 
{
	for [{_i = 0}, {_i < _thisDifficulty+1}, {_i = _i + 1}] do 
	{
		currentGroup = [_thisAvailableCivGroup, _thisAvailablePosition, civilian, "Civilian"] call doGenerateEnemyGroup;
		[currentGroup, getPos (leader currentGroup), 80, true] execVM 'enemyManagement\behaviorEngine\doGarrison.sqf';
	};
};

diag_log format ["End generation AO %1",_thisAvailablePosition];