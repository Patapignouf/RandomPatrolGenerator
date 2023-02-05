_thisGroup = _this select 0;
_isClose   = _this select 1;

diag_log format ["test : %1", _isClose];

currentGroup = nil;
currentRandomPos = objNull;
{
	if (!isNull _x) then
	{
		currentGroup = _x;
		if (round (random 2) != 0) then 
		{
			diag_log "Task_Garrison !";
			if (!isNil "_isClose" && _isClose == true) then
			{
				[currentGroup, currentGroup, 10, [], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
			} else
			{
				[currentGroup, currentGroup, 80, [], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
			};
			
		} 
		else 
		{
			currentRandomPos = [[[getPos (leader currentGroup), 50]], []] call BIS_fnc_randomPos;
			diag_log "Task_Camp !";
			if (!isNil "_isClose" && _isClose == true) then
			{
				[currentGroup, currentRandomPos, 10, [], true, true] call lambs_wp_fnc_taskCamp;
			} else
			{
				[currentGroup, currentRandomPos, 80, [], true, true] call lambs_wp_fnc_taskCamp;
			};
			
		};
	};
} forEach _thisGroup;