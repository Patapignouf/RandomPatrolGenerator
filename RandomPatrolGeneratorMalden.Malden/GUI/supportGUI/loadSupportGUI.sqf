//Based on the work of 7erra
//Github : https://github.com/7erra/LNBSort

#include "supportFunctions.sqf"

params ["_mode", "_this"];

private _mainDisplay = (findDisplay 60000);
private _buttonOK = _mainDisplay displayCtrl 60001;
private _vehicleShopTitle = _mainDisplay displayCtrl 59999;

_vehicleShopTitle ctrlSetText (format ["Support shop | Credits %1", missionNamespace getVariable "bluforVehicleAvalaibleSpawn"]);

diag_log format ["Init loadSupport GUI"];

switch (_mode) do
{
	case "onLoad":
	{
		_this params ["_display"];
		_lnbEntries = _display displayCtrl 60002;

		//Add support   
		[_lnbEntries] call addSupportForReinforcement;
		[_lnbEntries] call addSupportForForceReinforcement;

		if (enableHalo == 1) then 
		{
			[_lnbEntries] call addSupportForHALO;
		};
		
		//Add support for leader
		if (player getVariable "role" == "leader") then 
		{
			[_lnbEntries] call addCallForReinforcement;
			[_lnbEntries] call addSupportForArtillery;
			[_lnbEntries] call addSupportForIntel;
			[_lnbEntries] call addSupportForAirDrop;
			if (count (bluforUnarmedVehicleChopper+bluforExtractVehicleChopper) > 0) then 
			{
				[_lnbEntries] call addSupportForExtract;
				[_lnbEntries] call addSupportForTransport;
			};
			// if (missionNamespace getVariable ["warEra", 0] >= 2) then 
			// {
			// 	[_lnbEntries] call addSupportForDroneRecon;
			// };
		};

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
		_supportPrice = parseNumber (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 2]);

		_bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";

		if (_supportClass != "") then 
		{
			if (_bluforVehicleAvalaibleSpawnCounter>=_supportPrice) then 
			{
				
					//Else (other type of vehicle) do normal spawn around FOB
					//Do something
					[player, _supportClass] call doSupport;

					missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", _bluforVehicleAvalaibleSpawnCounter-_supportPrice, true];
				
				//Close mission setup
				//Refresh title
				(_display displayCtrl 59999) ctrlSetText (format ["Support shop | Credits %1", missionNamespace getVariable "bluforVehicleAvalaibleSpawn"]);
				//_display closeDisplay 1;
			} else 
			{
				_textToSpeech = "You don't have enough credit left.";
				[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", player, true];
			};
		};
	}
];