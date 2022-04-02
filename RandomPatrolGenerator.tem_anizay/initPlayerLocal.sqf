#include "database\arsenalLibrary.sqf"

bluFaction = "BluFaction" call BIS_fnc_getParamValue;
indFaction = "IndFaction" call BIS_fnc_getParamValue;

//Arsenal without save/load
[missionNamespace, "arsenalOpened", {
	disableSerialization;
	params ["_display"];
	_display displayAddEventHandler ["keydown", "_this select 3"];
	{(_display displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
}] call BIS_fnc_addScriptedEventHandler;

diag_log format ["Player %1 at position 0", name player];

//init tp to be able to spawn on the ground on each map
player setPos [0,0];
titleCut ["Please wait while mission is generating", "BLACK FADED", 5];

//Init disableThermal
[] execVM 'engine\disableThermal.sqf';
[player, -1, true] call BIS_fnc_respawnTickets;


//Wait player load
waitUntil {!isNull player};
if (!hasInterface || isDedicated) exitWith {};

//FOB Generated
waitUntil {!isNil "initBlueforLocation"};
titleCut ["", "BLACK IN", 5];
 
//Init basic variable
//missionGenerated = false;
//waitUntil {missionGenerated == true};

if (hasInterface) then
{
	diag_log format ["Player %1 at position 3", name player];
	waituntil {!isNil "isBluforAttacked" && !isNil "isIndAttacked" && !isNil "ind_group"};
	if (side player == independent) then 
	{
		player setVariable ["sideBeforeDeath","independent"];
		player setPos ([getPos initCityLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);
	    player setUnitLoadout (getUnitLoadout (configFile >> "CfgVehicles" >> (selectRandom ind_group)));
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
		["AmmoboxExit", VA2] call BIS_fnc_arsenal;	
		[VA2,([player,bluFaction] call getVirtualWeaponList )] call BIS_fnc_addVirtualWeaponCargo;
		[VA2,backpacksList] call BIS_fnc_addVirtualBackpackCargo;
		//[VA2,((itemCargo VA2) + _availableHeadgear + _availableUniforms + _availableVests)] call BIS_fnc_addVirtualItemCargo;
		//[VA2,((magazineCargo VA2) + _availablemagazinecargoindependent )] call BIS_fnc_addVirtualMagazineCargo;
		[VA2,([player,bluFaction] call getVirtualAttachement ) + ([player,bluFaction] call getVirtualItemList ) ] call BIS_fnc_addVirtualItemCargo;
		//["AmmoboxInit",[VA2,false,{_this getVariable "role" == "leader"}]] call BIS_fnc_arsenal;
		["AmmoboxInit",[VA2,false,{true}]] call BIS_fnc_arsenal;

		if (isBluforAttacked) then
		{
				//There's an issue : this message will erase the first one for Blufor
				[["Le QG vous informe qu'une attaque est possiblement en cours sur vos positions dans quelques de minutes, quittez les lieux avant leur arrivée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
	};
};



if (didJIP) exitWith {};

if (hasInterface) then
{	
	if (player getUnitTrait "Medic" == false) then 
	{
		for "_i" from 0 to 7 do { player addItem "ACE_elasticBandage" };	
		for "_i" from 0 to 1 do { player addItem "ACE_tourniquet" };
		for "_i" from 0 to 1 do { player addItem "ACE_splint" };
	}
	else 
	{
		player addItem "ACE_surgicalKit";
		for "_i" from 0 to 7 do { player addItem "ACE_epinephrine" };
		for "_i" from 0 to 7 do { player addItem "ACE_splint" };
		for "_i" from 0 to 29 do { player addItem "ACE_elasticBandage" };
		for "_i" from 0 to 29 do { player addItem "ACE_quikclot" };
		for "_i" from 0 to 9 do { player addItem "ACE_morphine" };
		for "_i" from 0 to 5 do { player addItem "ACE_bloodIV_500" };
		for "_i" from 0 to 2 do { player addItem "ACE_bloodIV" };
		for "_i" from 0 to 5 do { player addItem "ACE_tourniquet" };	
	};
	for "_i" from 0 to 1 do { player addItem "ACE_CableTie" };
	player addItem "ACE_MapTools";	
	player addItem "ACE_morphine";	
	player addItem "ACE_WaterBottle";
	player addItem "ACE_EarPlugs";
	player addItem "ACE_microDAGR";
	player unassignItem "itemRadio";
	player removeItem "itemRadio";
	//player addItem "TFAR_anprc148jem";
	//player assignItem "TFAR_anprc148jem";
	player addItem "TFAR_anprc152";
	player assignItem "TFAR_anprc152";
	player setSpeaker "noVoice";
};