
//Log player's death
diag_log format ["Player %1 is dead", name player];
	
if (isMultiplayer) then {
	if (("Respawn" call BIS_fnc_getParamValue) == 0) then {
		[player, 0, false] call BIS_fnc_respawnTickets;
		diag_log ([player, 0, true] call BIS_fnc_respawnTickets);
		[missionNamespace, 0] call BIS_fnc_respawnTickets;
		//setPlayerRespawnTime 0;
	};
};

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