disableSerialization;
#include "..\..\database\factionParameters.sqf"

//Create GUI
cutText ["", "BLACK FADED", 100];
createDialog "playerRespawnMenu";

//Specify all GUI items
//Define a comboBox foreach faction
private _mainDisplay = (findDisplay 8000);
private _buttonRespawnStart = _mainDisplay displayCtrl 8200;
private _buttonRespawnLeader = _mainDisplay displayCtrl 8201;

//Faction params
bluFaction = missionNamespace getVariable "bluforFaction";
indFaction = missionNamespace getVariable "independentFaction";
normalClose = false;

//Function params
_buttonRespawnStart ctrlAddEventHandler[ "ButtonClick", 
	{ 
		if (player getVariable "sideBeforeDeath" == "independent") then 
		{
			//Independent
			player setPos ([getPos initCityLocation, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		} else 
		{
			//Blufor
			if (isNil "USS_FREEDOM_CARRIER") then 
			{
				_spawnPos = [initBlueforLocation, 1, 15, 3, 0, 20, 0] call BIS_fnc_findSafePos;
				player setPos (_spawnPos);
			} else 
			{
				_spawnPos = initBlueforLocation;
				player setPosASL _spawnPos;
			};
		};
		["Respawn on start position", format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;

		//Initialize player
		[] call doInitializePlayer;

		normalClose = true;	

		//Close dialog
		(findDisplay 8000) closeDisplay 1;
	}];

_buttonRespawnLeader ctrlAddEventHandler[ "ButtonClick", 
	{ 
		
		//teleport player to another player with same side
		//Respawn on teamleader
		_tempLeader = ((allPlayers - [player]) select {alive _x && side _x isEqualTo (side player) && _x getVariable "role" == "leader"});
		
		//If no teamleader is avalaible respawn on another player
		if (count _tempLeader == 0) then 
		{
			_tempLeader = ((allPlayers - [player]) select {alive _x && side _x isEqualTo (side player)});
		};

		//SetPlayer position on leader position if it is on vehicle
		if !(player moveInAny (vehicle (_tempLeader select 0))) then 
		{
			//Leader on vehicle with empty space
			_tempPos = getPosASL (_tempLeader select 0);
			player setPosASL _tempPos;
		};

		["Respawn on teamleader", format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;

		//Initialize player
		[] call doInitializePlayer;
		
		normalClose = true;

		//Close dialog
		(findDisplay 8000) closeDisplay 1;
	}];


doInitializePlayer = {
		//Enable gameplay for player
		player allowdamage true;
		player enableSimulationGlobal true;
		player hideObjectGlobal false;
		cutText ["", "BLACK IN", 5];

		//Remove player name from the dead player's list
		_deadPlayerList = missionNamespace getVariable "deadPlayer";
		_deadPlayerList = _deadPlayerList - [name player];
		missionNamespace setVariable ["deadPlayer", _deadPlayerList, true];
};

//Disable space button in dialog
waituntil {(IsNull (findDisplay 8000))};
			
//If the control is closed by bug, set normal respawn
if (!normalClose) then 
{
	//Respawn on start position by default
	if (player getVariable "sideBeforeDeath" == "independent") then 
	{
		//Independent
		player setPos ([getPos initCityLocation, 1, 30, 1, 0, 30, 0, [], [getPos initCityLocation, getPos initCityLocation]] call BIS_fnc_findSafePos);
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
			player setPosASL [_spawnPos#0,_spawnPos#1,_spawnPos#2+0.5];
		};
	};
	["Respawn on start position", format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;

	//Initialize player
	[] call doInitializePlayer;
};

