forceBluforSetup = "ForceBluforSetup" call BIS_fnc_getParamValue;

//Wait player load
if (!hasInterface || isDedicated) exitWith {};
waitUntil {!isNull player && (getClientStateNumber>=10||!isMultiplayer)};

diag_log format ["Setup Player %1 at position 0", name player];

//init tp to be able to spawn on the ground on each map
player setPos [0,0];
player allowdamage false;
//player enableSimulationGlobal false;
player setVariable ["role", "rifleman"];
player setVariable ["isDead", false, true];

//Hide HUD group to debug the UI 
showHUD [
  true, // scriptedHUD
  true, // info
  true, // radar
  true, // compass
  true, // direction
  true, // menu
  false, // group
  true, // cursors
  true, // panels
  false, // kills
  false  // showIcon3D
];

cutText ["Please wait while mission is generating", "BLACK FADED", 100];
sleep 3; //Wait player load correctly the mission

//Define player who configure mission
//Independent leader can choose mission
if (!didJIP) then 
{
	if ({isPlayer _x && side _x == independent} count allPlayers != 0 && forceBluforSetup == 0) then 
	{
		if (side player == independent && player == (leader (group player))) then 
		{
			//Display setup menu
			[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	} else {
		//If there is no independent, blufor leader can choose mission
		if (side player == blufor && player == (leader (group player))) then 
		{
			//Display setup menu
			[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	};
};

//Wait mission setup
waitUntil {missionNamespace getVariable "generationSetup" == true};

//Load every mission settings dependencies
#include "database\arsenalLibrary.sqf"
#include "objectGenerator\vehicleManagement.sqf"

enableThermal = "EnableThermal" call BIS_fnc_getParamValue;
enableHalo = "EnableHALO" call BIS_fnc_getParamValue;
initBluforBase = "InitBluforBase" call BIS_fnc_getParamValue;
chooseStartPos = "ChooseStartPos" call BIS_fnc_getParamValue;

bluFaction = missionNamespace getVariable "bluforFaction";
indFaction = missionNamespace getVariable "independentFaction";
enableArmedAicraft = missionNamespace getVariable "enableArmedAicraft"; //Default armed aircraft are disabled
enableArmoredVehicle = missionNamespace getVariable "enableArmoredVehicle"; //Default armored vehicle are disabled

//Optimize scripts
private _disableThermal = compile preprocessFileLineNumbers "engine\disableThermal.sqf";
private _generateCivDialogs = compile preprocessFileLineNumbers "enemyManagement\generationEngine\generateCivDialogs.sqf";

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
// player addEventHandler ["Respawn",{ 

// 	params ["_newObject","_oldObject"];
// 	deleteVehicle _oldObject; 

// }];

//Init disableThermal
if (enableThermal==0) then 
{
	[] spawn _disableThermal;
};

//Disable miniMap GPS for ACE Player (use microDAGR instead)
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	player enableInfoPanelComponent ["left", "MinimapDisplay", false];
	player enableInfoPanelComponent ["right", "MinimapDisplay", false];
};

//Init player respawn ticket
[player, -1, true] call BIS_fnc_respawnTickets;


diag_log format ["Setup Player %1 at position 1", name player];

//Setup briefing 
player createDiarySubject ["RPG", "RPG"];
_diaryIntel = player createDiaryRecord ["RPG", ["RPG intel", "You can see here all intels collected : <br/>"]];
player setVariable ["diaryIntel", _diaryIntel];
player createDiaryRecord ["RPG", ["RPG respawn", "There are two ways to respawn on Random Patrol Generator missions :<br/>- First, when a mission is completed<br/>- Secondly, when players call a reinforcement on blufor advanced FOB<br/><br/><br/>Note : Respawn setting has to be enabled"]];
player createDiaryRecord ["RPG", ["RPG arsenal", "A limited arsenal is avalaible on your start position, it will allow you to switch between roles."]];

if (side player == independent) then 
{
	//Setup briefing independent
	player createDiaryRecord ["RPG", ["RPG objectives", "Help the people in the town. Complete the tasks assigned to your unit to finish the mission. You can also ask town citizens for intel to help you prepare the operation.
	"]];

	if (player == (leader (group player))) then
	{	
		if (chooseStartPos == 1) then 
		{
			if (!didJIP) then 
			{
				sleep 5;
				titleCut ["", "BLACK IN", 5];
				initCityLocationPosition = objNull;
				openMap true;
				sleep 1;
				hint "Click on map to select a starting area";
				onMapSingleClick "initCityLocationPosition = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)}; 
				publicVariable "initCityLocationPosition";
				titleCut ["Please wait while mission is generating", "BLACK FADED", 5];
			};
		};

		if (!didJIP) then 
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

	//Wait for the player to choose position
	waitUntil {!isNil "missionGenerated"};

	player setVariable ["sideBeforeDeath","independent"];
	_spawnPos = [getPos initCityLocation, 1, 15, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	diag_log format ["Player %1 has spawn on position %2", name player, _spawnPos];
	player setPos (_spawnPos);

	//Manage loadout
	[player, indFaction] call doInitializeLoadout;
	player setVariable ["spawnLoadout", getUnitLoadout player];

	//Manage arsenal	
	// [VA1, player, indFaction] call setupArsenalToItem;
	// [VA1, player, indFaction] call setupRoleSwitchToItem;
	// [VA1, player] call setupSaveAndLoadRole;
	[VA1] call setupPlayerLoadout;

	waituntil {!isNil "isBluforAttacked" && !isNil "isIndAttacked"};
	if (isIndAttacked) then
	{
			[["Vos informateurs vous informent qu'une attaque est en cours sur votre position.",independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
			[["Le QG vous informe qu'une attaque est probablement en cours sur la ville alliée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	};
};

if (side player == blufor) then
{
	//Setup briefing blufor
	player createDiaryRecord ["RPG", ["RPG objectives", "Help the independent town located on your map. Complete the tasks assigned to your unit to finish the mission.
	"]];
	player createDiaryRecord ["RPG", ["RPG FOB", "You can deploy an advanced FOB avalaible in a supply box near main FOB :<br/>- It can be used to skip time<br/>- It can be used to call a reinforcement (respawn players)"]];
	player createDiaryRecord ["RPG", ["RPG vehicles", "You can deploy use the blue flag on the main FOB to spawn vehicules. Each vehicle spawned use one specific credit. You have 10 credits for basic vehicle and 2 for advanced ones.<br/>Complete a mission to earn credits.<br/><br/> Note : Only the team leader can spawn vehicles."]];
	
	diag_log format ["Setup Player %1 at position 2", name player];
	if (player == (leader (group player)) && chooseStartPos == 1) then
	{	
		if (!didJIP) then 
		{
			sleep 5;
			titleCut ["", "BLACK IN", 5];
			openMap true;
			sleep 1;
			hint "Click on map to select a starting area";
			onMapSingleClick "initBlueforLocationPosition = _pos; onMapSingleClick ''; openMap false; true;";
			waitUntil{!visibleMap}; 
			publicVariable "initBlueforLocationPosition";
			titleCut ["Please wait while mission is generating", "BLACK FADED", 5];
		};
	};
	diag_log format ["Setup Player %1 at position 3", name player];

	//Wait for the player to choose position
	waitUntil {!isNil "missionGenerated"};


	player setVariable ["sideBeforeDeath","blufor"];
	_spawnPos = [initBlueforLocation, 1, 15, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	player setPos (_spawnPos);
	[player, bluFaction] call doInitializeLoadout;
	diag_log format ["Player %1 has spawn on position %2", name player, _spawnPos];
	player setVariable ["spawnLoadout", getUnitLoadout player];

	//Manage arsenal	
	[VA2] call setupPlayerLoadout;	
	if (!isNil "bluformobilehq") then
	{
		[bluforMobileHQ] call setupPlayerLoadout;
	};


	//Manage vehicle spawn options 
	if (enableArmoredVehicle) then 
	{	
		//TODO
	};

	//Add vehicle spawn option 
	//Unarmed vehicle
	waitUntil {!isNil "bluforUnarmedVehicle"};
	{
		_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];

				//Check players credit
				bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
				if (bluforVehicleAvalaibleSpawnCounter > 0) then 
				{
					[initBlueforLocation, [[_avalaibleVehicle, false]], 30, 100] call doGenerateVehicleForFOB;	
					missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter-1, true];
					hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforVehicleAvalaibleSpawnCounter-1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
				} else 
				{
					hint "You don't have enough advanced vehicle spawned credit left.";
				};
		},_x,1.5,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader')"];
	} foreach bluforUnarmedVehicle; 

	//Armed vehicle
	waitUntil {!isNil "bluforArmedVehicle"};
	{
		_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			//Check players credit
			bluforAdvancedVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforAdvancedVehicleAvalaibleSpawn";
			if (bluforAdvancedVehicleAvalaibleSpawnCounter > 0) then 
			{
				[initBlueforLocation, [[_avalaibleVehicle, false]], 30, 100] call doGenerateVehicleForFOB;	
				missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter-1, true];
				hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter-1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
			} else 
			{
				hint "You don't have enough advanced vehicle spawned credit left.";
			};
		},_x,1.5,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader')"];
	} foreach bluforArmedVehicle; 

	//Unarmed Chopper
	waitUntil {!isNil "bluforUnarmedVehicleChopper"};
	{
		_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			//Check players credit
			bluforAdvancedVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforAdvancedVehicleAvalaibleSpawn";
			if (bluforAdvancedVehicleAvalaibleSpawnCounter > 0) then 
			{
				[initBlueforLocation, [[_avalaibleVehicle, false]], 30, 100] call doGenerateVehicleForFOB;	
				missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter-1, true];
				hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter-1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
			} else 
			{
				hint "You don't have enough advanced vehicle spawned credit left.";
			};
		},_x,1.5,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader')"];
	} foreach bluforUnarmedVehicleChopper; 

	//Armed Chopper
	waitUntil {!isNil "bluforArmedChopper"};
	if (initBluforBase == 1 && enableArmedAicraft) then 
	{	
		{
			_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];

				//Check players credit
				bluforAdvancedVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforAdvancedVehicleAvalaibleSpawn";
				if (bluforAdvancedVehicleAvalaibleSpawnCounter > 0) then 
				{
					[initBlueforLocation, [[_avalaibleVehicle, false]], 30, 100] call doGenerateVehicleForFOB;	
					missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter-1, true];
					hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter - 1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
				} else 
				{
					hint "You don't have enough advanced vehicle spawned credit left.";
				};
			},_x,1.5,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader')"];
		} foreach bluforArmedChopper; 
	};

	//UAV
	waitUntil {!isNil "bluforDrone"};
	{
		_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			//Check players credit
			bluforAdvancedVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforAdvancedVehicleAvalaibleSpawn";
			if (bluforAdvancedVehicleAvalaibleSpawnCounter > 0) then 
			{
				[initBlueforLocation, [[_avalaibleVehicle, true]], 30, 100] call doGenerateVehicleForFOB;	
				missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter-1, true];
				hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter - 1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
			} else 
			{
				hint "You don't have enough advanced vehicle spawned credit left.";
			};
		},_x,1.5,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader')"];
	} foreach bluforDrone; 
	
	//Manage vehicle spawn options 
	waitUntil {!isNil "bluforFixedWing"};
	if (enableArmedAicraft) then 
	{	
		{
			_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn an %1 (this will open the map to choose a position)", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
				params ["_object","_caller","_ID","_avalaibleAicraft"];

				bluforAdvancedVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforAdvancedVehicleAvalaibleSpawn";
				if (bluforAdvancedVehicleAvalaibleSpawnCounter > 0) then 
				{
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
						
						//Reduce avalaible spawn counter
						missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter-1, true];
						hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter-1, getText (configFile >> "cfgVehicles" >> _avalaibleAicraft >> "displayName")];
					};
				} else 
				{
					hint "You don't have enough advanced vehicle spawned credit left.";
				};
			},_x,1.5,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'pilot')"];
		} foreach bluforFixedWing;
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
		},[],1.5,true,false,"","_target distance _this <5"];
	};

	waituntil {!isNil "isBluforAttacked" && !isNil "isIndAttacked"};
	if (isBluforAttacked) then
	{
			//There's an issue : this message will erase the first one for Blufor
			[["Le QG vous informe qu'une attaque est possiblement en cours sur vos positions dans quelques de minutes, quittez les lieux avant leur arrivée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	};
};


//Generate civilian dialogs
[] spawn _generateCivDialogs;

//Show a special message when there is a teamkill
player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	diag_log format ["%1 has been killed by : %2", name _unit, name _killer];
	if (isPlayer _killer) then 
	{
		[[format ["%1 has been killed by his teammate %2",name _unit, name _killer],side _killer], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	};	
}];

//If a player join in progress he will be teleported to his teamleader (WIP feature)
if (didJIP) then 
{
	diag_log format ["Player %1 has arrived on JIP", name player];
	//Check if player is trying to respawn by deco/reco method
	_deadPlayerList = missionNamespace getVariable "deadPlayer";
	if (count (_deadPlayerList select { _x == (name player) }) == 0) then 
	{

		//Disable specific respawn menu
		//player setPos [0,0,10000];
		player allowdamage false;
		// player enableSimulationGlobal false;
		player setVariable ["isDead", true, true];
		[[], 'GUI\respawnGUI\initPlayerRespawnMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
	} else 
	{
		player setPos [0,0];
		player setDamage 1;
		player setVariable ["isDead",true, true];
	};
} else {
	//Let's get it started !
	player allowdamage true;
	player enableSimulationGlobal true;
	cutText ["", "BLACK IN", 5];
};

