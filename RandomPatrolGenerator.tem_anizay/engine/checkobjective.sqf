#include "..\objectGenerator\vehicleManagement.sqf"

_objectivesToTest = _this select 0;
_objectivesDestinationArea = _this select 1;

//Obj management
obj_list_items = [];
respawnSettings = ["Respawn",1] call BIS_fnc_getParamValue;
campaignMode = "CampaignMode" call BIS_fnc_getParamValue;

//Define current test
current_obj = objNull;

missionComplete = false;
RTBComplete = false;
isRTBMissionGenerated = false;
numberOfCompletedObj = 0;
numberOfObjectives = count _objectivesToTest;

independantTrigger = createTrigger ["EmptyDetector", getPos _objectivesDestinationArea]; //create a trigger area created at object with variable name my_object
independantTrigger setTriggerArea [60, 60, 0, false]; // trigger area with a radius of 100m.

waitUntil {!isNil "missionGenerated"};
waitUntil {missionGenerated};

bluforTrigger = createTrigger ["EmptyDetector", initBlueforLocation]; //create a trigger area created at object with variable name my_object
bluforTrigger setTriggerArea [100, 100, 0, false]; // trigger area with a radius of 100m.
objectReturnedToCity = []; 

if (respawnSettings == 1) then 
{
	[] execVM "engine\respawnSetup.sqf";
};

while {sleep 10; !RTBComplete} do
{
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_missionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",_missionObjectives];
	missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
	diag_log format ["Loop to test objective : %1", _objectivesToTest];

	{
		obj_list_items pushBack (_x select 0);
	} foreach _missionUncompletedObjectives;

	objectReturnedToCity = obj_list_items inAreaArray independantTrigger; //vehicles (all vehicles) inAreaArray (Returns list of Objects or Positions that are in the area _independantTrigger.)  
	objectReturnedToFOB = obj_list_items inAreaArray bluforTrigger;
	{
		current_obj = _x;
		diag_log format ["Currently test objective : %1", current_obj];
		
		switch (current_obj select 1) do
		{
			case "steal":
				{
					if (current_obj select 0 in objectReturnedToCity || current_obj select 0 in objectReturnedToFOB) then
					{
						diag_log format ["Objective %1 completed !", current_obj select 0 ];
						obj_list_items = obj_list_items - [current_obj select 0];
						_missionUncompletedObjectives = _missionUncompletedObjectives - [current_obj];
						missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
						_completedObjectives pushBack current_obj;
						missionNamespace setVariable ["completedObjectives",_completedObjectives,true];
						[[format ["L'objectif %1 est terminé", getText (configFile >> "cfgVehicles" >> typeOf (current_obj select 0) >> "displayName")],independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
						//Manage player's feedback
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[] call doIncrementVehicleSpawnCounter;	
							[current_obj] execVM 'engine\completeObjective.sqf'; 
						};
						if (respawnSettings == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					};
				};
			case "supply":
				{
					if (current_obj select 0 in objectReturnedToCity || current_obj select 0 in objectReturnedToFOB) then
					{
						diag_log format ["Objective %1 completed !", current_obj select 0 ];
						obj_list_items = obj_list_items - [current_obj select 0];
						_missionUncompletedObjectives = _missionUncompletedObjectives - [current_obj];
						missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
						_completedObjectives pushBack current_obj;
						missionNamespace setVariable ["completedObjectives",_completedObjectives,true];
						[[format ["L'objectif %1 est terminé", getText (configFile >> "cfgVehicles" >> typeOf (current_obj select 0) >> "displayName")],independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
						//Manage player's feedback
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[] call doIncrementVehicleSpawnCounter;	
							[current_obj] execVM 'engine\completeObjective.sqf'; 
						};
						if (respawnSettings == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					};
				};
			case "ammo":
				{
					if (current_obj select 0 in objectReturnedToCity || current_obj select 0 in objectReturnedToFOB) then
					{
						diag_log format ["Objective %1 completed !", current_obj select 0 ];
						obj_list_items = obj_list_items - [current_obj select 0];
						_missionUncompletedObjectives = _missionUncompletedObjectives - [current_obj];
						missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
						_completedObjectives pushBack current_obj;
						missionNamespace setVariable ["completedObjectives",_completedObjectives,true];
						[[format ["L'objectif %1 est terminé", getText (configFile >> "cfgVehicles" >> typeOf (current_obj select 0) >> "displayName")],independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
						//Manage player's feedback
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[] call doIncrementVehicleSpawnCounter;	
							[current_obj] execVM 'engine\completeObjective.sqf'; 
						};
						if (respawnSettings == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					};
				};
			case "hvt":
				{
					if (!alive (current_obj select 0)) then 
					{	
						diag_log format ["Objective %1 completed !", current_obj select 0 ];
						obj_list_items = obj_list_items - [current_obj select 0];
						_missionUncompletedObjectives = _missionUncompletedObjectives - [current_obj];
						missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
						_completedObjectives pushBack current_obj;
						missionNamespace setVariable ["completedObjectives",_completedObjectives,true];
						[[format ["L'objectif %1 est terminé", getText (configFile >> "cfgVehicles" >> typeOf (current_obj select 0) >> "displayName")],independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
						//Manage player's feedback
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[] call doIncrementVehicleSpawnCounter;	
							[current_obj] execVM 'engine\completeObjective.sqf'; 
						};
						if (respawnSettings == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					};
				};
			case "vip":
				{
					if (current_obj select 0 in objectReturnedToCity || current_obj select 0 in objectReturnedToFOB) then
					{
						diag_log format ["Objective %1 completed !", current_obj select 0 ];
						obj_list_items = obj_list_items - [current_obj select 0];
						_missionUncompletedObjectives = _missionUncompletedObjectives - [current_obj];
						missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
						_completedObjectives pushBack current_obj;
						missionNamespace setVariable ["completedObjectives",_completedObjectives,true];
						//Manage player's feedback
						if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
						{
							[] call doIncrementVehicleSpawnCounter;	
							[current_obj] execVM 'engine\completeObjective.sqf'; 
						};
						[[format ["L'objectif %1 est terminé", getText (configFile >> "cfgVehicles" >> typeOf (current_obj select 0) >> "displayName")],independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
						if (respawnSettings == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					};
				};
			default { hint "default" };
		};
	} foreach _missionUncompletedObjectives;
	missionComplete = count _completedObjectives + 1 >= count _missionObjectives;

	//Check if mission is complete
	if (missionComplete && campaignMode == 0) then 
	{
		//Generate RTB mission
		if (!isRTBMissionGenerated) then 
		{
			[true, "taskRTB", ["Return to your initial base", "RTB", ""], objNull, 1, 3, true] call BIS_fnc_taskCreate;
			isRTBMissionGenerated = true;
		};

		nbBluePlayer = {alive _x && side _x == blufor} count allPlayers;
		nbIndPlayer = {alive _x && side _x == independent} count allPlayers;
		nbBluePlayerBack = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray bluforTrigger); //vehicles (all vehicles) inAreaArray (Returns list of Objects or Positions that are in the area _independantTrigger.)  
		nbIndPlayerBack = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray independantTrigger);
		if (nbBluePlayer == nbBluePlayerBack && nbIndPlayer == nbIndPlayerBack) then 
		{
			["taskRTB","SUCCEEDED"] call BIS_fnc_taskSetState;
			RTBComplete = true;
		};
	};
};


diag_log format ["All objectives completed !"];
if (isMultiplayer) then {
	'OBJ_OK' call BIS_fnc_endMissionServer;
} else {
	'OBJ_OK' call BIS_fnc_endMission;
};

