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
player setVariable ["role", player getVariable ["initRole","rifleman"], true];

[selectRandom ["LeadTrack01_F","LeadTrack01a_F","LeadTrack01b_F","LeadTrack03_F","LeadTrack01_F_Heli","LeadTrack04_F_EXP","LeadTrack01_F_Mark"], 10, 0.2] call BIS_fnc_playMusic;

cutText ["", "BLACK FADED", 100];

//Wait for UI totaly loaded
uiSleep 3;

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
			player setVariable ["isSetupMission", true];
			player setVariable ["isAdmin", true, true];
			[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	} else 
	{
		//Solo setup or game without  admin setup
		if ( ({isPlayer _x && side _x == independent} count (call BIS_fnc_listPlayers) != 0 && forceBluforSetup == 0)) then 
		{
			if (side player == independent && player == (leader (group player))) then 
			{
				//Display setup menu
				cutText ["", "BLACK FADED", 100];
				player setVariable ["isSetupMission", true];
				[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
			};
		} else {
			
			//If there is no independent, blufor leader can choose mission
			if (side player == blufor && player == (leader (group player))) then 
			{
				//Display setup menu
				cutText ["", "BLACK FADED", 100];
				player setVariable ["isSetupMission", true];
				[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
			};
		};
	};
};

//Add admin menu action
[] spawn {
	//Add admin settings GUI action
	if (player getVariable ["isAdmin", false] || (hasInterface && isServer)) then 
	{
		//Add 3 spaces empty actions
		for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
		{
			player addAction ["                       ",{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];
				//Do
			},_x,0.1,true,false,"","(_target distance _this <3) && (_target getVariable ['isAdmin', false] || (hasInterface && isServer))"];
		};

		//Add admin settings GUI action
		player addAction ["<t color='#FF0000'>Open ADMIN MENU</t>",{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];
			[[], 'GUI\adminGUI\adminGUIInit.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
		},_x,0,true,false,"","(_target distance _this <3) && (_target getVariable ['isAdmin', false] || (hasInterface && isServer))"];
	};
};

//Show loading message
[] spawn {

	if (player getVariable ["isSetupMission", false]) then 
	{
		cutText ["", "BLACK FADED", 100];
	} else 
	{
		[[], 'engine\showWaitingSetupScreen.sqf'] remoteExec ['BIS_fnc_execVM', player];
	};
};

//Start custom hint engine
[[], 'engine\hintManagement\customHintManager.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Wait mission setup
waitUntil {missionNamespace getVariable "generationSetup" == true};

if (player getVariable ["isSetupMission", false]) then 
{
	player setVariable ["isSetupMission", false];
	[[], 'engine\showWaitingSetupScreen.sqf'] remoteExec ['BIS_fnc_execVM', player];
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
} else 
{
	//Add ACE cookoff high probability on enemy weapon
	player addEventHandler["Fired",{
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    	[_weapon] call adjustCookOf;
  	}];

	//Reduce cookoff on jammed weapon
	["ace_weaponJammed", {
		_this call reduceCookOff;
	}] call CBA_fnc_addEventHandler;

};

//Init player rank
[[player], 'engine\rankManagement\rankManager.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Init player survivor objective
[[player], 'engine\objectiveManagement\survivorObjectiveManagement.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Init player respawn ticket
[player, -1, true] call BIS_fnc_respawnTickets;

//Corpse manager
player addEventHandler ["Respawn",{ 
	params ["_unit", "_corpse"];
	_corpse setVariable ["isPlayerObject",true, true];
	[_corpse] spawn {
		params ["_corpse"];
		uiSleep 500;
		deleteVehicle _corpse;
	};
}];

diag_log format ["Setup Player %1 at position 1", name player];

//Setup briefing 
player createDiarySubject ["RPG", "RPG"];
_diaryIntel = player createDiaryRecord ["RPG", ["RPG intel", "You can see here all intels collected : <br/>"]];
player setVariable ["diaryIntel", _diaryIntel];
player createDiaryRecord ["RPG", ["RPG respawn", "There are two ways to respawn on Random Patrol Generator missions :<br/>- First, when a mission is completed<br/>- Secondly, when players call a reinforcement on support Shop<br/><br/><br/>Note : Respawn setting has to be enabled"]];
player createDiaryRecord ["RPG", ["RPG arsenal", "A limited arsenal is avalaible on your start position, it will allow you to switch between roles."]];

if (side player == independent) then 
{
	//Setup briefing independent
	player createDiaryRecord ["RPG", ["RPG objectives", "Help the people in the civilian location. Complete the tasks assigned to your unit to finish the mission. You can also ask citizens for intel to help you prepare the operation.
	"]];

	if (player == (leader (group player))) then
	{	
		//Disable ind VIP feature
		// if (!didJIP) then 
		// {
		// 	diag_log format ["Warlord is set to player : %1", name player];
		// 	player addEventHandler ["Killed", {
		// 		params ["_unit", "_killer", "_instigator", "_useEffects"];
		// 		diag_log format ["Warlord has been killed by : %1", _killer];
		// 		diag_log format ["Mission end !"];
		// 		[['IND_DEAD'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
		// 	}];
		// };
	};

	//Wait for the player to choose position
	waitUntil {!isNil "missionGenerated"};

	player setVariable ["sideBeforeDeath","independent"];
	_spawnPos = [initCityLocation, 1, 30, 3, 0, 20, 0] call BIS_fnc_findSafePos;
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
	player createDiaryRecord ["RPG", ["RPG objectives", "Help the independent or civilian location. Complete the tasks assigned to your unit to finish the mission.
	"]];
	player createDiaryRecord ["RPG", ["RPG FOB", "You can deploy an advanced FOB avalaible in a supply box near main FOB :<br/>- It can be used to skip time<br/>- It can be used to access support shop"]];
	player createDiaryRecord ["RPG", ["RPG vehicles", "You can use the Vehicle Shop on the main FOB to spawn vehicules. Each vehicle spawned use one specific credit.<br/>Complete a mission to earn credits.<br/><br/> Note : Only the team leader and pilot can spawn vehicles."]];
	
	diag_log format ["Setup Player %1 at position 2", name player];

	//Wait for the player to choose position
	waitUntil {!isNil "missionGenerated"};


	player setVariable ["sideBeforeDeath","blufor"];
	
	//manage carrier spawn
	//Move player
	_spawnPos = [];
	if (isNil "USS_FREEDOM_CARRIER") then 
	{
		_spawnPos = [initBlueforLocation, 1, 30, 1, 0, 30, 0, [], [initBlueforLocation, initBlueforLocation]] call BIS_fnc_findSafePos;
		player setPos (_spawnPos);
	} else 
	{
		_spawnPos = initBlueforLocation;

		//Fix catapult on carrier
		[_spawnPos] spawn {
				params ["_spawnPos"];
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

				//End init
				[USS_FREEDOM_CARRIER,_spawnPos] spawn { 
					params ["_USSCarrier","_spawnPos"];
					_handleScirpt = _USSCarrier call BIS_fnc_Carrier01Init;
					waitUntil {isNull _handleScirpt};

					cutText ["ARRIVING ON CARRIER", "BLACK FADED", 100];
					uiSleep 15; 

					//Play random radio sound
					[] spawn {
						playMusic ["RadioAmbient5", 1];
						sleep 4;
						playMusic "";
					};

					//Tp player on carrier
					player setPosASL [_spawnPos#0 + random 30,_spawnPos#1+random 30,_spawnPos#2+0.5];
					titleCut ["WELCOME ON BOARD", "BLACK IN", 5];
				};
			};

			//Wait for USS Carrier spawn
			sleep 10;

			//Add Action for TP on the carrier
			_actionIdCarrier = player addAction ["Move to the carrier",{
				//Define parameters
				params ["_object","_caller","_ID","_spawnPos"];

				_caller setPosASL [_spawnPos#0,_spawnPos#1,_spawnPos#2+0.5];

			},_spawnPos,1.5,true,false,"","(initBlueforLocation distance _this <150)"];
			player setUserActionText [_actionIdCarrier, "Move to the carrier", "<img size='3' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa'/>"];

			//Add action moving to boat
			_actionIdBoat = player addAction ["Move to the boat",{
				//Define parameters
				params ["_object","_caller","_ID","_spawnPos"];

				_caller setPosASL [(_spawnPos#0)-40, (_spawnPos#1)+70,0];

			},_spawnPos,1.5,true,false,"","(initBlueforLocation distance _this <150)"];
			player setUserActionText [_actionIdBoat, "Move to the boat", "<img size='3' image='\a3\ui_f\data\igui\cfg\actions\loadvehicle_ca.paa'/>"];
	};

	[player, bluFaction] call doInitializeLoadout;
	diag_log format ["Player %1 has spawn on position %2", name player, _spawnPos];
	player setVariable ["spawnLoadout", getUnitLoadout player];

	//Manage arsenal
	waitUntil{!isNil "VA2"};
	[VA2] call setupPlayerLoadout;	

	[] spawn {
		waitUntil {!isNil "bluformobilehq"};
		
		//TODO FIX Mobile HQ Arsenal action
		[bluforMobileHQ] call setupPlayerLoadout;
	};


	//Add heal action to VA2
	_actionIdHeal = VA2 addAction 
	[
		"<t color='#00bc1a'>Heal</t>", 
		{
			//Heal player if mission's setup wasn't safe 
			if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
			{
				[objNull, player] call ace_medical_treatment_fnc_fullHeal;
			} else 
			{
				player setDamage 0;
			};
		},
		nil,		// arguments
		1.5,		// priority
		true,		// showWindow
		false,		// hideOnUse
		"",			// shortcut
		"true",		// condition
		50,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];
	//player setUserActionText [_actionIdHeal, "Heal", "<img size='2' image='\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca'/>"];

	//Add heal action to VA2
	_actionShowRoles = VA2 addAction 
	[
		"<t color='#5400ac'>Show roles</t>", 
		{
			_playerRoles = "";
			{
				_playerRoles = format ["%1\n%2 %3",_playerRoles, _x getVariable "role" , name _x];
			} foreach (allPlayers select {side _x == blufor});
			hint _playerRoles;
		},
		nil,		// arguments
		1,		// priority
		true,		// showWindow
		false,		// hideOnUse
		"",			// shortcut
		"true",		// condition
		50,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];

	//Add vehicle spawn option 
	waitUntil{!isNil "TPFlag1"};
	if (isNil "USS_FREEDOM_CARRIER") then 
	{
		TPFlag1 addAction [format ["Open vehicle shop"],{
					//Define parameters
					params ["_object","_caller","_ID","_avalaibleVehicle"];

					[[], 'GUI\vehicleSpawnerGUI\vehicleSpawner.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			},_x,3,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader' || _this getVariable 'role' == 'pilot')"];
	};

	TPFlag1 addAction [format ["Open support shop"],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			[[], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
	},_x,3,true,false,"","_target distance _this <5"];
	
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
	diag_log format ["%1 has been killed by : %2", name _unit, name _instigator];
	if (isPlayer _instigator) then 
	{
		[[format ["%1 has been killed by his teammate %2",name _unit, name _instigator], "teamkill"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', side _instigator];
		if (_instigator != _unit) then 
		{
			[[-50,5], 'engine\rankManagement\rankPenalty.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
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
		player setPos [0,0,1];
		player allowdamage false;
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
[] spawn {
	uiSleep 10;
	player call RemoveArsenalActionFromGivenObject;
};


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
uiSleep 5;
playMusic "";
[parseText "<t font='PuristaBold' size='1.6'>Welcome to <br />Random Patrol Generator</t><br />by Patapignouf", true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
uiSleep 20;
[format ["Somewhere on %1",worldName], format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;

