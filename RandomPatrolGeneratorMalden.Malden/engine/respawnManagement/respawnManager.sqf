// //respawn ticket management BLU
// neededTicketToRespawnBlufor = {!alive _x && _x getVariable "sideBeforeDeath" == "blufor"  && _x getVariable "isDead" == true} count allPlayers;
// [blufor, neededTicketToRespawnBlufor] call BIS_fnc_respawnTickets;
// myBluRespawn = [missionNamespace,"bluforGroup","Blufor group"] call BIS_fnc_addRespawnPosition;

// //respawn ticket management IND
// neededTicketToRespawnIndependent = {!alive _x && _x getVariable "sideBeforeDeath" == "independent" && _x getVariable "isDead" == true} count allPlayers;
// [independent, neededTicketToRespawnIndependent] call BIS_fnc_respawnTickets;
// myIndRespawn = [missionNamespace,"independentGroup","Ind group"] call BIS_fnc_addRespawnPosition;

if (player getVariable "isDead") then 
{
    setPlayerRespawnTime 1;
	[[], 'GUI\respawnGUI\initPlayerRespawnMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
	sleep 5;
	setPlayerRespawnTime 9999999999;
};