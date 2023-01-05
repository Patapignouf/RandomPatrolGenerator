bluforRespawn = [west, initBlueforLocation, "Blufor respawn"] call  BIS_fnc_addRespawnPosition;
independentRespawn = [independent, getPos initCityLocation, "Independent respawn"] call  BIS_fnc_addRespawnPosition;

while {sleep 20; true} do 
{
	bluforRespawn call BIS_fnc_removeRespawnPosition;
	_bluforAliveTeam = allUnits select {alive _x AND side _x isEqualTo blufor};
	_nbBluforAliveTeam = {isPlayer _x && side _x == blufor} count allUnits;

	if (_nbBluforAliveTeam >0) then 
	{
		bluforRespawn = [west, getPos (_bluforAliveTeam select 0), "Blufor respawn"] call  BIS_fnc_addRespawnPosition;
	};

	independentRespawn call BIS_fnc_removeRespawnPosition;
	_independentAliveTeam = allUnits select {alive _x AND side _x isEqualTo independent};
	_nbIndAliveTeam = {isPlayer _x && side _x == independent} count allUnits;

	if (_nbIndAliveTeam >0) then 
	{
		independentRespawn = [independent, getPos (_independentAliveTeam select 0), "Independent respawn"] call  BIS_fnc_addRespawnPosition;
	};
};