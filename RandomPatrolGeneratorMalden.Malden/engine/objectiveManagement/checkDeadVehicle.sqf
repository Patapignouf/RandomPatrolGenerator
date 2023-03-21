#include "..\..\objectGenerator\vehicleManagement.sqf"

params ["_objective"];

//init object 
_objectiveObject = _objective select 0;
_objectiveType = _objective select 1;
_objectiveTaskID = _objective select 2;

while {sleep 10; alive _objectiveObject} do 
{
	//Do nothing
};

switch (_objectiveType) do
{
	case "ammo":
	{
		_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
		_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];

		//Manage Completed Objective
		_completedObjectives pushBack _objective;
		missionNamespace setVariable ["completedObjectives", _completedObjectives, true];	
		//Manage UncompletedObjective
		_missionUncompletedObjectives = _missionUncompletedObjectives - _objective;
		missionNamespace setVariable ["missionUncompletedObjectives", _missionUncompletedObjectives, true];
		//Manage player's feedback
		if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
		{
			[] call doIncrementVehicleSpawnCounter;	
			[_objective] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
		};

		//Respawn
		if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
		{
			[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
		};
	};
	// case "supply":
	// case "ammo":
	// case "hvt":
	// case "vip":
	// case "steal":
	// case "clearArea":
	// case "collectIntel":
	// case "informant":
	default { hint "default" };
};