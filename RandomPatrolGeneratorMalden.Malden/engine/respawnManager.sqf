//respawn ticket management BLU
neededTicketToRespawnBlufor = {!alive _x && _x getVariable "sideBeforeDeath" == "blufor"} count allPlayers;
[blufor, neededTicketToRespawnBlufor] call BIS_fnc_respawnTickets;
myBluRespawn = [missionNamespace,"bluforGroup","Blufor group"] call BIS_fnc_addRespawnPosition;

//respawn ticket management IND
neededTicketToRespawnIndependent = {!alive _x && _x getVariable "sideBeforeDeath" == "independent"} count allPlayers;
[independent, neededTicketToRespawnIndependent] call BIS_fnc_respawnTickets;
myIndRespawn = [missionNamespace,"independentGroup","Ind group"] call BIS_fnc_addRespawnPosition;
