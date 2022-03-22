_thisGroup = _this select 0;
_thisTarget = _this select 1;

currentGroup = nil;

{
	if (!isNil _x) then
	{
		currentGroup = missionNamespace getVariable _x;
		diag_log "Task_CQB !";
		[_x, getPos _thisTarget,100] spawn lambs_wp_fnc_taskCQB;;

	};
} forEach _thisGroup;