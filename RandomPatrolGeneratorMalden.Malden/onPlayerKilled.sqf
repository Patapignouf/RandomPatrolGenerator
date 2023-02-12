if (isMultiplayer) then {
	if (("Respawn" call BIS_fnc_getParamValue) == 0) then {
		[player, 0, false] call BIS_fnc_respawnTickets;
		diag_log ([player, 0, true] call BIS_fnc_respawnTickets);
		[missionNamespace, 0] call BIS_fnc_respawnTickets;
		//setPlayerRespawnTime 0;
	};
};

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	[player, true] call TFAR_fnc_forceSpectator;
};
	
//Add player to a dead player base | This will block disconnection/connection method to respawn 
_deadPlayerList = missionNamespace getVariable "deadPlayer";
_deadPlayerList pushBack (name player);
missionNamespace setVariable ["deadPlayer", _deadPlayerList, true];

//In ironMan mode player stuff will be wipe
if (ironMan) then 
{
	//wipe loadout
	if (player getVariable "sideBeforeDeath" == "independent") then 
	{
		//Independent
		profileNamespace setVariable [format ["RPG_%1_%2_%3", name player, indFaction, player getVariable "role"], []];
	} else 
	{
		//Blufor
		profileNamespace setVariable [format ["RPG_%1_%2_%3", name player, bluFaction, player getVariable "role"], []];
	};
	saveProfileNamespace;
};