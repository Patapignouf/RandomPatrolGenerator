bluforLeader = Nil;
bluforRespawn = [west, initBlueforLocation, "Blufor respawn"] call  BIS_fnc_addRespawnPosition;

while {sleep 20; true} do 
{
	bluforRespawn call BIS_fnc_removeRespawnPosition;
	{
		if (side _x == blufor) then
		{
			bluforLeader = leader (group _x);
		};

	} foreach allPlayers;
	if (!isNil "bluforLeader") then
	{
		bluforRespawn = [west, getPos bluforLeader, "Blufor respawn"] call  BIS_fnc_addRespawnPosition;
	};
	
};