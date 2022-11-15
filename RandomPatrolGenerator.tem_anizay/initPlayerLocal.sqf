#include "database\arsenalLibrary.sqf"
#include "objectGenerator\vehicleManagement.sqf"

bluFaction = "BluFaction" call BIS_fnc_getParamValue;
indFaction = "IndFaction" call BIS_fnc_getParamValue;
enableThermal = "EnableThermal" call BIS_fnc_getParamValue;
enablePlane = "EnablePlane" call BIS_fnc_getParamValue;
enableArmedChopper = "EnableArmedChopper" call BIS_fnc_getParamValue;
enableHalo = "EnableHALO" call BIS_fnc_getParamValue;
enableArmored = "EnableArmored" call BIS_fnc_getParamValue;
initBluforBase = "InitBluforBase" call BIS_fnc_getParamValue;
chooseStartPos = "ChooseStartPos" call BIS_fnc_getParamValue;

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


if (hasInterface) then
{
	diag_log format ["Setup Player %1 at position 1", name player];

	if (side player == independent) then 
	{
		player createDiarySubject ["RPG", "Random Patrol Generator"];
		player createDiaryRecord ["RPG", ["Random Patrol Generator objectives", "Help the people in the town. Complete the tasks assigned to your unit to finish the mission. 
		"]];
		_diaryIntel = player createDiaryRecord ["RPG", ["Random Patrol Generator intel", "You can see here all intels collected : <br/>"]];
		player setVariable ["diaryIntel", _diaryIntel];

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
		player setPos ([getPos initCityLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);

		//Manage loadout
		player setUnitLoadout ([player,indFaction] call getLoadoutByRole);
		[player] call adjustLoadout;
		player setVariable ["spawnLoadout", getUnitLoadout player];

		//Manage arsenal	
		[VA1, player, indFaction] call setupArsenalToItem;
		[VA1, player, indFaction] call setupRoleSwitchToItem;
		[VA1, player] call setupSaveAndLoadRole;

		waituntil {!isNil "isBluforAttacked" && !isNil "isIndAttacked"};
		if (isIndAttacked) then
		{
				[["Vos informateurs vous informent qu'une attaque est en cours sur votre position.",independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
				[["Le QG vous informe qu'une attaque est probablement en cours sur la ville alliée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
	};

	if (side player == blufor) then
	{
		//Setup briefing 
		player createDiarySubject ["RPG", "Random Patrol Generator"];
		player createDiaryRecord ["RPG", ["Random Patrol Generator objectives", "Help the independent town located on your map. Complete the tasks assigned to your unit to finish the mission.
		"]];
		_diaryIntel = player createDiaryRecord ["RPG", ["Random Patrol Generator intel", "You can see here all intels collected : <br/>"]];
		player setVariable ["diaryIntel", _diaryIntel];


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
		player setPos ([initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		player setUnitLoadout ([player, bluFaction] call getLoadoutByRole);
		[player] call adjustLoadout;
		player setVariable ["spawnLoadout", getUnitLoadout player];

		//Manage arsenal	
		[VA2, player, bluFaction] call setupArsenalToItem;
		[VA2, player, bluFaction] call setupRoleSwitchToItem;
		[VA2, player] call setupSaveAndLoadRole;

		//Manage vehicle spawn options 
		if (enableArmored == 1) then 
		{	
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
						[initBlueforLocation, [_avalaibleVehicle], 30, 100] call doGenerateVehicleForFOB;	
						missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter-1, true];
						hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforVehicleAvalaibleSpawnCounter-1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
					} else 
					{
						hint "You don't have enough advanced vehicle spawned credit left.";
					};
			},_x,1.5,true,false,"","_target distance _this <5"];
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
					[initBlueforLocation, [_avalaibleVehicle], 30, 100] call doGenerateVehicleForFOB;	
					missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter-1, true];
					hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter-1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
				} else 
				{
					hint "You don't have enough advanced vehicle spawned credit left.";
				};
			},_x,1.5,true,false,"","_target distance _this <5"];
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
					[initBlueforLocation, [_avalaibleVehicle], 30, 100] call doGenerateVehicleForFOB;	
					missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter-1, true];
					hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter-1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
				} else 
				{
					hint "You don't have enough advanced vehicle spawned credit left.";
				};
			},_x,1.5,true,false,"","_target distance _this <5"];
		} foreach bluforUnarmedVehicleChopper; 

		//Armed Chopper
		waitUntil {!isNil "bluforArmedChopper"};
		if (initBluforBase == 1 && enableArmedChopper == 1) then 
		{	
			{
				_IDVehicleSpawn = TPFlag1 addAction [format ["Spawn a %1", getText (configFile >> "cfgVehicles" >> _x >> "displayName")],{
					//Define parameters
					params ["_object","_caller","_ID","_avalaibleVehicle"];

					//Check players credit
					bluforAdvancedVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforAdvancedVehicleAvalaibleSpawn";
					if (bluforAdvancedVehicleAvalaibleSpawnCounter > 0) then 
					{
						[initBlueforLocation, [_avalaibleVehicle], 30, 100] call doGenerateVehicleForFOB;	
						missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", bluforAdvancedVehicleAvalaibleSpawnCounter-1, true];
						hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter - 1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
					} else 
					{
						hint "You don't have enough advanced vehicle spawned credit left.";
					};
				},_x,1.5,true,false,"","_target distance _this <5"];
			} foreach bluforArmedChopper; 
		};

		
		//Manage vehicle spawn options 
		waitUntil {!isNil "bluforFixedWing"};
		if (enablePlane == 1) then 
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
							hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", bluforAdvancedVehicleAvalaibleSpawnCounter-1, getText (configFile >> "cfgVehicles" >> _avalaibleVehicle >> "displayName")];
						};
					} else 
					{
						hint "You don't have enough advanced vehicle spawned credit left.";
					};
				},_x,1.5,true,false,"","_target distance _this <5"];
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
			},o,1.5,true,false,"","_target distance _this <5"];
		};

		waituntil {!isNil "isBluforAttacked" && !isNil "isIndAttacked"};
		if (isBluforAttacked) then
		{
				//There's an issue : this message will erase the first one for Blufor
				[["Le QG vous informe qu'une attaque est possiblement en cours sur vos positions dans quelques de minutes, quittez les lieux avant leur arrivée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
	};
};

[] spawn _generateCivDialogs;

//Let's get it started !
player allowdamage true;
titleCut ["", "BLACK IN", 5];


//If a player join in progress he will be teleported to his teamleader (WIP feature)
if (didJIP) then 
{
	//Check if player is trying to respawn by deco/reco method
	_deadPlayerList = missionNamespace getVariable "deadPlayer";
	if (count (_deadPlayerList select { _x == (name player) }) == 0) then 
	{
		player setPos (getPos (leader (group player)));
	} else 
	{
		player setPos [0,0];
		player setDamage 1;
	};
};