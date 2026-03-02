//Based on the work of 7erra
//Github : https://github.com/7erra/LNBSort

#include "weaponShopFunctions.sqf"

params ["_mode", "_this", "_specialParam"];

private _mainDisplay = (findDisplay 60000);
private _buttonOK = _mainDisplay displayCtrl 60001;
private _vehicleShopTitle = _mainDisplay displayCtrl 59999;
private _icon = _mainDisplay displayCtrl 602399;
private _name = _mainDisplay displayCtrl 602400;
private _type = _mainDisplay displayCtrl 602401;
private _credit = _mainDisplay displayCtrl 602402;
private _buy = _mainDisplay displayCtrl 60001;
private _buttonRandom = _mainDisplay displayCtrl 60003;

_openArsenal = _specialParam#0;
_shopMode = _specialParam#1;

randomPrice = 1;
if (_shopMode == "OPFOR") then 
{
	_vehicleShopTitle ctrlSetText (format ["%2 | Unlock Token %1", [] call getUnlockCredit, localize "RPG_GUI_GENERAL_WEAPON_SHOP"]);

} else 
{
	_vehicleShopTitle ctrlSetText (format ["%2 | Unlock Token %1", [] call getUnlockCredit, localize "RPG_GUI_GENERAL_BM_SHOP"]);

	//hide random buy
	randomPrice = 5;
};

_icon ctrlSetText (localize "STR_GUI_BASE_ICON");
_name ctrlSetText (localize "STR_GUI_BASE_WEAPON_NAME");
_type ctrlSetText (localize "STR_GUI_BASE_WEAPON_TYPE");
_credit ctrlSetText (localize "STR_GUI_BASE_TOKEN");
_buy ctrlSetText (localize "STR_GUI_BASE_UNLOCK");

_buttonRandom ctrlSetText (format ["%1 : %2", localize "STR_GUI_BASE_RANDOM", randomPrice]);

diag_log format ["Init loadSupport GUI"];

switch (_mode) do
{
	case "onLoad":
	{
		_this params ["_display"];
		_lnbEntries = _display displayCtrl 60002;

		//Add support   
		_opFactionWeapon = [];
		if (_shopMode == "OPFOR") then 
		{
			_opFactionWeapon = [missionNamespace getVariable "opforFaction"] call getOpforWeaponCategory;

		} else 
		{
			_opFactionWeapon = [] call getBMWeaponCategory;
		};

		_currentFaction = indFaction;
		if (side player == blufor) then 
		{
			_currentFaction = bluFaction;
		};
		_ctrl = _lnbEntries;

		_opFactionWeapon = [_opFactionWeapon] call toFlatDesign;
		_opFactionWeapon = [_opFactionWeapon] call cleanWeaponsAndItems;
		_opFactionWeapon = [_opFactionWeapon, _currentFaction] call removeAlreadyUnlockedWeaponFromFlatList; //OnlyBluFaction for now 

		{
			_weaponClassName = _x#1;
			_categoryName = _x#0;
			_supportName = getText (configFile >> "CfgWeapons" >> _weaponClassName >> "displayName");
			_supportNameCode = "";
			switch (_categoryName) do 
			{
				case "rifle":
				{
					_supportNameCode = "Medium range";
				};
				case "smg":
				{
					_supportNameCode = "Short range";
				};
				case "grenadeLauncher":
				{
					_supportNameCode = localize "STR_RPG_LOADOUT_ROLE_GRENADIER";
				};
				case "launcher":
				{
					_supportNameCode = localize "STR_RPG_LOADOUT_ROLE_AT";
				};
				case "sniperRifle":
				{
					_supportNameCode = localize "STR_RPG_LOADOUT_ROLE_MARKSMAN";
				};
				case "autoRifle":
				{
					_supportNameCode = localize "STR_RPG_LOADOUT_ROLE_AUTORIFLEMAN";
				};
				case "shortAccessories":
				{
					_supportNameCode = "Base accessories";
				};
				case "longAccessories":
				{
					_supportNameCode = localize "STR_RPG_LOADOUT_ROLE_MARKSMAN";
				};
			};

			_price = 1; //Set default price of 1 for accessories
			_priceAnalysisReturn = [];

			if (_categoryName != "shortAccessories" && _categoryName != "longAccessories") then 
			{
				_priceAnalysisReturn = [_weaponClassName] call defineWeaponPrice;
				_price = _priceAnalysisReturn#0;
				//systemChat format ["Impact : %1 \nMax range : %2", _priceAnalysisReturn#1, _priceAnalysisReturn#2];
			} else 
			{
				_price = [_weaponClassName] call defineScopePrice;
			};

			_supportIcon = getText (configFile >> "CfgWeapons" >> _weaponClassName >> "picture");
			_supportType = _x#0;

			//Add row for support
			if (_shopMode == "BM") then 
			{
				//Increase price of Black market item by 5
				_price = _price + 5;
			};

			if (typeName _price == "SCALAR") then 
			{
				_ind = _ctrl lnbAddRow ["", _supportName, _supportNameCode, str _price];
			
				//Set tooltip
				if (count _priceAnalysisReturn != 0) then 
				{
					//_ctrl lnbSetTooltip [_ind, format ["Impact : %1 \nMax range : %2m", _priceAnalysisReturn#1, _priceAnalysisReturn#2]];
					_ctrl lnbSetTooltip [[_ind,0], format ["Impact : %1 \nMax range : %2m\nDefault ammo : %3\nAccuracy : %4%%", _priceAnalysisReturn#1, _priceAnalysisReturn#2, _priceAnalysisReturn#3, _priceAnalysisReturn#4]];
				};

				//Set picture
				_ctrl lnbSetPicture [[_ind, 0], _supportIcon];

				//Set data
				_ctrl lnbSetData [[_ind, 0], _weaponClassName];
				_ctrl lnbSetData [[_ind, 1], _supportType];
				_ctrl lnbSetData [[_ind, 2], str _price];
				_ctrl lnbSetData [[_ind, 3], _supportName];
			};

		} foreach (_opFactionWeapon);


		for "_idc" from 602400 to 602402 do {
			_btn = _display displayCtrl _idc;
			_btn setVariable ["reverseSort",false];
			_btn ctrlAddEventHandler ["ButtonClick",{
				["sortCol",[ctrlParent (_this#0)] +_this] execVM "GUI\vehicleSpawnerGUI\loadVehicleSpawner.sqf";
			}];
		};
	};
	case "sortCol":{
		params ["_display","_ctrl"];
		_lnbEntries = _display displayCtrl 1500;
		_column = [602400,602401,602402] find ctrlIDC _ctrl;
		_reverse = _ctrl getVariable "reverseSort";
		if (_column == 2) then {
			_lnbEntries lnbSortByValue [_column,_reverse];
		} else {
			_lnbEntries lnbSort [_column,_reverse];
		};
		_ctrl setVariable ["reverseSort",!_reverse];
	};
};

//Add a button to buy random item
_buttonRandom ctrlAddEventHandler [ "ButtonClick", 
	{ 
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		//
		_lnbEntries = _display displayCtrl 60002;
		_numberOfRows = (lnbSize _lnbEntries)#0;
		_lnbEntries lnbSetCurSelRow (floor random (_numberOfRows - 1)); //Select random index
		//hint (format ["number of entries : %1", _numberOfRows ]);
		_supportClass = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 0]);
		_supportType = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 1]);
		_supportPrice = randomPrice;
		_supportName = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 3]);
		_weaponIcon = getText (configFile >> "CfgWeapons" >> _supportClass >> "picture");

		_bluforVehicleAvalaibleSpawnCounter = [] call getUnlockCredit;

		if (_supportClass != "") then 
		{
			if (_bluforVehicleAvalaibleSpawnCounter>=_supportPrice) then 
			{
				//Remove entry 
				_lnbEntries lnbDeleteRow (lnbCurSelRow _lnbEntries);

				//get current player faction
				_currentFaction = indFaction;
				if (side player == blufor) then 
				{
					_currentFaction = bluFaction;
				};

				[_supportClass, _supportType, _currentFaction] call addUnlockedWeapon;		

				[_bluforVehicleAvalaibleSpawnCounter-_supportPrice] call saveUnlockCredit;
			
				[player, player, player call getPlayerFaction] call setupArsenalToItem;
				hint parseText format ["<img image='%1' size='5'/><br/><br/><t size='1.5'>You have unlocked <br/> %2 <br/>for the faction %3</t><br/><br/><t size='1.2'></t>", _weaponIcon, _supportName, _currentFaction];

				//Close mission setup
				//Refresh title
				if (shopMode == "OPFOR") then 
				{
					(_display displayCtrl 59999) ctrlSetText (format ["%2 | Unlock Token %1", [] call getUnlockCredit, localize "RPG_GUI_GENERAL_WEAPON_SHOP"]);

				} else 
				{
					(_display displayCtrl 59999) ctrlSetText (format ["%2 | Unlock Token %1", [] call getUnlockCredit, localize "RPG_GUI_GENERAL_BM_SHOP"]);
				};

			} else 
			{
				[{["STR_RPG_HC_NAME", "STR_RPG_HC_NOT_ENOUGH_CREDIT"] call doDialog}] remoteExec ["call", player];
			};
		};
	}
];

shopMode = _shopMode;
_buttonOK ctrlAddEventHandler [ "ButtonClick", 
	{ 
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		//Select item to buy
		_lnbEntries = _display displayCtrl 60002;
		_supportClass = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 0]);
		_supportType = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 1]);
		_supportPrice = parseNumber (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 2]);
		_supportName = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 3]);
		_weaponIcon = getText (configFile >> "CfgWeapons" >> _supportClass >> "picture");

		_bluforVehicleAvalaibleSpawnCounter = [] call getUnlockCredit;

		if (_supportClass != "") then 
		{
			if (_bluforVehicleAvalaibleSpawnCounter>=_supportPrice) then 
			{
				//Remove entry 
				_lnbEntries lnbDeleteRow (lnbCurSelRow _lnbEntries);

				//get current player faction
				_currentFaction = indFaction;
				if (side player == blufor) then 
				{
					_currentFaction = bluFaction;
				};

				[_supportClass, _supportType, _currentFaction] call addUnlockedWeapon;		

				[_bluforVehicleAvalaibleSpawnCounter-_supportPrice] call saveUnlockCredit;
			
				[player, player, player call getPlayerFaction] call setupArsenalToItem;
				hint parseText format ["<img image='%1' size='5'/><br/><br/><t size='1.5'>You have unlocked <br/> %2 <br/>for the faction %3</t><br/><br/><t size='1.2'></t>", _weaponIcon, _supportName, _currentFaction];

				//Close mission setup
				//Refresh title
				if (shopMode == "OPFOR") then 
				{
					(_display displayCtrl 59999) ctrlSetText (format ["%2 | Unlock Token %1", [] call getUnlockCredit, localize "RPG_GUI_GENERAL_WEAPON_SHOP"]);

				} else 
				{
					(_display displayCtrl 59999) ctrlSetText (format ["%2 | Unlock Token %1", [] call getUnlockCredit, localize "RPG_GUI_GENERAL_BM_SHOP"]);
				};

			} else 
			{
				[{["STR_RPG_HC_NAME", "STR_RPG_HC_NOT_ENOUGH_CREDIT"] call doDialog}] remoteExec ["call", player];
			};
		};
	}
];

waitUntil {isNull _mainDisplay};

if (_openArsenal) then 
{
	//Restart arsenal GUI
	[] execVM "GUI\LoadoutGUI\initPlayerLoadoutSetupRemake.sqf";
};

