#include "..\objectGenerator\vehicleManagement.sqf"

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
	
	currentObjType = selectRandom _avalaibleTypeOfObj;
	currentRandomPos = [] call BIS_fnc_randomPos;
	switch (currentObjType) do
	{
		case "supply":
			{
				currentObj = createVehicle [selectRandom avalaibleSupplyBox, currentRandomPos, [], 0, "NONE"];
			};
		case "ammo":
			{
				currentObj = createVehicle [selectRandom avalaibleAmmoBox, currentRandomPos, [], 0, "NONE"];
			};
		case "hvt":
			{
				currentObj = leader ([currentRandomPos, east, [selectRandom avalaibleHVT],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
			};
		case "vip":
			{
				currentObj = leader ([currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				currentObj setVariable ["missionObjectiveCivilian", true, true];
			};
		case "steal":
			{
				currentObj = createVehicle [selectRandom avalaibleStealVehicle, currentRandomPos, [], 0, "NONE"];
			};
		case "clearArea":
			{
				//Add trigger to detect cleared area
				currentObj = createTrigger ["EmptyDetector", currentRandomPos]; //create a trigger area created at object with variable name my_object
			};
		case "collectIntel":
			{
				//Add intel action to the intel case
				currentObj = createVehicle [selectRandom avalaibleCollectIntel, currentRandomPos, [], 0, "NONE"];
				currentObj setVariable ["missionObjectiveCivilian", true, true];
			};
		case "informant":
			{
				//Add dialog to the informant
				currentObj = leader ([currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
			};
		default { hint "default" };
	};

	//
	_currentObject = [currentObj, currentObjType];
	_selectedObjectivePosition = selectRandom _possibleObjectivePosition;
	_possibleObjectivePosition = _possibleObjectivePosition - [_selectedObjectivePosition];

	diag_log format ["Objective generation started : %1 on position %2", _currentObject, _selectedObjectivePosition];
	
	//Generate mission environement
	_handlePOIGeneration = [EnemyWaveLevel_1, baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, civilian_group, _selectedObjectivePosition, difficultyParameter] execVM 'enemyManagement\generatePOI.sqf'; 
	waitUntil {isNull _handlePOIGeneration};

	//Generate mission objectives
	[_currentObject, _selectedObjectivePosition] call generateObjectiveObject; 
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

		switch (objectiveType) do
		{
			case "supply":
				{
					(objectiveObject) setPos ([(getPos _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);

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
					(objectiveObject) setPos ([(getPos _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
					objectiveObject setVariable ["thisTask", _objectiveUniqueID, true];
					[_thisObjective] execVM 'engine\checkDeadVehicle.sqf';  
				};
			case "hvt":
				{
					(objectiveObject) setPos (getPos _thisObjectivePosition);
					[objectiveObject, objectiveObject, 75, [], true] call lambs_wp_fnc_taskGarrison;
				};
			case "vip":
				{
					diag_log format ["VIP task setup ! : %1", objectiveObject];
					(objectiveObject) setPos (getPos _thisObjectivePosition);
					[objectiveObject, objectiveObject, 75, [], true] call lambs_wp_fnc_taskGarrison;

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
					objectiveObject setPos ([(getPos _thisObjectivePosition), 1, 60, 7, 0, 20, 0] call BIS_fnc_findSafePos);

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
					objectiveObject setPos (getPos _thisObjectivePosition); //create a trigger area created at object with variable name my_object
					objectiveObject setTriggerArea [200, 200, 0, false]; // trigger area with a radius of 200m.
					objectiveObject setVariable ["associatedTask", _thisObjective];
					[objectiveObject] execVM 'engine\checkClearArea.sqf'; 
				};
			case "collectIntel":
				{
					//Add intel action to the intel case
					objectiveObject setPos ([(getPos _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
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
					(objectiveObject) setPos (getPos _thisObjectivePosition);
					[objectiveObject, objectiveObject, 75, [], true] call lambs_wp_fnc_taskGarrison;
					
					//Objective completion
					[objectiveObject, ["Talk to the informant",{
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
						//Manage respawn and remove actions from NPC
						removeAllActions _object;
						[_object] remoteExec ["removeAllActions", 0, true];
						if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					},_thisObjective,1.5,true,true,"","_target distance _this <3"]] remoteExec ["addAction", 0, true];

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