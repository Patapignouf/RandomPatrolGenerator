params ["_objectiveID", "_objectiveType", "_objectiveLocation", "_objectiveObject"];

//Debug command
//[["_TestID","AttackFOB",getPos player, player], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 0, true];

if ((_objectiveID call BIS_fnc_taskState ) != "SUCCEEDED" && !(missionNameSpace getVariable [format ["RPG_%1", _objectiveID], false])) then 
{
	//Setup unique quest to rules them all
	_mainSideQuestID = "RPG_SideObjective";

	if (!([_mainSideQuestID] call BIS_fnc_taskExists)) then 
	{
			[true, _mainSideQuestID, [["STR_RPG_OBJ_SIDE_MASTER_TEXT"], ["STR_RPG_OBJ_SIDE_MASTER"], "cookiemarker_mainSideQuest"], objNull, "CREATED", -1, true] call BIS_fnc_taskCreate;
	};

	//Set task description
	_currentObjectiveTitle = "";
	_currentObjectiveDescription = "";

	switch (_objectiveType) do
	{
		
		case "AttackFOB":
		{
			_currentObjectiveTitle = "STR_RPG_OBJ_ATK_FOB";
			_currentObjectiveDescription = ["STR_RPG_OBJ_ATK_FOB_TEXT", mapGridPosition _objectiveLocation];
			[_objectiveID, _objectiveLocation] spawn {
				params ["_objectiveID", "_objectiveLocation"];
				
				//Define enemy detect trigger
				_thisTrigger = createTrigger ["EmptyDetector", _objectiveLocation];
				_thisTrigger setTriggerArea [200, 200, 0, false]; 

				_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
				_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
				_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
				
				//Add more opfor to the area
				while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
				{	
					_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
					_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
					_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
				};			

				[_objectiveID, "SUCCEEDED"] call BIS_fnc_taskSetState;
				missionNameSpace setVariable [format ["RPG_%1", _objectiveID], true, true];
				[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
			};
		};
		case "DestroyAirVehicle":
		{
			_currentObjectiveTitle = "STR_RPG_OBJ_AIR_VCL";
			_currentObjectiveDescription = ["STR_RPG_OBJ_AIR_VCL_TEXT", mapGridPosition _objectiveLocation, getText (configFile >> "cfgVehicles" >> typeOf (vehicle leader (_objectiveObject)) >> "displayName")];

			_objectiveObject setVariable ["sideTaskAssociated", _objectiveID, true];
			
			if (alive _objectiveObject) then 
			{
				//Add eventhandler killed
				_objectiveObject setVariable ["sideObjectiveID", format ["RPG_%1", _objectiveID], true];
				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];

					_sideTaskID = _unit getVariable "sideTaskAssociated";
					[_sideTaskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
					missionNameSpace setVariable [format ["RPG_%1", _unit getVariable "sideObjectiveID"], true, true];
					[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
				}];
			} else 
			{
				//Already killed
				[_objectiveID, "SUCCEEDED"] call BIS_fnc_taskSetState;
				missionNameSpace setVariable [format ["RPG_%1", _objectiveID], true, true];
				[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
			};
		};
		case "DestroyArmored":
		{
			_currentObjectiveTitle = "STR_RPG_OBJ_ARM_VCL";
			_currentObjectiveDescription = ["STR_RPG_OBJ_ARM_VCL_TEXT", mapGridPosition _objectiveLocation, getText (configFile >> "cfgVehicles" >> typeOf (vehicle leader (_objectiveObject)) >> "displayName")];

			_objectiveObject setVariable ["sideTaskAssociated", _objectiveID, true];

			if (alive _objectiveObject) then 
			{
				//Add eventhandler killed
				_objectiveObject setVariable ["sideObjectiveID", format ["RPG_%1", _objectiveID], true];
				_objectiveObject addEventHandler ["HandleDamage", {
					params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
					if ((_unit getHit "motor") > 0.7) then 
					{
						_unit setDamage 1;

						_sideTaskID = _unit getVariable "sideTaskAssociated";

						if ([_sideTaskID] call BIS_fnc_taskState != "SUCCEEDED") then 
						{
							[_sideTaskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
							missionNameSpace setVariable [format ["RPG_%1", _unit getVariable "sideObjectiveID"], true, true];
							[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
						};

					};
				}];
				//Check killed EH
				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];

					_sideTaskID = _unit getVariable "sideTaskAssociated";
					if ([_sideTaskID] call BIS_fnc_taskState != "SUCCEEDED") then 
					{
						[_sideTaskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
						missionNameSpace setVariable [format ["RPG_%1", _unit getVariable "sideObjectiveID"], true, true];
						[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
					};
				}];

			} else 
			{
				//Already killed
				[_objectiveID, "SUCCEEDED"] call BIS_fnc_taskSetState;
				missionNameSpace setVariable [format ["RPG_%1", _objectiveID], true, true];
				[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
			};
		};
		case "DestroyMortar":
		{
			_currentObjectiveTitle = "STR_RPG_OBJ_MORTAR";
			_currentObjectiveDescription = ["STR_RPG_OBJ_MORTAR_TEXT", mapGridPosition _objectiveLocation, getText (configFile >> "cfgVehicles" >> typeOf (vehicle leader (_objectiveObject)) >> "displayName")];

			_objectiveObject setVariable ["sideTaskAssociated", _objectiveID, true];

			if (alive _objectiveObject) then 
			{
				//Add eventhandler killed
				_objectiveObject setVariable ["sideObjectiveID", format ["RPG_%1", _objectiveID], true];
				_objectiveObject addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];

					_sideTaskID = _unit getVariable "sideTaskAssociated";
					[_sideTaskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
					missionNameSpace setVariable [format ["RPG_%1", _unit getVariable "sideObjectiveID"], true, true];
					[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
				}];
			} else 
			{
				//Already killed
				[_objectiveID, "SUCCEEDED"] call BIS_fnc_taskSetState;
				missionNameSpace setVariable [format ["RPG_%1", _objectiveID], true, true];
				[{[25, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
			};
		};
		default
		{
			//Do nothing
		};
	};

	//Store every task id
	_currentSideObjectives = missionNamespace getVariable ["currentSideObjectives", []];
	_currentSideObjectives pushBack _objectiveID;
	 missionNamespace setVariable ["currentSideObjectives", _currentSideObjectives, true];

	//Generate the side task
	[true , [_objectiveID, _mainSideQuestID], [_currentObjectiveDescription, [_currentObjectiveTitle], "cookiemarker2_intel"], objNull, "CREATED", -1, true] call BIS_fnc_taskCreate;
};
