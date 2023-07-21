disableSerialization;
#include "..\..\database\factionParameters.sqf"

//Create GUI
cutText ["", "BLACK FADED", 100];
createDialog "playerRespawnMenu";

//Specify all GUI items
//Define a comboBox foreach faction
private _mainDisplay = (findDisplay 8000);
private _buttonRespawnStart = _mainDisplay displayCtrl 8200;

//Faction params
bluFaction = missionNamespace getVariable "bluforFaction";
indFaction = missionNamespace getVariable "independentFaction";
player setVariable ["isInRespawnMenu", true, true];
normalClose = false;

//Function params
_buttonRespawnStart ctrlAddEventHandler[ "ButtonClick", 
	{ 
		if (player getVariable "sideBeforeDeath" == "independent") then 
		{
			//Independent
			player setPos ([initCityLocation, 1, 30, 1, 0, 30, 0, [], [initCityLocation, initCityLocation]] call BIS_fnc_findSafePos);
		} else 
		{
			//Blufor
			if (isNil "USS_FREEDOM_CARRIER") then 
			{
				_spawnPos = [initBlueforLocation, 1, 30, 1, 0, 30, 0, [], [initBlueforLocation, initBlueforLocation]] call BIS_fnc_findSafePos;
				player setPos (_spawnPos);
			} else 
			{
				_spawnPos = initBlueforLocation;
				player setPosASL [_spawnPos#0 + random 30,_spawnPos#1+random 30,_spawnPos#2+0.5];
			};
		};
		["Respawn on start position", format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;

		//Initialize player
		[] call doInitializePlayer;

		normalClose = true;	

		//Close dialog
		(findDisplay 8000) closeDisplay 1;
	}];


//Add respawn option
_coordinateX = 0.50 * safezoneW + safezoneX;
_coordinateY = 0.17 * safezoneH + safezoneY;
_weight = 0.2* safezoneW;
_height = 0.02 *safezoneH;
_ypading = 0.06;

// x = GUI_GRID_CENTER_X + 25 * GUI_GRID_CENTER_W;
// y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
// w = 10 * GUI_GRID_CENTER_W;
// h = 1 * GUI_GRID_CENTER_H;
avalaiblePlayer = player;
{
	avalaiblePlayer = _x;

	_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", -1];
	_RcsButtonObjective ctrlSetText format ["Respawn on %1", name avalaiblePlayer];

	_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
	_RcsButtonObjective ctrlCommit 0;
	_RcsButtonObjective ctrlSetTextColor [1, 1, 1, 1];
	_RcsButtonObjective setVariable ["playerValue", avalaiblePlayer];

	_coordinateY = _coordinateY + _ypading;
	
	_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
	{
		params ["_ctrl"];
		normalClose = true;
		_currentRespawnPlayer = _ctrl getVariable "playerValue";
			
		//SetPlayer position on leader position if it is on vehicle
		if !(player moveInAny (vehicle _currentRespawnPlayer)) then 
		{
			//Leader on vehicle with empty space
			_tempPos = getPosASL _currentRespawnPlayer;
			player setPosASL _tempPos;
		};

		[format ["Respawn on %1", name _currentRespawnPlayer], format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;

		//Initialize player
		[] call doInitializePlayer;

		//Close dialog
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;
	}];
} foreach ((allPlayers - [player]) select {alive _x && side _x isEqualTo (side player) && !(_x getVariable ["isInRespawnMenu",false])}) ;



doInitializePlayer = {
		//Enable gameplay for player
		player allowdamage true;
		player enableSimulationGlobal true;
		player hideObjectGlobal false;
		player setVelocity [0, 0, 0];
		cutText ["", "BLACK IN", 5];

		//Remove player name from the dead player's list
		_deadPlayerList = missionNamespace getVariable "deadPlayer";
		_deadPlayerList = _deadPlayerList - [name player];
		missionNamespace setVariable ["deadPlayer", _deadPlayerList, true];
};

//Disable space button in dialog
waituntil {(IsNull (findDisplay 8000))};

//Player is not in respawn menu anymore an can be use as respawn player
player setVariable ["isInRespawnMenu", false, true];

//If the control is closed by bug, set normal respawn
if (!normalClose) then 
{
	//Respawn on start position by default
	if (player getVariable "sideBeforeDeath" == "independent") then 
	{
		//Independent
		player setPos ([initCityLocation, 1, 30, 1, 0, 30, 0, [], [initCityLocation, initCityLocation]] call BIS_fnc_findSafePos);
	} else 
	{
		//Blufor
		if (isNil "USS_FREEDOM_CARRIER") then 
		{
			_spawnPos = [initBlueforLocation, 1, 30, 1, 0, 30, 0, [], [initBlueforLocation, initBlueforLocation]] call BIS_fnc_findSafePos;
			player setPos (_spawnPos);
		} else 
		{
			_spawnPos = initBlueforLocation;
			[USS_FREEDOM_CARRIER] call BIS_fnc_Carrier01Init;
			player setPosASL [_spawnPos#0 + random 30,_spawnPos#1+random 30,_spawnPos#2+0.5];
		};
	};
	["Respawn on start position", format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;

	//Initialize player
	[] call doInitializePlayer;
};

