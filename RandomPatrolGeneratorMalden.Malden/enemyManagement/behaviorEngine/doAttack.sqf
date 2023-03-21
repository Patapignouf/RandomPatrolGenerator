_thisGroup = _this select 0;
_thisTarget = _this select 1;

currentGroup = nil;

if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
{
	if (!isNil "_thisGroup") then
	{
		diag_log "Task ATTACK [LAMBS]!";
		[_thisGroup, _thisTarget] spawn lambs_wp_fnc_taskAssault;;

	};
} else 
{
	diag_log "Task ATTACK !";
	[_thisGroup, _thisTarget] call BIS_fnc_taskAttack;
};