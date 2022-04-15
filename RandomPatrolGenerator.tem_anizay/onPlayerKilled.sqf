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
	["Initialize", [player, [], true ]] call BIS_fnc_EGSpectator;
	[1,["You will respawn on the next objective completion", "PLAIN", 5]] remoteExec ["cutText", _caller];	
} else 
{
	["Initialize", [player, [] , false, false ]] call BIS_fnc_EGSpectator;
};
	
