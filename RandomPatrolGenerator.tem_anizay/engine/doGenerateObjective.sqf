_thisObjective = _this select 0;
_thisObjectivePosition = _this select 1;

//Move Object objective and create marker
if (count _thisObjective > 0) then
{	
	objectiveObject = _thisObjective select 0;
	objectiveType = _thisObjective select 1;

	switch (objectiveType) do
	{
		case "supply":
			{
				(objectiveObject) setPos ([(getPos _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
			};
		case "ammo":
			{
				(objectiveObject) setPos ([(getPos _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
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
				[objectiveObject, true] call ACE_captives_fnc_setHandcuffed;
			};
		case "steal":
			{
				diag_log format ["Steal task setup ! : %1", objectiveObject];
				(vehicle leader objectiveObject) setPos ([(getPos _thisObjectivePosition), 1, 60, 7, 0, 20, 0] call BIS_fnc_findSafePos);
			};
		case "clearArea":
			{
				//Add trigger to detect cleared area
				currentObj setPos (getPos _thisObjectivePosition); //create a trigger area created at object with variable name my_object
				currentObj setTriggerArea [150, 150, 0, false]; // trigger area with a radius of 150m.
				//waitUntil 
			};
		case "collectIntel":
			{
				//Add intel action to the intel case
				(objectiveObject) setPos ([(getPos _thisObjectivePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
				objectiveObject addAction ["Collect intel",{
					params ["_object","_caller","_ID","_thisObjective"];
					deleteVehicle _object;
					_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
					_completedObjectives pushBack _thisObjective;
					missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
				},_thisObjective,1.5,true,true,"","_target distance _this <3"];
			};
		case "informant":
			{
				//Add dialog to the informant
				diag_log format ["VIP task setup ! : %1", objectiveObject];
				(objectiveObject) setPos (getPos _thisObjectivePosition);
				[objectiveObject, objectiveObject, 75, [], true] call lambs_wp_fnc_taskGarrison;
				objectiveObject addAction ["Talk to the informant",{
					params ["_object","_caller","_ID","_thisObjective"];
					_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
					_completedObjectives pushBack _thisObjective;
					missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
					removeAllActions objectiveObject;
				},_thisObjective,1.5,true,true,"","_target distance _this <3"];
			};
		default { hint "default" };
	};
	currentMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	currentMissionObjectives pushBack [objectiveObject,objectiveType];
    missionNamespace setVariable ["MissionObjectives",currentMissionObjectives,true];
	diag_log format ["MissionObjectives setup ! : %1", currentMissionObjectives];
	[[_thisObjective,getPos _thisObjectivePosition,independent], 'objectGenerator\doGeneratePOIMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
};