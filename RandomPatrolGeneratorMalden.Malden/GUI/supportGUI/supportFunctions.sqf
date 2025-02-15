//supportFunctions.sqf 
#include "..\botteamGUI\botteamFunctions.sqf"

doSupport = {
params ["_caller", "_supportType"];
	switch (_supportType) do
	{
		case "ReconIntel":
		{
			[[_caller, "HQ"], 'engine\objectiveManagement\revealMinorIntel.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
		};
		case "Reinforcement":
		{
			[_caller] spawn 
			{
				params ["_caller"];
				if (!(missionNamespace getVariable ["usedRespawnFewTimeAgo",false])) then 
				{
					if (count (allPlayers select {(alive _x) == false})!=0) then //Sorry for the test == false xD
					{
						//set morning
						skipTime 24;
						[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];

						//Send message to everyone
						[[_caller], {params ["_caller"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_REINFORCEMENT_CALL_2", name _caller] call doDialog}] remoteExec ["spawn", side _caller]; 
						
						missionNamespace setVariable ["usedRespawnFewTimeAgo",true,true];
						_respawnTimer = missionNamespace getVariable "missionRespawnParam";
						sleep _respawnTimer;
						missionNamespace setVariable ["usedRespawnFewTimeAgo",false,true];
					} else {
						[{["STR_RPG_HC_NAME", "STR_RPG_HC_REINFORCEMENT_CALL_NO_NEED", name _caller] call doDialog}] remoteExec ["call", _caller];
					};
				} else {
					[{["STR_RPG_HC_NAME", "STR_RPG_HC_REINFORCEMENT_CALL_WAIT"] call doDialog}] remoteExec ["call", _caller];
				};
			};
		};
		case "CallReinforcement":
		{
			[_caller] spawn 
			{
				params ["_caller"];
				[{["STR_RPG_HC_NAME", "STR_RPG_HC_SUPPORT_UNIT"] call doDialog}] remoteExec ["call", side _caller];

				_reinforcementSupportCounter = missionNamespace getVariable ["reinforcementSupportCounter", 0]; 
				missionNamespace setVariable ["reinforcementSupportCounter", _reinforcementSupportCounter+1, true];

				//Manage radio support 
				_reinforcementSupportID = _caller getVariable ["reinforcementSupportID", -1];

				if (_reinforcementSupportID == -1) then 
				{
					_reinforcementSupportID = [_caller, "myReinforcement"] call BIS_fnc_addCommMenuItem;
					_caller setVariable ["reinforcementSupportID", _reinforcementSupportID, true];
				};
			};
		};
		case "ForceReinforcement":
		{
			[_caller] spawn 
			{
				params ["_caller"];
				//set morning
				skipTime 24;

				[{["STR_RPG_HC_NAME", "STR_RPG_HC_REINFORCEMENT_CALL_3", name _caller] call doDialog}] remoteExec ["call", side _caller];

				[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
			};
		};
		case "Artillery":
		{
			[{["STR_RPG_HC_NAME", "STR_RPG_HC_ARTILLERY_READY"] call doDialog}] remoteExec ["call", side _caller];

			_supportArtilleryCounter = missionNamespace getVariable ["artlillerySupportCounter", 0]; 
			missionNamespace setVariable ["artlillerySupportCounter", _supportArtilleryCounter+1, true];

			//Manage radio support 
			_artillerySupportID = _caller getVariable ["artillerySupportID", -1];

			if (_artillerySupportID == -1) then 
			{
				_artillerySupportID = [_caller, "myArtillery"] call BIS_fnc_addCommMenuItem;
				_caller setVariable ["artillerySupportID", _artillerySupportID, true];
			};
		};
		case "Extract":
		{
			[{["STR_RPG_HC_NAME", "STR_RPG_HC_EXTRACT_UNIT"] call doDialog}] remoteExec ["call", side _caller];

			_supportextractCounter = missionNamespace getVariable ["extractSupportCounter", 0]; 
			missionNamespace setVariable ["extractSupportCounter", _supportextractCounter+1, true];

			//Manage radio support 
			_extractSupportID = _caller getVariable ["extractSupportID", -1];
			if (_extractSupportID == -1) then 
			{
				_extractSupportID = [_caller, "myExtract"] call BIS_fnc_addCommMenuItem;
				_caller setVariable ["extractSupportID", _extractSupportID, true];
			};
		};
		case "Transport":
		{
			[{["STR_RPG_HC_NAME", "STR_RPG_HC_TRANSPORT_UNIT"] call doDialog}] remoteExec ["call", side _caller];

			_supportTransportCounter = missionNamespace getVariable ["transportSupportCounter", 0]; 
			missionNamespace setVariable ["transportSupportCounter", _supportTransportCounter+1, true];

			//Manage radio support 
			_transportSupportID = _caller getVariable ["transportSupportID", -1];
			if (_transportSupportID == -1) then 
			{
				_transportSupportID = [_caller, "myTransport"] call BIS_fnc_addCommMenuItem;
				_caller setVariable ["transportSupportID", _transportSupportID, true];
			};
		};
		case "AirDrop":
		{
			[{["STR_RPG_HC_NAME", "STR_RPG_HC_LOGISTIC"] call doDialog}] remoteExec ["call", side _caller];

			_supportairDropCounter = missionNamespace getVariable ["airDropSupportCounter", 0]; 
			missionNamespace setVariable ["airDropSupportCounter", _supportairDropCounter+1, true];


			//Manage radio support 
			_airDropSupportID = _caller getVariable ["airDropSupportID", -1];
			if (_airDropSupportID == -1) then 
			{
				_airDropSupportID = [_caller, "myAirDrop"] call BIS_fnc_addCommMenuItem;
				_caller setVariable ["airDropSupportID", _airDropSupportID, true];
			};
		};
		case "HALOJump":
		{
			[_caller] spawn {
				params ["_caller"];
				//Click on map to Halo spawn
				selectedHaloLoc = [0,0,0];
				openMap true;
				uiSleep 1;
				["<t color='#ffffff' size='.8'>Click on map to spawn Halo jump<br />Your backpack will be saved</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					_caller setPos selectedHaloLoc;

					//Halo jump script of pierremgi
					player setpos (getpos player vectorAdd [0,0,1000]);
					0 = player spawn {
						private _plyr = _this;
						private "_whs";
						_plyr setVariable ["bpk",unitBackpack _plyr];
						_bpktype = backpack _plyr;
						if (_bpktype != "") then {
							_whs = createVehicle ["WeaponHolderSimulated_Scripted",[0,0,0],[],0,"can_collide"];
							_plyr action ["DropBag", _whs, _bpktype];
							_plyr addBackpackGlobal "B_parachute";

							waitUntil {0.5; !isNull objectParent _plyr or (position _plyr)#2<0.6}; 
							waitUntil {0.5; isNull objectParent _plyr or (position _plyr)#2<0.6};

							uiSleep 0.5;
							if (!isNull _whs) then {
								_plyr action ["AddBag",objectParent (_plyr getVariable "bpk"), _bpktype];
								_plyr setVariable ["bpk",nil];
								uiSleep 3;
								deleteVehicle _whs;
							};
						} else 
						{
							_plyr addBackpackGlobal "B_parachute";
						};
					};

					[format ["In the %1 airspace", worldName], format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;
				};
			};

			//Close support menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
		};
		case "MassiveHALOJump":
		{
			[_caller] spawn {
				params ["_caller"];
				//Click on map to Halo spawn
				selectedHaloLoc = [0,0,0];
				openMap true;
				uiSleep 1;
				["<t color='#ffffff' size='.8'>Click on map to spawn Halo jump<br />Your backpack will be saved</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					_playerNearby = allPlayers select {(_x distance _caller)<30};

					{
						_currentPlayer = _x;
						_currentPlayer setPos ([[[selectedHaloLoc, 15]], []] call BIS_fnc_randomPos);

						//Halo jump script of pierremgi
						_currentPlayer setpos (getpos _currentPlayer vectorAdd [0,0,1000]);
						0 = _currentPlayer spawn {
							private _plyr = _this;
							private "_whs";
							_plyr setVariable ["bpk",unitBackpack _plyr];
							_bpktype = backpack _plyr;
							if (_bpktype != "") then {
								_whs = createVehicle ["WeaponHolderSimulated_Scripted",[0,0,0],[],0,"can_collide"];
								_plyr action ["DropBag", _whs, _bpktype];
								_plyr addBackpackGlobal "B_parachute";

								waitUntil {0.5; !isNull objectParent _plyr or (position _plyr)#2<0.6}; 
								waitUntil {0.5; isNull objectParent _plyr or (position _plyr)#2<0.6};

								uiSleep 0.5;
								if (!isNull _whs) then {
									_plyr action ["AddBag",objectParent (_plyr getVariable "bpk"), _bpktype];
									_plyr setVariable ["bpk",nil];
									uiSleep 3;
									deleteVehicle _whs;
								};
							} else 
							{
								_plyr addBackpackGlobal "B_parachute";
							};
						};

						[format ["In the %1 airspace", worldName], format ["Year %1", date select 0], mapGridPosition _currentPlayer] spawn BIS_fnc_infoText;
					} foreach _playerNearby;
				};
			};

			//Close support menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
		};
		case "TacInsert":
		{
			[_caller] spawn {
				params ["_caller"];
				//Click on map to do a tactical insert
				selectedHaloLoc = [0,0,0];
				openMap true;
				uiSleep 1;
				["<t color='#ffffff' size='.8'>Click on map do a tactical insertion<br />All players around you will will be moved</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{	
					//Get all players near the caller
					_playerNearby = allPlayers select {(_x distance _caller)<30};

					//Move all players nearby
					{
						[1,["", "BLACK IN", 2]] remoteExec ["cutText", _x];
						_x setPos ([[[selectedHaloLoc, 15]], []] call BIS_fnc_randomPos);
					} foreach _playerNearby;
				};
			};

			//Close support menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
		};
		case "Tent":
		{
			[_caller] spawn {
				params ["_caller"];
				//Click on map to do a tactical insert
				//Last test to check if the tent is still avalaible
				_tentFOBLocation = missionNamespace getVariable [format ['bluforPositionAdvancedRespawn%1', str (group _caller)], [0,0,0]];
				if (playerSide == blufor && !([_tentFOBLocation, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					_advFOBLocation = missionNamespace getVariable [format ['bluforPositionAdvancedRespawn%1', str (group _caller)], [0,0,0]];
					_caller setPos _advFOBLocation;

					["Respawn on group tent position", format ["Year %1", date select 0], mapGridPosition _caller] spawn BIS_fnc_infoText;
				} else 
				{
					cutText ["There is no tent setup for your group", "PLAIN", 0.3];
				};
			};

			//Close support menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
			
		};
		case "attackSquad":
		{
			[_caller] spawn {
				params ["_caller"];
				//Click on map to do a tactical insert
				selectedHaloLoc = [0,0,0];
				openMap true;
				uiSleep 1;
				["<t color='#ffffff' size='.8'>Click on map do a tactical insertion<br />Select a position it will be attacked in 10 minutes</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{	
					_missionDifficulty = missionNamespace getVariable ["missionDifficultyParam", 1];
					for [{_iteration = 0}, {_iteration < _missionDifficulty}, {_iteration = _iteration + 1}] do
					{	
						//Spawn attack squad
						_allyGroup = [_caller, selectedHaloLoc, side _caller] call doSpawnAttackSquad;


						//Clean bots after attack
						{
							[_x] spawn 
							{	
								params ["_bot"];

								//Delete bot the optimize server after 30 minutes
								sleep 2500;
								deleteVehicle _bot;
							};
						}	foreach (units _allyGroup);
					};
				};
			};

			//Close support menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
		};
		case "DroneRecon":
		{
			[_caller] spawn {
				params ["_caller"];
				//Click on map to Halo spawn
				selectedHaloLoc = [0,0,0];
				openMap true;
				uiSleep 1;
				["<t color='#ffffff' size='.8'>Click on map to recon with a drone<br /></t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					
					private _savingEnabled = savingEnabled;
					_handle = [selectedHaloLoc, "", 250, 250, 75, 1, [], 0, true] spawn BIS_fnc_establishingShot;
					[_handle, _savingEnabled] spawn { 
						params ["_process", "_savingMode"];
						waitUntil { scriptDone _process }; 
						enableSaving [_savingMode, false];
						hint "Find script";
					 };
				};
			};

			//Close support menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
		};
		default
		{
			//Do nothing
		};
	};
};

addSupportOption = {
	params ["_ctrl", "_supportName", "_supportNameCode", "_supportIcon", "_price", "_supportType"];

	//Add row for support
	_ind = _ctrl lnbAddRow ["", _supportName, _supportType, str _price];

	//Set picture
	_ctrl lnbSetPicture [[_ind, 0], _supportIcon];

	//Set data
	_ctrl lnbSetData [[_ind, 0], _supportNameCode];
	_ctrl lnbSetData [[_ind, 1], _supportNameCode];
	_ctrl lnbSetData [[_ind, 2], str _price];
};


addSupportForIntel = {
	params ["_ctrl"];
	//Add support for INTEL
	_price = 25;
	_supportName = localize "STR_GUI_SUPPORT_RECON";
	_supportNameCode = "ReconIntel";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_RECON";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForReinforcement = {
	params ["_ctrl"];
	//Add support for respawn
	_price = 0;
	_supportName = format ["%2 (avalaible every %1 seconds)", missionNamespace getVariable "missionRespawnParam", localize "STR_GUI_SUPPORT_REINFORCEMENT_NOW"];
	_supportNameCode = "Reinforcement";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_REINFORCEMENT";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addCallForReinforcement = {
	params ["_ctrl"];
	//Add support for respawn with radio
	_price = 600;
	_supportName = localize "STR_GUI_SUPPORT_REINFORCEMENT_RADIO";
	_supportNameCode = "CallReinforcement";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_REINFORCEMENT";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForForceReinforcement = {
	params ["_ctrl"];
	//Add support for instant respawn
	_price = 500;
	_supportName = localize "STR_GUI_SUPPORT_FORCE_REINFORCEMENT_NOW";
	_supportNameCode = "ForceReinforcement";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_REINFORCEMENT";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForArtillery = {
	params ["_ctrl"];
	//Add support for friendly artillery
	_price = 200;
	_supportName = localize "STR_GUI_SUPPORT_ARTILLERY";
	_supportNameCode = "Artillery";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_ARTILLERY";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForHALO = {
	params ["_ctrl"];
	//Add support for Halo jump
	_price = 0;
	_supportName = localize "STR_GUI_SUPPORT_HALO";
	_supportNameCode = "HALOJump";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_MOVE";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};


addSupportForMassiveHALO = {
	params ["_ctrl"];
	//Add support for Halo jump
	_price = 300;
	_supportName = localize "STR_GUI_SUPPORT_MASSIVE_HALO";
	_supportNameCode = "MassiveHALOJump";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa";
	_supportType = "Movement";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForTent = {
	params ["_ctrl"];
	//Add support for reinforcement tent
	_price = 0;
	_supportName = localize "STR_GUI_SUPPORT_TENT";
	_supportNameCode = "Tent";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_MOVE";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForTacInsert = {
	params ["_ctrl"];
	//Add support for tactical insertion (group teleportation)
	_price = 500;
	_supportName = localize "STR_GUI_SUPPORT_TAC_INS";
	_supportNameCode = "TacInsert";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_MOVE";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addAttackSquad = {
	params ["_ctrl"];
	//Add support for friendly squad
	_price = 500;
	_supportName = localize "STR_GUI_SUPPORT_ATTACK_SQUAD";
	_supportNameCode = "attackSquad";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_ATTACK";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForExtract = {
	params ["_ctrl"];
	//Add support for extract chopper
	_price = 200;
	_supportName = localize "STR_GUI_SUPPORT_EXTRACT_CHOPPER";
	_supportNameCode = "Extract";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_MOVE";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForTransport = {
	params ["_ctrl"];
	//Add support for Transport
	_price = 300;
	_supportName = localize "STR_GUI_SUPPORT_TRANSPORT_CHOPPER";
	_supportNameCode = "Transport";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_MOVE";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForAirDrop = {
	params ["_ctrl"];
	//Add support for Air drop
	_price = 200;
	_supportName = localize "STR_GUI_SUPPORT_SUPPLY_DROP";
	_supportNameCode = "AirDrop";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_LOGISTIC";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};


addSupportForDroneRecon = {
	params ["_ctrl"];
	//Add support for Air drop
	_price = 100;
	_supportName = localize "STR_GUI_SUPPORT_RECON_DRONE";
	_supportNameCode = "DroneRecon";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = localize "STR_GUI_SUPPORT_CAT_RECON";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};