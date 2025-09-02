adjustRole = {
	params ["_cfgRole", "_cfgName"];

	_backpackToTest = (configFile >> "CfgVehicles" >> _cfgName >> "backpack") call BIS_fnc_GetCfgData;
	if (false) then 
	{
		_cfgRole = "autorifleman";//Temp
	} else 
	{
		//Bind role with wrole
		switch (_cfgRole) do {
			case "CombatLifeSaver": {_cfgRole = "medic"};
			case "Grenadier": {_cfgRole = "grenadier"};
			case "MachineGunner": {_cfgRole = "autorifleman"};
			case "Marksman": {_cfgRole = "marksman"};
			case "MissileSpecialist": {_cfgRole = "at"};
			case "Assistant": {_cfgRole = "rifleman"}; //Assistant must go with basic rifleman
			case "Rifleman": {_cfgRole = "rifleman"};
			case "Sapper": {_cfgRole = "engineer"};		
			case "Crewman": {_cfgRole = "pilot"}; //Assistant must go with basic rifleman
			case "RadioOperator": {_cfgRole = "radioman"};
			case "SpecialOperative": {_cfgRole = "rifleman"};
		};

		//Check if name contains specifics strings
		if (["pilot", _cfgName] call BIS_fnc_inString || ["Pilot", _cfgName] call BIS_fnc_inString || ["crew", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "pilot";
		};

		if (["marksman", _cfgName] call BIS_fnc_inString || ["spotter", _cfgName] call BIS_fnc_inString || ["_MRK", _cfgName] call BIS_fnc_inString || ["_RMRK", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "marksman";
		};
		if (["sniper", _cfgName] call BIS_fnc_inString || ["ghillie", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "sniper";
		};
		if (["grenadier", _cfgName] call BIS_fnc_inString || ["_GL", _cfgName] call BIS_fnc_inString || ["uns_men_US_3FRC_RF4", _cfgName] call BIS_fnc_inString|| ["uns_men_US_6SFG_SP2", _cfgName] call BIS_fnc_inString || ["uns_men_US_5SFG_SP2", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "grenadier";
		};
		if (["mechanic", _cfgName] call BIS_fnc_inString || ["_SAP", _cfgName] call BIS_fnc_inString || ["_DEM", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "engineer";
		};
		if (["_arifleman", _cfgName] call BIS_fnc_inString || ["_HMG", _cfgName] call BIS_fnc_inString || ["_LMG", _cfgName] call BIS_fnc_inString || ["_RMG", _cfgName] call BIS_fnc_inString || ["_RA", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "autorifleman";
		};
		if (["diver", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "diver";
		};
		if (["_UGV_", _cfgName] call BIS_fnc_inString || ["_UAV", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "UAV operator";
		};
		if (["_aa", _cfgName] call BIS_fnc_inString || ["_LAT", _cfgName] call BIS_fnc_inString || ["_RPG", _cfgName] call BIS_fnc_inString || ["_AT", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "at";
		};
		if (["JTAC", _cfgName] call BIS_fnc_inString || ["radioman", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "radioman";
		};
		if (["_sergeant", _cfgName] call BIS_fnc_inString ) then 
		{
			_cfgRole = "leader";
		};
		if (["_MED", _cfgName] call BIS_fnc_inString || ["_RMED", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "medic";
		};
	};

	_iconToTest = (configFile >> "CfgVehicles" >> _cfgName >> "icon") call BIS_fnc_GetCfgData;

	//Bind role with icon
	switch (_iconToTest) do {
		case "iconManLeader";
		case "\uns_men_c\icon\pavntroops\icon_officer_ca.paa";
		case "\uns_men_c\icon\pavntroops\icon_leader_ca.paa";
		case "\uns_men_c\icon\ustroops\icon_officer_ca.paa";
		case "\uns_men_c\icon\ustroops\icon_leader_ca.paa";
		case "iconManOfficer":
		{
			_cfgRole = "leader";
		};
		case "\uns_men_c\icon\ustroops\icon_launcher_ca.paa";
		case "\uns_men_c\icon\pavntroops\icon_launcher_ca.paa";
		case "iconManAT":
		{
			_cfgRole = "at";
		};
		case "\uns_men_c\icon\ustroops\icon_medic_ca.paa";
		case "\uns_men_c\icon\pavntroops\icon_medic_ca.paa";
		case "iconManMedic":
		{
			_cfgRole = "medic";
		};
		case "\uns_men_c\icon\pavntroops\icon_gren_ca.paa";
		case "\uns_men_c\icon\ustroops\icon_gren_ca.paa":
		{
			_cfgRole = "grenadier";
		};
		case "iconManExplosive";
		case "\uns_men_c\icon\ustroops\icon_eng_ca.paa";
		case "\uns_men_c\icon\pavntroops\icon_eng_ca.paa";
		case "iconManEngineer":
		{
			_cfgRole = "engineer";
		};		
		case "\uns_men_c\icon\ustroops\icon_sniper_ca.paa";
		case "\uns_men_c\icon\pavntroops\icon_sniper_ca.paa":
		{
			_cfgRole = "marksman";
		};
		case "\uns_men_c\icon\ustroops\icon_rto_ca.paa";
		case "\uns_men_c\icon\pavntroops\icon_rto_ca.paa":
		{
			_cfgRole = "radioman";
		};
		case "\uns_men_c\icon\ustroops\icon_machinegunner_ca.paa";
		case "\uns_men_c\icon\pavntroops\icon_machinegunner_ca.paa";
		case "iconManMG":
		{
			_cfgRole = "autorifleman";
		};
		default
		{
			//Just _cfgRole
		};
	};


	_cfgRole
};

isAccessory = {
	params ["_itemClassName"];
	_result = !(isNull (configFile >> "CfgWeapons" >> _itemClassName >> "ItemInfo" >> "mountAction"));

	_result;
};

isWeapon = {
	params ["_itemClassName"];
	_result = (count (getArray (configfile >> "CfgWeapons" >> _itemClassName >> "magazines")) != 0);
	_result;
};

isBag = {
	params ["_itemClassName"];
	_result = (([configFile >> "CfgVehicles" >> _itemClassName, true] call BIS_fnc_returnParents) findIf {"Bag_Base" == (_x)} != -1);
	_result;
};

isPistol = {
	params ["_itemClassName"];
	_result = (([configFile >> "CfgWeapons" >> _itemClassName, true] call BIS_fnc_returnParents) findIf {"PistolCore" == (_x)} != -1);
	_result;
};

isGrenadeLauncher = {
	params ["_itemClassName"];
	_result = (([configFile >> "CfgWeapons" >> _itemClassName, true] call BIS_fnc_returnParents) findIf {"GrenadeLauncher" == (_x)} != -1);

	if (!_result) then 
	{
		 private _cfg = configFile >> "CfgWeapons" >> _itemClassName;
		if !(isClass _cfg) exitWith {false};

		private _muzzles = getArray (_cfg >> "muzzles");

		// si juste "this", alors pas de GL
		if (_muzzles isEqualTo ["this"]) exitWith {false};

		{
			private _muzzleCfg = _cfg >> _x;
			if (isClass _muzzleCfg) then {
				private _base = inheritsFrom _muzzleCfg;
				if (configName _base == "UGL_F") exitWith {_result = true};
			};
		} forEach _muzzles;
	};

	_result;
};


isLauncher = {
	params ["_itemClassName"];
	_result = (([configFile >> "CfgWeapons" >> _itemClassName, true] call BIS_fnc_returnParents) findIf {"LauncherCore" == (_x)} != -1);
	_result;
};

getParentBag = {
	params ["_itemClassName"];
	_resultList = (([configFile >> "CfgVehicles" >> _itemClassName, true] call BIS_fnc_returnParents));
	_result = _itemClassName;
	if (count _resultList > 1) then 
	{	
		_result = _resultList#1;
	};
	_result;
};

issUniformAllowed = {
	params ["_currentUniform"];
	_uniformBlackList = ["FP_G3_OD_BLACK"];
	_uniformAllowed = true;

	if (_currentUniform in _uniformBlackList) then 
	{
		_uniformAllowed = false;
	};
	
	_uniformAllowed;
};

doSetOpfor = {
	params ["_currentFactionName","_opforNameClass", "_existingValues"];
	//diag_log format ["%1%2 : %3",_opforNameClass,_currentFactionName, _existingValues];
	missionNamespace setVariable [format ["%1%2",_opforNameClass,_currentFactionName], _existingValues]; 
};

getBasicUnitsGroup = {
	params ["_faction", "_unitType"];

	//Get faction loadout
	_currentFactionName = format ["loadout%1", _faction];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
	
	//Start building groups
	_resultGroup = [];
	_coreEnemyGroup = [];
	_resultGroup = +_coreEnemyGroup;

	//Setup core group
	_coreEnemyGroup pushBack ([_currentStuffFaction, "leader"] call getUnitByRole);
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{ 
		_coreEnemyGroup pushBack ([_currentStuffFaction, "rifleman"] call getUnitByRole);
	};

	switch (_unitType) do {
		case "BASIC":
		{
			if (count (baseEnemyGroup_db select {_x select 1  == opFaction} select 0 select 0) == 0) then 
			{
				_resultGroup = [_resultGroup, _currentStuffFaction, 8] call doFillWithRifleman;

			} else 
			{
				_resultGroup = baseEnemyGroup_db select {_x select 1  == opFaction} select 0 select 0;
			};
		};
		case "AT":
		{
			if (count (baseEnemyATGroup_db select {_x select 1  == opFaction} select 0 select 0) == 0) then 
			{
				//AT group
				_resultGroup pushBack ([_currentStuffFaction, "at"] call getUnitByRole);
				_resultGroup pushBack ([_currentStuffFaction, "grenadier"] call getUnitByRole);

				_resultGroup = [_resultGroup, _currentStuffFaction, 6] call doFillWithRifleman;
				//diag_log format ["_baseEnemyATGroup %1 ",_baseEnemyATGroup];

			} else 
			{
				_resultGroup = baseEnemyATGroup_db select {_x select 1  == opFaction} select 0 select 0;
			};
		};
		case "DEMO":
		{
			if (count (baseEnemyDemoGroup_db select {_x select 1  == opFaction} select 0 select 0) == 0) then 
			{
				//Demo group
				_resultGroup pushBack ([_currentStuffFaction, "engineer"] call getUnitByRole);
				_resultGroup pushBack ([_currentStuffFaction, "medic"] call getUnitByRole);
				_resultGroup = [_resultGroup, _currentStuffFaction, 6] call doFillWithRifleman;
			} else 
			{
				_resultGroup = baseEnemyDemoGroup_db select {_x select 1  == opFaction} select 0 select 0;
			};
		};
	};

	_resultGroup
};

doDefineOpforFactionInfantry = {
	params ["_opforFaction", "_currentStuffFaction"];

	_coreEnemyGroup = [];

	//Setup core group
	_coreEnemyGroup pushBack ([_currentStuffFaction, "leader"] call getUnitByRole);
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{ 
		_coreEnemyGroup pushBack ([_currentStuffFaction, "rifleman"] call getUnitByRole);
	};

	//setup core on every group
	_baseEnemyGroup = +_coreEnemyGroup;
	_baseEnemyATGroup = +_coreEnemyGroup;
	_baseEnemyDemoGroup = +_coreEnemyGroup;

	//Setup specific group design 
	//Base grouo
	_baseEnemyGroup pushBack ([_currentStuffFaction, "medic"] call getUnitByRole);
	_baseEnemyGroup pushBack ([_currentStuffFaction, "rifleman"] call getUnitByRole);
	for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
	{ 
		_baseEnemyGroup pushBack ([_currentStuffFaction, "autorifleman"] call getUnitByRole);
	};
	//diag_log format ["_baseEnemyGroup %1 ",_baseEnemyGroup];

	//AT group
	_baseEnemyATGroup pushBack ([_currentStuffFaction, "at"] call getUnitByRole);
	_baseEnemyATGroup pushBack ([_currentStuffFaction, "grenadier"] call getUnitByRole);
	//diag_log format ["_baseEnemyATGroup %1 ",_baseEnemyATGroup];

	//Demo group
	_baseEnemyDemoGroup pushBack ([_currentStuffFaction, "engineer"] call getUnitByRole);
	_baseEnemyDemoGroup pushBack ([_currentStuffFaction, "medic"] call getUnitByRole);
	//diag_log format ["_baseEnemyDemoGroup %1 ",_baseEnemyDemoGroup];

	//Fill with rifleman
	_baseEnemyGroup = [_baseEnemyGroup, _currentStuffFaction, 8] call doFillWithRifleman;
	_baseEnemyATGroup = [_baseEnemyATGroup, _currentStuffFaction, 6] call doFillWithRifleman;
	_baseEnemyDemoGroup = [_baseEnemyDemoGroup, _currentStuffFaction, 6] call doFillWithRifleman;

	[_opforFaction, "baseEnemyGroup", _baseEnemyGroup] call doSetOpfor;
	[_opforFaction, "baseEnemyATGroup", _baseEnemyATGroup] call doSetOpfor;
	[_opforFaction, "baseEnemyDemoGroup", _baseEnemyDemoGroup] call doSetOpfor;
};

getUnitByRole = {
	params ["_loadout", "_role"];

	_unit = "";
	_unitIndex = _loadout findIf {_x#0 == _role};

	if (_unitIndex != -1) then 
	{
		_units = (_loadout#_unitIndex);
		if (count _units >= 3) then 
		{
			_unit = selectRandom ((_units#2) + [_units#1]);
		} else 
		{
			_unit = _units#1;
		};
	};
	_unit
};

doFillWithRifleman = {
	params ["_groupToEvaluate", "_currentStuffFaction", "_desiredNumber"];

	//diag_log format ["_groupToEvaluate %1 %3 desiredNumber %2",_groupToEvaluate, _desiredNumber, count _groupToEvaluate];

	if ((count _groupToEvaluate) < _desiredNumber) then 
	{
		_neededUnits = _desiredNumber-(count _groupToEvaluate);
		for [{_i = 0}, {_i < (_neededUnits)}, {_i = _i + 1}] do
		{ 
			_groupToEvaluate pushBack ([_currentStuffFaction, "rifleman"] call getUnitByRole);
		};
	};
	//diag_log format ["_groupToEvaluate after %1 %3 desiredNumber %2",_groupToEvaluate, _desiredNumber, count _groupToEvaluate];
	_groupToEvaluate
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

	_array = _array - [""];

	_array
};

filterString = {
	params ["_array"];

	{
		if (typeName _x != "STRING") then 
		{
			_array = _array - [_x];
		};
	} foreach _array;
	_array
};


mergeFactions = {
	params ["_factionToEnhanced", "_factionToMerge"];

	_factionVariables = [
		"bluforUnarmedVehicle",
		"bluforArmedVehicle",
		"bluforStaticWeapon",
		"bluforMortar",
		"bluforFixedWing",
		"bluforFixedWingTransport",
		"bluforBoat",
		"bluforArmoredVehicle",
		"bluforUnarmedVehicleChopper",
		"bluforArmedChopper",
		"bluforDrone"
	];

	//Merge all vehicles and props
	{
		_factionToEnhancedVariable = format ["%1%2", _x, _factionToEnhanced];
		_factionToMergeVariable = format ["%1%2", _x, _factionToMerge];

		_baseFaction = missionNameSpace getVariable [_factionToEnhancedVariable, []];
		_mergingFaction = missionNameSpace getVariable [_factionToMergeVariable, []];
		_mergingFactions = _baseFaction + _mergingFaction;
		missionNameSpace setVariable [_factionToEnhancedVariable, _mergingFactions];
	} foreach _factionVariables;
	
	//merge infantry loadout
	_factionToEnhancedVariable = format ["loadout%1", _factionToEnhanced];
	_factionToMergeVariable = format ["loadout%1", _factionToMerge];
	_baseFaction = missionNameSpace getVariable [_factionToEnhancedVariable, []];
	_mergingFaction = missionNameSpace getVariable [_factionToMergeVariable, []];
	{
		_mergingRole = _x;
		_mergingRoleName = _x#0;
		if (count (_baseFaction select {_x#0 == _mergingRoleName}) == 0) then 
		{
			_baseFaction pushBack _mergingRole;
		};
		//[TODO] Needs to manage conflicts merging
	} foreach _mergingFaction;
	missionNameSpace setVariable [_factionToEnhancedVariable, _baseFaction];
};


getListOfAccessoriesFromStuff = 
{
	params ["_loadout"];
	_resultList = [];

	{
		_accToCheck = _x;
		if ([_accToCheck] call isAccessory) then 
		{
			_resultList pushBack _accToCheck;
		};
	} foreach _loadout;

	_resultList;
};

getListOfWeaponsFromStuff = 
{
	params ["_loadout"];
	_resultList = [];

	{
		_weaponToCheck  = _x;
		if ([_weaponToCheck] call isWeapon) then 
		{
			_resultList pushBack _weaponToCheck;
		};
	} foreach _loadout;

	_resultList;
};

getListOfBagsFromStuff = 
{
	params ["_loadout"];
	_resultList = [];

	{
		_bagToCheck  = _x;
		if ([_bagToCheck] call isBag) then 
		{
			_resultList pushBack _bagToCheck;
			_resultList pushBack ([_bagToCheck] call getParentBag);
		};
	} foreach _loadout;

	_resultList;
};

addBackPackDroneToFaction = {
	params ["_side", "_faction"];
	_currentFactionName = format ["droneBackPack%1", _faction];
	_defaultDrone = [];

	switch (_side) do {
		case blufor:
		{
			_defaultDrone append ["B_Crocus_AP_Bag", "B_Crocus_AT_Bag"];
		};
		case independent:
		{
			_defaultDrone append ["I_Crocus_AP_Bag", "I_Crocus_AT_Bag"];
		};
		case opfor:
		{
			_defaultDrone append ["I_Crocus_AP_Bag", "I_Crocus_AT_Bag"];
		};
	};

	missionNamespace setVariable [_currentFactionName, _defaultDrone]; 
};

addModernItemsToFaction = {
	params ["_side", "_faction"];
	_currentFactionName = format ["modernItems%1", _faction];
	_defaultModernItems = [];

	switch (_side) do {
		case blufor:
		{
			_defaultModernItems append ["B_UavTerminal"];
		};
		case independent:
		{
			_defaultModernItems append ["I_E_UavTerminal"];
		};
		case opfor:
		{
			_defaultModernItems append ["O_UavTerminal"];
		};
	};

	missionNamespace setVariable [_currentFactionName, _defaultModernItems]; 
};

addRadioToFaction = {
	params ["_side", "_faction"];
	_currentFactionName = format ["factionDefaultRadios%1", _faction];
	_defaultRadio = [];

	switch (_side) do {
		case blufor:
		{
			_defaultRadio pushBack "TFAR_anprc152"
		};
		case independent:
		{
			_defaultRadio pushBack "tfar_anprc148jem"
		};
		case opfor:
		{
			_defaultRadio pushBack "tfar_fadak"
		};
	};

	missionNamespace setVariable [_currentFactionName, _defaultRadio]; 
};

getAllAccessoriesAndWeaponsFromWeapons = {
	params ["_weaponsList"];
	_resultAllList = [[],[]];

	{	
		_weaponToCheckTotal = _x;

		_resultWeaponFiltered = [_weaponToCheckTotal] call filterWeaponsAndAccessoryByWeaponClassname;

		//filter weapon
		_resultAllList#0 append _resultWeaponFiltered#0; //Add weapon filtered
		_resultAllList#0 pushBack ([_weaponToCheckTotal] call BIS_fnc_baseWeapon); //Add base weapon
		_resultAllList#0 pushBack _weaponToCheckTotal; //Add base weapon

		//filter accessory
		_resultAllList#1 append _resultWeaponFiltered#1; //Add filtered accessories
	} foreach _weaponsList;

	_resultAllList;
};

getAllDistinctRifleAndPistolAndLauncher = {
	params ["_weaponsList"];
	_resultAllListWP = [[],[],[],[],[],[]];

	// [[pistol],[launcher],[rifle],[autorifle],[grenadeLauncher],[SniperRifle]]

	{	
		// _weaponToCheckTotal = _x;
		// if ([_weaponToCheckTotal] call isPistol) then 
		// {
		// 	_resultAllListWP#0 pushBackUnique _weaponToCheckTotal;
		// } else 
		// {
		// 	if ([_weaponToCheckTotal] call isLauncher) then 
		// 	{
		// 		_resultAllListWP#1 pushBackUnique _weaponToCheckTotal;
		// 	} else 
		// 	{
		// 		_resultAllListWP#2 pushBackUnique _weaponToCheckTotal;
		// 	};
		// 	//TODO Add GL
		// };

		_firstParsingWeaponCategoryResult = [_x] call BIS_fnc_itemType;

		if (_firstParsingWeaponCategoryResult#0 == "weapon") then 
		{
			switch (_firstParsingWeaponCategoryResult#1) do {
				case ("Handgun");
				case ("SubmachineGun"):
				{
					_resultAllListWP#0 pushBackUnique _x;
				};
				case ("RocketLauncher");
				case ("MissileLauncher"):
				{
					_resultAllListWP#1 pushBackUnique _x;
				};
				case ("Shotgun");
				case ("Rifle");
				case ("AssaultRifle"):
				{
					//Filter bad category on grenadeLauncher
					if ([_x] call isGrenadeLauncher) then 
					{
						_resultAllListWP#4 pushBackUnique _x;
					} else 
					{
						_resultAllListWP#2 pushBackUnique _x;
					};
				};
				case ("MachineGun"):
				{
					_resultAllListWP#3 pushBackUnique _x;
				};
				case ("GrenadeLauncher"):
				{
					_resultAllListWP#4 pushBackUnique _x;
				};
				case ("SniperRifle"):
				{
					_resultAllListWP#5 pushBackUnique _x;
				};
			};
		};
	} foreach _weaponsList;

	_resultAllListWP;
};

filterWeaponsAndAccessoryByWeaponClassname = 
{
	params ["_weaponClassname"];
	_resultList = [[],[]];
	_baseWeaponArray = _weaponClassname call BIS_fnc_weaponComponents;
	{
		//filter weapon
		if ([_x] call isAccessory) then 
		{
			_resultList#1 pushBack _x;
		};

		//filter accessory
		if ([_x] call isWeapon) then 
		{
			_resultList#0 pushBack _x;
		};
	} foreach _baseWeaponArray;

	_resultList;
};

parseOpforFaction = 
{
	params ["_opforFaction"];
	//Define Opfor factions 
	{
		_thisFac = _x#1;

		//Parse only selected factions
		if (_thisFac == _opforFaction) then 
		{
			//Define infantry
			_currentFactionName = format ["loadout%1", _thisFac];
			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			//[_thisFac, _currentStuffFaction] call doDefineOpforFactionInfantry;

			//Define mortar 
			_currentFactionName = format ["bluforMortar%1", _thisFac];
			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			if (count _currentStuffFaction > 0) then 
			{
				[_thisFac, "baseEnemyMortarGroup", [_currentStuffFaction#0]] call doSetOpfor;
			};

			//Define vehicle
			_currentFactionName = format ["bluforUnarmedVehicle%1", _thisFac];
			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentFactionName = format ["bluforArmedVehicle%1", _thisFac];
			_currentStuffFaction = _currentStuffFaction + (missionNamespace getVariable [_currentFactionName, []]);
			[_thisFac, "baseEnemyVehicleGroup", _currentStuffFaction] call doSetOpfor;

			_currentFactionName = format ["bluforArmoredVehicle%1", _thisFac];
			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_heavy = [];
			_light = [];
			{
				switch true do {
					case (_x isKindOf 'Tank'):
					{
						_heavy pushBack _x;
					};
					case (_x isKindOf 'Wheeled_APC_F');
					case (_x isKindOf 'APC_Tracked_02_base_F'):
					{
						_light pushBack _x;
					};
				};
			} foreach _currentStuffFaction;
			[_thisFac, "baseEnemyLightArmoredVehicleGroup", _light] call doSetOpfor;
			[_thisFac, "baseEnemyHeavyArmoredVehicleGroup", _heavy] call doSetOpfor;

			_currentFactionName = format ["bluforUnarmedVehicleChopper%1", _thisFac];
			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			[_thisFac, "baseEnemyUnarmedChopperGroup", _currentStuffFaction] call doSetOpfor;

			_currentFactionName = format ["bluforFixedWing%1", _thisFac];
			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			[_thisFac, "baseFixedWingGroup", _currentStuffFaction] call doSetOpfor;

			//Define static
			_currentFactionName = format ["bluforStaticWeapon%1", _thisFac];
			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_static = [];
			{
				_static pushBack [_x, selectRandom ["SMALLBUNKER", "NOTHING"]];
			} foreach _currentStuffFaction;

			[_thisFac, "baseEnemyTurretGroup", _static] call doSetOpfor;
		};

	} foreach factionInfos;

	checkFinishOpforFaction = true;
};
