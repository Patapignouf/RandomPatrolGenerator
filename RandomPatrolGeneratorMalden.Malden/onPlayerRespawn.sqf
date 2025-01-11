player setUnitLoadout (player getVariable "spawnLoadout");

//reset respawn timer
setPlayerRespawnTime (missionNamespace getVariable "missionRespawnParam");

//Setup respawn GUI
cutText ["", "BLACK FADED", 4];
uiSleep 3;
[[], 'GUI\respawnGUI\initPlayerRespawnMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];

//Make the player doesn't count on RTB for 60 secs 
player setVariable ["canRTB", false, true];
[] spawn 
{
	uiSleep 60;
	player setVariable ["canRTB", true, true];
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



//Hide HUD group to debug the UI after death
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
//#####

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
		},_x,0,true,false,"","(_target distance _this <3) && (_target getVariable ['isAdmin', false] || (hasInterface && isServer))", 50, true];
	};
};

//Default respawn 
//Remove player name from the dead player's list
_deadPlayerList = missionNamespace getVariable "deadPlayer";
_deadPlayerList = _deadPlayerList - [name player];
missionNamespace setVariable ["deadPlayer", _deadPlayerList, true];

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
["Respawn on start position", format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;


if (missionNameSpace getVariable ["enableAdvancedRespawn", 1] == 1) then 
{
	//Add vehicle shop
	player addAction [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep_ca.paa'/><t size='1'>Place reinforcement tent</t>"],{
		//Define parameters
		params ["_object","_caller","_ID","_avalaibleVehicle"];

		missionNameSpace setVariable [format ['bluforAdvancedRespawn%1', str (group _caller)], false, true];
		missionNameSpace setVariable [format ['bluforPositionAdvancedRespawn%1', str (group _caller)], getPos _object, true];

		//Create tent
		_createTent = createVehicle ["Land_TentDome_F", [getPos _caller, 1, 5, 3, 0, 20, 0, [], [getPos _caller, getPos _caller]] call BIS_fnc_findSafePos, [], 0, "NONE"];
		_createTent setVariable [str (group _caller), true, true];

		[{["STR_RPG_HC_NAME", "STR_RPG_HC_RESPAWN_TENT"] call doDialog}] remoteExec ["call", units (group _caller)];

		[[str (group _caller), _createTent,"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa" , [0,0,1,1]], 'GUI\3DNames\3DObjectNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];

		//Add support action on tent
		_createTent addAction ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>Open support shop</t>",{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			[[false], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
		},_x,3,true,false,"","(_target distance _this <5) && (_target getVariable [str (group _this), false])"];

		//Create action to authorize tent disassembly
		[
			_createTent, 
			"Disassemble tent", 
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", 
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", 
			"(_this distance _target < 3) && (_this getVariable 'role' == 'leader') && (vehicle _this == _this)",
			"true", 
			{
				// Action start code
			}, 
			{
				// Action on going code
			},  
			{
				// Action successfull code
				params ["_object","_caller","_ID","_param"];

				//If the tent is on your squad
				if (_object getVariable [str (group _caller), false]) then 
				{
					//delete the tent and allow leader to place another one
					deleteVehicle _object;
					missionNameSpace setVariable [format ['bluforAdvancedRespawn%1', str (group _caller)], true, true];
					missionNameSpace setVariable [format ['bluforPositionAdvancedRespawn%1', str (group _caller)], [0,0,0], true];
				} else 
				{
					cutText ["This is not your tent", "PLAIN", 0.3];
				};
			}, 
			{
				// Action failed code
			}, 
			[],  
			2,
			1000, 
			false,
			false
		] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

	},_x,3,true,false,"","(_this getVariable 'role' == 'leader') && (missionNameSpace getVariable [ format ['bluforAdvancedRespawn%1', str (group _this)], true]) && (vehicle _this == _this)"];
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
			//Reward PvP kill
			_distance = _instigator distance _unit;
			if (_distance<100 || _distance>5000) then {_distance = nil};
			[[_distance], {params ["_distance"]; [1, "RPG_ranking_infantry_kill", _distance] call doUpdateRank}] remoteExec ["spawn", _instigator]; 
		} else 
		{
			
			[[_unit, _instigator], {params ["_unit", "_instigator"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_TEAMKILL", name _unit, name _instigator] call doDialog}] remoteExec ["spawn", side _instigator]; 

			if (_instigator != _unit) then 
			{
				[{[-50,5] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];
			};
		};
	};
}];
player setVariable ["KilledEH", _KilledEH, true];

//Allow damage post respawn
sleep 30;
player allowDamage true;