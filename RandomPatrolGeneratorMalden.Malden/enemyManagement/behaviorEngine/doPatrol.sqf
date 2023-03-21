params ["_thisGroup", "_position", "_distance"];

currentGroup = nil;

if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
{
	diag_log "Task_Patrol [LAMBS]!";
	[_thisGroup, _position, _distance] call lambs_wp_fnc_taskPatrol;

} else 
{
	diag_log "Task_Patrol !";
	[_thisGroup, _position, _distance] call BIS_fnc_taskPatrol;
};
