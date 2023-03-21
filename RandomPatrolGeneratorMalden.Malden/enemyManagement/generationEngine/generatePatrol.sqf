_thisAvailableGroup = _this select 0;
_thisAvailablePosition = _this select 1;
_thisDifficulty = _this select 2;

currentGroupPatrol = objNull;
{
	if (round (random _thisDifficulty+1)!= _thisDifficulty) then
	{
		//Patrol generation
		_currentRandomPatrol = selectRandom _thisAvailableGroup;
		currentGroupPatrol = [_currentRandomPatrol, getPos _x, east, "Patrol"] call doGenerateEnemyGroup;
		[currentGroupPatrol, getPos (leader currentGroupPatrol), 200 + random 250] execVM 'enemyManagement\behaviorEngine\doPatrol.sqf';
	};
} foreach _thisAvailablePosition;