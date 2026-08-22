//Set default respawn loadout
player setUnitLoadout (player getVariable "spawnLoadout");

//Reset enginneer action
player setVariable ["fortifyActionID", -1];

//Adjust trait 
[player, player getVariable "role"] call setUnitTraitAccordingToRole;

//Close spectator mode
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	[false] call ace_spectator_fnc_setSpectator;
	["Terminate"] call BIS_fnc_EGSpectator;
	(findDisplay 60492) closeDisplay 2;
	player switchCamera "INTERNAL"; 
} else 
{
	["Terminate"] call BIS_fnc_EGSpectator;
	(findDisplay 60492) closeDisplay 2;
	player switchCamera "INTERNAL"; 
};




//Set player normal state 
player setVariable ["isUnconscious", false, true];

//Make the player doesn't count on RTB for 90 secs 
player setVariable ["canRTB", false, true];
[] spawn 
{
	uiSleep 90;
	player setVariable ["canRTB", true, true];
};

//Remove respawn timer hint
hint "";

//Respawn on start position by default
//Protect player for 30 sec on spawn
player allowDamage false;
if (player getVariable "sideBeforeDeath" == "independent") then 
{
  //Independent
  player setPos ([initCityLocation, 1, 30, 1, 0, 20, 0, [], [initCityLocation, initCityLocation]] call BIS_fnc_findSafePos);
} else 
{
  //Blufor
  if (isNil "USS_FREEDOM_CARRIER") then 
  {
    _spawnPos = [initBlueforLocation, 1, 30, 1, 0, 20, 0, [], [initBlueforLocation, initBlueforLocation]] call BIS_fnc_findSafePos;
    player setPos (_spawnPos);
  } else 
  {
    _spawnPos = initBlueforLocation;
    [USS_FREEDOM_CARRIER] call BIS_fnc_Carrier01Init;
    player setPosASL [(_spawnPos#0)+random 30, (_spawnPos#1)+random 30,_spawnPos#2+0.5];
  };
};

//reset respawn timer
if (missionNameSpace getVariable ["enableSelfRespawnTimer", 0] == 0) then 
{
	//No self respawn timer (directed by the server)
	setPlayerRespawnTime 99999999;
} else 
{
	//set personnal respawn timer
	setPlayerRespawnTime (missionNamespace getVariable "missionRespawnParam");
};

//Setup respawn GUI
cutText ["", "BLACK FADED", 4];
uiSleep 3;


if (missionNameSpace getVariable ["respawnOnOtherPlayers", 1] == 1) then 
{
	[[], 'GUI\respawnGUI\initPlayerRespawnMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];
} else 
{
	//Clear screen
	cutText ["", "BLACK IN", 5];

	//Open Map
	[[false], 'GUI\respawnGUI\respawnMapGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];
};




// Fix player damaged on respawn 
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
  [objNull, player] call ace_medical_treatment_fnc_fullHeal;
} else 
{
  player setDamage 0;
};

//Disable miniMap GPS for ACE Player (use microDAGR instead)
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	player enableInfoPanelComponent ["left", "MinimapDisplay", false];
	player enableInfoPanelComponent ["right", "MinimapDisplay", false];
};

//Init player rank
[[player, false], 'engine\rankManagement\rankManager.sqf'] remoteExec ['BIS_fnc_execVM', player];

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


//Weapon forbidden script 
if (missionNameSpace getVariable ["gunsOnly", 0] == 1) then 
{
	[player] spawn {
		params ["_choosenPlayer"];

		while {sleep 1; true} do 
		{
			//Get reporter weapon
			_primaryWeapon = primaryWeapon _choosenPlayer;
			//_secondaryWeapon = secondaryWeapon _choosenPlayer;

			if (_primaryWeapon != "") then
			{
				[["<t color='#ff0000' size='5'>RIFLES ARE NOT ALLOWED</t><br/>", "PLAIN", -1, true, true]] remoteExec ['cutText', _choosenPlayer];
			};
		};
	};
};



//Hide HUD group to debug the UI after death
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
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
};
//#####


//Default respawn 
//Remove player name from the dead player's list
_deadPlayerList = missionNamespace getVariable "deadPlayer";
_deadPlayerList = _deadPlayerList - [name player];
missionNamespace setVariable ["deadPlayer", _deadPlayerList, true];

["Respawn on start position", format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;

if (missionNameSpace getVariable ["enableAdvancedRespawn", 1] == 1) then 
{
	#include "engine\tentActionManagement.sqf"
};

_KilledEH = player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	diag_log format ["%1 has been killed by : %2", name _unit, name _instigator];

	//Check if the killer is a player
	if (isPlayer _instigator) then 
	{
		//Check if player are on opposite side
		if ([side _instigator, playerSide] call BIS_fnc_sideIsEnemy) then 
		{
			//Find distance between killed unit and killer
			_distance = 0;

			if (isRemoteControlling _instigator) then 
			{
				_distance = (remoteControlled _instigator) distance _unit;
			} else 
			{
				_distance = _instigator distance _unit;
			};	

			//Store kill distance
			[[_distance], 
			{
				params ["_distance"];
				_infantryKillRange = player getVariable ["RPG_ranking_infantry_killRange", 0];

				if (_infantryKillRange < _distance) then 
				{
					player setVariable ["RPG_ranking_infantry_killRange", _distance, true];
				};
			}] remoteExec ["spawn", _instigator]; 

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

						//Wait spectator mode
						sleep 5;
					
						// 1. display GUI
						("TAG_RscPunishPrompt" call BIS_fnc_rscLayer) cutRsc ["TAG_RscPunishPrompt", "PLAIN", 0, true];

						[_instigator] spawn {
							params ["_instigator"];
							// 2. wait display to be available
							private _titleDisplay = objNull;
							waitUntil {
								_titleDisplay = uiNamespace getVariable ["TAG_PunishPrompt_Display", objNull];
								!isNull _titleDisplay
							};

							// 3. move display and adjust content
							private _clickCtrl = _titleDisplay displayCtrl 9001;
							private _pos = ctrlPosition _clickCtrl; // [x, y, w, h]
							private _minX = _pos select 0;
							private _minY = _pos select 1;
							private _maxX = _minX + (_pos select 2);
							private _maxY = _minY + (_pos select 3);

							// store data on player
							player setVariable ["TAG_punishPrompt_Bounds", [_minX, _maxX, _minY, _maxY]];
							player setVariable ["TAG_punishPrompt_IsActive", true];
							player setVariable ["TAG_punishTeamKiller", _instigator];
							_clickCtrl ctrlSetStructuredText parseText format ["<a color='#ff0000' size='1'><t color='#ff0000'>Click here to punish %1</t></a>", name _instigator];

							// 4. Add listener to spectator mode
							private _mapDisplay = findDisplay 60492; // ID natif d'ArmA pour la carte principale

							TAG_healPrompt_MouseEHId = _mapDisplay displayAddEventHandler ["MouseButtonDown", {
								params ["_mapDisplay", "_button", "_mx", "_my"];
								
								// Listen left mouse button
								if (_button == 0 && {player getVariable ["TAG_punishPrompt_IsActive", false]}) then {
									private _bounds = player getVariable ["TAG_punishPrompt_Bounds", []];
									if (_bounds isEqualTo []) exitWith {};
									_bounds params ["_minX", "_maxX", "_minY", "_maxY"];

									// 5. check if the player click on the display
									if (_mx >= _minX && _mx <= _maxX && _my >= _minY && _my <= _maxY) then {
										
										_instigator = player getVariable "TAG_punishTeamKiller";
										_instigator setDamage 1;
										[[_instigator], {params ["_instigator"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_PUNISH", name _instigator] call doDialog}] remoteExec ["spawn", side _instigator]; 

										// clean
										player setVariable ["TAG_punishPrompt_IsActive", false];
										("TAG_RscPunishPrompt" call BIS_fnc_rscLayer) cutFadeOut 0.1;
									};
								};
							}];
							
							//wait display to vanish
							sleep 10;
							// clean 
							player setVariable ["TAG_punishPrompt_IsActive", false];
							("TAG_RscPunishPrompt" call BIS_fnc_rscLayer) cutFadeOut 0.1;

						};
					}
				] remoteExec ["spawn", _unit]; 
			};
		};
	};
}];
player setVariable ["KilledEH", _KilledEH, true];


//Add solo tank crew feature
if (missionNameSpace getVariable ["enableSoloCrewTank", 1] == 1) then 
{
	player addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle", "_turret"];

		// check if the vehicle is a tank or tank like
		if (_vehicle isKindOf "Tank" || _vehicle isKindOf "Wheeled_APC_F" || _vehicle isKindOf "TrackedAPC") then {
			
			// if the player enter as driver then start solo crew script
			if (_role == "driver") then {
				

				// 1. If turret is empty add an AI to make solo crew
				if (isNull (gunner _vehicle)) then {
					private _group = createGroup [side _unit, true];
					private _aiGunner = _group createUnit ["B_Survivor_F", [0,0,0], [], 0, "NONE"];
					
					_aiGunner hideObjectGlobal true; // make AI invisible
					_aiGunner allowDamage false;     // Invincible
					_aiGunner moveInGunner _vehicle; // Move AI to gunner place, maybe driver is better :p
					
					// Keep ai variable in the vehicle to allow cleaning
					_vehicle setVariable ["my_solo_ai_gunner", _aiGunner, true];


					// Clean AI if it leave the vehicle
					_aiGunner addEventHandler ["GetOutMan", {
						params ["_unit", "_role", "_vehicle", "_turret"];

						//Clean AI
						if (!isNull _unit) then {
							deleteVehicle _unit; // Delete AI
						};
					}];
				};

				// 2. Give control to gunner
				_unit action ["TakeVehicleControl", _vehicle];
				
				//Move player to turret role to allow solo crew
				_unit action ["MoveToGunner", _vehicle];  
			};
		};
	}];

	// Clean when player leave vehicle
	player addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle", "_turret"];

		private _aiGunner = _vehicle getVariable ["my_solo_ai_gunner", objNull];
		if (!isNull _aiGunner) then {
			deleteVehicle _aiGunner; // Delete AI
			_vehicle setVariable ["my_solo_ai_gunner", nil, true];
		};
	}];
};


//Allow damage post respawn
sleep 30;
player allowDamage true;


