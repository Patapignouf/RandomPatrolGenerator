baseWeaponName = "RPG_Weapon";
basePlayerCreditName = "RPG_UnlockCredit";

baseWeaponCategory = [
		["rifle",[]],
		["smg",[]],
		["launcher",[]],
		["sniperRifle",[]],
		["grenadeLauncher",[]],
		["autoRifle",[]],
		["shortAccessories",[]],
		["longAccessories",[]]
	];

//Get all unlocked weapons for a player faction
getPlayerFactionUnlockedWeapons = {
	params ["_playerFaction"];
	
	_resultOpforWeaponsUnlocked = baseWeaponCategory;

	_allFactionsUnlocked = [] call getAllUnlockedWeapons;
	_playerFactionFindIndex = _allFactionsUnlocked findIf {_playerFaction == _x#0};

	if (_playerFactionFindIndex != -1) then 
	{
		_resultOpforWeaponsUnlocked = _allFactionsUnlocked#_playerFactionFindIndex#1;
	};

	_resultOpforWeaponsUnlocked
};

getPlayerFactionUnlockedWeaponForCategory = {
	params ["_playerFaction", "_category"];
	_tempCategoryResult = [_playerFaction] call getPlayerFactionUnlockedWeapons;
	_tempCategoryResult = (_tempCategoryResult select {_category == _x#0})#0;
	_tempCategoryResult#1
};

getPlayerFactionUnlockedWeaponForCategoryWithUnlockedInput = {
	params ["_playerFaction", "_category", "_tempCategoryResult"];
	_tempCategoryResult = (_tempCategoryResult select {_category == _x#0})#0;
	_tempCategoryResult#1
};


//Get all unlocked weapons and accessories stored on player DB
getAllUnlockedWeapons = {
	_allUnlockedWeapons = profileNamespace getVariable [baseWeaponName,[]];
	_allUnlockedWeapons
};

//Save current unlocked weapon profile to player personal DB
saveAllUnlockedWeapons = {
	params ["_allUnlockedWeaponsToSave"];
	profileNamespace setVariable [baseWeaponName, _allUnlockedWeaponsToSave];
	saveProfileNamespace;
};

//Get all unlocked weapons and accessories stored on player DB
getUnlockCredit = {
	_allUnlockedWeapons = profileNamespace getVariable [basePlayerCreditName, 0];
	_allUnlockedWeapons
};

//Save current unlocked weapon profile to player personal DB
saveUnlockCredit = {
	params ["_unlockCreditToSave"];
	profileNamespace setVariable [basePlayerCreditName, _unlockCreditToSave];
	saveProfileNamespace;
};

// getVariableName = 
// {
// 	params ["_opforFaction"];
// 	_resultVN = format ["%1%2", baseWeaponName, _opforFaction];
// 	_resultVN
// };

//Add
addWeaponToCategory = {
	params ["_weaponToAdd", "_weaponCategory", "_categories"];
	_baseWeaponCategoryCopy = _categories;
	_findWeaponCategory = _baseWeaponCategoryCopy findIf {_weaponCategory == _x#0};
    
	(_baseWeaponCategoryCopy#_findWeaponCategory#1) pushBack _weaponToAdd;
	_baseWeaponCategoryCopy set [_findWeaponCategory ,[_weaponCategory, _baseWeaponCategoryCopy#_findWeaponCategory#1]];

	_baseWeaponCategoryCopy
};

addUnlockedWeapon = {
	params ["_weapon", "_weaponCategory", "_currentFaction"];

	//Get all weapons
	_currentWeapons =  [] call getAllUnlockedWeapons;
	//Get unlocked weapons for this faction
	_weaponIndex = _currentWeapons findIf {_currentFaction == _x#0};

	if (_weaponIndex != -1) then 
	{
		//Add new weapon to the faction
		_weaponsListWithOneMore = [_weapon, _weaponCategory, (_currentWeapons#_weaponIndex)#1] call addWeaponToCategory;
		_currentWeapons set [_weaponIndex, [_currentFaction, _weaponsListWithOneMore]];
	} else 
	{
		_freshWeaponCategory = [_weapon, _weaponCategory, baseWeaponCategory] call addWeaponToCategory;
		_currentWeapons pushBack [_currentFaction, _freshWeaponCategory];
	};

	[_currentWeapons] call saveAllUnlockedWeapons;
};

removeAlreadyUnlockedWeapon = {
	params ["_weaponsListToCheck", "_currentFaction"];
	_listToRemove = [_currentFaction] call getPlayerFactionUnlockedWeapons;
	{
		_catName = _x#0;
		_x set [1,_x#1-((_listToRemove select {_catName ==_x#0})#0#1)]
	} foreach _weaponsListToCheck;
	_weaponsListToCheck
};

removeAlreadyUnlockedWeaponFromFlatList = {
	params ["_weaponsListToCheck", "_currentFaction"];
	_listToRemove = [_currentFaction] call getPlayerFactionUnlockedWeapons;
	{
		_catName = _x#0;
		_weaponName = _x#1;

		if ((((_listToRemove select {_x#0 == _catName})#0)#1 findIf {_x == _weaponName}) != -1 )  then 
		{
			_weaponsListToCheck = _weaponsListToCheck - [_x];
		};

	} foreach _weaponsListToCheck;
	_weaponsListToCheck
};

toFlatDesign = {
	params ["_titleListToFlat"];
	_resultFlat = [];

	{
		_currentCatName = _x#0;
		_currentWeaponsListToFlat = _x#1;

		{
			_resultFlat pushBack [_currentCatName, _x];
		} foreach _currentWeaponsListToFlat;

	} foreach _titleListToFlat;

	_resultFlat
};

getOpforWeaponCategory = {
	params ["_currentOpforFaction"];

	//Get opfor weapon minus player faction 
	_currentPlayerFaction = indFaction;
	if (side player == blufor) then 
	{
		_currentPlayerFaction = bluFaction;
	};

	_resultWPOpfor = [
		[ "rifle",(rifleList_db select {_x select 1  == _currentOpforFaction} select 0 select 0) - (rifleList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "smg",(smgList_db select {_x select 1  == _currentOpforFaction} select 0 select 0) - (smgList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "sniperRifle",(marksmanrifleList_db select {_x select 1  == _currentOpforFaction} select 0 select 0) - (marksmanrifleList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "autoRifle",(autorifleList_db select {_x select 1  == _currentOpforFaction} select 0 select 0) - (autorifleList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "launcher",(launcherList_db select {_x select 1  == _currentOpforFaction} select 0 select 0) - (launcherList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "grenadeLauncher",(grenadeLauncherList_db select {_x select 1  == _currentOpforFaction} select 0 select 0) - (grenadeLauncherList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "shortAccessories",(attachmentShortList_db select {_x select 1  == _currentOpforFaction} select 0 select 0) - (attachmentShortList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "longAccessories", (attachmentLongList_db select {_x select 1  == _currentOpforFaction} select 0 select 0) - (attachmentLongList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)]
	];
	_resultWPOpfor
};

cleanWeaponsAndItems = {
	params ["_listToClean"];

	_cleanList = [];

	//Clean weapons and accessories
	{
		_itemCat = _x#0;
		_itemName = _x#1;
	
		//Check accessories or weapons
		if ((_itemCat == "shortAccessories")||(_itemCat == "longAccessories")) then 
		{
			//Accessories 
			_cleanList pushBackUnique [_itemCat, toLower _itemName];
		} else 
		{
			//Weapons
			if (([configFile >> "CfgWeapons" >> _itemName, true] call BIS_fnc_returnParents) findIf {_x == "ItemCore"} == -1) then 
			{
				_baseWeapon = [_itemName] call BIS_fnc_baseWeapon;
				if (_baseWeapon != "") then 
				{
					_cleanList pushBackUnique [_itemCat, toLower _baseWeapon];
				};
			};
		};

	} foreach _listToClean;

	//Clean duplicate rifle in other specialities
	_baseRifleToClean = _listToClean select {_x#0 == "rifle"};
	{
		_rifleBase = _x#1;
		_listWeaponsToClean = _cleanList select {_x#1 == _rifleBase && _x#0 != "rifle"};
		_cleanList = _cleanList - _listWeaponsToClean;
	} foreach _baseRifleToClean;

	//Clean duplicate smg
	_baseRifleToClean = _listToClean select {_x#0 == "smg"};
	{
		_rifleBase = _x#1;
		_listWeaponsToClean = _cleanList select {_x#1 == _rifleBase && _x#0 != "smg"};
		_cleanList = _cleanList - _listWeaponsToClean;
	} foreach _baseRifleToClean;

	//Clean duplicate accessories
	_baseAccToClean = _listToClean select {_x#0 == "shortAccessories"};
	{
		_rifleBase = _x#1;
		_listWeaponsToClean = _cleanList select {_x#1 == _rifleBase && _x#0 != "shortAccessories"};
		_cleanList = _cleanList - _listWeaponsToClean;
	} foreach _baseAccToClean;

	//Clean non arsenal weapon
	_baseAccToClean = _listToClean select {_x#0 != "shortAccessories" && _x#0 != "longAccessories"};
	{
		_typeBase = _x#0;
		_rifleBase = _x#1;
		_scopeValue = getNumber (configFile >> "CfgWeapons" >> _rifleBase >> "scope");
		if (_scopeValue == 1) then 
		{	
			_weaponIndex = _cleanList findIf {_x#1 == _rifleBase};
			_cleanList deleteAt _weaponIndex;

			_weaponBaseParents = [configFile >> "CfgWeapons" >> _rifleBase, true] call BIS_fnc_returnParents;
			_weaponBaseParents = (_weaponBaseParents select {getNumber (configFile >> "CfgWeapons" >> _x >> "scope")  == 2}) select 0;
			if (_weaponBaseParents != "") then 
			{

				_cleanList pushBackUnique [_typeBase, toLower _weaponBaseParents];
			};
		};
	} foreach _baseAccToClean;

	//Clean duplicate rifle in other specialities
	_baseRifleToClean = _cleanList select {_x#0 == "rifle"};
	{
		_rifleBase = _x#1;
		_listWeaponsToClean = _cleanList select {_x#1 == _rifleBase && _x#0 != "rifle"};
		_cleanList = _cleanList - _listWeaponsToClean;
	} foreach _baseRifleToClean;

	//Clean duplicate smg
	_baseRifleToClean = _cleanList select {_x#0 == "smg"};
	{
		_rifleBase = _x#1;
		_listWeaponsToClean = _cleanList select {_x#1 == _rifleBase && _x#0 != "smg"};
		_cleanList = _cleanList - _listWeaponsToClean;
	} foreach _baseRifleToClean;

	//Clean duplicate accessories
	_baseAccToClean = _cleanList select {_x#0 == "shortAccessories"};
	{
		_rifleBase = _x#1;
		_listWeaponsToClean = _cleanList select {_x#1 == _rifleBase && _x#0 != "shortAccessories"};
		_cleanList = _cleanList - _listWeaponsToClean;
	} foreach _baseAccToClean;


	_cleanList = [_cleanList, [], {_x#0}, "DESCEND"] call BIS_fnc_sortBy;

	diag_log format ["_cleanList = %1", _cleanList];

	_cleanList;
};



defineWeaponPrice = {
	params ["_weaponClassName"];
	_priceResult = 1;

	_cfgWpn = configFile >> "CfgWeapons" >> _weaponClassName;


	if !(isClass _cfgWpn) exitWith {
		diag_log format ["Arme introuvable : %1", _weaponClassName];
	};

	_mags = getArray (_cfgWpn >> "magazines");

	// Si vide, on check les wells
	if (_mags isEqualTo []) then {
		private _wells = getArray (_cfgWpn >> "magazineWell");
		{
			private _well = _x;
			private _magsInWell = getArray (configFile >> "CfgMagazineWells" >> _well >> "magazines");
			_mags append _magsInWell;
		} forEach _wells;
	};

	// Nettoyage doublons
	_mags = _mags arrayIntersect _mags;


	if (_mags isEqualTo []) exitWith {
		diag_log format ["Aucun chargeur trouvé pour %1", _weaponClassName];
	};

	//Take the default mag
	_output = "";
	_rangeEst = 0;
	_hit = 0;
	_cal = 0;
	_spd = 0;
	{
		private _mag = _x;
		private _ammo = getText (configFile >> "CfgMagazines" >> _mag >> "ammo");
		private _cfgAmmo = configFile >> "CfgAmmo" >> _ammo;

		_hit = getNumber (_cfgAmmo >> "hit");
		_cal = getNumber (_cfgAmmo >> "caliber");
		_spd = getNumber (_cfgAmmo >> "typicalSpeed");
		_airF = getNumber (_cfgAmmo >> "airFriction");
		_ttl = getNumber (_cfgAmmo >> "timeToLive");

		// --- Estimation de la portée ---
		private _dt = 0.01; // pas de simulation (s)
		private _t = 0;
		private _v = _spd;
		private _dist = 0;

		while {_t < _ttl && _v > 1} do {
			_dist = _dist + (_v * _dt);
			_v = _v + (_airF * _v * _v * _dt); // perte de vitesse
			_t = _t + _dt;
		};

		_rangeEst = round _dist;

		_output = _output + format [
			"\n\nMagazine : %1\n  Ammo: %2\n  Dégâts (hit): %3\n  Pénétration (caliber): %4\n  Vitesse (m/s): %5\n  AirFriction: %6\n  Durée de vie (s): %7",
			_mag, _ammo, _hit, _cal, _spd, _airF, _ttl
		];
	} foreach [_mags#0]; //Take only the first mag

	//Adjust price with range
	if (_rangeEst > 1500) then 
	{
		_priceResult = _priceResult + 1;
	};

	//Adjust price with range
	if (_cal > 1) then 
	{
		_priceResult = _priceResult + 1;
	};

	//Adjust price with damage
	if (_hit > 15) then 
	{
		_priceResult = _priceResult + 1;
	};

	_priceResult
};

defineScopePrice = {
	params ["_optic"];

	_priceResult = 1;

	private _cfg = configFile >> "CfgWeapons" >> _optic >> "ItemInfo" >> "OpticsModes";

	if !(isClass _cfg) exitWith { hint format["Lunette introuvable : %1", _optic]; _priceResult;};

	private _out = format ["Lunette : %1", _optic];
	private _fovNormal = 0.75; // valeur approximative du FOV normal
	_magMax = 0;

	for "_i" from 0 to (count _cfg - 1) do {
		private _mode = _cfg select _i;
		if (isClass _mode) then {
			private _name = configName _mode;
			private _zMin = getNumber (_mode >> "opticsZoomMin");
			private _zMax = getNumber (_mode >> "opticsZoomMax");
			private _zInit = getNumber (_mode >> "opticsZoomInit");

			private _magMin = if (_zMax > 0) then { round((_fovNormal / _zMax) * 10) / 10 } else {0};
			_magMax = if (_zMin > 0) then { round((_fovNormal / _zMin) * 10) / 10 } else {0};
			private _magInit = if (_zInit > 0) then { round((_fovNormal / _zInit) * 10) / 10 } else {0};

			_out = _out + format [
				"\n\nMode: %1\n Zoom init: x%2\n Zoom min: x%3\n Zoom max: x%4",
				_name, _magInit, _magMin, _magMax
			];
		};
	};

	//Adjust price with range
	if (_magMax > 3) then 
	{
		_priceResult = _priceResult + 1;
	};

	if (_magMax > 10) then 
	{
		_priceResult = _priceResult + 1;
	};

	_priceResult
};