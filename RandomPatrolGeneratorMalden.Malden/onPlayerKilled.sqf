
//Log player's death
diag_log format ["Player %1 is dead", name player];

_respawnTimer = missionNamespace getVariable "missionRespawnParam";
setPlayerRespawnTime (_respawnTimer);
_initialCountDown = [_respawnTimer, false] call BIS_fnc_countDown;
addMissionEventHandler ["EachFrame",
	{
		if (!alive player) then 
		{
			hintSilent format["%1", [(([0, false] call BIS_fnc_countdown)/60)+.01,"HH:MM"] call BIS_fnc_timetostring]
		};
	}
];

//Update dead counter 
player setVariable ["deathNumber", (player getVariable ["deathNumber", 0])+1, true];

//Add experience penalty on death
[[-10, 1], 'engine\rankManagement\rankPenalty.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Add player to a dead player base | This will block disconnection/connection method to respawn 
_deadPlayerList = missionNamespace getVariable "deadPlayer";
_deadPlayerList pushBack (name player);
missionNamespace setVariable ["deadPlayer", _deadPlayerList, true];

//Start spectator mod only ally players
["Terminate"] call BIS_fnc_EGSpectator;
["Initialize", [player, [] , false, false ]] call BIS_fnc_EGSpectator;

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	[player, true] call TFAR_fnc_forceSpectator;
	player setVariable ["tf_voiceVolume",1,true];
};