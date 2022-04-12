_thisAvailableGroup = _this select 0;
_thisAvailableCivGroup = _this select 1;
_thisAvailablePosition = _this select 2;
_thisDifficulty = _this select 3;

currentRandomGroup = objNull;
currentGroup = objNull;

//Generate camp and AO
for [{_i = 0}, {_i < _thisDifficulty+3}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom _thisAvailableGroup;
	currentGroup = [currentRandomGroup, getPos _thisAvailablePosition, east, "Defense"] call doGenerateEnemyGroup;
	
	//Spawn group
	diag_log "Task_Garrison !";
	[currentGroup, currentGroup, 75, [], true, (round random 3 == 0), -2, true] call lambs_wp_fnc_taskGarrison;

		
	//Add chance to spawn civilian
	if (round (random 4) != 0 && count _thisAvailableCivGroup > 0) then 
	{
		currentGroup = [_thisAvailableCivGroup, getPos _thisAvailablePosition, civilian, "Civilian"] call doGenerateEnemyGroup;
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