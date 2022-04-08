#include "database\arsenalLibrary.sqf"

bluFaction = "BluFaction" call BIS_fnc_getParamValue;
indFaction = "IndFaction" call BIS_fnc_getParamValue;


//////////////////////////
////Event Handler/////////
//////////////////////////

//Arsenal without save/load
[missionNamespace, "arsenalOpened", {
	disableSerialization;
	params ["_display"];
	_display displayAddEventHandler ["keydown", "_this select 3"];
	{(_display displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
}] call BIS_fnc_addScriptedEventHandler;

//Remove Body on respawn 
player addEventHandler ["Respawn",{ 

	params ["_newObject","_oldObject"];
	deleteVehicle _oldObject; 

}];

diag_log format ["Setup Player %1 at position 0", name player];

//init tp to be able to spawn on the ground on each map
player setPos [0,0];
//player setCaptive true;
titleCut ["Please wait while mission is generating", "BLACK FADED", 5];

//Init disableThermal
[] execVM 'engine\disableThermal.sqf';
[player, -1, true] call BIS_fnc_respawnTickets;

//Wait player load
waitUntil {!isNull player};
if (!hasInterface || isDedicated) exitWith {};

//Wait for FOB Generated
waitUntil {!isNil "initBlueforLocation"};

if (hasInterface) then
{
	diag_log format ["Setup Player %1 at position 3", name player];
	waituntil {!isNil "isBluforAttacked" && !isNil "isIndAttacked"};
	if (side player == independent) then 
	{
		player setVariable ["sideBeforeDeath","independent"];
		player setPos ([getPos initCityLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);

		//Manage loadout
		player setVariable ["spawnLoadout",[player,indFaction] call getLoadoutByRole];
		player setUnitLoadout (player getVariable "spawnLoadout");

		//Manage arsenal	
		[VA1, player, indFaction] call setupArsenalToItem;
		[VA1, player, indFaction] call setupRoleSwitchToItem;


		if (isIndAttacked) then
		{
				[["Vos informateurs vous informent qu'une attaque est en cours sur votre position.",independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
				[["Le QG vous informe qu'une attaque est probablement en cours sur la ville alliée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
		if (player == (leader (group player))) then
		{	
			diag_log format ["Warlord is set to player : %1", name player];
			player addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				diag_log format ["Warlord has been killed by : %1", _killer];
				diag_log format ["Mission end !"];
				if (isMultiplayer) then {
					['IND_DEAD'] remoteExec ["BIS_fnc_endMission"];
				} else {
					'IND_DEAD' call BIS_fnc_endMission;
				};
			}];
		};
	};
	if (side player == blufor) then
	{
		player setVariable ["sideBeforeDeath","blufor"];
		player setPos ([initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		player setVariable ["spawnLoadout",[player,bluFaction] call getLoadoutByRole];
		player setUnitLoadout (player getVariable "spawnLoadout");

		//Manage arsenal	
		[VA2, player, bluFaction] call setupArsenalToItem;
		[VA2, player, bluFaction] call setupRoleSwitchToItem;

		if (isBluforAttacked) then
		{
				//There's an issue : this message will erase the first one for Blufor
				[["Le QG vous informe qu'une attaque est possiblement en cours sur vos positions dans quelques de minutes, quittez les lieux avant leur arrivée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
	};
};

[] execVM 'enemyManagement\generateCivDialogs.sqf'; 
//Init player's stuff according to the init role
if (hasInterface) then
{	
	[player] call adjustLoadout;
};

//If a player join in progress he will be teleported to his teamleader (WIP feature)
if (didJIP) then 
{
	player setPos (getPos (leader (group player)));
};

//Let's get it started !
player setCaptive false;
titleCut ["", "BLACK IN", 5];