//respawn ticket management
neededTicketToRespawnBlufor = {!alive _x && _x getVariable "sideBeforeDeath" == "blufor"} count allPlayers;
[blufor, neededTicketToRespawnBlufor] call BIS_fnc_respawnTickets;
myRespawn = [missionNamespace,"bluforGroup","Blufor group"] call BIS_fnc_addRespawnPosition;