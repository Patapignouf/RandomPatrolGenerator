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

getAllPossibleLoadout = {
	params ["_currentPlayer", "_currentFaction"];
	_currentPlayerClass = _currentPlayer getVariable "role";
	_thisloadout = [];
	//Need to adapt a little thing to allow default loadout when there's no loadout found
	_thisloadoutConfig = ((loadout_db select {_x select 1 == _currentFaction}) select 0 select 0) select {_x select 0 == _currentPlayerClass} select 0;

	//Test if there are alternative role description
	if (count _thisloadoutConfig == 4) then 
	{
		{
			_thisloadout pushBack (getUnitLoadout _x)
		} foreach _thisloadoutConfig#2;
	};

	//Get every item 
	_thisloadout = [_thisloadout] call getAllStringInArray;
	_thisloadout
};

getAllStringInArray = {
	params ["_array"];

	{
		if (typeName _x == "ARRAY") then 
		{
			_array = _array - [_x];
			_array = _array + ([_x] call getAllStringInArray);
		};
	} foreach _array;
	_array
};

getParentsFromItems = {
	params ["_candidateItemsList"];
	_candidateItemsListResult = _candidateItemsList;

	{
		if (typeName _x == "STRING") then 
		{
			_possibleItems = ([configFile >> "CfgWeapons" >> _x, true] call BIS_fnc_returnParents);
			if (typeName _possibleItems == "ARRAY") then 
			{	
				//Purge possible items list from basic game items (avoid allowing base game in mod factions)
				if (count _possibleItems > 0) then 
				{
					_modAuthor = getText (configFile >> "CfgWeapons" >> _possibleItems#0 >> "author");
					{
						if (getText (configFile >> "CfgWeapons" >> _x >> "author") != _modAuthor) then 
						{
							_possibleItems = _possibleItems - [_x];
						};
					} foreach (_possibleItems);
				};

				//Add reste of item in futur allowed stuff
				_candidateItemsListResult = _candidateItemsListResult + _possibleItems;
			};
		};
	} foreach _candidateItemsList;
	//diag_log format ["_candidateItemsListResult %1", _candidateItemsListResult];
	_candidateItemsListResult
};

getPrestigeItems = {
	_result = [];
	_playerCurrentPrestige = profileNamespace getVariable ["RPG_prestige", 0];
	for [{_i = 0}, {_i < _playerCurrentPrestige}, {_i = _i + 1}] do
	{
		//Only ten prestige items
		if ( _i <10 ) then 
		{
			_result pushBack (prestigeItem#_i);
		};
	};
	_result
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
	//diag_log format ["Player %1 with role %2 has access to weapons %3", name _currentPlayer, _currentPlayerClass,_virtualWeaponList ];
	_virtualWeaponList
};


getItembyWarEra = {
	params ["_warEra","_currentPlayer", "_currentFaction"];
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
				_defaultRadios = ((factionDefaultRadios_db select {_x#1  == _currentFaction})#0)#0;

				if (count _defaultRadios == 0) then 
				{
					_defaultRadios = ["TFAR_anprc152"];
				};

				_itemList append _defaultRadios;
			} ;
		};
		//Modern Warfare
		case 2:
		{
			_itemList = ["ACE_Sandbag_empty","ItemGPS","ACE_DAGR","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_defaultRadios = ((factionDefaultRadios_db select {_x#1  == _currentFaction})#0)#0;

				if (count _defaultRadios == 0) then 
				{
					_defaultRadios = ["TFAR_anprc152"];
				};

				_itemList append _defaultRadios;
			} ;

			//Add modern items
			_defaultModernItems = ((modernItems_db select {_x#1  == _currentFaction})#0)#0;
			_itemList append _defaultModernItems;

		};
		//Actual Warfare
		case 3:
		{	
			_itemList = ["ACE_NVG_Wide_Black_WP", "ACE_NVG_Wide_WP","ACE_NVG_Wide_Green_WP", "ACE_Sandbag_empty","ItemGPS", "ACE_DAGR", "ACE_microDAGR","B_UavTerminal","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_defaultRadios = ((factionDefaultRadios_db select {_x#1  == _currentFaction})#0)#0;

				if (count _defaultRadios == 0) then 
				{
					_defaultRadios = ["TFAR_anprc152"];
				};

				_itemList append _defaultRadios;
			} ;

			//Add modern items
			_defaultModernItems = ((modernItems_db select {_x#1  == _currentFaction})#0)#0;
			_itemList append _defaultModernItems;
		};
		//Future Warfare
		case 4:
		{
			_itemList = ["ACE_NVG_Wide_Black_WP", "ACE_NVG_Wide_WP","ACE_NVG_Wide_Green_WP", "ACE_Sandbag_empty","ItemGPS","ACE_DAGR", "ACE_microDAGR","B_UavTerminal","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_defaultRadios = ((factionDefaultRadios_db select {_x#1  == _currentFaction})#0)#0;

				if (count _defaultRadios == 0) then 
				{
					_defaultRadios = ["TFAR_anprc152"];
				};

				_itemList append _defaultRadios;
			} ;

			//Add modern items
			_defaultModernItems = ((modernItems_db select {_x#1  == _currentFaction})#0)#0;
			_itemList append _defaultModernItems;
		};
		default
		{
			
		};
	};

	_itemList
};

getVirtualItemList = {
	params ["_currentPlayer","_currentFaction"];
	currentPlayerClass = _currentPlayer getVariable "role";
	virtualItemList = [warEra, _currentPlayer, _currentFaction] call getItembyWarEra;
	//diag_log format ["virtualItemList : %1", virtualItemList];
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
	//diag_log format ["Player %1 with role %2 has access to items %3", name _currentPlayer, currentPlayerClass, virtualItemList ];
	virtualItemList
};


getVirtualUniform = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualUniformList = [];
	//diag_log format ["virtualUniformList : %1", virtualUniformList];
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
	//diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass,virtualUniformList ];
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
	//diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass, virtualAttachementList ];
	virtualAttachementList
};


getVirtualBackPack = {
	currentPlayer = _this select 0;
	_currentFaction = _this select 1;
	_currentPlayerClass = currentPlayer getVariable "role";
	_virtualBackpackList = [];

	switch (_currentPlayerClass) do
	{
		case c_drone:
			{
				_virtualBackpackList = _virtualBackpackList + (backPackList_db select {_x select 1  == _currentFaction} select 0 select 0);
				_virtualBackpackList = _virtualBackpackList + ([_currentFaction] call getDroneBackPack);
			};		
		default
			{
				//Non implemented role : Default rifle
			 	_virtualBackpackList = _virtualBackpackList + (backPackList_db select {_x select 1  == _currentFaction} select 0 select 0); 
			};
	};
	//diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass, virtualBackpackList ];
	_virtualBackpackList
};

getDroneBackPack = {
	_currentFaction = _this select 0;
	_virtualDroneBackpackList = [];


	_virtualDroneBackpackList = _virtualDroneBackpackList + (droneBackPack_db select {_x select 1  == _currentFaction} select 0 select 0);

	//diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass, virtualBackpackList ];
	_virtualDroneBackpackList
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
									virtualMagazineList pushBackUnique _x;
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
								virtualMagazineList pushBackUnique _x;
							};
						};
					} foreach _currentWeaponMagazineList;
				};
				} foreach currentWeaponList;
			};
	};

		//In addition add basic smokes and grenades
		virtualMagazineList = virtualMagazineList + basicAmmunitions; 

	//diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass, virtualMagazineList ];
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

	//Check other default units defined in faction file
	_currentDefaultLoadout = _currentDefaultLoadout + ([_currentPlayer, _currentFaction] call getAllPossibleLoadout);

	//Add inherited items
	//_currentDefaultLoadout = [_currentDefaultLoadout] call getParentsFromItems;

	_whiteListDefaultStuff = [_currentPlayer, _currentDefaultLoadout, []] call listCurrentItemsLoadout;
	diag_log format ["List of whitelist default items by listCurrentItemsLoadout %1", _whiteListDefaultStuff];

	//Merge every whitelist
	//Add prestige item 
	_prestigeItems = [] call getPrestigeItems;
	_whitelistOfArsenalItems = _currentWeaponItems+_currentBackpackItems+_currentMagazineItems+_currentItems + _whiteListDefaultStuff+ _prestigeItems + ["ACE_key_west","ACE_key_east","ACE_key_civ","ACE_key_indp"];
	diag_log format ["List of whitelist items by listCurrentItemsLoadout %1", _whitelistOfArsenalItems];

	//Fix vanilla arsenal not showing all weapon 
	_currentMagazineItems = [_currentPlayer,_currentFaction, _whitelistOfArsenalItems] call getVirtualMagazine;
	_currentPlayer setVariable ["avalaibleItemsInArsenal", _whitelistOfArsenalItems+_currentMagazineItems, true];

	[_itemToAttachArsenal, _whitelistOfArsenalItems, false, false] call BIS_fnc_addVirtualWeaponCargo;
	[_itemToAttachArsenal, _whitelistOfArsenalItems, false, false] call BIS_fnc_addVirtualBackpackCargo;
	[_itemToAttachArsenal, _currentMagazineItems, false, false] call BIS_fnc_addVirtualMagazineCargo;
	[_itemToAttachArsenal, _whitelistOfArsenalItems,false, false] call BIS_fnc_addVirtualItemCargo;

	//Remove arsenal action
	player call RemoveArsenalActionFromGivenObject;
	["AmmoboxExit", _itemToAttachArsenal] call BIS_fnc_arsenal;
	[_itemToAttachArsenal, _currentMagazineItems, false, false] call BIS_fnc_addVirtualMagazineCargo;

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
		if (count _thisClasse <= 3) then 
		{
			[_player] call adjustLoadout;
			
		} else 
		{
			if (_thisClasse # 3 == false) then 
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

		//Add airDrop action
	_advancedAirDropSupportID = _player getVariable ["advancedAirDropSupportID", -1];
	if (_currentPlayerClass == "leader") then 
	{
		_airDropSupportCounter = missionNamespace getVariable ["airDropSupportCounter", 0];
		if (_airDropSupportCounter > 0 && _advancedAirDropSupportID == -1) then 
		{
			_advancedAirDropSupportID = [_player, "myAdvancedAirDrop"] call BIS_fnc_addCommMenuItem;
			_player setVariable ["advancedAirDropSupportID", _advancedAirDropSupportID, true];
		};
	} else 
	{
		if (_advancedAirDropSupportID != -1) then 
		{
			[_player, _advancedAirDropSupportID] call BIS_fnc_removeCommMenuItem;
			_player setVariable ["advancedAirDropSupportID", -1, true]
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
	params ["_arsenalItem", "_caller", "_faction", "_role", "_allowCustomLoad", "_skipAnimation"];

	//Switch to role
	diag_log format ["Player %1 has switched to role %2 in faction %3", name _caller, _role, _faction];

	//Manage player's role
	//Check if the role is existing and avalaible
	if ([_caller, _role] call checkRoleAvalaibility && (count (((loadout_db select {_x # 1 == _faction}) # 0 # 0) select {_x#0 == _role}) != 0)) then
	{
		//Player is allowed to change role
		_caller setVariable ["role", _role, true];
	} else 
	{
		//reset player role
		if (_role == _caller getVariable "role") then 
		{
			//player get rifleman role because there are no place in his role
			_role = c_rifleman;
		} else 
		{
			//reset previous player role
			_role = _caller getVariable "role";
		};
	};

	if (!_skipAnimation) then 
	{
		titleCut [format ["Switching to role %1", _role], "BLACK FADED", 5];
	};

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
	if (_role == c_leader) then 
	{
		group _caller selectLeader _caller;
	};

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
	
	if (!_skipAnimation) then 
	{
		titleCut ["", "BLACK IN", 5];
	};
};

checkRoleAvalaibility = {
	params ["_caller", "_roleToCheck"];

	_isOkToSwitch = false;
	if (isPlayer _caller) then 
	{
		//Adapt loadout to a specific Era
		switch (_roleToCheck) do
		{
			case c_leader:
			{
				//Max 1 
				if ([_caller, _roleToCheck] call numberOfUnitWithRoleInGroup == 0) then 
				{
					_isOkToSwitch = true;
				};
			};
			case c_rifleman:
			{
				//No Max
				_isOkToSwitch = true;
			};
			default
			{
				//Max 2
				if ([_caller, _roleToCheck] call numberOfUnitWithRoleInGroup <= 1) then 
				{
					_isOkToSwitch = true;
				};
			};
		};
	} else 
	{
		_isOkToSwitch = true;
	};
	_isOkToSwitch;
};

checkRoleMaxNumber = {
	params ["_roleToCheck"];

	_maxNumberInRole = "0";

	//Adapt loadout to a specific Era
	switch (_roleToCheck) do
	{
		case c_leader:
		{
			//Max 1 
			_maxNumberInRole = "1";
		};
		case c_rifleman:
		{
			//No Max
			_maxNumberInRole = localize "STR_RPG_LOADOUT_ROLE_NB_INFINITE";
		};
		default
		{
			//Max 2
			_maxNumberInRole = "2";
		};
	};
	
	_maxNumberInRole;
};

numberOfUnitWithRoleInGroup = {
	params ["_caller", "_roleToCount"];
	_unitsWithSameRole = count ((units (group _caller)) select {_x getVariable ["role", ""] == _roleToCount && isPlayer _x});

	_unitsWithSameRole;
};


setupRoleSwitchToList = {
	//InitParam
	params ["_currentFaction"];

	//Check if current faction has specific role definition
	listOfRoles = ((loadout_db select {_x # 1 == _currentFaction}) # 0 # 0) apply {_x # 0};

 	listOfRoles;
};

setupSimpleRoleSwitchWithToList = {
	//InitParam
	params ["_player"];

	_bluFaction = missionNamespace getVariable "bluforFaction";
	_indFaction = missionNamespace getVariable "independentFaction";

	_currentFaction = _bluFaction;

	if (PlayerSide == independent) then 
	{
		_currentFaction = _indFaction;
	};

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
		_controlDistance = "(_this distance _target < 15) && ((_target distance initBlueforLocation < 150) || (_target distance (missionNamespace getVariable 'advancedBlueforLocation') < 30))"
	};
	if (side _caller == independent) then 
	{
		_controlDistance = "(_this distance _target < 15) && (_target distance (initCityLocation) < 1000)";
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

	_actionLoadoutSetup = _itemToAttachArsenal addAction [format ["<img size='3' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa'/><t size='1.2'>%1</t>", localize "STR_ACTIONS_SETUP_LOADOUT"],{
		//Define parameters
		params ["_object","_caller","_ID","_parameters"];

		[[], 'GUI\loadoutGUI\initPlayerLoadoutSetup.sqf'] remoteExec ['BIS_fnc_execVM', _caller];

	},[],1000,true, false,"",[player] call isAreaEligibleForArsenal];

	//Setup initArsenal whitelist items
	[player, player, player call getPlayerFaction] call setupArsenalToItem;

	_whitelistOfArsenalItems = player getVariable ["avalaibleItemsInArsenal", []];
	_whitelistOfArsenalItems append ([getUnitLoadout player] call getAllStringInArray);
	player setVariable ["avalaibleItemsInArsenal", _whitelistOfArsenalItems, true];
};

setupPlayerLoadoutRemake = {

	//InitParam
	params ["_itemToAttachArsenal"];

	_actionLoadoutSetup = _itemToAttachArsenal addAction [format ["<img size='3' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa'/><t size='1.2'>%1</t>", localize "STR_ACTIONS_SETUP_LOADOUT"],{
		//Define parameters
		params ["_object","_caller","_ID","_parameters"];

		[] execVM "GUI\LoadoutGUI\initPlayerLoadoutSetupRemake.sqf"

	},[],1000,true, false,"",[player] call isAreaEligibleForArsenal];

	//Setup initArsenal whitelist items
	[player, player, player call getPlayerFaction] call setupArsenalToItem;

	_whitelistOfArsenalItems = player getVariable ["avalaibleItemsInArsenal", []];
	_whitelistOfArsenalItems append ([getUnitLoadout player] call getAllStringInArray);
	player setVariable ["avalaibleItemsInArsenal", _whitelistOfArsenalItems, true];
};

setupPlayerLoadoutWithoutConditionRemake = {

	//InitParam
	params ["_itemToAttachArsenal"];

	_actionLoadoutSetup = _itemToAttachArsenal addAction [format ["<img size='3' image='\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa'/><t size='1.2'>%1</t>", localize "STR_ACTIONS_SETUP_LOADOUT"],{
		//Define parameters
		params ["_object","_caller","_ID","_parameters"];

		[] execVM "GUI\LoadoutGUI\initPlayerLoadoutSetupRemake.sqf"

	},[],1000,true, false,"","(_this distance _target < 15)"];

	//Setup initArsenal whitelist items
	[player, player, player call getPlayerFaction] call setupArsenalToItem;

	_whitelistOfArsenalItems = player getVariable ["avalaibleItemsInArsenal", []];
	_whitelistOfArsenalItems append ([getUnitLoadout player] call getAllStringInArray);
	player setVariable ["avalaibleItemsInArsenal", _whitelistOfArsenalItems, true];
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
		
		// _unitHaveRadio = (("ItemRadio" in (assignedItems _currentPlayer)) || (call TFAR_fnc_haveDDRadio) || (call TFAR_fnc_haveLRRadio) || call TFAR_fnc_haveSWRadio);
 		_unitHaveRadio = ("ItemRadio" in (assignedItems _currentPlayer));
		_currentPlayer unassignItem "ItemRadio";
		_currentPlayer removeItem "ItemRadio";

		//Clear automatic radio conversion
		_assignedItems = assignedItems _currentPlayer;
		{
			if (["TFAR_anprc152", _x] call BIS_fnc_inString) then 
			{
				_currentPlayer unassignItem _x;
				_currentPlayer removeItem _x;
			};
		} foreach _assignedItems;

		//Get default radio setup in the faction
		_currentFaction = _currentPlayer call getPlayerFaction;
		_factionDefaultRadios = ((factionDefaultRadios_db select {_x#1  == _currentFaction})#0)#0;

		//If there is a radio defined, add it to the player else add basic default radio
		// if (_unitHaveRadio) then 
		// {
			if (count _factionDefaultRadios > 0) then 
			{
				_currentPlayer addItem _factionDefaultRadios#0;
				_currentPlayer assignItem _factionDefaultRadios#0;
			} else 
			{
				_currentPlayer addItem basicDefaultRadio#0;
				_currentPlayer assignItem basicDefaultRadio#0;	
			};
		// };

		//Seems not working
		if (side _currentPlayer == blufor) then
		{
			// Comment TFAR function seems broken
			// [(call TFAR_fnc_activeSwRadio), 1, format ["%1",bluforShortFrequencyTFAR]] call TFAR_fnc_setChannelFrequency;
			// [(call TFAR_fnc_activeLrRadio), 1, format ["%1",bluforShortFrequencyTFAR]] call TFAR_fnc_SetChannelFrequency;
		};
	};
};

removeTFARID = {
	params ["_unitLoadout"];
	
	//From https://github.com/michail-nikolaev/task-force-arma-3-radio/blob/master/addons/core/functions/fnc_loadoutReplaceProcess.sqf
	//Adjusted to work with getUnitLoadout 

	private _cfgWeapons = configFile >> "CfgWeapons"; //So we don't resolve every time in loop

	// _loadouts is an associative array [loadoutName, loadoutContent, loadoutName, ...], so we have to skip the name in our loop
	_inventory = _unitLoadout;
	// iterate through each container
	{
		_content = _x;
		diag_log format ["_content tested %1",_content];
		// iterate through each item of the container
		{
			_class = _cfgWeapons >> _x;
			diag_log format ["class tested %1",_class];

			//Following will replace 0.9.x Radios with their 1.0 versions. //#TODO Enable for Release -- yet untested
			//if ((_class select [0,3]) == "tf_") then {_class = "tfar_" + (_class select [3])};

			// if the item is an actual radio, not a radio prototype nor common item
			if ((isClass _class) && {isNumber (_class >> "tf_radio")}) then {
				// erase the content value with parent prototype
				diag_log ["TFAR","replace",_class,_forEachIndex,getText (_class >> "tf_parent")];
				_content set [_forEachIndex, getText (_class >> "tf_parent")];
			};
		} forEach _content;
		true
	} count [
		//(_inventory select 3) select 1, // uniform content
		//(_inventory select 4) select 1, // vest content
		//(_inventory select 5) select 1, // backpack content
		_inventory select 9             // assigned items
		];

	diag_log  format ["TFAR stuff : %1", _inventory];

	_inventory;
};

adjustLoadout = {
	params ["_currentPlayer"];

	//Adjust ACE medic items 
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		if (_currentPlayer getUnitTrait "Medic" == false) then 
		{
			for "_i" from 0 to 7 do { _currentPlayer addItem "ACE_elasticBandage" };	
			for "_i" from 0 to 1 do { _currentPlayer addItem "ACE_tourniquet" };
			for "_i" from 0 to 1 do { _currentPlayer addItem "ACE_splint" };
		}
		else 
		{
			_currentPlayer removeItems "Medikit";
			_currentPlayer removeItems "ACE_tourniquet";
			_currentPlayer removeItems "ACE_elasticBandage";
			_currentPlayer removeItems "ACE_fieldDressing";
			_currentPlayer removeItems "ACE_packingBandage";
			_currentPlayer removeItems "ACE_tourniquet";
			_currentPlayer removeItems "ACE_morphine";
			_currentPlayer removeItems "ACE_quikclot";
			_currentPlayer removeItems "ACE_epinephrine";


			_currentPlayer addItem "ACE_surgicalKit";
			for "_i" from 0 to 11 do { _currentPlayer addItem "ACE_epinephrine" };
			for "_i" from 0 to 11 do { _currentPlayer addItem "ACE_splint" };
			for "_i" from 0 to 59 do { _currentPlayer addItem "ACE_elasticBandage" };
			// for "_i" from 0 to 29 do { _currentPlayer addItem "ACE_quikclot" };
			for "_i" from 0 to 59 do { _currentPlayer addItem "ACE_suture" };
			for "_i" from 0 to 9 do { _currentPlayer addItem "ACE_morphine" }; //Basic ACE conversion will give enough morphine
			for "_i" from 0 to 11 do { _currentPlayer addItem "ACE_bloodIV_500" };
			for "_i" from 0 to 7 do { _currentPlayer addItem "ACE_bloodIV" };
			for "_i" from 0 to 11 do { _currentPlayer addItem "ACE_tourniquet" };	//Basic ACE conversion will give enough tourniquet
		};
	};

	for "_i" from 0 to 1 do { _currentPlayer addItem "ACE_CableTie" };
	_currentPlayer addItem "ACE_MapTools";	
	_currentPlayer addItem "ACE_morphine";	
	_currentPlayer addItem "ACE_WaterBottle";
	_currentPlayer addItem "ACE_EarPlugs";
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

	if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
		//Remove TFAR radio ID 
		_defaultStuff = [_defaultStuff] call removeTFARID;
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
									//Last chance for weapon if an ancestor is known the player can keep it 
									//This code is here to prevent strange issue with RHS inherited items 
									// _technicalParents = [configFile >> "CfgWeapons" >> _x, true] call BIS_fnc_returnParents;
									// diag_log format ["technical parents"];
									// if (getParentsFromItems)

									//"arifle_mx_gl_black_hamr_pointer_f" call BIS_fnc_weaponComponents;
									_currentPlayer removeprimaryWeaponItem _itemToVerify;
								};

								//Remove this specific item
								_currentPlayer unassignItem _itemToVerify;
								_currentPlayer removeItems _itemToVerify;

								//Log this restriction
								hint format ["%1 has been removed by loadout restriction", _itemToVerify];
								//diag_log format ["%1 has been removed from %2 loadout due to loadout restriction %3",_itemToVerify, name _currentPlayer, _restrictedItemsList];
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
				//diag_log format ["listCurrentItemsLoadout testing item  %1 ",_currentItemToTest];
				//Test if the item exist in avalaible items list
				_currenItemPos = (_listOfItems) findIf {_x == _currentItemToTest };
				if (_currenItemPos == -1) then 
				{
					//Remove this specific item
					_listOfItems pushBack _currentItemToTest;

					//Log this addition
					//diag_log format ["%1 has been added to %2 loadout basic items",_currentItemToTest, name _currentPlayer];
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
		_weaponData set [0, (_weaponData # 0) + 0.10];
		_weaponData set [2, (_weaponData # 2) + (0.02 / 100)];
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

getNumberOfClassInSquad = {
	params ["_caller", "_role"];
	_numberOfClass = count ((units group _caller) select {(_x getVariable ["role", ""]) == _role});
	_numberOfClass
};

getClassInformation = {
	params ["_class"];

	_classDescription = "";

	switch (_class) do
		{
			case c_leader:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_LEADER";
				};
			case c_at:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_AT";
				};
			case c_rifleman:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_RIFLEMAN";
				};
			case c_engineer:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_ENGINEER";
				};
			case c_autorifleman:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_AUTORIFLEMAN";
				};
			case c_marksman:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_MARKSMAN";
				};
			case c_sniper: 
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_SNIPER";
				};
			case c_medic:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_MEDIC";
				};	
			case c_grenadier:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_GRENADIER";
				};
			case c_pilot:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_PILOT";
				};
			case c_radioman:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_RADIOMAN";
				};
			case "diver":
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_DIVER";
				};		
			case "UAV operator":
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_UAV";
				};	
			default
				{
					//Non implemented role
					//_classDescription = "Custom class";
				};
		};
	_classDescription;
};

getDescClassInformation = {
	params ["_class"];

	_classDescription = "";

	switch (_class) do
		{
			case c_leader:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_LEADER_DESC";
				};
			case c_at:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_AT_DESC";
				};
			case c_rifleman:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_RIFLEMAN_DESC";
				};
			case c_engineer:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_ENGINEER_DESC";
				};
			case c_autorifleman:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_AUTORIFLEMAN_DESC";
				};
			case c_marksman:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_MARKSMAN_DESC";
				};
			case c_sniper: 
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_SNIPER_DESC";
				};
			case c_medic:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_MEDIC_DESC";
				};	
			case c_grenadier:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_GRENADIER_DESC";
				};
			case c_pilot:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_PILOT_DESC";
				};	
			case c_radioman:
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_RADIOMAN_DESC";
				};	
			case "diver":
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_DIVER_DESC";
				};		
			case "UAV operator":
				{
					_classDescription = localize "STR_RPG_LOADOUT_ROLE_UAV_DESC";
				};						
			default
				{
					//Non implemented role
					//_classDescription = "Custom class";
				};
		};
	_classDescription;
};