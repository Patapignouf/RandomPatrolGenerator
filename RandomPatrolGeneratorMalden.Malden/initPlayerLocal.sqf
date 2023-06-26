#include "engine\modManager.sqf"

forceBluforSetup = "ForceBluforSetup" call BIS_fnc_getParamValue;

//Wait player load
if (!hasInterface || isDedicated) exitWith {};
waitUntil {!isNull player && (getClientStateNumber>=10||!isMultiplayer)};

diag_log format ["Setup Player %1 at position 0", name player];

//init tp to be able to spawn on the ground on each map
player setPos [0,0,1];
player allowdamage false;
enableSentences false;

//player enableSimulationGlobal false;
player setVariable ["role", player getVariable ["initRole","rifleman"]];

[selectRandom ["LeadTrack01_F","LeadTrack01a_F","LeadTrack01b_F","LeadTrack03_F","LeadTrack01_F_Heli","LeadTrack04_F_EXP","LeadTrack01_F_Mark"], 10, 0.2] call BIS_fnc_playMusic;
cutText [format ["<t size='1.2'>Please wait while mission is generating</t><br/><br/><img size=20 align='bottom' valign='bottom' image='%1'/>",format ["a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_%1_co.paa",selectRandom [16,59,118,106,98,62,76,93,75,64,122,87,70,14,104,108,111,123,20,92,63,41,65,68,22,91,72,30,31,80,32,47,27,18,46,121]]], "BLACK FADED", 100, true, true];
sleep 3; //Wait player load correctly the mission

//Define player who configure mission
//Independent leader can choose mission
waitUntil {!isNil "adminExist"};
if (!didJIP) then 
{
	//Check if there is an admin to setup the mission
	if (isMultiplayer && adminExist) then 
	{
		if (call BIS_fnc_admin != 0) then 
		{
			cutText ["", "BLACK FADED", 100];
			[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	} else 
	{
		//Solo setup or game without  admin setup
		if ( ({isPlayer _x && side _x == independent} count allPlayers != 0 && forceBluforSetup == 0)) then 
		{
			if (side player == independent && player == (leader (group player))) then 
			{
				//Display setup menu
				cutText ["", "BLACK FADED", 100];
				[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
			};
		} else {
			//If there is no independent, blufor leader can choose mission
			if (side player == blufor && player == (leader (group player))) then 
			{
				//Display setup menu
				cutText ["", "BLACK FADED", 100];
				[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
			};
		};
	};
};

//Start custom hint engine
[[], 'engine\hintManagement\customHintManager.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Wait mission setup
waitUntil {missionNamespace getVariable "generationSetup" == true};

//Show loading message
[] spawn {
	_randomPos = [nil, ["water"]] call BIS_fnc_randomPos;
	_randomPos set [2,_randomPos#2+100];
	_camera = "camera" camCreate (_randomPos);
	_camera cameraEffect ["internal", "back"];

	while {isNil "missionGenerated"} do 
	{
		_camera camPrepareTarget ([[[_randomPos, 200]], []] call BIS_fnc_randomPos);
		_randomPos = [nil, ["water"]] call BIS_fnc_randomPos;
		_randomPos set [2,_randomPos#2+100];
		_camera camPreparePos (_randomPos);
		_camera camPreload 3;
		_camera camCommitPrepared 400;
		cutText [format ["<t size='1.2'>Please wait while mission is generating</t><br/><br/><img size=20 align='bottom' valign='bottom' image='%1'/>",format ["a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_%1_co.paa",selectRandom [16,59,118,106,98,62,76,93,75,64,122,87,70,14,104,108,111,123,20,92,63,41,65,68,22,91,72,30,31,80,32,47,27,18,46,121]]], "PLAIN", 0.5, true, true];
		sleep 4;
	};
	_camera cameraEffect ["terminate", "back"];
	camDestroy _camera;
};


//Load every mission settings dependencies
#include "database\arsenalLibrary.sqf"
#include "objectGenerator\vehicleManagement.sqf"

enableThermal = "EnableThermal" call BIS_fnc_getParamValue;
enableHalo = "EnableHALO" call BIS_fnc_getParamValue;

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

//Arsenal without save/load when ironMan mode
if (ironMan) then 
{
	[missionNamespace, "arsenalOpened", {
		disableSerialization;
		params ["_display"];
		_display displayAddEventHandler ["keydown", "_this select 3"];
		{(_display displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
	}] call BIS_fnc_addScriptedEventHandler;
};


//Validate current player's stuff
[missionNamespace, "arsenalClosed", {
	disableSerialization;
	params ["_display"];

	//Check loadout
	[player] call validateLoadout;
	["AmmoboxExit", player] call BIS_fnc_arsenal;
}] call BIS_fnc_addScriptedEventHandler;


//Init disableThermal
if (enableThermal==0) then 
{
	[] spawn _disableThermal;
};

//Validate mods 
[] call doCheckRunningModsOnClient;

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

//Disable miniMap GPS for ACE Player (use microDAGR instead)
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	player enableInfoPanelComponent ["left", "MinimapDisplay", false];
	player enableInfoPanelComponent ["right", "MinimapDisplay", false];
};

//Prevent players from instant death
if !(isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	player addEventHandler ["HandleDamage",{
		private["_damage"];
		if ((lifeState player == "INCAPACITATED")||(lifeState player == "SHOOTING")) then {
			_damage = 0;
		};    
		_damage    
	}];
};

//Init player rank
[[player], 'engine\rankManagement\rankManager.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Init player respawn ticket
[player, -1, true] call BIS_fnc_respawnTickets;

//Corpse manager
player addEventHandler ["Respawn",{ 
	params ["_unit", "_corpse"];
	_corpse setVariable ["isPlayerObject",true, true];
	[_corpse] spawn {
		params ["_corpse"];
		sleep 500;
		deleteVehicle _corpse;
	};
}];

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

		if (!didJIP) then 
		{
			diag_log format ["Warlord is set to player : %1", name player];
			player addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				diag_log format ["Warlord has been killed by : %1", _killer];
				diag_log format ["Mission end !"];
				[['IND_DEAD'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
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

	//Wait for the player to choose position
	waitUntil {!isNil "missionGenerated"};


	player setVariable ["sideBeforeDeath","blufor"];
	
	//manage carrier spawn
	//Move player
	_spawnPos = [];
	if (isNil "USS_FREEDOM_CARRIER") then 
	{
		_spawnPos = [initBlueforLocation, 1, 15, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		player setPos (_spawnPos);
	} else 
	{
		_spawnPos = initBlueforLocation;

		//Fix catapult on carrier
		[] spawn {
				waitUntil { !(isNull (missionNamespace getVariable ["USS_FREEDOM_CARRIER",objNull])) };

				["Carrier %1 Found. Client Initilising.",USS_FREEDOM_CARRIER] call BIS_fnc_logFormatServer;
				if (count (USS_FREEDOM_CARRIER getVariable ["bis_carrierParts", []]) == 0) then {
					["Carrier %1 is empty. Client Fixing.",str "bis_carrierParts"] call BIS_fnc_logFormatServer;
					private _carrierPartsArray = (configFile >> "CfgVehicles" >> typeOf USS_FREEDOM_CARRIER >> "multiStructureParts") call BIS_fnc_getCfgDataArray;
					private _partClasses = _carrierPartsArray apply {_x select 0};
					private _nearbyCarrierParts = nearestObjects [USS_FREEDOM_CARRIER,_partClasses,500];
					{
						private _carrierPart = _x;
						private _index = _forEachIndex;
						{
							if ((_carrierPart select 0) isEqualTo typeOf _x) exitWith { _carrierPart set [0,_x]; };
						} forEach _nearbyCarrierParts;
						_carrierPartsArray set [_index,_carrierPart];
					} forEach _carrierPartsArray;
					USS_FREEDOM_CARRIER setVariable ["bis_carrierParts",_nearbyCarrierParts];
					["Carrier %1 was empty. Now contains %2.",str "bis_carrierParts",USS_FREEDOM_CARRIER getVariable ["bis_carrierParts", []]] call BIS_fnc_logFormatServer;
				};
				[USS_FREEDOM_CARRIER] spawn { sleep 1; _this call BIS_fnc_Carrier01Init};
			};

			//Tp player on carrier
			player setPosASLW [_spawnPos#0,_spawnPos#1,_spawnPos#2+0.5];

			//Add Action for TP on the carrier
			private _actionId = player addAction ["Move to the carrier",{
				//Define parameters
				params ["_object","_caller","_ID","_spawnPos"];

				_caller setPosASLW [_spawnPos#0,_spawnPos#1,_spawnPos#2+0.5];

			},_spawnPos,1.5,true,false,"","(initBlueforLocation distance _this <150)"];
			player setUserActionText [_actionId, "Move to the carrier", "<img size='3' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa'/>"];
	};

	[player, bluFaction] call doInitializeLoadout;
	diag_log format ["Player %1 has spawn on position %2", name player, _spawnPos];
	player setVariable ["spawnLoadout", getUnitLoadout player];

	//Manage arsenal	
	[VA2] call setupPlayerLoadout;	
	if (!isNil "bluformobilehq") then
	{
		//TODO FIX Mobile HQ Arsenal action
		[bluforMobileHQ] call setupPlayerLoadout;
	};

	//Add heal action to VA2
	private _actionId = VA2 addAction ["Heal", {
		
		//Heal player if mission's setup wasn't safe 
		if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
		{
			[objNull, player] call ace_medical_treatment_fnc_fullHeal;
		} else 
		{
			player setDamage 0;
		};
	}];
	player setUserActionText [_actionId, "Heal", "<img size='2' image='\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca'/>"];


	//Manage vehicle spawn options 
	if (enableArmoredVehicle) then 
	{	
		//TODO
	};

	//Add vehicle spawn option 
	//Unarmed vehicle
	waitUntil {!isNil "bluforUnarmedVehicle"};
	{
		_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1 (%2 credits)", getText (configFile >> "cfgVehicles" >> _x >> "displayName"), 100],{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];

				//Check players credit
				bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
				if (bluforVehicleAvalaibleSpawnCounter >= 100) then 
				{
					[initBlueforLocation, [[_avalaibleVehicle, false]], 30, 100] call doGenerateVehicleForFOB;	
					missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter-100, true];
					hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforVehicleAvalaibleSpawnCounter-100, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
				} else 
				{
					hint "You don't have enough advanced vehicle spawned credit left.";
				};
		},_x,1.5,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader')"];
	} foreach bluforUnarmedVehicle; 

	//Armed vehicle
	waitUntil {!isNil "bluforArmedVehicle"};
	{
		_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1 (%2 credits)", getText (configFile >> "cfgVehicles" >> _x >> "displayName"), 300],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			//Check players credit
			bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
			if (bluforVehicleAvalaibleSpawnCounter >= 300) then 
			{
				[initBlueforLocation, [[_avalaibleVehicle, false]], 30, 100] call doGenerateVehicleForFOB;	
				missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter-300, true];
				hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforVehicleAvalaibleSpawnCounter-300, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
			} else 
			{
				hint "You don't have enough advanced vehicle spawned credit left.";
			};
		},_x,1.5,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader')"];
	} foreach bluforArmedVehicle; 

	//Unarmed Chopper
	waitUntil {!isNil "bluforUnarmedVehicleChopper"};
	{
		_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1 (%2 credits)", getText (configFile >> "cfgVehicles" >> _x >> "displayName"), 400],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			//Check players credit
			bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
			if (bluforVehicleAvalaibleSpawnCounter >= 400) then 
			{
				[initBlueforLocation, [[_avalaibleVehicle, false]], 30, 100] call doGenerateVehicleForFOB;	
				missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter-400, true];
				hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforVehicleAvalaibleSpawnCounter-400, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
			} else 
			{
				hint "You don't have enough advanced vehicle spawned credit left.";
			};
		},_x,1.5,true,false,"","(_target distance _this <5) && ((_this getVariable 'role' == 'leader') || (_this getVariable 'role' == 'pilot'))"];
	} foreach bluforUnarmedVehicleChopper; 

	//Armed Chopper
	waitUntil {!isNil "bluforArmedChopper"};
	if (enableArmedAicraft) then 
	{	
		{
			_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1 (%2 credits)", getText (configFile >> "cfgVehicles" >> _x >> "displayName"), 500],{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];

				//Check players credit
				bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
				if (bluforVehicleAvalaibleSpawnCounter >= 500) then 
				{
					[initBlueforLocation, [[_avalaibleVehicle, false]], 30, 100] call doGenerateVehicleForFOB;	
					missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter-500, true];
					hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforVehicleAvalaibleSpawnCounter-500, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
				} else 
				{
					hint "You don't have enough advanced vehicle spawned credit left.";
				};
			},_x,1.5,true,false,"","(_target distance _this <5) && ((_this getVariable 'role' == 'leader') || (_this getVariable 'role' == 'pilot'))"];
		} foreach bluforArmedChopper; 
	};

	//UAV
	waitUntil {!isNil "bluforDrone"};
	{
		_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1 (%2 credits)", getText (configFile >> "cfgVehicles" >> _x >> "displayName"),500],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			//Check players credit
			bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
			if (bluforVehicleAvalaibleSpawnCounter >= 500) then 
			{
				[initBlueforLocation, [[_avalaibleVehicle, true]], 30, 100] call doGenerateVehicleForFOB;	
				missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter-500, true];
				hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforVehicleAvalaibleSpawnCounter - 500, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
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
			_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1 (%2 credits) (you will be teleported)", getText (configFile >> "cfgVehicles" >> _x >> "displayName"),600],{
				params ["_object","_caller","_ID","_avalaibleAicraft"];

				bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
				if (bluforVehicleAvalaibleSpawnCounter >= 600) then 
				{
					//Click on map to spawn
					selectedLoc = [0,0,0];
					openMap true;
					sleep 1;

					["<t color='#ffffff' size='.8'>Click on map to sapwn an aircraft and teleport<br />The aircraft will spawn oriented on the north</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
					onMapSingleClick "selectedLoc = _pos; onMapSingleClick ''; openMap false; true;";
					waitUntil{!(visibleMap)};  
					if (!([selectedLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
					{
						_caller setPos selectedLoc;
						createVehicle [_avalaibleAicraft, selectedLoc, [], 0, "NONE"];
						[_object,_ID] remoteExec [ "removeAction", 0, true ];
						
						//Reduce avalaible spawn counter
						missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter-600, true];
						hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforVehicleAvalaibleSpawnCounter-600, getText (configFile >> "cfgVehicles" >> _avalaibleAicraft >> "displayName")];
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
			["<t color='#ffffff' size='.8'>Click on map to spawn Halo jump<br />Your backpack will be saved</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
			onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
			waitUntil{!(visibleMap)};  
			if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
			{
				_caller setPos selectedHaloLoc;
				[_caller,1500] call BIS_fnc_halo;
				[format ["In the %1 airspace", worldName], format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;
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

//Disable revive if ACE medic is enable
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	[player] call BIS_fnc_disableRevive;
};

//Respawn setup 
setPlayerRespawnTime (missionNamespace getVariable "missionRespawnParam");

//Generate civilian dialogs
[] spawn _generateCivDialogs;

//Show a special message when there is a teamkill
player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	diag_log format ["%1 has been killed by : %2", name _unit, name _killer];
	if (isPlayer _killer) then 
	{
		[format ["%1 has been killed by his teammate %2",name _unit, name _killer], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', side _killer];
		if (_killer != _unit) then 
		{
			[[-50], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _killer];
		};
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
		[[], 'GUI\respawnGUI\initPlayerRespawnMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
	} else 
	{
		player setPos [0,0];
		player setDamage 1;
	};
} else {
	//Let's get it started !
	player allowdamage true;
	player enableSimulationGlobal true;
};

//Remove arsenal from player 
player call RemoveArsenalActionFromGivenObject;

//Heal player if mission's setup wasn't safe 
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
  [objNull, player] call ace_medical_treatment_fnc_fullHeal;
} else 
{
  player setDamage 0;
};

//Display welcome message
5 fadeMusic 0;
sleep 5;
[parseText "<t font='PuristaBold' size='1.6'>Welcome to <br />Random Patrol Generator</t><br />by Patapignouf", true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
sleep 20;
[format ["Somewhere on %1",worldName], format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;
