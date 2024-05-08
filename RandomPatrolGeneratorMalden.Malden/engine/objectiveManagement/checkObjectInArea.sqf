params ["_objective"];

//init object 
_objectiveObject = _objective select 0;
_objectiveType = _objective select 1;
_objectiveTaskID = _objective select 2;

//Wait for the player to choose position
waitUntil {!isNil "missionGenerated"};

_triggerArea1 = createTrigger ["EmptyDetector", initBlueforLocation];
_triggerArea1 setTriggerArea [150, 150, 0, true];

_triggerArea2 = createTrigger ["EmptyDetector", initCityLocation];
_triggerArea2 setTriggerArea [150, 150, 0, true];

_isInArea = false;

while {sleep 10; !_isInArea} do {
	_isInArea = [_triggerArea1, _objectiveObject] call BIS_fnc_inTrigger ||  [_triggerArea2, _objectiveObject] call BIS_fnc_inTrigger;
};

if (alive _objectiveObject) then 
{
	//Define current objective status
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_missionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",_missionObjectives];

	//Manage uncompleted objective
	diag_log format ["Objective %1 completed !", _objective ];
	_missionUncompletedObjectives = _missionUncompletedObjectives - [_objective];
	missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];

	//Manage complete objective
	_completedObjectives pushBack _objective;
	missionNamespace setVariable ["completedObjectives",_completedObjectives,true];

	//Manage player's feedback
	if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
	{
		[] call doIncrementVehicleSpawnCounter;	
		[_objective] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
		[[50, "RPG_ranking_objective_complete"], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', 0];
	};

	[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
	
};

//Clean trigger
deleteVehicle _triggerArea1;
deleteVehicle _triggerArea2;