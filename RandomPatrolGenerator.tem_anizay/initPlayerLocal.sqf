#include "database\arsenalLibrary.sqf"
#include "objectGenerator\vehicleManagement.sqf"

bluFaction = "BluFaction" call BIS_fnc_getParamValue;
indFaction = "IndFaction" call BIS_fnc_getParamValue;
enableThermal = "EnableThermal" call BIS_fnc_getParamValue;
enablePlane = "EnablePlane" call BIS_fnc_getParamValue;
enableHalo = "EnableHALO" call BIS_fnc_getParamValue;
enableArmored = "EnableArmored" call BIS_fnc_getParamValue;
initBluforBase = "InitBluforBase" call BIS_fnc_getParamValue;

//Optimize scripts
private _disableThermal = compile preprocessFileLineNumbers "engine\disableThermal.sqf";
private _generateCivDialogs = compile preprocessFileLineNumbers "enemyManagement\generateCivDialogs.sqf";

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
player allowdamage false;
titleCut ["Please wait while mission is generating", "BLACK FADED", 5];

//Init disableThermal
if (enableThermal==0) then 
{
	[] spawn _disableThermal;
};

//Init player respawn ticket
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
		player setUnitLoadout ([player,indFaction] call getLoadoutByRole);
		[player] call adjustLoadout;
		player setVariable ["spawnLoadout", getUnitLoadout player];

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
		player setUnitLoadout ([player, bluFaction] call getLoadoutByRole);
		[player] call adjustLoadout;
		player setVariable ["spawnLoadout", getUnitLoadout player];

		//Manage arsenal	
		[VA2, player, bluFaction] call setupArsenalToItem;
		[VA2, player, bluFaction] call setupRoleSwitchToItem;

		//Manage vehicle spawn options 
		if (enableArmored == 1) then 
		{	
		};

		//Add vehicle spawn option 
		//Unarmed vehicle
		{
			_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn an %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
				params ["_object","_caller","_ID","_avalaibleVehicle"];
				//Click on map to spawn
				[initBlueforLocation, [_avalaibleVehicle], 30, 100] call doGenerateVehicleForFOB;	
				[_object,_ID] remoteExec [ "removeAction", 0, true ];
			},_x,1.5,true,true,"","_target distance _this <5"];
		} foreach (missionNamespace getVariable ["bluforUnarmedVehicle",[]]); 

		//Armed vehicle
		{
			_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn an %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
				params ["_object","_caller","_ID","_avalaibleVehicle"];
				//Click on map to spawn
				[initBlueforLocation, [_avalaibleVehicle], 30, 100] call doGenerateVehicleForFOB;	
				[_object,_ID] remoteExec [ "removeAction", 0, true ];
			},_x,1.5,true,true,"","_target distance _this <5"];
		} foreach (missionNamespace getVariable ["bluforArmedVehicle",[]]); 

		//Unarmed Chopper
		if (initBluforBase == 1) then 
		{
			{
				_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn an %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
					params ["_object","_caller","_ID","_avalaibleVehicle"];
					//Click on map to spawn
					[initBlueforLocation, [_avalaibleVehicle], 30, 100] call doGenerateVehicleForFOB;	
					[_object,_ID] remoteExec [ "removeAction", 0, true ];
				},_x,1.5,true,true,"","_target distance _this <5"];
			} foreach (missionNamespace getVariable ["bluforUnarmedVehicleChopper",[]]); 
		};

		_avalaibleAicraft = "CUP_B_A10_DYN_USA"; //temp aircraft list 

		//Manage vehicle spawn options 
		if (enablePlane == 1) then 
		{	
			_IDVehicleSpawn = TPFlag1 addAction ["Spawn an aircraft",{
				params ["_object","_caller","_ID","_avalaibleAicraft"];
				//Click on map to spawn
				selectedLoc = [0,0,0];
				openMap true;
				sleep 1;
				hint "Click on map to sapwn an aircraft and teleport\n The aircraft will spawn oriented on the north";
				onMapSingleClick "selectedLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					_caller setPos selectedLoc;
					createVehicle [_avalaibleAicraft, selectedLoc, [], 0, "NONE"];
					[_object,_ID] remoteExec [ "removeAction", 0, true ];
				}
				else 
				{
					//hint format ["fail with selectedLoc : %1", selectedLoc];
				};
			},_avalaibleAicraft,1.5,true,true,"","_target distance _this <5"];
		};

		//Add HaloJump function
		if (enableHalo == 1) then 
		{	
			_IDHalo = TPFlag1 addAction ["Go in HALO JUMP",{
				params ["_object","_caller","_ID"];
				//Click on map to Halo spawn
				selectedHaloLoc = [0,0,0];
				openMap true;
				sleep 1;
				hint "Click on map to sapwn Halo jump\n Your backpack will be saved";
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					_caller setPos selectedHaloLoc;
					[_caller,1500] call BIS_fnc_halo;
				};
			},o,1.5,true,false,"","_target distance _this <5"];
		};


		if (isBluforAttacked) then
		{
				//There's an issue : this message will erase the first one for Blufor
				[["Le QG vous informe qu'une attaque est possiblement en cours sur vos positions dans quelques de minutes, quittez les lieux avant leur arrivée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
	};
};

[] spawn _generateCivDialogs;
//Init player's stuff according to the init role
if (hasInterface) then
{	
	[player] call adjustLoadout;
};

//Let's get it started !
player allowdamage true;
titleCut ["", "BLACK IN", 5];


//If a player join in progress he will be teleported to his teamleader (WIP feature)
if (didJIP) then 
{
	player setPos (getPos (leader (group player)));
};