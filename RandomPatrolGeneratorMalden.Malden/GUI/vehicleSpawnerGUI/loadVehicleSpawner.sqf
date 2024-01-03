#include "..\..\objectGenerator\vehicleManagement.sqf"

//Based on the work of 7erra
//Github : https://github.com/7erra/LNBSort
params ["_mode", "_this"];

private _mainDisplay = (findDisplay 50000);
private _buttonOK = _mainDisplay displayCtrl 50001;

switch (_mode) do
{
	case "onLoad":
	{
		_this params ["_display"];
		_lnbEntries = _display displayCtrl 50002;
		_cfgs = "true" configClasses (configFile >> "CfgVehicles");
		_names = _cfgs apply {[_x] call BIS_fnc_displayname};
		_cfgNames = _cfgs apply {configName _x};

		{
			_price = 100;
			_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
			_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
			_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Light vehicle", str _price];
    		_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
			_lnbEntries lnbSetData [[_ind, 0], _x];
			_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
			_lnbEntries lnbSetData [[_ind, 2], str _price];
		} foreach bluforUnarmedVehicle;

		{
			_price = 300;
			_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
			_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
			_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Armed vehicle", str _price];
			_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
			_lnbEntries lnbSetData [[_ind, 0], _x];
			_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
			_lnbEntries lnbSetData [[_ind, 2], str _price];
		} foreach bluforArmedVehicle;

		//Add armored vehicle for blufor
		if (enableArmoredVehicle) then 
		{
			{
				_price = 700;
				_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
				_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
				_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Armored vehicle", str _price];
				_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
				_lnbEntries lnbSetData [[_ind, 0], _x];
				_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
				_lnbEntries lnbSetData [[_ind, 2], str _price];
			} foreach bluforArmoredVehicle;
		};

		//Unarmed Chopper

		{
			_price = 400;
			_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
			_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
			_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Unarmed helicopter", str _price];
			_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
			_lnbEntries lnbSetData [[_ind, 0], _x];
			_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
			_lnbEntries lnbSetData [[_ind, 2], str _price];
		} foreach bluforUnarmedVehicleChopper;

		//Add armored vehicle for blufor
		if (enableArmedAicraft) then 
		{
			{
				_price = 500;
				_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
				_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
				_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Armed helicopter", str _price];
				_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
				_lnbEntries lnbSetData [[_ind, 0], _x];
				_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
				_lnbEntries lnbSetData [[_ind, 2], str _price];
			} foreach bluforArmedChopper;

			{
				_price = 500;
				_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
				_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
				_ind = _lnbEntries lnbAddRow ["", _vehicleName, "UAV", str _price];
				_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
				_lnbEntries lnbSetData [[_ind, 0], _x];
				_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
				_lnbEntries lnbSetData [[_ind, 2], str _price];
			} foreach bluforDrone;

			{
				_price = 600;
				_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
				_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
				_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Fixed wing aircraft", str _price];
				_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
				_lnbEntries lnbSetData [[_ind, 0], _x];
				_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
				_lnbEntries lnbSetData [[_ind, 2], str _price];
			} foreach bluforFixedWing;
		};

		// for "_i" from 0 to 30 do {
		// 	_rInd = floor random (count _cfgs);
		// 	_ind = _lnbEntries lnbAddRow [_vehicleName,_cfgNames#_rInd, _names#_rInd, str _rInd];
		// 	_lnbEntries lnbSetValue [[_ind,2],_rInd];
		// };

		for "_idc" from 2400 to 2402 do {
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
		_column = [2400,2401,2402] find ctrlIDC _ctrl;
		_reverse = _ctrl getVariable "reverseSort";
		if (_column == 2) then {
			_lnbEntries lnbSortByValue [_column,_reverse];
		} else {
			_lnbEntries lnbSort [_column,_reverse];
		};
		_ctrl setVariable ["reverseSort",!_reverse];
	};
};


_buttonOK ctrlAddEventHandler[ "ButtonClick", 
	{ 
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		//Spawn vehicle
		_lnbEntries = _display displayCtrl 50002;
		_vehicleClassToSpawn = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 0]);
		_vehicleNameToSpawn = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 1]);
		_vehiclePriceToSpawn = parseNumber (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 2]);
		_vehicleIsUAV = getText (configFile >> "CfgVehicles" >> _vehicleClassToSpawn >> "textSingular") == "UAV";

		_bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";

		if (_bluforVehicleAvalaibleSpawnCounter>=_vehiclePriceToSpawn) then 
		{
			//Check if this is a plane
			if (_vehicleClassToSpawn isKindOf "Plane") then 
			{
					//Open map and spawn plane
					[_vehicleClassToSpawn, _vehiclePriceToSpawn, _vehicleNameToSpawn, _bluforVehicleAvalaibleSpawnCounter] spawn {
						params ["_vehicleClassToSpawn", "_vehiclePriceToSpawn", "_vehicleNameToSpawn", "_bluforVehicleAvalaibleSpawnCounter"];

						//Click on map to spawn
						selectedLoc = [0,0,0];
						openMap true;
						uiSleep 1;

						["<t color='#ffffff' size='.8'>Click on map to spawn an aircraft and teleport<br />The aircraft will spawn oriented on the north</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
						onMapSingleClick "selectedLoc = _pos; onMapSingleClick ''; openMap false; true;";
						waitUntil{!(visibleMap)};  
						if (!([selectedLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
						{
							_spawnedVehicle = createVehicle [_vehicleClassToSpawn, selectedLoc, [], 0, "NONE"];
							player moveInAny (vehicle _spawnedVehicle);

							//Reduce avalaible spawn counter
							missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, true];
							hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, _vehicleNameToSpawn];
						};
					};	
			} else 
			{
				//Else (other type of vehicle) do normal spawn around FOB
				[_vehicleClassToSpawn, _vehicleIsUAV] spawn {
					params ["_vehicleClassToSpawn", "_vehicleIsUAV"];
					[initBlueforLocation, [[_vehicleClassToSpawn, _vehicleIsUAV]], 30, 100] call doGenerateVehicleForFOB;	
				};	

				missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, true];
				hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, _vehicleNameToSpawn];
			};


			//Close mission setup
			_display closeDisplay 1;
		} else 
		{
			hint "You don't have enough credit left.";
		};
	}
];
