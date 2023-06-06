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



//Old OnPlayerRespawn script 
player setVariable ["isDead", true, true];

if ((["Respawn",1] call BIS_fnc_getParamValue) == 0 ) then
{
  if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
  {
	["Terminate"] call BIS_fnc_EGSpectator;
	[false] call ace_spectator_fnc_setSpectator;
    [true, true, false] call ace_spectator_fnc_setSpectator;
    [allPlayers, allPlayers select {alive _x == false || _x getVariable "isDead" == true}] call ace_spectator_fnc_updateUnits;
    [[0,1,2], []] call ace_spectator_fnc_updateCameraModes;
  } else 
  {
	["Terminate"] call BIS_fnc_EGSpectator;
    ["Initialize", [player, [], true ]] call BIS_fnc_EGSpectator;
    [1,["You will respawn on the next objective completion", "PLAIN", 5]] remoteExec ["cutText", player];	
  };
} else 
{
  if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
  {
	["Terminate"] call BIS_fnc_EGSpectator;
	[false] call ace_spectator_fnc_setSpectator;
    [true, true, false] call ace_spectator_fnc_setSpectator;
    [allPlayers, allPlayers select {alive _x == false || _x getVariable "isDead" == true}] call ace_spectator_fnc_updateUnits;
    [[1,2], [0]] call ace_spectator_fnc_updateCameraModes;
  } else 
  {
	["Terminate"] call BIS_fnc_EGSpectator;
    ["Initialize", [player, [] , false, false ]] call BIS_fnc_EGSpectator;
  };
};
