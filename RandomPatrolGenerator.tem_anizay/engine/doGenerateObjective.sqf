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
			default { hint "default" };
		};
	currentMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
	currentMissionObjectives pushBack [objectiveObject,objectiveType];
    missionNamespace setVariable ["MissionObjectives",currentMissionObjectives,true];
	[[_thisObjective,getPos _thisObjectivePosition,independent], 'objectGenerator\doGeneratePOIMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
};