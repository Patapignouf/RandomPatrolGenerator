_currentRespawnTimer = missionNamespace getVariable "missionRespawnParam";

//Sync respawn with server timer
waitUntil {(round (serverTime) % _currentRespawnTimer) == 0};

//Apply first respawn wave
[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', allPlayers select {!alive _x}];

//wait every respawn timer
while {true; !(missionNamespace getVariable ["isEndMissionRunning", false])} do
{
	//Wait respawn timer
	waitUntil {(round (serverTime) % _currentRespawnTimer) == 0};

	//respawn all dead players
	[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', allPlayers select {!alive _x}];
};