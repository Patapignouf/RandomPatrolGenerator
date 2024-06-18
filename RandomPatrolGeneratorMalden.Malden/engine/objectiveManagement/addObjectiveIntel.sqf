params ["_currentGroup", "_thisObjective"];

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
						if (random 100 < 25 && !([format ["%1%2",_objectiveParam # 0 # 2 ,"_Intel"]] call BIS_fnc_taskExists)) then 
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
											_currentObjectiveDescription = format ["The supply %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
										};
									case "ammo":
										{
											_currentObjectiveDescription = format ["The %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
										};
									case "hvt":
										{
											_currentObjectiveDescription = format ["The enemy HVT %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
										};
									case "vip":
										{
											_currentObjectiveDescription = format ["The friendly VIP %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
										};
									case "steal":
										{
											_currentObjectiveDescription = format ["The %1 to steal is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
										};
									case "informant":
										{
											_currentObjectiveDescription = format ["The informant %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
										};
									case "hostage":
										{
											_currentObjectiveDescription = format ["The hostage %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
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
									case "takeAndHold":
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
											_currentObjectiveDescription = format ["The intel %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
										};
									case "captureFlag":
										{
											_currentObjectiveDescription = format ["The flag to capture %1 is at %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), mapGridPosition (getPos _thisObject)];
										};
									default { 
											//hint "default" 
										};
								};

								//Create child task associated to main task
								[_side, [format ["%1%2",_thisObjectiveCode ,"_Intel"], _thisObjectiveCode], [_currentObjectiveDescription, "Updated intel", "cookiemarker2_intel"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
								[format ["%1%2",_thisObjectiveCode ,"_Intel"],"documents"] call BIS_fnc_taskSetType;
								//Reward with experience 
								[[3, "RPG_ranking_intel_collect"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
							} else 
							{
								//75% chance to get a minor intel
								if (random 100 < 75) then 
								{
									//Reveal minor intel for the caller
									[[_caller, "corpseLooting"], 'engine\objectiveManagement\revealMinorIntel.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
								} else 
								{
									//Display no intel found message
									[[format ["<t align = 'center' shadow = '2' color='#FF0000' size='1.5' font='PuristaMedium' >Corpse</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >No intel found</t>"], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", _caller];
								};
								//Reward with less experience 
								[[1, "RPG_ranking_intel_collect"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
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
} foreach (units _currentGroup);