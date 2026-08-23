baseWeaponName = "RPG_Weapon";
basePlayerCreditName = "RPG_UnlockCreditV2";

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

//Convert old token system 
_unblockCredit = profileNameSpace getVariable ["RPG_UnlockCredit",0];
if (_unblockCredit != 0) then 
{
	profileNameSpace setVariable ["RPG_UnlockCredit_Old",_unblockCredit];
	profileNameSpace setVariable ["RPG_UnlockCredit",0];
	profileNameSpace setVariable [basePlayerCreditName, _unblockCredit*100];
};


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

RemoveWeaponFromCategory = {
	params ["_weaponToRemove", "_weaponCategory", "_categories"];
	_baseWeaponCategoryCopy = _categories;
	_findWeaponCategory = _baseWeaponCategoryCopy findIf {_weaponCategory == _x#0};
    //systemChat format ["test : %1", (_baseWeaponCategoryCopy#_findWeaponCategory#1)];
	_baseWeaponCategoryCopy set [_findWeaponCategory ,[_weaponCategory, (_baseWeaponCategoryCopy#_findWeaponCategory#1) select {_x != _weaponToRemove}]];

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
		_currentWeapons pushBackUnique [_currentFaction, _freshWeaponCategory];
	};

	[_currentWeapons] call saveAllUnlockedWeapons;
};

removeUnlockedWeapon = {
	params ["_weapon", "_weaponCategory", "_currentFaction"];

	//Get all weapons
	_currentWeapons =  [] call getAllUnlockedWeapons;
	//Get unlocked weapons for this faction
	_weaponIndex = _currentWeapons findIf {_currentFaction == _x#0};

	//Faction found
	if (_weaponIndex != -1) then 
	{
		//Add new weapon to the faction
		_weaponsListWithOneMore = [_weapon, _weaponCategory, (_currentWeapons#_weaponIndex)#1] call RemoveWeaponFromCategory;
		_currentWeapons set [_weaponIndex, [_currentFaction, _weaponsListWithOneMore]];
	};

	[_currentWeapons] call saveAllUnlockedWeapons;
};

/// Deprecated use removeUnlockedWeapon instead
removeAlreadyUnlockedWeapon = {
	params ["_weaponsListToCheck", "_currentFaction"];
	_listToRemove = [_currentFaction] call getPlayerFactionUnlockedWeapons;
	{
		_catName = _x#0;
		_x set [1,_x#1-((_listToRemove select {_catName ==_x#0})#0#1)]
	} foreach _weaponsListToCheck;
	_weaponsListToCheck
};
///

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

//Get a complete shop with OPFOR items
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

//Get a complete shop with Black market items
getBMWeaponCategory = {
	//Get opfor weapon minus player faction 
	_currentPlayerFaction = indFaction;
	if (side player == blufor) then 
	{
		_currentPlayerFaction = bluFaction;
	};

	_resultWPOpfor = [
		[ "rifle",(BMrifleList) - (rifleList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "smg",(BMsmgList) - (smgList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "sniperRifle",(BMsniperRifleList) - (marksmanrifleList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "autoRifle",(BMautoRifleList) - (autorifleList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "launcher",(BMlauncherList) - (launcherList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "grenadeLauncher",(BMgrenadeLauncherList) - (grenadeLauncherList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "shortAccessories",(BMshortAccessoriesList) - (attachmentShortList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)],
		[ "longAccessories", (BMlongAccessoriesList) - (attachmentLongList_db select {_x select 1  == _currentPlayerFaction} select 0 select 0)]
	];
	_resultWPOpfor
};

//Get a complete shop with both OPFOR and BM
//Test with [missionNamespace getVariable "opforFaction"] call getBMAndOpforWeaponsCategory
getBMAndOpforWeaponsCategory = {
	params ["_currentOpforFaction"];

	_opforShop = [_currentOpforFaction] call getOpforWeaponCategory;
	_bmShop = [] call getBMWeaponCategory;

	//Merge both shops
	{
		_catName = _x#0;
		_temp = _bmShop select {_x#0 == _catName};
		_x set [1, (_x#1)+(_temp#0#1)];

		//systemChat format ["Items %1 %2",_catName,  (_x#1)+(_temp#0#1)];
	} foreach _opforShop;

	//Return merged array
	_opforShop
};

//GetShopList to flat design and remove duplicate
prepareShopList = {
	params ["_shopToClean", "_currentFaction"];

	_shopToClean = [_shopToClean] call toFlatDesign;
	_shopToClean = [_shopToClean] call cleanWeaponsAndItems;
	_shopToClean = [_shopToClean, _currentFaction] call removeAlreadyUnlockedWeaponFromFlatList; //OnlyBluFaction for now 
	
	//Return a clean shop in format [["category", "itemName"],["category2", "itemName2"]]
	_shopToClean
};

//Display a little reward hint with picture of unlocked item
//Test with ["optic_lrps_ghex_f","64"] call displayReward;
displayReward = {
	params ["_supportClass", "_currentFaction"];

	_supportName = getText (configFile >> "CfgWeapons" >> _supportClass >> "displayName");
	_weaponIcon = getText (configFile >> "CfgWeapons" >> _supportClass >> "picture");
	_factionName = (factionInfos select {_x#1 == _currentFaction})#0#2;

	[[parseText format ["<img image='%1' size='5'/><br/><br/><t size='1.5'>You have unlocked <br/> %2 <br/>for the faction %3</t><br/><br/><t size='1.2'></t>", _weaponIcon, _supportName, _factionName], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', player]; 
};


rewardRandomItem = {

	//get current player faction
	_currentFaction = indFaction;
	if (side player == blufor) then 
	{
		_currentFaction = bluFaction;
	};

	//Define full shop OPFOR + Black Market
	_fullShop = [missionNamespace getVariable "opforFaction"] call getBMAndOpforWeaponsCategory;
	_fullShop = [_fullShop, _currentFaction] call prepareShopList;

	//Unlock random item in list
	if (count _fullShop != 0) then 
	{
		//Define item to unlock
		_itemToUnlock = selectRandom _fullShop;
		_supportClass = _itemToUnlock#1;
		_supportType = _itemToUnlock#0;

		//Add unlocked Item to current Faction
		[_supportClass, _supportType, _currentFaction] call addUnlockedWeapon;		

		//Refresh BIS_fnc_arsenal
		[player, player, player call getPlayerFaction] call setupArsenalToItem;

		//Display reward hint
		[_supportClass, _currentFaction] call displayReward;
	} else 
	{
		systemChat "Nothing to unlock";
	};
};

//Increase personal token counter or unlock random stuff from OPFOR or Black market 
//Test [] call shopRelatedReward;
shopRelatedReward = {

	//Check if shop/token reward has been enabled
	if (missionNameSpace getVariable ["enableOpforWeaponShop", 2] != 0) then 
	{
		_rewardMode = missionNameSpace getVariable ["rewardMode", 2];

		//Reward Token
		if (_rewardMode == 0 || (_rewardMode == 2 && (profileNameSpace getVariable ["RPG_rewardMode", "Token"] == "Token"))) then 
		{
			//Get current token number
			_baseTokenReward = 100;
			_unblockCredit = profileNameSpace getVariable [basePlayerCreditName, 0];
			profileNameSpace setVariable [basePlayerCreditName, _unblockCredit+_baseTokenReward];

			["scorePos",["Token", format ["+%1", _baseTokenReward], format ["Total tokens : %1", _unblockCredit+_baseTokenReward]]] call bis_fnc_showNotification;
		};

		//Reward random stuff
		if (_rewardMode == 1 || (_rewardMode == 2 && (profileNameSpace getVariable ["RPG_rewardMode", "Token"] == "Instant"))) then 
		{
			[] call rewardRandomItem;
		};
	};
};

earnToken = {
	params [["_earnedToken", 100]];

	_unblockCredit = profileNameSpace getVariable [basePlayerCreditName, 0];
	profileNameSpace setVariable [basePlayerCreditName, _unblockCredit+_earnedToken];
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
			if (count _weaponBaseParents != 0) then 
			{
				_weaponBaseParent = (_weaponBaseParents select {getNumber (configFile >> "CfgWeapons" >> _x >> "scope")  == 2});

				if (count _weaponBaseParent != 0) then 
				{
					_weaponBaseParent = _weaponBaseParent#0;
					_cleanList pushBackUnique [_typeBase, toLower _weaponBaseParent];
				} else 
				{
					//Check scope in cfgVehicle
					_weaponBaseParent = (_weaponBaseParents select {getNumber (configFile >> "CfgVehicles" >> format ["%1%2","Weapon_",_x] >> "scope")  == 2});
					if (count _weaponBaseParent != 0) then 
					{
						//Remove non functionnal feature :p
						//_weaponBaseParent = _weaponBaseParent#0;
						//_cleanList pushBackUnique [_typeBase, toLower _weaponBaseParent];
					};
				};
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
	_baseSmgToClean = _cleanList select {_x#0 == "smg"};
	{
		_rifleBase = _x#1;
		_listWeaponsToClean = _cleanList select {_x#1 == _rifleBase && _x#0 != "smg"};
		_cleanList = _cleanList - _listWeaponsToClean;
	} foreach _baseSmgToClean;

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
	params [["_priceResult", 100], "_weaponClassName", ["_isBM", false]];

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

	// --- 1) Premier mode de tir
	private _modes = getArray (_cfgWpn >> "modes");
	if (_modes isEqualTo []) exitWith { hint "Pas de modes trouvés."; };
	private _mode = _modes select 0;
	private _cfgMode = _cfgWpn >> _mode;
	if !(isClass _cfgMode) then {
		_score = 100;
	};

	private _disp = getNumber (_cfgMode >> "dispersion");
	if (_disp <= 0) then {_disp = 0.002}; // fallback


	if (_mags isEqualTo []) exitWith {
		diag_log format ["Aucun chargeur trouvé pour %1", _weaponClassName];
	};

	//Take the default mag
	_output = "";
	_rangeEst = 0;
	_hit = 0;
	_cal = 0;
	_spd = 0;
	_score = 0;

	_ammoRange = [];
	_scoreRangeArray = [];
	
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
		private _energy0 = _hit * _spd * _spd;
		private _energy = _energy0;
		private _v = _spd;
		private _t = 0;
		private _dt = 0.01;
		private _dist = 0;
		private _rangeEff = 0;
		private _found = false;

		// simulation du vol
		while {_t < _ttl && _v > 1} do {
			_dist = _dist + (_v * _dt);
			_v = _v + (_airF * _v * _v * _dt);
			_energy = _hit * _v * _v;
			if (!_found && _energy < (_energy0 * 0.5)) then {
				_rangeEff = _dist;
				_found = true;
			};
			_t = _t + _dt;
		};

		private _rangeMax = round _dist;
		private _rangeEffFinal = if (_found) then {round _rangeEff} else {_rangeMax};
		_ammoRange pushBackUnique _rangeEffFinal;

		private _refDisp = 0.002;   // rad
		private _refPower = 10 * 1.0; // hit*caliber
		private _refRange = 600;    // m

		private _power = _hit * _cal;
		private _scoreDisp = (1 - (_disp / _refDisp)) max 0 min 1; 
		private _scorePower = (_power / _refPower) min 1;
		private _scoreRange = (_rangeEffFinal / _refRange) min 1;

		// pondération
		private _score = (_scoreDisp * 0.4 + _scorePower * 0.3 + _scoreRange * 0.3) * 100;
		_scoreRangeArray pushBackUnique _score;

		_output = _output + format [
			"\n\nMagazine : %1\n  Ammo: %2\n  Dégâts (hit): %3\n  Pénétration (caliber): %4\n  Vitesse (m/s): %5\n  AirFriction: %6\n  Durée de vie (s): %7",
			_mag, _ammo, _hit, _cal, _spd, _airF, _ttl
		];
	} foreach _mags; //Take only the first mag

	_rangeEst = selectMax _ammoRange;
	_score = selectMax _scoreRangeArray;
	_multiplier = 1;

	if (_isBM) then 
	{
		_multiplier = 2;
	};

	//Adjust price with range
	if (_rangeEst > 1500) then 
	{
		_priceResult = _priceResult + 50*_multiplier;
	};

	//Adjust price with range
	if (_cal > 1) then 
	{
		_priceResult = _priceResult + 50*_multiplier;
	};

	//Adjust price with damage
	if (_hit > 10) then 
	{
		_priceResult = _priceResult + 30*_multiplier;
	};

	//systemChat str _score;

	[_priceResult, _hit, _rangeEst, getText (configFile >> "CfgMagazines" >> _mags#0 >> "displayName"), _score];
};

defineScopePrice = {
	params [["_priceResult", 50], "_optic", ["_isBM", false]];

	private _cfg = configFile >> "CfgWeapons" >> _optic >> "ItemInfo" >> "OpticsModes";

	if !(isClass _cfg) exitWith { 
		//hint format["Lunette introuvable : %1", _optic]; 
		_priceResult;
		};

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

	_multiplier = 1;

	if (_isBM) then 
	{
		_multiplier = 2;
	};

	//Adjust price with range
	if (_magMax > 3) then 
	{
		_priceResult = _priceResult + 30*_multiplier;
	};

	if (_magMax > 10) then 
	{
		_priceResult = _priceResult + 50*_multiplier;
	};

	_priceResult
};