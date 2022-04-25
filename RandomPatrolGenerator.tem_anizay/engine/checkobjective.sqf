_objectivesToTest = _this select 0;
_objectivesDestinationArea = _this select 1;

//Obj management
obj_list_items = [];
respawnSettings = ["Respawn",1] call BIS_fnc_getParamValue;

//Define current test
current_obj = objNull;

missionComplete = false;
numberOfCompletedObj = 0;
numberOfObjectives = count _objectivesToTest;

independantTrigger = createTrigger ["EmptyDetector", getPos _objectivesDestinationArea]; //create a trigger area created at object with variable name my_object
independantTrigger setTriggerArea [60, 60, 0, false]; // trigger area with a radius of 100m.

waitUntil {!isNil "initBlueforLocation" && count initBlueforLocation != 0};
bluforTrigger = createTrigger ["EmptyDetector", initBlueforLocation]; //create a trigger area created at object with variable name my_object
bluforTrigger setTriggerArea [100, 100, 0, false]; // trigger area with a radius of 100m.
objectReturnedToCity = []; 

if (respawnSettings == 1) then 
{
	[] execVM "engine\respawnSetup.sqf";
};

{
	obj_list_items pushBack (_x select 0);
} foreach _objectivesToTest;

diag_log format ["Objective to test :  %1 in complete list %2", obj_list_items, _objectivesToTest];

while {sleep 10; !missionComplete} do
{
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_missionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",_missionObjectives];
	missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];
	diag_log format ["Loop to test objective : %1", _objectivesToTest];
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
							[current_obj select 2,"SUCCEEDED"] call BIS_fnc_taskSetState;
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
							[current_obj select 2,"SUCCEEDED"] call BIS_fnc_taskSetState;
						};
						if (respawnSettings == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					};
				};
			case "ammo":
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
							[current_obj select 2,"SUCCEEDED"] call BIS_fnc_taskSetState;
						};
						if (respawnSettings == 1) then 
						{
							[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
						};
					} else 
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
								[current_obj select 2,"SUCCEEDED"] call BIS_fnc_taskSetState;
							};
							if (respawnSettings == 1) then 
							{
								[[], "engine\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
							};
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
							[current_obj select 2,"SUCCEEDED"] call BIS_fnc_taskSetState;
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
							[current_obj select 2,"SUCCEEDED"] call BIS_fnc_taskSetState;
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
};

diag_log format ["All objectives completed !"];
if (isMultiplayer) then {
	'OBJ_OK' call BIS_fnc_endMissionServer;
} else {
	'OBJ_OK' call BIS_fnc_endMission;
};

