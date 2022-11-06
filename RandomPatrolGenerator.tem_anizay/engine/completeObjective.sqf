params ["_objective"];

_objectiveID = current_obj select 2;

if ([_objectiveID] call BIS_fnc_taskExists) then 
{
	[_objectiveID,"SUCCEEDED"] call BIS_fnc_taskSetState;
} else 
{
	_mainPlayerSide = blufor;
	if ({isPlayer _x && side _x == independent} count allPlayers != 0) then 
	{
		_mainPlayerSide = independent;
	};
	[objNull, _objective, _mainPlayerSide] execVM 'engine\revealObjective.sqf';
	sleep 5;
	[_objectiveID,"SUCCEEDED"] call BIS_fnc_taskSetState;
};