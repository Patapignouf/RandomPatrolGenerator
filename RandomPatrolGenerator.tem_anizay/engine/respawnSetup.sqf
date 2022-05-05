bluforLeader = Nil;
bluforRespawn = [west, initBlueforLocation, "Blufor respawn"] call  BIS_fnc_addRespawnPosition;

while {sleep 20; true} do 
{
	bluforRespawn call BIS_fnc_removeRespawnPosition;
	_bluforAliveTeam = allUnits select {alive _x AND side _x isEqualTo blufor};
	_nbBluforAliveTeam = {isPlayer _x && side _x == blufor} count allUnits;

	if (_nbBluforAliveTeam >0) then 
	{
		bluforRespawn = [west, getPos (leader (group (_bluforAliveTeam select 0))), "Blufor respawn"] call  BIS_fnc_addRespawnPosition;
	};
};