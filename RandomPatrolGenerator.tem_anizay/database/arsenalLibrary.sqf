#include "factionParameters.sqf"

//Import mission params
warEra = "WarEra" call BIS_fnc_getParamValue;

c_listOfRoles = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic];

c_variableToInit = ["listOfRoles","loadout","rifleList","grenadeLauncherList","attachmentLongList","attachmentShortList","smgList","marksmanrifleList","autorifleList","launcherList","itemList","itemEngineerList","itemMedicList",'backPackList','uniformList'];

//Join

////////////////////////
//Backpack management///
////////////////////////

initFactionDb = {
	params ["_currentVariable"];
	_currentTempVariable = [];
	{
		_currentFactionName = _x select 0;
		_currentFactionParameters = _x select 1;
		_currentFactionBuild = format ["%1%2", _currentVariable, _currentFactionName];
		_currentTempVariable pushBack [missionNamespace getVariable [_currentFactionBuild,[]], _currentFactionParameters];
	} foreach factionInfos;
	_currentVariableName = format ["%1%2", _currentVariable, c_db];
	missionNamespace setVariable [_currentVariableName, _currentTempVariable, true];
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
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (autorifleList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_marksman:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
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
			_itemList = ["ACE_DAGR", "ACE_microDAGR","ACE_EntrenchingTool","ACE_WaterBottle","ACE_CableTie","ACE_MapTools","ItemCompass","ItemMap","ItemWatch","ACE_RangeTable_82mm","Binocular","ACE_SpraypaintRed","ACE_EarPlugs"];
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


setupArsenalToItem = {
	//InitParam
	params ["_itemToAttachArsenal","_currentPlayer","_currentFaction"];

	//Process
	//Clean arsenal
	//["AmmoboxExit", itemToAttachArsenal] call BIS_fnc_arsenal;	
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualWeaponCargo,false] call BIS_fnc_removeVirtualWeaponCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualItemCargo,false] call BIS_fnc_removeVirtualItemCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualMagazineCargo,false] call BIS_fnc_removeVirtualMagazineCargo;
	[_itemToAttachArsenal,_itemToAttachArsenal call BIS_fnc_getVirtualBackpackCargo,false] call BIS_fnc_removeVirtualBackpackCargo;

	//Add Weapon to arsenal
	[_itemToAttachArsenal, ([_currentPlayer, _currentFaction] call getVirtualWeaponList )] call BIS_fnc_addVirtualWeaponCargo;

	//Add backpack to arsenal
	[_itemToAttachArsenal, ([_currentPlayer, _currentFaction] call getVirtualBackPack )] call BIS_fnc_addVirtualBackpackCargo;

	//[VA2,((itemCargo VA2) + _availableHeadgear + _availableUniforms + _availableVests)] call BIS_fnc_addVirtualItemCargo;
	[VA2,true] call BIS_fnc_addVirtualMagazineCargo;
	[_itemToAttachArsenal,([_currentPlayer,_currentFaction] call getVirtualAttachement ) + ([_currentPlayer,_currentFaction] call getVirtualItemList ) + ([_currentPlayer,_currentFaction] call getVirtualUniform ) ] call BIS_fnc_addVirtualItemCargo;
	["AmmoboxInit",[_itemToAttachArsenal,false,{true}]] call BIS_fnc_arsenal;
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
				_caller setUnitLoadout ([_caller,(_params select 1)] call getLoadoutByRole);
				[_caller] call adjustLoadout;
				_caller setVariable ["spawnLoadout", getUnitLoadout _caller];

				//Manage arsenal stuff
				[_target, _caller, (_params select 1)] call setupArsenalToItem;

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


setupSaveAndLoadRole = {
	//InitParam
	params ["_itemToAttachArsenal", "_currentPlayer" ];

	//Add action where player can save his loadout
	itemToAttachArsenal addAction 
		["Save loadout", 
		{
			//Define params
			params ["_target","_caller","_ID","_params"];

			//Save loadout
			_caller setVariable ["spawnLoadout", getUnitLoadout _caller];

			hint "Loadout saved";
		},[]];
			
	//Add action where player can load his loadout
	itemToAttachArsenal addAction 
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
			[(call TFAR_fnc_activeSwRadio), 1, format ["%1",bluforShortFrequencyTFAR]] call TFAR_fnc_setChannelFrequency;
			[(call TFAR_fnc_activeLrRadio), 1, format ["%1",bluforShortFrequencyTFAR]] call TFAR_fnc_SetChannelFrequency;
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
		for "_i" from 0 to 9 do { _currentPlayer addItem "ACE_morphine" };
		for "_i" from 0 to 5 do { _currentPlayer addItem "ACE_bloodIV_500" };
		for "_i" from 0 to 2 do { _currentPlayer addItem "ACE_bloodIV" };
		for "_i" from 0 to 5 do { _currentPlayer addItem "ACE_tourniquet" };	
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




//////////
//InitDB//
//////////

{
	[_x] call initFactionDb;
}
foreach c_variableToInit;