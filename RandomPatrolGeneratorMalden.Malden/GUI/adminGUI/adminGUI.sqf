//Based on the work of 7erra
//Github : https://github.com/7erra/LNBSort

#include "adminFunctions.sqf"

params ["_mode", "_this"];

private _mainDisplay = (findDisplay 60000);
private _buttonOK = _mainDisplay displayCtrl 60001;
private _vehicleShopTitle = _mainDisplay displayCtrl 59999;

diag_log format ["Init admin GUI"];

switch (_mode) do
{
	case "onLoad":
	{
		_this params ["_display"];
		_lnbEntries = _display displayCtrl 60002;

		//Add support   
		[_lnbEntries] call addRespawn;
		[_lnbEntries] call addDifficultyIncrease;
		[_lnbEntries] call addDifficultyDecrease;
		[_lnbEntries] call addVehicleSpawnerGUI;
		[_lnbEntries] call addSupportGUI;
		[_lnbEntries] call addCredit;
		[_lnbEntries] call addClearWeather;
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
		_adminOption = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 0]);

		//Do something
		[_adminOption] call doAdminStuff;
	}
];