//Import mission params
warEra = missionNamespace getVariable "warEra"; // Default actual warfare

c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_radioman = "radioman";
c_grenadier = "grenadier";
c_ammobearer = "ammobearer";

c_listOfRoles = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic];

loadoutSaveName = "RPG_%1_%2_%3";

if (ironMan) then 
{
	loadoutSaveName = "RPG_ironMan_%1_%2_%3";
};


getLoadoutByRole = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;

	currentPlayerClass = currentPlayer getVariable "role";
	thisloadout = [];
	//Need to adapt a little thing to allow default loadout when there's no loadout found
	thisloadout = ((loadout_db select {_x select 1 == currentFaction}) select 0 select 0) select {_x select 0 == currentPlayerClass} select 0 select 1;
	diag_log format ["Player %1 with role %2 has loadout %3", name currentPlayer, currentPlayerClass,thisloadout ];
	thisloadout
};

getVirtualWeaponList = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualWeaponList = [];

	switch (currentPlayerClass) do
	{
		case c_leader:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_at:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (launcherList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_rifleman:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_engineer:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_autorifleman:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (autorifleList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_marksman:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (marksmanrifleList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_medic:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
			};	
		case c_grenadier:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (grenadeLauncherList_db select {_x select 1  == currentFaction} select 0 select 0);
			};				
		default
			{
				//Non implemented role : Default rifle
			 	virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0); 
			};
	};
	diag_log format ["Player %1 with role %2 has access to weapons %3", name currentPlayer, currentPlayerClass,virtualWeaponList ];
	virtualWeaponList
};


getItembyWarEra = {
	params ["_warEra","_currentPlayer"];
	_itemList = [];

	switch (_warEra) do
	{
		//2nd War
		case 0:
		{
			_itemList = ["ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_EarPlugs"];
		};
		//Cold War
		case 1:
		{
			_itemList = ["ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_itemList pushBack "TFAR_anprc152";
			} ;
		};
		//Modern Warfare
		case 2:
		{
			_itemList = ["ACE_DAGR","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_itemList pushBack "TFAR_anprc152";
			} ;
		};
		//Actual Warfare
		case 3:
		{
			_itemList = ["ACE_DAGR", "ACE_microDAGR","B_UavTerminal","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_itemList pushBack "TFAR_anprc152";
			} ;
		};
		//Future Warfare
		case 4:
		{
			_itemList = ["ACE_DAGR", "ACE_microDAGR","B_UavTerminal","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_itemList pushBack "TFAR_anprc152";
			} ;
		};
		default
		{
			
		};
	};

	//Add ACE Key management
	//ACE key doesn't work on the arsenal
	switch (side _currentPlayer) do 
	{
		case independent:
		{
			_itemList pushBack "ACE_key_indp";
		};
		case blufor:
		{
			_itemList pushBack "ACE_key_west";
		};
		default 
		{
			//Do nothing
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
			};			
		case c_engineer:	
			{
				virtualItemList = virtualItemList + (itemList_db select {_x select 1  == _currentFaction} select 0 select 0);
				virtualItemList = virtualItemList + (itemEngineerList_db select {_x select 1  == _currentFaction} select 0 select 0);
			};		
		default 
			{
				//Default item list
			 	virtualItemList = virtualItemList + (itemList_db select {_x select 1  == _currentFaction} select 0 select 0); 
			};
	};
	diag_log format ["Player %1 with role %2 has access to items %3", name _currentPlayer, currentPlayerClass,virtualItemList ];
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
		case c_marksman:	
			{
				//add ghilie to the uniform list
				virtualUniformList = virtualUniformList + (uniformList_db select {_x select 1  == currentFaction} select 0 select 0);
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
		case c_marksman:		
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
	currentPlayerClass = currentPlayer getVariable "role";
	virtualMagazineList = [];

	switch (currentPlayerClass) do
	{
		default 
			{ 
				//Default Magazine list
				virtualMagazineList = virtualMagazineList + (magazineList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
	};
	diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass, virtualMagazineList ];
	virtualMagazineList
};

setupArsenalToItem = {
	//InitParam
	params ["_itemToAttachArsenal","_currentPlayer","_currentFaction"];

	//Process
	//Clean arsenal
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualWeaponCargo,false] call BIS_fnc_removeVirtualWeaponCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualItemCargo,false] call BIS_fnc_removeVirtualItemCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualMagazineCargo,false] call BIS_fnc_removeVirtualMagazineCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualBackpackCargo,false] call BIS_fnc_removeVirtualBackpackCargo;

	//Add Weapon to arsenal
	_currentWeaponItems = [_currentPlayer, _currentFaction] call getVirtualWeaponList;
	[_itemToAttachArsenal, _currentWeaponItems, false, false] call BIS_fnc_addVirtualWeaponCargo;

	//Add backpack to arsenal
	_currentBackpackItems = [_currentPlayer, _currentFaction] call getVirtualBackPack;
	[_itemToAttachArsenal, _currentBackpackItems, false, false] call BIS_fnc_addVirtualBackpackCargo;

	//Add magazine to arsenal
	_currentMagazineItems = [_currentPlayer,_currentFaction] call getVirtualMagazine;
	if (count _currentMagazineItems == 0) then 
	{
		[_itemToAttachArsenal,true, false, false] call BIS_fnc_addVirtualMagazineCargo;
	} else {
		[_itemToAttachArsenal, _currentMagazineItems, false, false] call BIS_fnc_addVirtualMagazineCargo;
	};

	//Add items, uniforms and optics to arsenal
	_currentItems = ([_currentPlayer, _currentFaction] call getVirtualAttachement ) + ([_currentPlayer,_currentFaction] call getVirtualItemList ) + ([_currentPlayer,_currentFaction] call getVirtualUniform );
	[_itemToAttachArsenal, _currentItems,false, false] call BIS_fnc_addVirtualItemCargo;

	//Remove action Arsenal
	_itemToAttachArsenal call RemoveArsenalActionFromGivenObject;

	//Save avalaible item list
	_whitelistOfArsenalItems = _currentWeaponItems+_currentBackpackItems+_currentMagazineItems+_currentItems + (_currentPlayer getVariable ["avalaibleItemsInArsenal", []]);
	_currentPlayer setVariable ["avalaibleItemsInArsenal", _whitelistOfArsenalItems, true];
	
	//Remove arsenal action
	{if (player actionParams _x select 0 == "Arsenal") exitWith {player removeAction _x}} forEach actionIDs player;
	["AmmoboxExit", _itemToAttachArsenal] call BIS_fnc_arsenal;

	_itemToAttachArsenal;
};


doInitializeLoadout = {
	//InitParam
	params ["_player","_currentFaction"];

	_currentPlayerClass = _player getVariable "role";
	_thisClasse = ((loadout_db select {_x select 1 == _currentFaction}) select 0 select 0) select {_x select 0 == _currentPlayerClass} select 0;

	_player setUnitLoadout ([_player,_currentFaction] call getLoadoutByRole);

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
	
	//Whitelist current player loadout
	_player setVariable ["avalaibleItemsInArsenal", [_player, getUnitLoadout _player, []] call listCurrentItemsLoadout, true];
};


switchToRole = {
	//Init params
	params ["_arsenalItem", "_caller", "_faction", "_role", "_allowCustomLoad"];

	//Switch to role
	diag_log format ["Player %1 has switch to role %2 in faction %3", name _caller, _role, _faction];
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
	_personalLoadout = profileNamespace getVariable [format [loadoutSaveName,name _caller, _faction , _role], []];
	if (count _personalLoadout != 0 && _allowCustomLoad) then 
	{
		//Personal loadout 
		_caller setUnitLoadout _personalLoadout;
	} else 
	{
		//Default loadout
		[_caller, _faction] call doInitializeLoadout;
	};

	_caller setVariable ["spawnLoadout", getUnitLoadout _caller];

	titleCut ["", "BLACK IN", 5];
};

setupRoleSwitchToItem = {
	//InitParam
	itemToAttachArsenal = _this select 0;
	currentPlayer = _this select 1;
	currentFaction = _this select 2;

	//Check if current faction has specific role definition
	if (count (listOfRoles_db select {_x select 1  == currentFaction} select 0 select 0) == 0 ) then 
	{
		listOfRoles = c_listOfRoles;
	} else 
	{
		listOfRoles = listOfRoles_db select {_x select 1  == currentFaction} select 0 select 0;
	};
	
	//Add action to change role
	{
		itemToAttachArsenal addAction 
			[format ["Switch to role %1", _x], 
			{
				//Define params
				params ["_target","_caller","_ID","_params"];
				diag_log format ["Player %1 has switch to role %2 in faction %3", name _caller, _params select 0, _params select 1];

				titleCut [format ["Switching to role %1",(_params select 1)], "BLACK FADED", 5];

				//Manage Unit trait
				_caller setUnitTrait ["Medic", false];
				_caller setUnitTrait ["Engineer", false];
				_caller setUnitTrait ["ExplosiveSpecialist", false];
				if ((_params select 0) == c_medic) then 
				{
					_caller setUnitTrait ["Medic", true];
				};
				if ((_params select 0) == c_engineer) then 
				{
					_caller setUnitTrait ["Engineer", true];
					_caller setUnitTrait ["ExplosiveSpecialist", true];
				};

				//Manage player's role
				_caller setVariable ["role", (_params select 0)];

				//Manage default stuff
				[_caller,(_params select 1)] call doInitializeLoadout;

				_caller setVariable ["spawnLoadout", getUnitLoadout _caller];

				titleCut ["", "BLACK IN", 5];
			},[_x,currentFaction]];
	} foreach listOfRoles;

	//Display player's current role
	itemToAttachArsenal addAction 
		[format ["Show team roles"], 
		{
			private _target = (_this select 0);
			private _caller = (_this select 1);
			private _params = (_this select 3);
			
			private _currentPlayersFaction = side _caller;
			private _globalRoles = "Your team's roles :";
			{
				if (alive _x && side _x == _currentPlayersFaction) then 
				{
					_globalRoles = _globalRoles + format ["\n Player %1 has role %2",name _x, _x getVariable "role"];
				};
			} foreach allPlayers;
			hint _globalRoles;
		},[currentFaction]];
};



setupRoleSwitchToList = {
	//InitParam
	params ["_currentFaction"];

	//Check if current faction has specific role definition
	if (count (listOfRoles_db select {_x select 1  == _currentFaction} select 0 select 0) == 0 ) then 
	{
		listOfRoles = c_listOfRoles;
	} else 
	{
		listOfRoles = listOfRoles_db select {_x select 1  == _currentFaction} select 0 select 0;
	};
 	listOfRoles;
};

//Controls if a player is in a safe area to access arsenal
isAreaEligibleForArsenal = {
	params ["_caller"];
	_controlDistance = "";
	if (side _caller == blufor) then 
	{
		_controlDistance = "(_this distance _target < 3) && ((_target distance initBlueforLocation < 30) || (_target distance (missionNamespace getVariable 'advancedBlueforLocation') < 30))"
	};
	if (side _caller == independent) then 
	{
		_controlDistance = "(_this distance _target < 3) && (_target distance (getPos initCityLocation) < 1000)";
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
	diag_log "test setupPlayerLoadout";
	params ["_itemToAttachArsenal"];
	[
			_itemToAttachArsenal, 
			"Setup loadout", 
			"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", 
			"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", 
			[player] call isAreaEligibleForArsenal,						// Condition for the action to be shown
			"_caller distance _target < 10",						// Condition for the action to progress
			{
				// Action start code
			}, 
			{
				// Action on going code
			},  
			{
				// Action successfull code
				//Params
				params ["_target", "_caller", "_unusedParam" ,"_params"];
				//Show GUI
				[[], 'GUI\loadoutGUI\initPlayerLoadoutSetup.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			}, 
			{
				// Action failed code
			}, 
			[],  
			0.5,
			1000, 
			false, 
			false
		] call BIS_fnc_holdActionAdd;

		//Setup initArsenal whitelist items
		[player, player, player call getPlayerFaction] call setupArsenalToItem;
		sleep 1;
		{if (player actionParams _x select 0 == "Arsenal") exitWith {player removeAction _x}} forEach actionIDs player;
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
		_currentPlayer addItem "TFAR_anprc152";
		_currentPlayer assignItem "TFAR_anprc152";

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

	switch (side _currentPlayer) do 
	{
		case independent:
		{
			_currentPlayer addItem "ACE_key_indp";
		};
		case blufor:
		{
			_currentPlayer addItem "ACE_key_west";
		};
		default 
		{
			//Do nothing
		};
	};

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

	diag_log format ["list of whitelist items by listCurrentItemsLoadout %1", _listOfItems];
	_listOfItems
};