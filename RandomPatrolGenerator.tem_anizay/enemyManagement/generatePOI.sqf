_thisAvailableGroup = _this select 0;
_thisAvailableRareGroup = _this select 1;
_thisAvailablePosition = _this select 2;
_thisDifficulty = _this select 3;
_thisObjective = _this select 4;

currentRandomGroup = objNull;
currentGroup = objNull;

//Generate camp and AO
for [{_i = 0}, {_i < _thisDifficulty+2}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom _thisAvailableGroup;
	currentGroup = [getPos _thisAvailablePosition, east, currentRandomGroup,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	
	//Spawn group
	if (round (random 2) != 0) then 
	{
		diag_log "Task_Garrison !";
		[currentGroup, currentGroup, 75, [], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
		
	} 
	else 
	{
		diag_log "Task_Camp !";
		[currentGroup, getPos (leader currentGroup), 75, [], true, true] call lambs_wp_fnc_taskCamp;
	};
	
	
	//Add chance to spawn civilian
	if (round (random 3) != 0) then 
	{
		currentGroup = [getPos _thisAvailablePosition, civilian, _thisAvailableRareGroup,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		if (round (random 2) != 0) then 
		{
			diag_log "Task_Garrison civilian !";
			[currentGroup, currentGroup, 75, [], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
			
		} 
		else 
		{
			diag_log "Task_Camp civilian !";
			[currentGroup, getPos (leader currentGroup), 75, [], true, true] call lambs_wp_fnc_taskCamp;
		};
	};
	
};

//Move Object objective and create marker
if (count _thisObjective > 0) then
{	
	objectiveObject = _thisObjective select 0;
	objectiveType = _thisObjective select 1;

	switch (objectiveType) do
		{
			case "supply":
				{
					(objectiveObject) setPos ([(getPos _thisAvailablePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
				};
			case "ammo":
				{
					(objectiveObject) setPos ([(getPos _thisAvailablePosition), 1, 25, 5, 0, 20, 0] call BIS_fnc_findSafePos);
				};
			case "hvt":
				{
					(objectiveObject) setPos (getPos _thisAvailablePosition);
					[objectiveObject, objectiveObject, 75, [], true] call lambs_wp_fnc_taskGarrison;
				};
			case "vip":
				{
					diag_log format ["VIP task setup ! : %1", objectiveObject];
					(objectiveObject) setPos (getPos _thisAvailablePosition);
					[objectiveObject, objectiveObject, 75, [], true] call lambs_wp_fnc_taskGarrison;
					[objectiveObject, true] call ACE_captives_fnc_setHandcuffed;
				};
			default { hint "default" };
		};
	
	
	[[_thisObjective,_thisAvailablePosition,independent], 'objectGenerator\doGeneratePOIMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
};