#include "..\..\objectGenerator\vehicleManagement.sqf"

generateObjective =
{
	params ["_avalaibleTypeOfObj","_possibleObjectivePosition"];

	//Init mission objective status
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_missionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",_missionObjectives];

	//Generate a new objective
	SupplyObjects =  [];
	SelectedObjectives = [];
	publicvariable "SupplyObjects";
	publicvariable "SelectedObjectives";
	
	//Define objective type
	currentObjType = selectRandom _avalaibleTypeOfObj;
	
	//Define objective position
	_selectedObjectivePosition = selectRandom _possibleObjectivePosition;
	_possibleObjectivePosition = _possibleObjectivePosition - [_selectedObjectivePosition];

	diag_log format ["Objective generation started : %1 on position %2", currentObjType, _selectedObjectivePosition];

	//Generate mission objectives
	_objectiveCreated = [currentObjType, _selectedObjectivePosition] call generateObjectiveObject; 
	
	//Generate mission environement
	if (currentObjType != "defendArea") then 
	{
		if (random 100 < 80) then 
		{
			_handlePOIGeneration = [EnemyWaveLevel_1, baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, civilian_group, _selectedObjectivePosition, _objectiveCreated] execVM 'enemyManagement\generationEngine\generatePOI.sqf'; 
			waitUntil {isNull _handlePOIGeneration};
		} else 
		{
			_handlePOIGeneration = [EnemyWaveLevel_1, baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, civilian_group, _selectedObjectivePosition, _objectiveCreated] execVM 'enemyManagement\generationEngine\generateHostileCivPOI.sqf'; 
			waitUntil {isNull _handlePOIGeneration};
		};

	} else 
	{
		//Populate the area with only civilian randomly
		if (random 100 > 50) then 
		{
			[civilian_group, ((initCityLocation) findEmptyPosition [5, 60]), civilian, "Civilian"] call doGenerateEnemyGroup;
		};
	};

	//Return objective selected location
	_possibleObjectivePosition;
};


generateObjectiveObject = 
{
	params ["_thisObjectiveType","_thisObjectivePosition"];

	//Define specific objective data
	_thisObjective = []; 

	//Try to find position with building if avalaible
	_allBuildings = nearestTerrainObjects [_thisObjectivePosition, ["house"], 100, false, true];
	_allPositions = [];
	_allBuildings apply {_allPositions append (_x buildingPos -1)};
	_thistempObjectivePosition = selectRandom _allPositions;
	
	//Test if there's an avalaible position
	if (!isNil "_thistempObjectivePosition") then 
	{
		_thisObjectivePosition = _thistempObjectivePosition;
	};

	_possibleIEDLocation = [_thisObjectivePosition, 1000, round (random 4)] call findPositionsNearRoads;
	if (count _possibleIEDLocation >0) then 
	{
		{
			_tempIED = createVehicle [selectRandom avalaibleIED, [[[_x, 10]], []] call BIS_fnc_randomPos, [], 0, "NONE"];
			[_tempIED, selectRandom [1,2,3], false] execVM "objectGenerator\iedBlast.sqf";
		} foreach _possibleIEDLocation;
	};

	_possibleRoadBlockLocation = [_thisObjectivePosition, 1500, round (random 2)] call findPositionsNearRoads;
	if (count _possibleRoadBlockLocation >0) then 
	{
		{
			[_x] execVM 'enemyManagement\generationEngine\generateOpforRoadBlock.sqf';
		} foreach _possibleRoadBlockLocation;
	};

	//Define random pos for objective generation
	_currentRandomPos = [] call BIS_fnc_randomPos;

	switch (_thisObjectiveType) do
	{
		case "supply":
			{
				//Generate objective object
				_objectiveObject = createVehicle [selectRandom avalaibleSupplyBox, _currentRandomPos, [], 0, "NONE"];
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				//Search safe position around objective position
				_objectiveObject setPos ([( _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);

				//Manage objective completion
				[_thisObjective] execVM 'engine\objectiveManagement\checkObjectInArea.sqf';  

				//Objective failed
				_objectiveObject setVariable ["thisTask", _thisObjective select 2, true];
				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					//get task associated to the object
					_thisTaskID = _unit getVariable "thisTask";
					//Manage objective
					_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
					_missionFailedObjectives = _missionFailedObjectives + [_thisTaskID]; //needs to be improved
					missionNamespace setVariable ["missionFailedObjectives", _missionFailedObjectives, true];

					//Add penalty
					[[-50,5], 'engine\rankManagement\rankPenalty.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];


					//Manage task system
					if ("RealismMode" call BIS_fnc_getParamValue == 1 ) then 
					{
						[_thisTaskID, "FAILED"] call BIS_fnc_taskSetState;
					};
				}];
			};
		case "ammo":
			{
				//Generate objective object
				_objectiveObject = createVehicle [selectRandom avalaibleAmmoBox, _currentRandomPos, [], 0, "NONE"];
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;


				_objectiveObject setPos ([( _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
				_objectiveObject setVariable ["thisTask", _thisObjective select 2, true];

				//Manage objective completion
				[_thisObjective] execVM 'engine\objectiveManagement\checkObjectInArea.sqf';
				[_thisObjective] execVM 'engine\objectiveManagement\checkDeadVehicle.sqf';  
			};
		case "hvt":
			{
				//Generate objective object
				_objectiveObject = leader ([_currentRandomPos, east, [selectRandom avalaibleHVT],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				_objectiveObject disableAI "PATH";
				diag_log format ["HVT %2 _thisObjectivePosition : %1",_thisObjectivePosition, _objectiveObject];
				currentObj setVariable ["isObjectiveObject", true, true];
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;
				diag_log format ["HVT %2 _thisObjectivePosition : %1",_thisObjectivePosition, _objectiveObject];
				_objectiveObject setPos _thisObjectivePosition;

				_objectiveObject setVariable ["thisObjective", _thisObjective, true];

				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];

					//Manage Completed Objective
					_thisObjectiveToComplete = _unit getVariable "thisObjective";
					_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
					_completedObjectives pushBack _thisObjectiveToComplete;
					missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
					//Manage UncompletedObjective
					_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
					_missionUncompletedObjectives = _missionUncompletedObjectives - [_thisObjectiveToComplete];
					missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
					//Manage player's feedback
					if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
					{
						[] call doIncrementVehicleSpawnCounter;	
						[_thisObjectiveToComplete] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
						[[50, "RPG_ranking_objective_complete"], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', 0];
					};
					//Manage respawn 
					if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
					{
						[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
					};
				}];


			};
		case "vip":
			{
				//Generate objective object
				_objectiveObject =  leader ([_currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				diag_log format ["VIP task setup ! : %1", _objectiveObject];
				_objectiveObject setPos _thisObjectivePosition;

				//Use ACE function to set hancuffed
				if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
				{
					[_objectiveObject, true] call ACE_captives_fnc_setHandcuffed;
				};
				
				//Objective failed
				_objectiveObject setVariable ["thisTask", _thisObjective select 2, true];
				
				//Manage objective completion
				[_thisObjective] execVM 'engine\objectiveManagement\checkObjectInArea.sqf';  
				
				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					//get task associated to the object
					_thisTaskID = _unit getVariable "thisTask";

					//Remove all actions
					[_unit] remoteExec ["removeAllEventHandlers", 0, true];
					[_unit] remoteExec ["removeAllActions", 0, true];

					//Manage objective
					_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
					_missionFailedObjectives = _missionFailedObjectives + [_thisTaskID]; //needs to be improved
					missionNamespace setVariable ["missionFailedObjectives", _missionFailedObjectives, true];
					//Manage task system
					if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
					{
						[_thisTaskID, "FAILED"] call BIS_fnc_taskSetState;
					};
				}];
			};
		case "steal":
			{
				//Generate objective object
				_objectiveObject = createVehicle [selectRandom avalaibleStealVehicle, _currentRandomPos, [], 0, "NONE"];
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				diag_log format ["Steal task setup ! : %1", _objectiveObject];
				_objectiveObject setPos ([( _thisObjectivePosition), 1, 100, 7, 0, 20, 0] call BIS_fnc_findSafePos);

				//Manage objective completion
				[_thisObjective] execVM 'engine\objectiveManagement\checkObjectInArea.sqf';  

				//Objective failed
				_objectiveObject setVariable ["thisTask", _thisObjective select 2, true];
				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					//get task associated to the object
					_thisTaskID = _unit getVariable "thisTask";
					//Manage objective
					_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
					_missionFailedObjectives = _missionFailedObjectives + [_thisTaskID]; //needs to be improved
					missionNamespace setVariable ["missionFailedObjectives", _missionFailedObjectives, true];

					//Add penalty
					[[-50,5], 'engine\rankManagement\rankPenalty.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];

					//Manage task system
					if ("RealismMode" call BIS_fnc_getParamValue == 1 ) then 
					{
						[_thisTaskID, "FAILED"] call BIS_fnc_taskSetState;
					};
				}];
			};
		case "clearArea":
			{
				//Generate objective object
				_objectiveObject = createTrigger ["EmptyDetector", _currentRandomPos]; //create a trigger area created at object with variable name my_object
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				//Add trigger to detect cleared area
				_objectiveObject setPos _thisObjectivePosition; //create a trigger area created at object with variable name my_object
				_objectiveObject setTriggerArea [200, 200, 0, false]; // trigger area with a radius of 200m.
				_objectiveObject setVariable ["associatedTask", _thisObjective];
				[_objectiveObject] execVM 'engine\objectiveManagement\checkClearArea.sqf'; 
			};
		case "defendArea":
			{
				//Generate objective object
				_objectiveObjectBox = createVehicle [selectRandom avalaibleAmmoBox, _currentRandomPos, [], 0, "NONE"];
				_objectiveObjectBox setVariable ["isObjectiveObject", true, true];
				_tempPosition = [_thisObjectivePosition, 200] call BIS_fnc_nearestRoad;

				//Place the box on the nearest road if avalaible
				if (!(isNull _tempPosition)) then 
				{
					_objectiveObjectBox setPos (getPos (_tempPosition));
				} else 
				{
					_objectiveObjectBox setPos _thisObjectivePosition;
				};		

				//Define the objective
				_thisObjective = [_objectiveObjectBox, _thisObjectiveType] call generateObjectiveTracker;


				[_objectiveObjectBox, ["Send signal to defend the location",{
					params ["_object","_caller","_ID","_thisObjective"];

					//Remove object interaction
					[_object] remoteExec ["removeAllActions", 0, true];

					//Generate objective trigger
					_objectiveObject = createTrigger ["EmptyDetector", getPos _object]; //create a trigger area created at object with variable name my_object
					_objectiveObject setVariable ["isObjectiveObject", true, true];

					//Add trigger to detect cleared area
					_objectiveObject setTriggerArea [150, 150, 0, false]; // trigger area with a radius of 200m.
					_objectiveObject setVariable ["associatedTask", _thisObjective, true];
							
					//Tell the player that enemy wave is incoming
					_textToSpeech = format ["We have spotted enemies around your position, be ready"];
					[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", _caller, true];

					//Start defend
					[[_objectiveObject], 'engine\objectiveManagement\checkDefendArea.sqf'] remoteExec ['BIS_fnc_execVM', 2];
				},_thisObjective, 10,true,true,"","_target distance _this <3"]] remoteExec ["addAction", 0, true];
			};
		case "takeAndHold":
			{
				//Generate objective object
				_objectiveObject = createTrigger ["EmptyDetector", _currentRandomPos]; //create a trigger area created at object with variable name my_object
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				//Add trigger to detect cleared area
				_objectiveObject setPos _thisObjectivePosition; //create a trigger area created at object with variable name my_object
				_objectiveObject setTriggerArea [200, 200, 0, false]; // trigger area with a radius of 200m.
				_objectiveObject setVariable ["associatedTask", _thisObjective];
				[_objectiveObject] execVM 'engine\objectiveManagement\checkDefendArea.sqf';
			};	
		case "collectIntel":
			{
				//Generate objective object
				_objectiveObject = createVehicle [selectRandom avalaibleCollectIntel, _currentRandomPos, [], 0, "NONE"];
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				//Add intel action to the intel case
				_objectiveObject setPos _thisObjectivePosition;
				[_objectiveObject, ["Collect intel",{
					params ["_object","_caller","_ID","_thisObjective"];
					//Manage Completed Objective
					_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
					_completedObjectives pushBack _thisObjective;
					missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
					//Manage UncompletedObjective
					_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
					_missionUncompletedObjectives = _missionUncompletedObjectives - [_thisObjective];
					missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];

					//Reveal minor intel for the caller
					[[_caller, "documentIntel"], 'engine\objectiveManagement\revealMinorIntel.sqf'] remoteExec ['BIS_fnc_execVM', _caller];

					//Manage player's feedback
					if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
					{
						[] call doIncrementVehicleSpawnCounter;	
						[_thisObjective] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
						[[50, "RPG_ranking_objective_complete"], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', 0];
					};
					//Manage respawn and delete object
					deleteVehicle _object;
					if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
					{
						[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
					};
				},_thisObjective,1.5,true,true,"","_target distance _this <3"]] remoteExec ["addAction", 0, true];
			};
		case "captureFlag":
			{
				//Generate objective object
				_objectiveObject = createVehicle ["Flag_Red_F", _currentRandomPos, [], 0, "NONE"];
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				//Search safe position around objective position
				_objectiveObject setPos ([( _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);

				//Add capture action to the flag
				[
					_objectiveObject, 
					"Capture the flag", 
					"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fragment_back_ca.paa", 
					"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fragment_back_ca.paa", 
					"_this distance _target < 5", 
					"_caller distance _target < 5", 
					{
						// Action start code
						params ["_object","_caller","_ID","_objectParams"];
						{
							//Check every opfor group near the flag
							if ((_object distance (leader _x)) < 150 ) then 
							{
								//Remove current opfor group action if LAMBS is enable
								if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
								{
									[_x] call lambs_wp_fnc_taskReset; //reset current task
								};

								//Enable MOVE and PATH for all opfor units in the area
								{
									_x enableAI "PATH";
									_x enableAI "MOVE";
								}
								foreach (units _x);
								
								//Ask opfor group to go to the flag
								[_x, getPos _object] execVM 'enemyManagement\behaviorEngine\doAttack.sqf';
							};
						} foreach (allGroups select {side _x == opfor});
					}, 
					{
						// Action on going code
					},  
					{
						// Action successfull code
						params ["_object","_caller","_ID","_objectParams","_progress","_maxProgress"];
						_thisObjective = _objectParams select 0;

						// Old flag position and rotation
						_flagPos = getPosASL _object;
						_flagVectorDir = vectorDir _object;
						_flagVectorUp = vectorUp _object;

						// Create new flag
						_newFlag = createVehicle ["Flag_Blue_F", _flagPos];
						// createVehicle is a bit random so need to reset position after creation
						_newFlag setPosASL _flagPos;
						// Set flag rotation
						_newFlag setVectorDir _flagVectorDir;
						_newFlag setVectorUp _flagVectorUp;

						// Olg flag removed
						deleteVehicle (_object);

						//Manage Completed Objective
						_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
						_completedObjectives pushBack _thisObjective;
						missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
						//Manage UncompletedObjective
						_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
						_missionUncompletedObjectives = _missionUncompletedObjectives - [_thisObjective];
						missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
						//Manage player's feedback
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[] call doIncrementVehicleSpawnCounter;	
							[_thisObjective] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
							[[50, "RPG_ranking_objective_complete"], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', 0];
							
						};
						//Manage respawn and remove actions from NPC
						removeAllActions _object;
						[_object] remoteExec ["removeAllActions", 0, true];
						if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
						{
							[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					}, 
					{
						// Action failed code
					}, 
					[_thisObjective],  
					30,
					0, 
					true, 
					false
				] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

			};

		case "informant":
			{
				//Generate objective object
				_objectiveObject = leader ([_currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;
				_objectiveObject disableAI "PATH";
				
				//Add dialog to the informant
				diag_log format ["Informant task setup ! : %1", _objectiveObject];
				_objectiveObject setPos ( _thisObjectivePosition);
				
				[
					_objectiveObject, 
					"Talk to the informant", 
					"\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa", 
					"\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa", 
					"_this distance _target < 3",						// Condition for the action to be shown
					"_caller distance _target < 3",						// Condition for the action to progress
					{
						// Action start code
					}, 
					{
						// Action on going code
					},  
					{
						// Action successfull code
						params ["_object","_caller","_ID","_objectParams","_progress","_maxProgress"];
						_thisObjective = _objectParams select 0;

						//Manage Completed Objective
						_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
						_completedObjectives pushBack _thisObjective;
						missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
						//Manage UncompletedObjective
						_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
						_missionUncompletedObjectives = _missionUncompletedObjectives - [_thisObjective];
						missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];

						//Reveal minor intel for the caller
						[[_caller, "civilianAsking"], 'engine\objectiveManagement\revealMinorIntel.sqf'] remoteExec ['BIS_fnc_execVM', _caller];

						//Manage player's feedback
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[] call doIncrementVehicleSpawnCounter;	
							[_thisObjective] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
							[[50, "RPG_ranking_objective_complete"], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
						//Manage respawn and remove actions from NPC
						removeAllActions _object;
						[_object] remoteExec ["removeAllActions", 0, true];
						if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
						{
							[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					}, 
					{
						// Action failed code
					}, 
					[_thisObjective],  
					2,
					0, 
					true, 
					false
				] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

				//Objective failed
				_objectiveObject setVariable ["thisTask", _thisObjective select 2, true];
				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					//get task associated to the object
					_thisTaskID = _unit getVariable "thisTask";
					//Manage objective
					_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
					_missionFailedObjectives = _missionFailedObjectives + [_thisTaskID]; //needs to be improved
					missionNamespace setVariable ["missionFailedObjectives", _missionFailedObjectives, true];

					//Remove all actions
					[_unit] remoteExec ["removeAllEventHandlers", 0, true];
					[_unit] remoteExec ["removeAllActions", 0, true];

					//Add penalty
					[[-50,5], 'engine\rankManagement\rankPenalty.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];

					//Manage task system
					if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
					{
						[_thisTaskID, "FAILED"] call BIS_fnc_taskSetState;
					};
				}];
			};
		default { 
			//hint "default" 
			};
	};
	currentMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	currentMissionObjectives pushBack _thisObjective;
	missionNamespace setVariable ["MissionObjectives",currentMissionObjectives,true];
	diag_log format ["MissionObjectives setup ! : %1", currentMissionObjectives];
	_thisObjective;
};



generateObjectiveTracker = 
{
	params ["_thisObjectiveObject","_thisObjectiveType"];
	_thisObjective = [];
	_thisObjective pushBack _thisObjectiveObject;
	_thisObjective pushBack _thisObjectiveType;
	_objectiveUniqueID = format ["%1%2",_thisObjectiveType, random 10000];
	_thisObjective pushBack _objectiveUniqueID;
	_thisObjective;
};