_thisAvailableGroup = _this select 0;
_thisAvailablePosition = _this select 1;
_thisDifficulty = _this select 2;

currentRandomPatrol = objNull;
currentGroupPatrol = objNull;
{
	if (round (random _thisDifficulty+1)!= _thisDifficulty) then
	{
		currentRandomPatrol = selectRandom _thisAvailableGroup;
		currentGroupPatrol = [getPos _x, east, currentRandomPatrol,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		
		{
			[_x, [], 200 + random 250] call lambs_wp_fnc_taskPatrol;

		} forEach [currentGroupPatrol];
	};
} foreach _thisAvailablePosition;