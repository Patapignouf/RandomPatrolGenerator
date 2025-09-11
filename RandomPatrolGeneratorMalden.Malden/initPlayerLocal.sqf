//init tp to be able to spawn on the ground on each map
cutText ["FINISHING LOADING MISSION", "BLACK FADED", 100];

player setPos [worldSize,worldSize, 1000];
player enableSimulationGlobal false;
player allowdamage false;

#include "engine\modManager.sqf"
#include "database\missionParameters.sqf"
#include "enemyManagement\behaviorEngine\unitsBehaviorFunctions.sqf"
#include "engine\searchLocation.sqf"
#include "engine\hintManagement\customDialog.sqf"
#include "GUI\scoreBoardGUI\scoreFunctions.sqf"

forceBluforSetup = "ForceBluforSetup" call BIS_fnc_getParamValue;

//Wait player load
if (!hasInterface || isDedicated) exitWith {};
waitUntil {alive player};
waitUntil {!isNull player && (getClientStateNumber>=10||!isMultiplayer)};
waitUntil {!isNil "factionInfos"};

diag_log format ["Setup Player %1 at position 0", name player];


//prevent player from drowning in loading
[] spawn {
	while {!isTouchingGround player} do { 
		player setOxygenRemaining 100; 
	};
};

enableSentences false;


player setVariable ["role", player getVariable ["initRole","rifleman"], true];

[selectRandom ["LeadTrack01_F","LeadTrack01a_F","LeadTrack01b_F","LeadTrack03_F","LeadTrack01_F_Heli","LeadTrack04_F_EXP","LeadTrack01_F_Mark"], 10, 0.2] call BIS_fnc_playMusic;

cutText ["PREPARING MISSION SETUP", "BLACK FADED", 100];

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
			cutText ["PREPARING SETUP", "BLACK FADED", 100];
			player setVariable ["isSetupMission", true];
			player setVariable ["isAdmin", true, true];

				waitUntil { !isNull findDisplay 46 };
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
				cutText ["PREPARING SETUP", "BLACK FADED", 100];
				player setVariable ["isSetupMission", true];
				waitUntil { !isNull findDisplay 46 };

				[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
			};
		} else {
			
			//If there is no independent, blufor leader can choose mission
			if (side player == blufor && player == (leader (group player))) then 
			{
				//Display setup menu
				cutText ["", "BLACK FADED", 100];
				player setVariable ["isSetupMission", true];

				waitUntil { !isNull findDisplay 46 };
				[[], 'GUI\setupGUI\initMissionMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
			};
		};
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


//Format mission settings display to other players
_missionSettings = "";
{
	_currentParam = _x;
	_paramName = _currentParam#1;
	_paramValue = ((_currentParam#0) select {(missionNameSpace getVariable [_currentParam#3,0]) == _x#0})#0#1;
	_missionSettings = format ["%1%2 : %3<br />", _missionSettings, _paramName, _paramValue];
} foreach baseParamsToManage;
[format ["<t color='#ffffff' align='left' size='.6'>Mission settings :<br />%1</t>", _missionSettings],1,-0.1,10,1,0,789] spawn BIS_fnc_dynamicText;


if (player getVariable ["isSetupMission", false]) then 
{
	player setVariable ["isSetupMission", false];
	[[], 'engine\showWaitingSetupScreen.sqf'] remoteExec ['BIS_fnc_execVM', player];
};

//Wait auto faction builder
waitUntil {!isNil "missionFactionSetup"};
waitUntil {!isNil "missionInitFactionSetup"};


//Load every mission settings dependencies
#include "database\arsenalLibrary.sqf"
#include "objectGenerator\vehicleManagement.sqf"

enableThermal = "EnableThermal" call BIS_fnc_getParamValue;
enableHalo = missionNamespace getVariable "enableHalo";

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


// //Validate current player's stuff
// if ((missionNameSpace getVariable "enableLoadoutRestriction") == 1) then 
// {
// 	[missionNamespace, "arsenalClosed", {
// 		disableSerialization;
// 		params ["_display"];

// 		//Check loadout
// 		[player] call validateLoadout;
// 		["AmmoboxExit", player] call BIS_fnc_arsenal;
// 	}] call BIS_fnc_addScriptedEventHandler;
// };


//Init disableThermal
if (enableThermal==0) then 
{
	[] spawn _disableThermal;
};

//Validate mods
if ((missionNameSpace getVariable "enableModChecker") == 1) then 
{
	[] call doCheckRunningModsOnClient;
};

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
	_handleDamageEH = player addEventHandler ["HandleDamage",{
		private["_damage"];
		if ((lifeState player == "INCAPACITATED")||(lifeState player == "SHOOTING")) then {
			_damage = 0;
		};    
		_damage    
	}];
	
	player setVariable ["HandleDamageEH", _handleDamageEH, true];
} else 
{
	//Only do weapon jamming if loadout restriction is enable
	if ((missionNameSpace getVariable "enableLoadoutRestriction") == 1) then 
	{
		if (missionNameSpace getVariable ["enableOverHeat",1] == 1) then 
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
	};

	//Display message to abort when unconscious
	["ace_unconscious", {
		params ["_unit", "_status"];
		
		//Exclude other players
		if (player != _unit) exitWith {}; 

		//Disable physX collision 
		//_unit setPhysicsCollisionFlag !_status;

		//If unit become unconscious
		if (_status) then 
		{
			[_unit] spawn {
				params ["_unit"];
				sleep 60;
				if (lifeState _unit == "INCAPACITATED" && count (allPlayers select {alive _x && _x distance _unit <5 && lifeState _x != "INCAPACITATED"}) == 0) then 
				{
					private _result = ["No one seems to be helping you, die and go to spectate ?", "Confirm", true, true] call BIS_fnc_guiMessage;

					if (_result) then {
						//systemChat "The player is sure.";
						_unit setDamage 1;
					} else {
						//systemChat "The player is not sure.";
					};
				};
			};

			[[_unit] , "GUI\displayNearestMedicGUI\displayNearestMedicGUI.sqf"] remoteExec ['BIS_fnc_execVM', _unit];
		};
	}] call CBA_fnc_addEventHandler;
};

//Init player rank
[[player, true], 'engine\rankManagement\rankManager.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Init player survivor objective
[[player], 'engine\objectiveManagement\survivorObjectiveManagement.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Init player respawn ticket
[player, -1, true] call BIS_fnc_respawnTickets;

//Corpse manager
_respawnEH = player addEventHandler ["Respawn",{ 
	params ["_unit", "_corpse"];
	_corpse setVariable ["isPlayerObject",true, true];
	[_corpse] spawn {
		params ["_corpse"];
		uiSleep 500;
		deleteVehicle _corpse;
	};
}];
player setVariable ["RespawnEH", _respawnEH, true];

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
	_spawnPos = [initCityLocation, 1, 30, 3, 0, 20, 0, [], [initCityLocation,initCityLocation]] call BIS_fnc_findSafePos;
	diag_log format ["Player %1 has spawn on position %2", name player, _spawnPos];
	player setPos (_spawnPos);

	//Manage loadout
	[player, indFaction] call doInitializeLoadout;
	player setVariable ["spawnLoadout", getUnitLoadout player];

	//Manage arsenal	
	[VA1] call setupPlayerLoadout;

	//Add vehicle shop
	VA1 addAction [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_OPEN_VEHICLE_SHOP"],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			//Define independent shop vehicle
			_independentUnarmedVehicle = bluforUnarmedVehicle_db select {_x select 1  == indFaction} select 0 select 0;
			_independentUnarmedChopper = bluforUnarmedVehicleChopper_db select {_x select 1  == indFaction} select 0 select 0;

			[["independentVehicleAvalaibleSpawn", _independentUnarmedVehicle, [], [], _independentUnarmedChopper, [], [], [], [], [], []], 'GUI\vehicleSpawnerGUI\vehicleSpawner.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
	},_x,3,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader' || _this getVariable 'role' == 'pilot')"];

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
					player setVelocity [0, 0, 0];
					player setPosASL [_spawnPos#0-105 + random 15,_spawnPos#1-18+random 15,_spawnPos#2+0.5];
					titleCut ["WELCOME ON BOARD", "BLACK IN", 5];
				};
			};

			//Wait for USS Carrier spawn
			sleep 10;

			//Add Action for TP on the carrier
			_actionIdCarrier = player addAction ["Move to the carrier",{
				//Define parameters
				params ["_object","_caller","_ID","_spawnPos"];

				_caller setPosASL [_spawnPos#0-105 + random 15,_spawnPos#1-18+random 15,_spawnPos#2+0.5];

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
	waitUntil{!isNil "bluforFOBBuild"};
	if (ironMan) then 
	{
		[VA2] call setupPlayerLoadout;	
	} else 
	{
		[VA2] call setupPlayerLoadoutRemake;	
	};

	[] spawn {
		waitUntil {!isNil "bluformobilehq"};
		
		//TODO FIX Mobile HQ Arsenal action
		if (ironMan) then 
		{
			[bluforMobileHQ] call setupPlayerLoadout;	
		} else 
		{
			[bluforMobileHQ] call setupPlayerLoadoutRemake;	
		};
	};


	//Add heal action to VA2
	_actionIdHeal = VA2 addAction 
	[
		"<img size='2' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa'/><t color='#00bc1a'>Heal all players around here</t>", 
		{
			{
				if ((_x distance player) < 50) then
				{
					//Heal player if mission's setup wasn't safe 
					if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
					{
						[objNull, _x] call ace_medical_treatment_fnc_fullHeal;
					} else 
					{
						_x setDamage 0;
					};

					//Display heal message information
					[["<t color='#6AA84F' size='.8'>You have been healed</t>",0,0,2,0,0,789], BIS_fnc_dynamicText] remoteExec ["spawn", _x];
				};
			} foreach allPlayers;

		
			// ["<t color='#6AA84F' size='.8'>You have been healed</t>",0,0,2,0,0,789] spawn BIS_fnc_dynamicText;
		},
		nil,		// arguments
		3,		// priority
		true,		// showWindow
		false,		// hideOnUse
		"",			// shortcut
		"true",		// condition
		50,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];


	//Add rank action to VA2
	_actionIdRankManager = VA2 addAction 
	[
		"<img size='2' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_thumbsup_ca.paa'/><t color='#0433b1'>Show rank and experience</t>", 
		{
			//Open player rank manager
			[[], 'GUI\rankGUI\rankGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];

		},
		nil,		// arguments
		4,		// priority
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
		"<img size='2' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_follow_start_ca.paa'/><t color='#5400ac'>Show roles</t>", 
		{
			_playerRoles = "";
			{
				_playerRoles = format ["%1\n%2 %3",_playerRoles, _x getVariable "role" , name _x];
			} foreach (allPlayers select {side _x == blufor});
			hint _playerRoles;
		},
		nil,		// arguments
		3,		// priority
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
		TPFlag1 addAction [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_OPEN_VEHICLE_SHOP"],{

					//Define parameters
					params ["_object","_caller","_ID","_avalaibleVehicle"];

					[["bluforVehicleAvalaibleSpawn", bluforUnarmedVehicle, bluforArmedVehicle, bluforArmoredVehicle, bluforUnarmedVehicleChopper, bluforArmedChopper, bluforDrone, bluforFixedWing, bluforFixedWingTransport, bluforBoat, bluforStaticWeapon], 'GUI\vehicleSpawnerGUI\vehicleSpawner.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			},_x,3,true,false,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader' || _this getVariable 'role' == 'pilot')"];	
	};

	TPFlag1 addAction [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_OPEN_SUPPORT_SHOP"],{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			[[true], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
	},_x,3,true,false,"","_target distance _this <5"];

		//Add abort action to TPFlag1
	_actionIdAbortMission = TPFlag1 addAction 
	[
		"<img size='2' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa'/><t color='#FF0000'>Abort mission</t>", 
		{
			[['ABORT', true], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
		},
		nil,		// arguments
		0,		// priority
		true,		// showWindow
		false,		// hideOnUse
		"",			// shortcut
		"_this getVariable 'role' == 'leader'",		// condition
		5,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];
	
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
_KilledEH = player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	diag_log format ["%1 has been killed by : %2", name _unit, name _instigator];

	//Check if the killer is a player
	if (isPlayer _instigator) then 
	{
		//Check if player are on opposite side
		if ([side _instigator, playerSide] call BIS_fnc_sideIsEnemy) then 
		{
			//Reward PvP kill
			_distance = _instigator distance _unit;
			if (_distance<100 || _distance>5000) then {_distance = nil};
			[[_distance], {params ["_distance"]; [1, "RPG_ranking_infantry_kill", _distance] call doUpdateRank}] remoteExec ["spawn", _instigator]; 
		} else 
		{
			
			[[_unit, _instigator], {params ["_unit", "_instigator"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_TEAMKILL", name _unit, name _instigator] call doDialog}] remoteExec ["spawn", side _instigator]; 

			if (_instigator != _unit) then 
			{
				//Punish killer with XP loss
				[{[-50,3] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];

				//Add dialog to punish the teamkiller
				[[_instigator], {
					params ["_instigator"];
					    sleep 10;
						private _resultAlone = [format ["Do you want to punish your killer %1 ?", name _instigator], "Yes", true, true] call BIS_fnc_guiMessage;

						if (_resultAlone) then {
							//systemChat "The player is sure.";
							_instigator setDamage 1;
							[[_instigator], {params ["_instigator"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_PUNISH", name _instigator] call doDialog}] remoteExec ["spawn", side _instigator]; 
						} else {
							//systemChat "The player is not sure.";
						};
					}
				] remoteExec ["spawn", _unit]; 
			};
		};
	};
}];
player setVariable ["KilledEH", _KilledEH, true];

//If a player join in progress he will be teleported to his teamleader (WIP feature)
if (didJIP) then 
{
	diag_log format ["Player %1 has arrived on JIP", name player];
	//Check if player is trying to respawn by deco/reco method
	_deadPlayerList = [];
	if (missionNameSpace getVariable ["respawnCheat", 0] == 1) then
	{
		_deadPlayerList = missionNamespace getVariable "deadPlayer";
	};

	if (count (_deadPlayerList select { _x == (name player) }) == 0) then 
	{
		//Disable specific respawn menu
		player setVelocity [0, 0, 0];
		player setPos [worldSize,worldSize,0];
		player allowdamage false;
		[[], 'GUI\respawnGUI\initPlayerRespawnMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
	} else 
	{
		player setPos [-500,-500];
		player setDamage 1;
	};
} else {
	//Let's get it started !
	player setVelocity [0, 0, 0]; //reset speed
	player allowdamage true;
	player enableSimulationGlobal true;
};


//Remove arsenal from player 
[] spawn {
	uiSleep 5;
	player call RemoveArsenalActionFromGivenObject;
};

//Make the player doesn't count on RTB for 90 secs 
[] spawn 
{
	uiSleep 90;
	player setVariable ["canRTB", true, true];
};

if (didJIP && count (units group player) == 1 && count (allPlayers select {side _x == side player}) != 1) then 
{
	private _resultAlone = ["You seem to be alone in your squad, do you want to join another ?", "Confirm", true, true] call BIS_fnc_guiMessage;

	if (_resultAlone) then {
		//systemChat "The player is sure.";
		[player] joinSilent (group (selectRandom (allPlayers select {side _x == side player && _x != player})));
	} else {
		//systemChat "The player is not sure.";
	};
};

//Add RPG menu 
[] spawn
{
	waitUntil {!isNull(findDisplay 46)};
	
	(findDisplay 46) displayAddEventHandler ["KeyDown",
	{
		if(_this select 1 == profileNameSpace getVariable ["RPG_Menu_Key", 0x16])
		then
		{
			[[], 'GUI\RPGMenuGUI\RPGMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	}];
};

//Setup default TFAR radio frequency
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
	"50" call TFAR_fnc_setPersonalRadioFrequency;
};

//Heal player if mission's setup wasn't safe 
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
  [objNull, player] call ace_medical_treatment_fnc_fullHeal;
} else 
{
  player setDamage 0;
};

#include "GUI\mapIndicatorGUI\mapRealTimeMarkers.sqf"
#include "engine\tentActionManagement.sqf"



//Display welcome message
5 fadeMusic 0;
uiSleep 5;
playMusic "";
[parseText "<t font='PuristaBold' size='1.6'>Welcome to <br />Random Patrol Generator</t><br />by Patapignouf", true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
uiSleep 20;
[format ["Somewhere on %1",worldName], format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;


//Display tutorial for new players 
_playerCurrentXP = [player] call getExperience;
if (_playerCurrentXP < 50) then 
{
	localize "STR_RPG_TUTO_WELCOME" hintC [
		localize "STR_RPG_TUTO_OBJ",
		localize "STR_RPG_TUTO_LOADOUT",
		localize "STR_RPG_TUTO_VEHICLE",
		localize "STR_RPG_TUTO_RESPAWN"
	];
};