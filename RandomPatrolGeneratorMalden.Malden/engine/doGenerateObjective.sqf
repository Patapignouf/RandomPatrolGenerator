#include "..\objectGenerator\vehicleManagement.sqf"

generateObjective =
{
	params ["_avalaibleTypeOfObj","_possibleObjectivePosition","_missionDifficulty"];

	//Init mission objective status
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_missionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",_missionObjectives];

	//Generate a new objective
	SupplyObjects =  [];
	SelectedObjectives = [];
	publicvariable "SupplyObjects";
	publicvariable "SelectedObjectives";
	
	currentObjType = selectRandom _avalaibleTypeOfObj;
	currentRandomPos = [] call BIS_fnc_randomPos;
	switch (currentObjType) do
	{
		case "supply":
			{
				currentObj = createVehicle [selectRandom avalaibleSupplyBox, currentRandomPos, [], 0, "NONE"];
				currentObj setVariable ["isObjectiveObject", true, true];
			};
		case "ammo":
			{
				currentObj = createVehicle [selectRandom avalaibleAmmoBox, currentRandomPos, [], 0, "NONE"];
				currentObj setVariable ["isObjectiveObject", true, true];
			};
		case "hvt":
			{
				currentObj = leader ([currentRandomPos, east, [selectRandom avalaibleHVT],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				currentObj setVariable ["isObjectiveObject", true, true];
			};
		case "vip":
			{
				currentObj = leader ([currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				currentObj setVariable ["isObjectiveObject", true, true];
			};
		case "steal":
			{
				currentObj = createVehicle [selectRandom avalaibleStealVehicle, currentRandomPos, [], 0, "NONE"];
				currentObj setVariable ["isObjectiveObject", true, true];
			};
		case "clearArea":
			{
				//Add trigger to detect cleared area
				currentObj = createTrigger ["EmptyDetector", currentRandomPos]; //create a trigger area created at object with variable name my_object
			};
		case "defendArea":
			{
				//Add trigger to detect cleared area
				currentObj = createTrigger ["EmptyDetector", currentRandomPos]; //create a trigger area created at object with variable name my_object
			};
		case "collectIntel":
			{
				//Add intel action to the intel case
				currentObj = createVehicle [selectRandom avalaibleCollectIntel, currentRandomPos, [], 0, "NONE"];
				currentObj setVariable ["isObjectiveObject", true, true];
			};
		case "informant":
			{
				//Add dialog to the informant
				currentObj = leader ([currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				currentObj setVariable ["isObjectiveObject", true, true];
			};
		default { hint "default" };
	};

	//
	_currentObject = [currentObj, currentObjType];
	_selectedObjectivePosition = selectRandom _possibleObjectivePosition;
	_possibleObjectivePosition = _possibleObjectivePosition - [_selectedObjectivePosition];

	diag_log format ["Objective generation started : %1 on position %2", _currentObject, _selectedObjectivePosition];
	
	//Generate mission environement
	_handlePOIGeneration = [EnemyWaveLevel_1, baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, civilian_group, getPos _selectedObjectivePosition, _missionDifficulty] execVM 'enemyManagement\generatePOI.sqf'; 
	waitUntil {isNull _handlePOIGeneration};

	//Generate mission objectives
	[_currentObject, getPos _selectedObjectivePosition] call generateObjectiveObject; 
	_possibleObjectivePosition;
};



generateObjectiveObject = 
{
	params ["_thisObjective","_thisObjectivePosition"];

	//Move Object objective and create marker
	if (count _thisObjective > 0) then
	{	
		objectiveObject = _thisObjective select 0;
		objectiveType = _thisObjective select 1;
		_objectiveUniqueID = format ["%1%2",objectiveType, random 10000];
		_thisObjective pushBack _objectiveUniqueID;

		//Try to find position with building if avalaible
		_allBuildings = nearestTerrainObjects [_thisObjectivePosition, ["house"], 100, false, true];
		_allPositions = [];
		_allBuildings apply {_allPositions append (_x buildingPos -1)};
		_thisObjectivePosition = selectRandom _allPositions;

		switch (objectiveType) do
		{
			case "supply":
				{
					//Search safe position around objective position
					(objectiveObject) setPos ([( _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);

					//Objective failed
					objectiveObject setVariable ["thisTask", _objectiveUniqueID, true];
					objectiveObject addEventHandler ["Killed", {
						params ["_unit", "_killer", "_instigator", "_useEffects"];
						//get task associated to the object
						_thisTaskID = _unit getVariable "thisTask";
						//Manage objective
						_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
						_missionFailedObjectives = _missionFailedObjectives + [_thisTaskID]; //needs to be improved
						missionNamespace setVariable ["missionFailedObjectives", _missionFailedObjectives, true];
						//Manage task system
						if ("RealismMode" call BIS_fnc_getParamValue == 1 ) then 
						{
							[_thisTaskID, "FAILED"] call BIS_fnc_taskSetState;
						};
					}];
				};
			case "ammo":
				{
					(objectiveObject) setPos ([( _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
					objectiveObject setVariable ["thisTask", _objectiveUniqueID, true];
					[_thisObjective] execVM 'engine\checkDeadVehicle.sqf';  
				};
			case "hvt":
				{
					objectiveObject setPos _thisObjectivePosition;
				};
			case "vip":
				{
					diag_log format ["VIP task setup ! : %1", objectiveObject];
					(objectiveObject) setPos _thisObjectivePosition;

					//Use ACE function to set hancuffed
					if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
					{
						[objectiveObject, true] call ACE_captives_fnc_setHandcuffed;
					};
					
					//Objective failed
					objectiveObject setVariable ["thisTask", _objectiveUniqueID, true];
					objectiveObject addEventHandler ["Killed", {
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
					diag_log format ["Steal task setup ! : %1", objectiveObject];
					objectiveObject setPos ([( _thisObjectivePosition), 1, 60, 7, 0, 20, 0] call BIS_fnc_findSafePos);

					//Objective failed
					objectiveObject setVariable ["thisTask", _objectiveUniqueID, true];
					objectiveObject addEventHandler ["Killed", {
						params ["_unit", "_killer", "_instigator", "_useEffects"];
						//get task associated to the object
						_thisTaskID = _unit getVariable "thisTask";
						//Manage objective
						_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
						_missionFailedObjectives = _missionFailedObjectives + [_thisTaskID]; //needs to be improved
						missionNamespace setVariable ["missionFailedObjectives", _missionFailedObjectives, true];
						//Manage task system
						if ("RealismMode" call BIS_fnc_getParamValue == 1 ) then 
						{
							[_thisTaskID, "FAILED"] call BIS_fnc_taskSetState;
						};
					}];
				};
			case "clearArea":
				{
					//Add trigger to detect cleared area
					objectiveObject setPos _thisObjectivePosition; //create a trigger area created at object with variable name my_object
					objectiveObject setTriggerArea [200, 200, 0, false]; // trigger area with a radius of 200m.
					objectiveObject setVariable ["associatedTask", _thisObjective];
					[objectiveObject] execVM 'engine\checkClearArea.sqf'; 
				};
			case "defendArea":
				{
					//Add trigger to detect cleared area
					objectiveObject setPos _thisObjectivePosition; //create a trigger area created at object with variable name my_object
					objectiveObject setTriggerArea [200, 200, 0, false]; // trigger area with a radius of 200m.
					objectiveObject setVariable ["associatedTask", _thisObjective];
					[objectiveObject] execVM 'engine\checkDefendArea.sqf'; 
				};
			case "collectIntel":
				{
					//Add intel action to the intel case
					objectiveObject setPos _thisObjectivePosition;
					[objectiveObject, ["Collect intel",{
						params ["_object","_caller","_ID","_thisObjective"];
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
							[_thisObjective] execVM 'engine\completeObjective.sqf'; 
						};
						//Manage respawn and delete object
						deleteVehicle _object;
						if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					},_thisObjective,1.5,true,true,"","_target distance _this <3"]] remoteExec ["addAction", 0, true];
				};
			case "informant":
				{
					//Add dialog to the informant
					diag_log format ["VIP task setup ! : %1", objectiveObject];
					(objectiveObject) setPos ( _thisObjectivePosition);
					[objectiveObject, objectiveObject, 75, [], true] call lambs_wp_fnc_taskGarrison;
					
					[
						objectiveObject, 
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
							//Manage player's feedback
							if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
							{
								[] call doIncrementVehicleSpawnCounter;	
								[_thisObjective] execVM 'engine\completeObjective.sqf'; 
								
							};
							//Manage respawn and remove actions from NPC
							removeAllActions _object;
							[_object] remoteExec ["removeAllActions", 0, true];
							if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
							{
								[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
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
					objectiveObject setVariable ["thisTask", _objectiveUniqueID, true];
					objectiveObject addEventHandler ["Killed", {
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

						//Manage task system
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[_thisTaskID, "FAILED"] call BIS_fnc_taskSetState;
						};
					}];
				};
			default { hint "default" };
		};
		currentMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
		currentMissionObjectives pushBack _thisObjective;
		missionNamespace setVariable ["MissionObjectives",currentMissionObjectives,true];
		diag_log format ["MissionObjectives setup ! : %1", currentMissionObjectives];
	};
};