adjustRole = {
	params ["_cfgRole", "_cfgName"];

	_backpackToTest = (configFile >> "CfgVehicles" >> _cfgName >> "backpack") call BIS_fnc_GetCfgData;
	if (["_Ammo_", _backpackToTest] call BIS_fnc_inString) then 
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
		if (["pilot", _cfgName] call BIS_fnc_inString || ["Pilot", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "pilot";
		};

		if (["marksman", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "marksman";
		};
		if (["sniper", _cfgName] call BIS_fnc_inString || ["ghillie", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "sniper";
		};
		if (["grenadier", _cfgName] call BIS_fnc_inString || ["_GL", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "grenadier";
		};
		if (["_arifleman", _cfgName] call BIS_fnc_inString) then 
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
		if (["_aa", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "at";
		};
		if (["JTAC", _cfgName] call BIS_fnc_inString || ["radioman", _cfgName] call BIS_fnc_inString) then 
		{
			_cfgRole = "radioman";
		};
	};

	_iconToTest = (configFile >> "CfgVehicles" >> _cfgName >> "icon") call BIS_fnc_GetCfgData;

	//Bind role with icon
	switch (_iconToTest) do {
		case "iconManLeader";
		case "iconManOfficer":
		{
			_cfgRole = "leader";
		};
		case "iconManAT":
		{
			_cfgRole = "at";
		};
		case "iconManMedic":
		{
			_cfgRole = "medic";
		};
		case "iconManExplosive";
		case "iconManEngineer":
		{
			_cfgRole = "engineer";
		};		
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

doSetOpfor = {
	params ["_currentFactionName","_opforNameClass", "_existingValues"];
	//diag_log format ["%1%2 : %3",_opforNameClass,_currentFactionName, _existingValues];
	missionNamespace setVariable [format ["%1%2",_opforNameClass,_currentFactionName], _existingValues]; 
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
		_unit = (_loadout#_unitIndex)#1;
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
		_resultAllList#0 append _resultWeaponFiltered#0;
		//filter accessory
		_resultAllList#1 append _resultWeaponFiltered#1;
	} foreach _weaponsList;

	_resultAllList;
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
		if ([_x] call isAccessory) then 
		{
			_resultList#0 pushBack _x;
		};
	} foreach _baseWeaponArray;

	_resultList;
};