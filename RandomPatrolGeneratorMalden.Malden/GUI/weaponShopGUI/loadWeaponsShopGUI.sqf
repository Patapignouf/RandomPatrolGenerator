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

_vehicleShopTitle ctrlSetText (format ["Weapon shop | Unlock Token %1", [] call getUnlockCredit]);
_icon ctrlSetText (localize "STR_GUI_BASE_ICON");
_name ctrlSetText (localize "STR_GUI_BASE_WEAPON_NAME");
_type ctrlSetText (localize "STR_GUI_BASE_WEAPON_TYPE");
_credit ctrlSetText (localize "STR_GUI_BASE_TOKEN");
_buy ctrlSetText (localize "STR_GUI_BASE_UNLOCK");

diag_log format ["Init loadSupport GUI"];

switch (_mode) do
{
	case "onLoad":
	{
		_this params ["_display"];
		_lnbEntries = _display displayCtrl 60002;

		//Add support   
		_opFactionWeapon = [opFaction] call getOpforWeaponCategory;

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
			_price = 1;
			_weaponClassName = _x#1;
			_supportName = getText (configFile >> "CfgWeapons" >> _weaponClassName >> "displayName");
			_supportNameCode = "";
			switch (_x#0) do 
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

			_supportIcon = getText (configFile >> "CfgWeapons" >> _weaponClassName >> "picture");
			_supportType = _x#0;

			//Add row for support
			_ind = _ctrl lnbAddRow ["", _supportName, _supportNameCode, str _price];

			//Set picture
			_ctrl lnbSetPicture [[_ind, 0], _supportIcon];

			//Set data
			_ctrl lnbSetData [[_ind, 0], _weaponClassName];
			_ctrl lnbSetData [[_ind, 1], _supportType];
			_ctrl lnbSetData [[_ind, 2], str _price];
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


_buttonOK ctrlAddEventHandler [ "ButtonClick", 
	{ 
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		//Spawn vehicle
		_lnbEntries = _display displayCtrl 60002;
		_supportClass = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 0]);
		_supportType = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 1]);
		_supportPrice = parseNumber (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 2]);

		_bluforVehicleAvalaibleSpawnCounter = [] call getUnlockCredit;

		if (_supportClass != "") then 
		{
			if (_bluforVehicleAvalaibleSpawnCounter>=_supportPrice) then 
			{
				//get current player faction
				_currentFaction = indFaction;
				if (side player == blufor) then 
				{
					_currentFaction = bluFaction;
				};

				[_supportClass, _supportType, _currentFaction] call addUnlockedWeapon;		

				[_bluforVehicleAvalaibleSpawnCounter-_supportPrice] call saveUnlockCredit;
			
				[player, player, player call getPlayerFaction] call setupArsenalToItem;

				//Close mission setup
				//Refresh title
				(_display displayCtrl 59999) ctrlSetText (format ["Weapon shop | Unlock Token %1", [] call getUnlockCredit]);
				_display closeDisplay 1;

				//Restart arsenal GUI
				[] execVM "GUI\LoadoutGUI\initPlayerLoadoutSetupRemake.sqf"
			} else 
			{
				[{["STR_RPG_HC_NAME", "STR_RPG_HC_NOT_ENOUGH_CREDIT"] call doDialog}] remoteExec ["call", player];
			};
		};
	}
];