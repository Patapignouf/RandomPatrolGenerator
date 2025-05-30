#include "..\..\objectGenerator\vehicleManagement.sqf"
#include "..\..\enemyManagement\generationEngine\hostileGroupManager.sqf"

generateObjective =
{
	params ["_avalaibleTypeOfObj","_possibleObjectivePosition"];

	//Init mission objective status
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_missionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",_missionObjectives];
	_warEra = missionNamespace getVariable "warEra";
	_basicEnemyGroups = [[opFaction, "BASIC"] call getBasicUnitsGroup, [opFaction, "AT"] call getBasicUnitsGroup];

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

	//GenerateAnimals 
	[[_selectedObjectivePosition, 40, 200, 7, 0, 0, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos] call doGenerateAnimalGroup;
	
	//Generate mission environement
	switch (currentObjType) do 
	{
		case "defendArea":
		{
			//Populate the area with only civilian randomly
			if (random 100 > 50) then 
			{
				[civilian_group, ((_selectedObjectivePosition) findEmptyPosition [5, 60]), civilian, "Civilian"] call doGenerateEnemyGroup;
			};

			//Generate mission objectives
			diag_log format ["_selectedObjectivePosition %1", _selectedObjectivePosition];
			_objectiveCreated = [currentObjType, _selectedObjectivePosition] call generateObjectiveObject; 

		};
		case "hostage":
		{
			//Populate biggest buildings with opfor
			_tempSelectedObjectivePosition = [_selectedObjectivePosition, 200, _basicEnemyGroups] call generateOpforInBiggestBuildings;
			_selectedObjectivePosition = _tempSelectedObjectivePosition;

			//Generate mission objectives
			diag_log format ["_selectedObjectivePosition %1", _selectedObjectivePosition];
			_objectiveCreated = [currentObjType, _selectedObjectivePosition] call generateObjectiveObject; 
		};
		default
		{
			//Generate mission objectives
			diag_log format ["_selectedObjectivePosition %1", _selectedObjectivePosition];
			_objectiveCreated = [currentObjType, _selectedObjectivePosition] call generateObjectiveObject; 

			if (random 100 < 20 && _warEra != 0) then 
			{
				//20% objective with hostile almost only civilian
				//Not avalaible on WWII era
				_handlePOIGeneration = [_basicEnemyGroups, baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, civilian_group, _selectedObjectivePosition, _objectiveCreated] execVM 'enemyManagement\generationEngine\generateHostileCivPOI.sqf'; 
				waitUntil {isNull _handlePOIGeneration};
			} else 
			{
				//80% normal objective with opfor forces 
				_handlePOIGeneration = objNull;
				if ((missionNamespace getVariable "enableCiviliansOnObjectives") == 1) then 
				{
					_handlePOIGeneration = [baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, baseEnemyTurretGroup, civilian_group, _selectedObjectivePosition, _objectiveCreated] execVM 'enemyManagement\generationEngine\generatePOI.sqf'; 
				} else 
				{
					_handlePOIGeneration = [baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, baseEnemyTurretGroup, [], _selectedObjectivePosition, _objectiveCreated] execVM 'enemyManagement\generationEngine\generatePOI.sqf'; 
				};
				waitUntil {isNull _handlePOIGeneration};
			};
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
	_thistempObjectivePosition = [];
	_warEra = missionNamespace getVariable "warEra";

	//Try to find position with building if avalaible
	if (_thisObjectiveType != "hostage") then 
	{
		_allBuildings = nearestTerrainObjects [_thisObjectivePosition, ["house", "FORTRESS", "BUNKER"], 100, false, true];
		_allPositions = [];
		_allBuildings apply {_allPositions append (_x buildingPos -1)};

		//Check if there is an eligible building to the objective
		if (count _allPositions != 0) then 
		{
			_thistempObjectivePosition = selectRandom _allPositions;
		};
	};

	
	//Test if there's an avalaible position
	if (count _thistempObjectivePosition != 0) then 
	{
		_thisObjectivePosition = _thistempObjectivePosition;
	};

	//Place IED 
	//No IED on WWII
	if (_warEra != 0) then 
	{
		_possibleIEDLocation = [_thisObjectivePosition, 1000, round (random 4)] call findPositionsNearRoads;
		if (count _possibleIEDLocation >0) then 
		{
			{
				_tempIED = createVehicle [selectRandom avalaibleIED, [[[_x, 10]], []] call BIS_fnc_randomPos, [], 0, "NONE"];
				[_tempIED, selectRandom [1,2,3], false] execVM "objectGenerator\iedBlast.sqf";
			} foreach _possibleIEDLocation;
		};
	};


	//50% chance to spawn mines around the objective
	if (random 100 > 50) then 
	{
		_mineBlackListTrigger = createTrigger ["EmptyDetector", _thisObjectivePosition];
		_mineBlackListTrigger setTriggerArea [400, 400, 0, true];
		
		//generate 2 minefields
		for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
		{		

			_pos = [[[_thisObjectivePosition, 1000]], ["water", _mineBlackListTrigger]] call BIS_fnc_randomPos;
			[[_pos], 'objectGenerator\doGenerateMineField.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
	};


	//Place roadblock
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
					[{[-50,5] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];

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

				[
					_objectiveObject, 
					"Destroy ammo box", 
					"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa", 
					"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa", 
					"_this distance _target < 3 && _this getVariable 'role' == 'engineer'",						// Condition for the action to be shown
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
						sleep 5;
						_object setDamage 1;

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
			};
		case "hvt":
			{
				//Generate objective object
				_objectiveObject = leader ([_currentRandomPos, east, [selectRandom avalaibleHVT],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				_objectiveObject disableAI "PATH";
				diag_log format ["HVT %2 _thisObjectivePosition : %1",_thisObjectivePosition, _objectiveObject];
				_objectiveObject setVariable ["isObjectiveObject", true, true];
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
						[{[50, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
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
				removeAllWeapons _objectiveObject;
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				diag_log format ["VIP task setup ! : %1", _objectiveObject];
				_objectiveObject setPos _thisObjectivePosition;

				//Play random dialog to help players to find objective
				[_objectiveObject] spawn {
					params ["_objectiveObject"];
					while {sleep 10; alive _objectiveObject} do 
					{
						_currentlyVoice = ["a3\dubbing_f_epc\c_in1\14_ambient_talk_04\c_in1_14_ambient_talk_04_abb_1.ogg",
											"a3\dubbing_f_epc\c_in1\14_ambient_talk_04\c_in1_14_ambient_talk_04_abb_0.ogg",
											"a3\dubbing_f_epc\c_in1\14_ambient_talk_04\c_in1_14_ambient_talk_04_aba_0.ogg",
											"a3\dubbing_f_epc\c_in1\13_ambient_talk_03\c_in1_13_ambient_talk_03_aba_0.ogg",
											"a3\dubbing_f_epc\c_in1\11_ambient_talk_01\c_in1_11_ambient_talk_01_aba_1.ogg"
										];
						playSound3D [selectRandom _currentlyVoice, _objectiveObject, true, getPosASL _objectiveObject, 5, 1, 20, 0, false];
					};
				};

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

					//Punish player
					if (isPlayer _instigator) then 
					{
						//Add penalty
						[{[-50,5] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];
					};

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
		case "hostage":
			{
				//Generate objective object
				_objectiveObject =  leader ([_currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
				_objectiveObject setVariable ["isObjectiveObject", true, true];
				_thisObjective = [_objectiveObject, _thisObjectiveType] call generateObjectiveTracker;

				diag_log format ["VIP task setup ! : %1", _objectiveObject];
				_objectiveObject setPos _thisObjectivePosition;

				//Use ACE function to set hancuffed
				_objectiveObject setcaptive true;                              // keep tangos from targeting hostage until breach trigger fires
				[_objectiveObject, "acts_aidlpsitmstpssurwnondnon_loop"] remoteExec ["switchMove", 0, true];
				_objectiveObject setBehaviour "CARELESS";   
				_objectiveObject disableAI "PATH";

				//Objective failed
				_objectiveObject setVariable ["thisTask", _thisObjective select 2, true];
				
				//Manage objective completion
				[
					_objectiveObject, 
					"Free the hostage", 
					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", 
					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", 
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

						//Free the hostage
						_object setcaptive false;                              // keep tangos from targeting hostage until breach trigger fires
						[_object, ""] remoteExec ["switchMove", 0, true];
						_object setBehaviour "CARELESS";   
						_object enableAI "PATH";
						removeAllWeapons _object;

						[{["STR_RPG_OBJ_HOSTAGE", "STR_RPG_OBJ_HOSTAGE_THANK"] call doDialog}] remoteExec ["call", side _caller];

						//Manage player's feedback
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[] call doIncrementVehicleSpawnCounter;	
							[_thisObjective] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
							[{[50, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
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
					10,
					10, 
					true, 
					false
				] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
				
				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					//get task associated to the object
					_thisTaskID = _unit getVariable "thisTask";

					//Remove all actions
					[_unit] remoteExec ["removeAllEventHandlers", 0, true];
					[_unit] remoteExec ["removeAllActions", 0, true];

					//Punish player
					if (isPlayer _instigator) then 
					{
						//Add penalty
						[{[-50,5] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];
					};

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
					[{[-50,5] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];

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
					[{["STR_RPG_HC_NAME", "STR_RPG_HC_OPFOR_AROUND"] call doDialog}] remoteExec ["call", side _caller];

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

				//play sound to help player
				[_objectiveObject] spawn {
					params ["_objectiveObject"];
					while {sleep 10; alive _objectiveObject} do 
					{
						playSound3D ["a3\sounds_f\debugsound.wss", _objectiveObject, true, getPosASL _objectiveObject, 3, 1, 20, 0, false];
					};
				};

				//Add intel action to the intel case
				_objectiveObject setPos _thisObjectivePosition;
				[_objectiveObject, ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa'/><t size='1'>Collect intel</t>",{
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
						[{[50, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
					};
					//Manage respawn and delete object
					deleteVehicle _object;
					if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
					{
						[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
					};
				},_thisObjective,10,true,true,"","_target distance _this <4"]] remoteExec ["addAction", 0, true];
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
								[_x, getPos _object] call doAttack;
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
							[{[50, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
							
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
					10, 
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
				removeAllWeapons _objectiveObject;

				//Add dialog to the informant
				diag_log format ["Informant task setup ! : %1", _objectiveObject];
				_objectiveObject setPos ( _thisObjectivePosition);

				//Play random dialog to help players to find objective
				[_objectiveObject] spawn {
					params ["_objectiveObject"];
					while {sleep 10; alive _objectiveObject} do 
					{
						_currentlyVoice = ["a3\dubbing_f_epc\c_in1\14_ambient_talk_04\c_in1_14_ambient_talk_04_abb_1.ogg",
											"a3\dubbing_f_epc\c_in1\14_ambient_talk_04\c_in1_14_ambient_talk_04_abb_0.ogg",
											"a3\dubbing_f_epc\c_in1\14_ambient_talk_04\c_in1_14_ambient_talk_04_aba_0.ogg",
											"a3\dubbing_f_epc\c_in1\13_ambient_talk_03\c_in1_13_ambient_talk_03_aba_0.ogg",
											"a3\dubbing_f_epc\c_in1\11_ambient_talk_01\c_in1_11_ambient_talk_01_aba_1.ogg"
										];
						playSound3D [selectRandom _currentlyVoice, _objectiveObject, true, getPosASL _objectiveObject, 5, 1, 20, 0, false];
					};
				};
				
				
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
							[{[50, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
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

					//Punish player
					if (isPlayer _instigator) then 
					{
						//Add penalty
						[{[-50,5] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];
					};

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

	//Setup all missions database
	currentMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	currentMissionObjectives pushBack _thisObjective;
	missionNamespace setVariable ["MissionObjectives",currentMissionObjectives,true];

	//Setup all uncompleted missions database
	_currentUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
	_currentUncompletedObjectives pushBack _thisObjective;
	missionNamespace setVariable ["missionUncompletedObjectives",_currentUncompletedObjectives,true];

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