if (isMultiplayer) then {
	//player setVariable ["respawnLoadout", (getUnitLoadout player)];
	if (("Respawn" call BIS_fnc_getParamValue) == 0) then {
		[player, 0, false] call BIS_fnc_respawnTickets;
		diag_log ([player, 0, true] call BIS_fnc_respawnTickets);
		[missionNamespace, 0] call BIS_fnc_respawnTickets;
		//setPlayerRespawnTime 0;
	};
};


if ((["Respawn",1] call BIS_fnc_getParamValue) == 0 ) then
{
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		[true, true, false] call ace_spectator_fnc_setSpectator;
		[allPlayers, []] call ace_spectator_fnc_updateUnits;
		[[0,1,2], []] call ace_spectator_fnc_updateCameraModes;
	} else 
	{
		["Initialize", [player, [], true ]] call BIS_fnc_EGSpectator;
		[1,["You will respawn on the next objective completion", "PLAIN", 5]] remoteExec ["cutText", _caller];	
	};
} else 
{
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		[true, true, false] call ace_spectator_fnc_setSpectator;
		[allPlayers, []] call ace_spectator_fnc_updateUnits;
		[[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
	} else 
	{
		["Initialize", [player, [] , false, false ]] call BIS_fnc_EGSpectator;
	};
};

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	[player, true] call TFAR_fnc_forceSpectator;
};
	
//Add player to a dead player base | This will block disconnection/connection method to respawn 
_deadPlayerList = missionNamespace getVariable "deadPlayer";
_deadPlayerList pushBack (name player);
missionNamespace setVariable ["deadPlayer", _deadPlayerList, true];