#include "..\..\objectGenerator\vehicleManagement.sqf"

_objectivesDestinationArea = _this select 0;

//Obj management
obj_list_items = [];
respawnSettings = ["Respawn",1] call BIS_fnc_getParamValue;
enableCampaignMode = missionNamespace getVariable "enableCampaignMode"; //Default disable

//Define current test
current_obj = objNull;

missionComplete = false;
RTBComplete = false;
isRTBMissionGenerated = false;
numberOfCompletedObj = 0;

independantTrigger = createTrigger ["EmptyDetector", getPos _objectivesDestinationArea]; //create a trigger area created at object with variable name my_object
independantTrigger setTriggerArea [60, 60, 0, false]; // trigger area with a radius of 100m.

waitUntil {!isNil "missionGenerated"};
waitUntil {missionGenerated};

bluforTrigger = createTrigger ["EmptyDetector", initBlueforLocation]; //create a trigger area created at object with variable name my_object
bluforTrigger setTriggerArea [100, 100, 0, false]; // trigger area with a radius of 100m.
objectReturnedToCity = []; 

if (respawnSettings == 1) then 
{
	[] execVM "engine\respawnManagement\respawnSetup.sqf";
};

while {sleep 10; !RTBComplete} do
{
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_missionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",_missionObjectives];
	missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];

	missionComplete = count _completedObjectives + 1 >= count _missionObjectives;

	//Check if mission is complete
	if (missionComplete && !enableCampaignMode) then 
	{
		//Generate RTB mission
		if (!isRTBMissionGenerated) then 
		{
			[true, "taskRTB", ["Return to your initial base or exctract  area of operation", "RTB or Extract", ""], objNull, 1, 3, true] call BIS_fnc_taskCreate;
			isRTBMissionGenerated = true;

			extractExtendedTriggerArea = createTrigger ["EmptyDetector", areaOfOperationPosition]; //create a trigger area created at object with variable name my_object
			extractExtendedTriggerArea setTriggerArea [(extendedTriggerArea #0)*2+500, (extendedTriggerArea #1)*2+500, 0, false]; // trigger area with a radius of 100m.
			
			//Display area of operation
			[[areaOfOperationPosition,[(extendedTriggerArea #0)+500,(extendedTriggerArea #1)+500]], "engine\objectiveManagement\drawAORectangle.sqf"] remoteExec ['BIS_fnc_execVM', 0, true];
		};

		nbBluePlayer = {alive _x && side _x == blufor} count allPlayers;
		nbIndPlayer = {alive _x && side _x == independent} count allPlayers;
		nbBluePlayerBack = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray bluforTrigger); //vehicles (all vehicles) inAreaArray (Returns list of Objects or Positions that are in the area _independantTrigger.)  
		nbIndPlayerBack = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray independantTrigger);
		if (((nbBluePlayer == nbBluePlayerBack && nbIndPlayer == nbIndPlayerBack) && (nbBluePlayerBack != 0 || nbIndPlayerBack != 0))||(count (allPlayers inAreaArray extractExtendedTriggerArea) == 0)) then 
		{
			["taskRTB","SUCCEEDED"] call BIS_fnc_taskSetState;
			//Reward player for RTB
			[[50], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', 0];
			RTBComplete = true;

			//Save current loadout
			if (ironMan) then 
			{
				[objNull, "personal"] remoteExec ["saveCustomLoadout", 0, true];
			};
		};
	};
};


diag_log format ["All objectives completed !"];
[['OBJ_OK'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];

