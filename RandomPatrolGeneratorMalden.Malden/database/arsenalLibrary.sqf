#include "classConstant.sqf"
#include "itemdb.sqf"

//Import mission params
warEra = missionNamespace getVariable "warEra"; // Default actual warfare

loadoutSaveName = "RPG_%1_%2_%3";

if (ironMan) then 
{
	loadoutSaveName = "RPG_ironMan_%1_%2_%3";
};

getLoadoutByRole = {
	params ["_currentPlayer", "_currentFaction"];

	_currentPlayerClass = _currentPlayer getVariable "role";
	_thisloadout = [];
	//Need to adapt a little thing to allow default loadout when there's no loadout found
	_thisloadout = ((loadout_db select {_x select 1 == _currentFaction}) select 0 select 0) select {_x select 0 == _currentPlayerClass} select 0 select 1;
	diag_log format ["Player %1 with role %2 has loadout %3", name _currentPlayer, _currentPlayerClass,_thisloadout ];
	_thisloadout
};

getVirtualWeaponList = {
	params ["_currentPlayer", "_currentFaction"];

	_currentPlayerClass = _currentPlayer getVariable "role";
	_virtualWeaponList = [];

	switch (_currentPlayerClass) do
	{
		case c_leader:
			{
				_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (smgList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};
		case c_at:
			{
				_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (smgList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (launcherList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};
		case c_rifleman:
			{
				_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (smgList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};
		case c_engineer:
			{
				_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (smgList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};
		case c_autorifleman:
			{
				_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (autorifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};
		case c_marksman;
		case c_sniper: 
			{
				_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (marksmanrifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};
		case c_medic:
			{
				_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (smgList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};	
		case c_grenadier:
			{
				_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualWeaponList = _virtualWeaponList + (grenadeLauncherList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};				
		default
			{
				//Non implemented role : Default rifle
			 	_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == _currentFaction} select 0 select 0); 
			};
	};
	diag_log format ["Player %1 with role %2 has access to weapons %3", name _currentPlayer, _currentPlayerClass,_virtualWeaponList ];
	_virtualWeaponList
};


getItembyWarEra = {
	params ["_warEra","_currentPlayer"];
	_itemList = [];

	switch (_warEra) do
	{
		//2nd War
		case 0:
		{
			_itemList = ["ACE_Sandbag_empty","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_EarPlugs"];
		};
		//Cold War
		case 1:
		{
			_itemList = ["ACE_Sandbag_empty","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_itemList pushBack "TFAR_anprc152";
			} ;
		};
		//Modern Warfare
		case 2:
		{
			_itemList = ["ACE_Sandbag_empty","ItemGPS","ACE_DAGR","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_itemList pushBack "TFAR_anprc152";
			} ;
		};
		//Actual Warfare
		case 3:
		{
			_itemList = ["ACE_Sandbag_empty","ItemGPS", "ACE_DAGR", "ACE_microDAGR","B_UavTerminal","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_itemList pushBack "TFAR_anprc152";
			} ;
		};
		//Future Warfare
		case 4:
		{
			_itemList = ["ACE_Sandbag_empty","ItemGPS","ACE_DAGR", "ACE_microDAGR","B_UavTerminal","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_itemList pushBack "TFAR_anprc152";
			} ;
		};
		default
		{
			
		};
	};

	diag_log format ["itemList : %1", _itemList];
	_itemList
};

getVirtualItemList = {
	params ["_currentPlayer","_currentFaction"];
	currentPlayerClass = _currentPlayer getVariable "role";
	virtualItemList = [warEra, _currentPlayer] call getItembyWarEra;
	diag_log format ["virtualItemList : %1", virtualItemList];
	switch (currentPlayerClass) do
	{
		case c_medic:
			{
				virtualItemList = virtualItemList + (itemList_db select {_x select 1  == _currentFaction} select 0 select 0);
				virtualItemList = virtualItemList + (itemMedicList_db select {_x select 1  == _currentFaction} select 0 select 0);
				virtualItemList = virtualItemList + (factionDefaultRadios_db select {_x select 1  == _currentFaction} select 0 select 0); 
				virtualItemList = virtualItemList + basicItemsList;
				virtualItemList = virtualItemList + basicMedicItems;
			};			
		case c_engineer:	
			{
				virtualItemList = virtualItemList + (itemList_db select {_x select 1  == _currentFaction} select 0 select 0);
				virtualItemList = virtualItemList + (itemEngineerList_db select {_x select 1  == _currentFaction} select 0 select 0);
				virtualItemList = virtualItemList + (factionDefaultRadios_db select {_x select 1  == _currentFaction} select 0 select 0); 
				virtualItemList = virtualItemList + basicItemsList;
				virtualItemList = virtualItemList + basicEngineerItems;
			};		
		default 
			{
				//Default item list
			 	virtualItemList = virtualItemList + (itemList_db select {_x select 1  == _currentFaction} select 0 select 0); 
				virtualItemList = virtualItemList + (factionDefaultRadios_db select {_x select 1  == _currentFaction} select 0 select 0); 
				virtualItemList = virtualItemList + basicItemsList;
			};
	};
	diag_log format ["Player %1 with role %2 has access to items %3", name _currentPlayer, currentPlayerClass, virtualItemList ];
	virtualItemList
};


getVirtualUniform = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualUniformList = [warEra, currentPlayer] call getItembyWarEra;
	diag_log format ["virtualUniformList : %1", virtualUniformList];
	switch (currentPlayerClass) do
	{
		case c_leader:
			{
				//add leader uniform
				virtualUniformList = virtualUniformList + (uniformList_db select {_x select 1  == currentFaction} select 0 select 0);
			};			
		case c_sniper:	
			{
				//add ghilie to the uniform list
				virtualUniformList = virtualUniformList + (uniformList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualUniformList = virtualUniformList + (uniformListSniper_db select {_x select 1  == currentFaction} select 0 select 0);
			};		
		default 
			{ 
				//Default uniform list
				virtualUniformList = virtualUniformList + (uniformList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
	};
	diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass,virtualUniformList ];
	virtualUniformList
};


getVirtualAttachement = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualAttachementList = [];

	switch (currentPlayerClass) do
	{
		case c_marksman;
		case c_sniper:		
			{
				virtualAttachementList = virtualAttachementList + (attachmentShortList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualAttachementList = virtualAttachementList + (attachmentLongList_db select {_x select 1  == currentFaction} select 0 select 0);
			};		
		default 
			{ 
				//Default attachment list
				virtualAttachementList = virtualAttachementList + (attachmentShortList_db select {_x select 1  == currentFaction} select 0 select 0); 
			};
	};
	diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass, virtualAttachementList ];
	virtualAttachementList
};


getVirtualBackPack = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualBackpackList = [];

	switch (currentPlayerClass) do
	{
		default 
			{ 
				//Default backpack list
				virtualBackpackList = virtualBackpackList + (backPackList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
	};
	diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass, virtualBackpackList ];
	virtualBackpackList
};

getVirtualMagazine = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentWeaponList = _this select 2;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualMagazineList = [];

	//Faction Magazine list
	virtualMagazineList = virtualMagazineList + (magazineList_db select {_x select 1  == currentFaction} select 0 select 0);

	switch (currentPlayerClass) do
	{
		//Add default weapon magazine
		case c_autorifleman:
			{
				{
					_currentWeaponMagazineList = getArray (configfile >> "CfgWeapons" >> _x >> "magazines");
					if (count _currentWeaponMagazineList != 0) then 
					{
						_currentWeapon = _x;
						{
							if ((virtualMagazineList) findIf {_currentWeapon == (_x)} == -1) then 
							{
								if (!([_x] call isBannedItem)) then 
								{
									virtualMagazineList pushBack _x;
								};
							};
						} foreach _currentWeaponMagazineList;
					};
				} foreach currentWeaponList;
			};
		default 
			{ 
				{
				//Add default weapon magazine except large magazine
				_listOfLargeMagazineText = ["40Rnd","50Rnd", "60Rnd", "75rnd", "100Rnd", "150Rnd", "200Rnd"]; //
				_currentWeaponMagazineList = getArray (configfile >> "CfgWeapons" >> _x >> "magazines");
					if (count _currentWeaponMagazineList != 0) then 
					{
						_currentWeapon = _x;
						{
							if ((virtualMagazineList) findIf {_currentWeapon == (_x)} == -1) then 
							{
								if (!([_x, _listOfLargeMagazineText] call isElementOfArrayInString) && !([_x] call isBannedItem)) then 
								{
									virtualMagazineList pushBack _x;
								};
							};
						} foreach _currentWeaponMagazineList;
					};
				} foreach currentWeaponList;
			};
	};

		//In addition add basic smokes and grenades
		virtualMagazineList = virtualMagazineList + basicAmmunitions; 

	diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass, virtualMagazineList ];
	virtualMagazineList
};

setupArsenalToItem = {
	//InitParam
	params ["_itemToAttachArsenal","_currentPlayer","_currentFaction"];

	//Process
	//Clean regular arsenal
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualWeaponCargo,false] call BIS_fnc_removeVirtualWeaponCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualItemCargo,false] call BIS_fnc_removeVirtualItemCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualMagazineCargo,false] call BIS_fnc_removeVirtualMagazineCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualBackpackCargo,false] call BIS_fnc_removeVirtualBackpackCargo;

	//Clean ACE arsenal
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		[_itemToAttachArsenal, true, false] call ace_arsenal_fnc_removeVirtualItems;
	};
	

	//Add Weapon to arsenal
	_currentWeaponItems = [_currentPlayer, _currentFaction] call getVirtualWeaponList;
	[_itemToAttachArsenal, _currentWeaponItems, false, false] call BIS_fnc_addVirtualWeaponCargo;

	//Add backpack to arsenal
	_currentBackpackItems = [_currentPlayer, _currentFaction] call getVirtualBackPack;
	[_itemToAttachArsenal, _currentBackpackItems, false, false] call BIS_fnc_addVirtualBackpackCargo;

	//Add magazine to arsenal
	_currentMagazineItems = [_currentPlayer,_currentFaction, _currentWeaponItems] call getVirtualMagazine;
	[_itemToAttachArsenal, _currentMagazineItems, false, false] call BIS_fnc_addVirtualMagazineCargo;
	

	//Add items, uniforms and optics to arsenal
	_currentItems = ([_currentPlayer, _currentFaction] call getVirtualAttachement ) + ([_currentPlayer,_currentFaction] call getVirtualItemList ) + ([_currentPlayer,_currentFaction] call getVirtualUniform );
	[_itemToAttachArsenal, _currentItems,false, false] call BIS_fnc_addVirtualItemCargo;

	//Remove action Arsenal
	_itemToAttachArsenal call RemoveArsenalActionFromGivenObject;

	//Save avalaible item list
	_currentDefaultLoadout = [_currentPlayer, _currentFaction] call getLoadoutByRole;

	//Check if there is a basic unit config
	if (typeName _currentDefaultLoadout == "STRING") then 
	{
		_currentDefaultLoadout = getUnitLoadout _currentDefaultLoadout;
	};
	_whiteListDefaultStuff = [_currentPlayer, _currentDefaultLoadout, []] call listCurrentItemsLoadout;
	diag_log format ["List of whitelist default items by listCurrentItemsLoadout %1", _whiteListDefaultStuff];

	//Merge every whitelist
	_whitelistOfArsenalItems = _currentWeaponItems+_currentBackpackItems+_currentMagazineItems+_currentItems + _whiteListDefaultStuff + ["ACE_key_west","ACE_key_east","ACE_key_civ","ACE_key_indp"];
	_currentPlayer setVariable ["avalaibleItemsInArsenal", _whitelistOfArsenalItems, true];
	diag_log format ["List of whitelist items by listCurrentItemsLoadout %1", _whitelistOfArsenalItems];

	//Remove arsenal action
	player call RemoveArsenalActionFromGivenObject;
	["AmmoboxExit", _itemToAttachArsenal] call BIS_fnc_arsenal;

	_itemToAttachArsenal;
};


doInitializeLoadout = {
	//InitParam
	params ["_player", "_currentFaction", "_forceDefault"];

	//Save personnal loadout
	_currentPlayerClass = _player getVariable "role";
	_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, _currentFaction, _currentPlayerClass], []];
	_isDefault = false;

	//Setup default stuff
	if (isNil "_forceDefault") then 
	{
		_forceDefault = false;
	};

	//If there is a custom class already saved
	if (count _loadableLoadout == 0 || ironMan || _forceDefault) then
	{
		_loadableLoadout = [_player, _currentFaction] call getLoadoutByRole;
		_isDefault = true;
	};

	//Load player loadout
	_player setUnitLoadout _loadableLoadout;

	//If it's a default loadout then adjust
	if (_isDefault) then 
	{
		_thisClasse = ((loadout_db select {_x select 1 == _currentFaction}) select 0 select 0) select {_x select 0 == _currentPlayerClass} select 0;
	
		//Check if loadout need adjustment
		//If the faction doesn't implement well ACE, loadout will be adjusted (check boolean flag in role definition)
		if (count _thisClasse == 2) then 
		{
			[_player] call adjustLoadout;
			
		} else 
		{
			if (_thisClasse select 2 == false) then 
			{
				[_player] call adjustLoadout;
			};
		};
	};

	//Manage radio support 
	_artillerySupportID = _player getVariable ["artillerySupportID", -1];
	if (_currentPlayerClass == "leader") then 
	{
		_artlillerySupportCounter = missionNamespace getVariable ["artlillerySupportCounter", 0];
		if (_artlillerySupportCounter > 0 && _artillerySupportID == -1) then 
		{
			_artillerySupportID = [_player, "myArtillery"] call BIS_fnc_addCommMenuItem;
			_player setVariable ["artillerySupportID", _artillerySupportID, true];
		};
	} else 
	{
		if (_artillerySupportID != -1) then 
		{
			[_player, _artillerySupportID] call BIS_fnc_removeCommMenuItem;
			_player setVariable ["artillerySupportID", -1, true]
		};
	};

	//Add extract action
	_extractSupportID = _player getVariable ["extractSupportID", -1];
	if (_currentPlayerClass == "leader") then 
	{
		_extractSupportCounter = missionNamespace getVariable ["extractSupportCounter", 0];
		if (_extractSupportCounter > 0 && _extractSupportID == -1) then 
		{
			_extractSupportID = [_player, "myExtract"] call BIS_fnc_addCommMenuItem;
			_player setVariable ["extractSupportID", _extractSupportID, true];
		};
	} else 
	{
		if (_extractSupportID != -1) then 
		{
			[_player, _extractSupportID] call BIS_fnc_removeCommMenuItem;
			_player setVariable ["extractSupportID", -1, true]
		};
	};

	//Add transport action
	_transportSupportID = _player getVariable ["transportSupportID", -1];
	if (_currentPlayerClass == "leader") then 
	{
		_transportSupportCounter = missionNamespace getVariable ["transportSupportCounter", 0];
		if (_transportSupportCounter > 0 && _transportSupportID == -1) then 
		{
			_transportSupportID = [_player, "myTransport"] call BIS_fnc_addCommMenuItem;
			_player setVariable ["transportSupportID", _transportSupportID, true];
		};
	} else 
	{
		if (_transportSupportID != -1) then 
		{
			[_player, _transportSupportID] call BIS_fnc_removeCommMenuItem;
			_player setVariable ["transportSupportID", -1, true]
		};
	};

	//Add airDrop action
	_airDropSupportID = _player getVariable ["airDropSupportID", -1];
	if (_currentPlayerClass == "leader") then 
	{
		_airDropSupportCounter = missionNamespace getVariable ["airDropSupportCounter", 0];
		if (_airDropSupportCounter > 0 && _airDropSupportID == -1) then 
		{
			_airDropSupportID = [_player, "myAirDrop"] call BIS_fnc_addCommMenuItem;
			_player setVariable ["airDropSupportID", _airDropSupportID, true];
		};
	} else 
	{
		if (_airDropSupportID != -1) then 
		{
			[_player, _airDropSupportID] call BIS_fnc_removeCommMenuItem;
			_player setVariable ["airDropSupportID", -1, true]
		};
	};

	//Add reinforcement action
	_reinforcementSupportID = _player getVariable ["reinforcementSupportID", -1];
	if (_currentPlayerClass == "leader") then 
	{
		_reinforcementSupportCounter = missionNamespace getVariable ["reinforcementSupportCounter", 0];
		if (_reinforcementSupportCounter > 0 && _reinforcementSupportID == -1) then 
		{
			_reinforcementSupportID = [_player, "myReinforcement"] call BIS_fnc_addCommMenuItem;
			_player setVariable ["reinforcementSupportID", _reinforcementSupportID, true];
		};
	} else 
	{
		if (_reinforcementSupportID != -1) then 
		{
			[_player, _reinforcementSupportID] call BIS_fnc_removeCommMenuItem;
			_player setVariable ["reinforcementSupportID", -1, true]
		};
	};
};


switchToRole = {
	//Init params
	params ["_arsenalItem", "_caller", "_faction", "_role", "_allowCustomLoad"];

	//Switch to role
	diag_log format ["Player %1 has switched to role %2 in faction %3", name _caller, _role, _faction];
	titleCut [format ["Switching to role %1", _role], "BLACK FADED", 5];

	//Manage Unit trait
	//Reset unit trait
	_caller setVariable ["ace_medical_medicClass", 0, true]; //Remove special ACE medic trait
	_caller setVariable ["ace_isEngineer", 0, true];
	_caller setUnitTrait ["Medic", false];
	_caller setUnitTrait ["Engineer", false];
	_caller setUnitTrait ["ExplosiveSpecialist", false];

	//Set specific trait
	if (_role == c_medic) then 
	{
		_caller setUnitTrait ["Medic", true];
		_caller setVariable ["ace_medical_medicClass", 2, true]; //add special ACE medic trait doctor
	};
	if (_role == c_engineer) then 
	{
		_caller setUnitTrait ["Engineer", true];
		_caller setUnitTrait ["ExplosiveSpecialist", true];
		_caller setVariable ["ace_isEngineer", 2, true]; //add special ACE medic trait advanced engineer
	};

	//Manage player's role
	_caller setVariable ["role", _role, true];

	//Manage default stuff
	_personalLoadout = profileNamespace getVariable [format [loadoutSaveName, name _caller, _faction , _role], []];
	if (count _personalLoadout != 0 && _allowCustomLoad) then 
	{
		//Personal loadout 
		_caller setUnitLoadout _personalLoadout;
	} else 
	{
		//Default loadout
		[_caller, _faction, true] call doInitializeLoadout;
	};

	_caller setVariable ["spawnLoadout", getUnitLoadout _caller];

	titleCut ["", "BLACK IN", 5];
};


setupRoleSwitchToList = {
	//InitParam
	params ["_currentFaction"];

	//Check if current faction has specific role definition
	listOfRoles = ((loadout_db select {_x # 1 == _currentFaction}) # 0 # 0) apply {_x # 0};

 	listOfRoles;
};

//Controls if a player is in a safe area to access arsenal
isAreaEligibleForArsenal = {
	params ["_caller"];
	_controlDistance = "";
	if (side _caller == blufor) then 
	{
		_controlDistance = "(_this distance _target < 10) && ((_target distance initBlueforLocation < 150) || (_target distance (missionNamespace getVariable 'advancedBlueforLocation') < 30))"
	};
	if (side _caller == independent) then 
	{
		_controlDistance = "(_this distance _target < 10) && (_target distance (initCityLocation) < 1000)";
	};
	_controlDistance;
};

getPlayerFaction = {
	params ["_unit"];

	_faction = "";
	if (side _unit == independent) then 
	{
		_faction = indFaction;
	} else 
	{
		_faction = bluFaction;
	};

	_faction;
};

setupPlayerLoadout = {

	//InitParam
	params ["_itemToAttachArsenal"];

	_actionLoadoutSetup = _itemToAttachArsenal addAction ["<img size='3' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa'/><t size='1.2'>Setup loadout</t>",{
		//Define parameters
		params ["_object","_caller","_ID","_parameters"];

		[[], 'GUI\loadoutGUI\initPlayerLoadoutSetup.sqf'] remoteExec ['BIS_fnc_execVM', _caller];

	},[],1000,true, false,"",[player] call isAreaEligibleForArsenal];

	//Setup initArsenal whitelist items
	[player, player, player call getPlayerFaction] call setupArsenalToItem;
};

setupSaveAndLoadRole = {
	//InitParam
	params ["_itemToAttachArsenal", "_currentPlayer" ];

	//Add action where player can save his loadout
	_itemToAttachArsenal addAction 
		["Save loadout", 
		{
			//Define params
			params ["_target","_caller","_ID","_params"];

			//Save loadout
			_caller setVariable ["spawnLoadout", getUnitLoadout _caller];

			hint "Loadout saved";
		},[]];
			
	//Add action where player can load his loadout
	_itemToAttachArsenal addAction 
		["Load loadout", 
		{
			//Define params
			params ["_target","_caller","_ID","_params"];

			//load loadout
			_caller setUnitLoadout (_caller getVariable "spawnLoadout");

			hint "Loadout loaded";
		},[]];
};

//Define's TFAR Radio frequencie
adjustTFARRadio = {
	params ["_currentPlayer"];
	if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {

		//Get default radio setup in the faction
		_currentFaction = _currentPlayer call getPlayerFaction;
		_factionDefaultRadios = ((factionDefaultRadios_db select {_x#1  == _currentFaction})#0)#0;

		//If there is a radio defined, add it to the player else add basic default radio
		if (count _factionDefaultRadios > 0) then 
		{
			_currentPlayer addItem _factionDefaultRadios#0;
			_currentPlayer assignItem _factionDefaultRadios#0;
		} else 
		{
			_currentPlayer addItem basicDefaultRadio#0;
			_currentPlayer assignItem basicDefaultRadio#0;	
		};

		//Seems not working
		if (side _currentPlayer == blufor) then
		{
			// Comment TFAR function
			// [(call TFAR_fnc_activeSwRadio), 1, format ["%1",bluforShortFrequencyTFAR]] call TFAR_fnc_setChannelFrequency;
			// [(call TFAR_fnc_activeLrRadio), 1, format ["%1",bluforShortFrequencyTFAR]] call TFAR_fnc_SetChannelFrequency;
		};
	};
};

adjustLoadout = {
	params ["_currentPlayer"];

	if (_currentPlayer getUnitTrait "Medic" == false) then 
	{
		for "_i" from 0 to 7 do { _currentPlayer addItem "ACE_elasticBandage" };	
		for "_i" from 0 to 1 do { _currentPlayer addItem "ACE_tourniquet" };
		for "_i" from 0 to 1 do { _currentPlayer addItem "ACE_splint" };
	}
	else 
	{
		_currentPlayer addItem "ACE_surgicalKit";
		for "_i" from 0 to 7 do { _currentPlayer addItem "ACE_epinephrine" };
		for "_i" from 0 to 7 do { _currentPlayer addItem "ACE_splint" };
		for "_i" from 0 to 29 do { _currentPlayer addItem "ACE_elasticBandage" };
		for "_i" from 0 to 29 do { _currentPlayer addItem "ACE_quikclot" };
		for "_i" from 0 to 11 do { _currentPlayer addItem "ACE_suture" };
		//for "_i" from 0 to 9 do { _currentPlayer addItem "ACE_morphine" }; //Basic ACE conversion will give enough morphine
		for "_i" from 0 to 5 do { _currentPlayer addItem "ACE_bloodIV_500" };
		for "_i" from 0 to 2 do { _currentPlayer addItem "ACE_bloodIV" };
		//for "_i" from 0 to 5 do { _currentPlayer addItem "ACE_tourniquet" };	//Basic ACE conversion will give enough tourniquet
	};
	for "_i" from 0 to 1 do { _currentPlayer addItem "ACE_CableTie" };
	_currentPlayer addItem "ACE_MapTools";	
	_currentPlayer addItem "ACE_morphine";	
	_currentPlayer addItem "ACE_WaterBottle";
	_currentPlayer addItem "ACE_EarPlugs";
	_currentPlayer unassignItem "itemRadio";
	_currentPlayer removeItem "itemRadio";
	_currentPlayer setSpeaker "noVoice";

	//Adapt loadout to a specific Era
	switch (warEra) do
	{
		//2nd War
		case 0:
		{
			
		};
		//Cold War
		case 1:
		{
			[_currentPlayer] call adjustTFARRadio;
		};
		//Modern Warfare
		case 2:
		{
			_currentPlayer addItem "ACE_DAGR";
			[_currentPlayer] call adjustTFARRadio;
		};
		//Actual Warfare
		case 3:
		{
			_currentPlayer addItem "ACE_microDAGR";
			[_currentPlayer] call adjustTFARRadio;
		};
		//Future Warfare
		case 4:
		{
			_currentPlayer addItem "ACE_microDAGR";
			[_currentPlayer] call adjustTFARRadio;
		};
		default
		{
			
		};
	};
	diag_log format ["Player %1 loadout adjust", name _currentPlayer];
};

RemoveArsenalActionFromGivenObject = {
	{if (_this actionParams _x select 0 == "Arsenal") exitWith {_this removeAction _x}} forEach actionIDs _this;
};


saveCustomLoadout = {
		params ["_currentPlayer", "_defaultParam"];

		//Case where no player's is given as parameter
		if (isNull _currentPlayer) then 
		{
			_currentPlayer = player;
		};

		_defaultStuff = [];

		//Determine default loadout
		switch (_defaultParam) do
			{
			case "personal":
				{
					_defaultStuff = getUnitLoadout _currentPlayer;
				};
			case "spawnLoadout":
				{
					_defaultStuff = _currentPlayer getVariable ["spawnLoadout", []];
				};
			default
				{
					//Do nothing
				};
		};

		//Save personnal loadout
		profileNamespace setVariable [format [loadoutSaveName, name _currentPlayer, _currentPlayer call getPlayerFaction, _currentPlayer getVariable "role"], _defaultStuff];

		//diag_log format ["Loadout saved on : RPG_%1_%2_%3 = %4", name player, indFaction, player getVariable "role", _defaultStuff];
		saveProfileNamespace;
};

validateLoadout = 
{
	params ["_currentPlayer"];

	_playerLoadout = getUnitLoadout _currentPlayer;
	_playerRestrictedItemsList = _currentPlayer getVariable ["avalaibleItemsInArsenal", []];
	if (count _playerRestrictedItemsList != 0) then 
	{
		[_currentPlayer, _playerLoadout, _playerRestrictedItemsList] call validateSpecificItem;
	};
};

validateSpecificItem = 
{
	params ["_currentPlayer", "_itemToVerify", "_restrictedItemsList"];

	if (!isNil "_itemToVerify" && !isNil "_restrictedItemsList") then 
	{
		switch (typeName _itemToVerify) do
				{
				case "ARRAY":
					{
						if (count _itemToVerify != 0 ) then 
						{
							{
								[_currentPlayer, _x, _restrictedItemsList] call validateSpecificItem;
							} foreach _itemToVerify;
						};
					};
				case "STRING":
					{
						//Test if it's a magazine
						diag_log format ["validateSpecificItem testing item  %1 ",_itemToVerify];
						if (([getText (configFile >>  "cfgMagazines" >> _itemToVerify >> "Displayname"), ""] call BIS_fnc_areEqual ) && !([_itemToVerify, ""] call BIS_fnc_areEqual) && !(["TFAR_",_itemToVerify] call BIS_fnc_inString)) then 
						{
							
							//Clean item name from variant 
							//Filter 3D and pip optics 
							_opticsKeyWords = ["PIP","pip","3D","3d","2D","2d"];
							_tempArray = (_itemToVerify splitString "_");
							_tempArray = _tempArray - _opticsKeyWords;
							_itemToVerify = (_tempArray joinString "_");

							//Test if the item exist in avalaible items list
							_currenItemPos = (_restrictedItemsList) findIf {_x == _itemToVerify };
							if (_currenItemPos == -1) then 
							{
								//If it is a vest then remove
								if ([vest _currentPlayer, _itemToVerify] call BIS_fnc_areEqual) then 
								{	
									removeVest _currentPlayer;
								};

								//If it is a headgear  then remove
								if ([headgear  _currentPlayer, _itemToVerify] call BIS_fnc_areEqual) then 
								{	
									removeHeadgear  _currentPlayer;
								};

								//If it is a uniform then remove
								if ([uniform _currentPlayer, _itemToVerify] call BIS_fnc_areEqual) then 
								{	
									removeUniform _currentPlayer;
								};

								//If it is a backpack then remove
								if ([backpack  _currentPlayer, _itemToVerify] call BIS_fnc_areEqual) then 
								{	
									removeBackpack _currentPlayer;
								};

								//If it is a weapon then remove
								if ((weapons _currentPlayer) findIf {_x == _itemToVerify } != -1) then 
								{	
									_currentPlayer removeWeaponGlobal _itemToVerify;
								};

								//If it is a secondaryWeaponItems then remove
								if ((secondaryWeaponItems _currentPlayer) findIf {_x == _itemToVerify } != -1) then 
								{	
									_currentPlayer removesecondaryWeaponItem _itemToVerify;
								};

								//If it is a primaryWeaponItems then remove
								if ((primaryWeaponItems _currentPlayer) findIf {_x == _itemToVerify } != -1) then 
								{	
									_currentPlayer removeprimaryWeaponItem _itemToVerify;
								};

								//Remove this specific item
								_currentPlayer unassignItem _itemToVerify;
								_currentPlayer removeItems _itemToVerify;

								//Log this restriction
								hint format ["%1 has been removed by loadout restriction", _itemToVerify];
								diag_log format ["%1 has been removed from %2 loadout due to loadout restriction %3",_itemToVerify, name _currentPlayer, _restrictedItemsList];
							};
						};
					};
				default
					{
						//Usually quantity of items
					};
			};
	} else 
	{
		diag_log "RPG_ERROR : validateSpecificItem";
	};
};


listCurrentItemsLoadout = 
{
	params ["_currentPlayer","_currentItemToTest","_listOfItems"];
	switch (typeName _currentItemToTest) do
		{
		case "ARRAY":
			{
				if (count _currentItemToTest != 0 ) then 
				{
					{
						[_currentPlayer, _x, _listOfItems] call listCurrentItemsLoadout;
					} foreach _currentItemToTest;
				};
			};
		case "STRING":
			{
				//Test if it's a magazine
				diag_log format ["listCurrentItemsLoadout testing item  %1 ",_currentItemToTest];
				//Test if the item exist in avalaible items list
				_currenItemPos = (_listOfItems) findIf {_x == _currentItemToTest };
				if (_currenItemPos == -1) then 
				{
					//Remove this specific item
					_listOfItems pushBack _currentItemToTest;

					//Log this addition
					diag_log format ["%1 has been added to %2 loadout basic items",_currentItemToTest, name _currentPlayer];
				};
			};
		default
			{
				//Usually quantity of items
			};
	};

	//diag_log format ["list of whitelist items by listCurrentItemsLoadout %1", _listOfItems];
	_listOfItems
};


//[ACE] Increase cookoff chance on opfor weapon 
adjustCookOf = {
	params ["_weaponUsed"];

	//Get player's authorized item list
	_playerRestrictedItemsList = player getVariable ["avalaibleItemsInArsenal", []];
	_currenItemPos = (_playerRestrictedItemsList) findIf {_x == _weaponUsed };

	if (_currenItemPos == -1) then 
	{
		//hint format ["Weapon %1: not authorized", _weaponUsed];
		private _weaponData = [_weaponUsed] call ace_overheating_fnc_getWeaponData;
		/*
		* 0: dispresion <NUMBER>
		* 1: slowdownFactor <NUMBER>
		* 2: jamChance <NUMBER>
		*/
		_weaponData set [0, (_weaponData # 0) + 0.25];
		_weaponData set [2, (_weaponData # 2) + (0.08 / 100)];
		ace_overheating_cacheWeaponData set [_weaponUsed, _weaponData];
	};

};

//[ACE] Reduce non authorized weapon cookoff on jammed eh
reduceCookOff = 
{
	params["_unit","_weaponUsed"];
	//Get player's authorized item list
	_playerRestrictedItemsList = player getVariable ["avalaibleItemsInArsenal", []];
	_currenItemPos = (_playerRestrictedItemsList) findIf {_x == _weaponUsed };

	if (_currenItemPos == -1) then 
	{
		//hint format ["Weapon %1: not authorized", _weaponUsed];
		private _weaponData = [_weaponUsed] call ace_overheating_fnc_getWeaponData;
		/*
		* 0: dispresion <NUMBER>
		* 1: slowdownFactor <NUMBER>
		* 2: jamChance <NUMBER>
		*/
		_weaponData set [0, (_weaponData # 0)/2];
		_weaponData set [2, (_weaponData # 2)/2];
		ace_overheating_cacheWeaponData set [_weaponUsed, _weaponData];
	};
};

isBannedItem = {
	params ["_itemToAnalyse"];
	_result = false;
	_bannedItemList = ["rhsusf_mag_10Rnd_STD_50BMG_mk211"];

	_result = _bannedItemList findIf { _x == _itemToAnalyse } > -1;

	_result
};

isElementOfArrayInString = 
{
	params ["_stringToAnalyse", "_arrayToTest"];
	_result = false;

	{
		if ([_x, _stringToAnalyse] call BIS_fnc_inString) then 
		{
			_result = true;
		};
	} foreach _arrayToTest;

	_result
};

getClassInformation = {
	params ["_class"];

	_classDescription = "";

	switch (_class) do
		{
			case c_leader:
				{
					_classDescription = "The leader have access to multiple options such as complete vehicle shop and support shop";
				};
			case c_at:
				{
					_classDescription = "The AT have access to Anti-Tank and Anti-Aircraft launchers";
				};
			case c_rifleman:
				{
					_classDescription = "The rifleman has a basic class without any speciality";
				};
			case c_engineer:
				{
					_classDescription = "The engineer has access to the toolbox, he can defuse IED and build fortifications";
				};
			case c_autorifleman:
				{
					_classDescription = "The autorifleman has access to machinegun, he can provide suppressive fire to his teammates";
				};
			case c_marksman:
				{
					_classDescription = "The marksman has access to marksman rifle and accurate scopes";
				};
			case c_sniper: 
				{
					_classDescription = "The sniper has access to marksman rifle and accurate scopes and specific camoflage";
				};
			case c_medic:
				{
					_classDescription = "The medic has access to Medikit, he's able to heal his teammates";
				};	
			case c_grenadier:
				{
					_classDescription = "The grenadier has access to grenade launcher";
				};
			case c_pilot:
				{
					_classDescription = "The pilot has access to air vehicle shop";
				};						
			default
				{
					//Non implemented role
					//_classDescription = "Custom class";
				};
		};
	_classDescription;
};