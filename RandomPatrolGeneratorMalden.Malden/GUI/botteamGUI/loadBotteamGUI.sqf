//Based on the work of 7erra
//Github : https://github.com/7erra/LNBSort

#include "botteamFunctions.sqf"

params ["_mode", "_this"];

private _mainDisplay = (findDisplay 60000);
private _buttonOK = _mainDisplay displayCtrl 60001;
private _vehicleShopTitle = _mainDisplay displayCtrl 59999;

_vehicleShopTitle ctrlSetText (format ["Team member shop | Credits %1", missionNamespace getVariable "bluforVehicleAvalaibleSpawn"]);

diag_log format ["Init loadSupport GUI"];

switch (_mode) do
{
	case "onLoad":
	{
		_this params ["_display"];
		_lnbEntries = _display displayCtrl 60002;

		//Add support   
		[_lnbEntries] call addInfantryBots;

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

		_bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";

		if (_supportClass != "") then 
		{
			if (_bluforVehicleAvalaibleSpawnCounter>=_supportPrice) then 
			{
				
					//Else (other type of vehicle) do normal spawn around FOB
					//Do something

					_currentFaction = 0;
					if (side player == independent) then 
					{
						//Independent
						_currentFaction = indFaction;

					} else 
					{
						//Blufor
						_currentFaction = bluFaction;
					};

					_bot = [player, _currentFaction, _supportClass, _supportType] call doAddBot;

					//join player unit
					[_bot] joinSilent player;
					_bot doFollow player;

					missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", _bluforVehicleAvalaibleSpawnCounter-_supportPrice, true];
				
				//Close mission setup
				//Refresh title
				(_display displayCtrl 59999) ctrlSetText (format ["Support shop | Credits %1", missionNamespace getVariable "bluforVehicleAvalaibleSpawn"]);
				//_display closeDisplay 1;
			} else 
			{
				[{["STR_RPG_HC_NAME", "STR_RPG_HC_NOT_ENOUGH_CREDIT"] call doDialog}] remoteExec ["call", player];
			};
		};
	}
];