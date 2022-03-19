_thisGroup = _this select 0;

currentGroup = nil;


if (typeName _thisGroup == "GROUP") then
{
	diag_log "Task_Patrol !";
	[_thisGroup, [], 250] call lambs_wp_fnc_taskPatrol;
} else {
	{
		if (!isNil _x) then
		{
			currentGroup = missionNamespace getVariable _x;
			diag_log "Task_Patrol !";
			[_x, [], 250] call lambs_wp_fnc_taskPatrol;

		};
	} forEach _thisGroup;
};