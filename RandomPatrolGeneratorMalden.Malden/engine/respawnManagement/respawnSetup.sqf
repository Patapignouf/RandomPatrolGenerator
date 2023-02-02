bluforRespawn = "respawn_west" setMarkerPos initBlueforLocation;
independentRespawn = "respawn_guerrila" setMarkerPos (getPos initCityLocation);


//Disable dynamic teamleader respawn

// while {sleep 20; true} do 
// {
// 	bluforRespawn call BIS_fnc_removeRespawnPosition;
// 	_bluforAliveTeam = allUnits select {alive _x && side _x isEqualTo blufor && _x getVariable "isDead" == false};
// 	_nbBluforAliveTeam = {isPlayer _x && side _x == blufor && _x getVariable "isDead" == false} count allUnits;

// 	if (_nbBluforAliveTeam >0) then 
// 	{
// 		bluforRespawn = [west, getPos (_bluforAliveTeam select 0), "Blufor respawn"] call  BIS_fnc_addRespawnPosition;
// 	};

// 	independentRespawn call BIS_fnc_removeRespawnPosition;
// 	_independentAliveTeam = allUnits select {alive _x AND side _x isEqualTo independent && _x getVariable "isDead" == false};
// 	_nbIndAliveTeam = {isPlayer _x && side _x == independent && _x getVariable "isDead" == false} count allUnits;

// 	if (_nbIndAliveTeam >0) then 
// 	{
// 		independentRespawn = [independent, getPos (_independentAliveTeam select 0), "Independent respawn"] call  BIS_fnc_addRespawnPosition;
// 	};
// };