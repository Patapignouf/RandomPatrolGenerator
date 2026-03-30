#include "..\..\objectGenerator\vehicleManagement.sqf"

//Based on the work of 7erra
//Github : https://github.com/7erra/LNBSort
params ["_mode", "_this", "_VehicleAvalaibleSpawn","_UnarmedVehicle","_ArmedVehicle","_ArmoredVehicle","_UnarmedVehicleChopper","_ArmedChopper","_Drone","_FixedWing", "_FixedWingTransport","_Boat", "_staticWeapons"];
private _mainDisplay = (findDisplay 50000);
private _buttonOK = _mainDisplay displayCtrl 50001;
private _buttonPreview = _mainDisplay displayCtrl 50003;
private _vehicleShopTitle = _mainDisplay displayCtrl 49999;

_vehicleShopTitle ctrlSetText (format ["Vehicle shop | Credits %1", missionNamespace getVariable _VehicleAvalaibleSpawn]);

_mainDisplay setVariable ["VehicleAvalaibleSpawn", _VehicleAvalaibleSpawn];

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
		} foreach _UnarmedVehicle;

		{
			_price = 300;
			_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
			_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
			_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Armed vehicle", str _price];
			_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
			_lnbEntries lnbSetData [[_ind, 0], _x];
			_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
			_lnbEntries lnbSetData [[_ind, 2], str _price];
		} foreach _ArmedVehicle;

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
			} foreach _ArmoredVehicle;
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
		} foreach _UnarmedVehicleChopper;

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
			} foreach _ArmedChopper;

			{
				_price = 500;
				_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
				_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
				_ind = _lnbEntries lnbAddRow ["", _vehicleName, "UAV", str _price];
				_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
				_lnbEntries lnbSetData [[_ind, 0], _x];
				_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
				_lnbEntries lnbSetData [[_ind, 2], str _price];
			} foreach _Drone;

			{
				_price = 600;
				_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
				_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
				_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Fixed wing aircraft", str _price];
				_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
				_lnbEntries lnbSetData [[_ind, 0], _x];
				_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
				_lnbEntries lnbSetData [[_ind, 2], str _price];
			} foreach _FixedWing;

			{
				_price = 400;
				_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
				_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
				_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Transport aircraft", str _price];
				_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
				_lnbEntries lnbSetData [[_ind, 0], _x];
				_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
				_lnbEntries lnbSetData [[_ind, 2], str _price];
			} foreach _FixedWingTransport;
		};

		//Add ships
		{
			_price = 200;
			_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
			_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
			_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Ship", str _price];
			_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
			_lnbEntries lnbSetData [[_ind, 0], _x];
			_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
			_lnbEntries lnbSetData [[_ind, 2], str _price];
		} foreach _Boat;

		//Add static weapons
		{
			_price = 50;
			_vehicleName = getText (configFile >> "cfgVehicles" >> _x >> "displayName");
			_vehiclePicture = getText (configFile >> "cfgVehicles" >> _x >> "picture");
			_ind = _lnbEntries lnbAddRow ["", _vehicleName, "Static", str _price];
			_lnbEntries lnbSetPicture [[_ind, 0], _vehiclePicture];
			_lnbEntries lnbSetData [[_ind, 0], _x];
			_lnbEntries lnbSetData [[_ind, 1], _vehicleName];
			_lnbEntries lnbSetData [[_ind, 2], str _price];
		} foreach _staticWeapons;

		for "_idc" from 2400 to 2402 do {
			_btn = _display displayCtrl _idc;
			_btn setVariable ["reverseSort",false];
			_btn ctrlAddEventHandler ["ButtonClick",{
				["sortCol",[ctrlParent (_this#0)] +_this , _VehicleAvalaibleSpawn, _UnarmedVehicle, _ArmedVehicle, _ArmoredVehicle, _UnarmedVehicleChopper, _ArmedChopper, _Drone, _FixedWing, _FixedWingTransport, _Boat] execVM "GUI\vehicleSpawnerGUI\loadVehicleSpawnerCarrier.sqf";
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
		_vehicleIsUAV = _vehicleClassToSpawn isKindOf "UAV";

		_VehicleAvalaibleSpawnName = _display getVariable "VehicleAvalaibleSpawn";
		_bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable _VehicleAvalaibleSpawnName;
		
		if (_vehicleClassToSpawn != "") then 
		{
			if (_bluforVehicleAvalaibleSpawnCounter>=_vehiclePriceToSpawn) then 
			{
				
				if (_vehicleClassToSpawn isKindOf "Ship") then 
				{
					//Spawn ship
					//Open map and spawn plane
					[_vehicleClassToSpawn, _vehiclePriceToSpawn, _VehicleAvalaibleSpawnName, _vehicleNameToSpawn, _bluforVehicleAvalaibleSpawnCounter] spawn {
						params ["_vehicleClassToSpawn", "_vehiclePriceToSpawn", "_VehicleAvalaibleSpawnName", "_vehicleNameToSpawn", "_bluforVehicleAvalaibleSpawnCounter"];

						//Click on map to spawn
						selectedLoc = [0,0,0];
						openMap true;
						uiSleep 1;

						["<t color='#ffffff' size='.8'>Click on map to spawn an ship<br />The ship will spawn oriented on the north</t>",0,0,2,0,0,789] spawn BIS_fnc_dynamicText;
						onMapSingleClick "selectedLoc = _pos; onMapSingleClick ''; openMap false; true;";
						waitUntil{!(visibleMap)};  
						if (!([selectedLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
						{
							_spawnedVehicle = createVehicle [_vehicleClassToSpawn, selectedLoc, [], 0, "NONE"];
							//player moveInAny (vehicle _spawnedVehicle);

							//Reduce avalaible spawn counter
							missionNamespace setVariable [_VehicleAvalaibleSpawnName, _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, true];
							hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, _vehicleNameToSpawn];
						};
					};
				} else 
				{

					//Reduce avalaible spawn counter
					missionNamespace setVariable [_VehicleAvalaibleSpawnName, _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, true];
					hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, _vehicleNameToSpawn];

					_index = missionNameSpace getVariable ["AicraftCarrierBluforIndex", 0];
					_spawnPositions = missionNameSpace getVariable ["AicraftCarrierBluforSpawn", []];



					if ((count _spawnPositions)-1 < _index  ) then 
					{
						_index = 0;
					};

					if (_vehicleIsUAV && _vehicleClassToSpawn isKindOf "Plane") then 
					{
						//UAV spawn is only avalaible for blufor
						_thisPosition = _spawnPositions#_index;
						//systemChat format ["test pos : %1", _thisPosition];
						_tempPos = [_thisPosition select 0, _thisPosition select 1];
						_tempPos pushBack ((_thisPosition select 2)+1400); //Set 3 dimension position
						//_currentUAVArray = [_tempPos, 0, _vehicleClass, blufor] call BIS_fnc_spawnVehicle;
						_currentVehicle = createVehicle [_vehicleClassToSpawn,  [_tempPos#0, _tempPos#1, _tempPos#2+100], [], 0, "FLY"];
						createVehicleCrew _currentVehicle;
						//systemChat format ["test : %1", _currentUAVArray];
						//_currentVehicle = _currentUAVArray select 0;
						//_currentUAVGroup = _currentUAVArray select 2;

						//Set waypoint to current pos to the UAV
						_wp = _currentUAVGroup addWaypoint [_tempPos, 0];

						//Set unlimited fuel to the UAV
						[[_currentVehicle], 'objectGenerator\setUnlimitedFuel.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
					} else 
					{
						[_vehicleClassToSpawn, _spawnPositions#_index] call spawnVehicleOnAicraft;
					};



					
					
					//adjust global variable
					missionNameSpace setVariable ["AicraftCarrierBluforIndex", _index+1, true];
				};

				//Close mission setup
				_display closeDisplay 1;
			} else 
			{
				[{["STR_RPG_HC_NAME", "STR_RPG_HC_NOT_ENOUGH_CREDIT"] call doDialog}] remoteExec ["call", player];
			};
		};
	}
];


_buttonPreview ctrlAddEventHandler[ "ButtonClick", 
	{ 
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		//Spawn vehicle
		_lnbEntries = _display displayCtrl 50002;
		_vehicleClassToSpawn = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 0]);
		_vehicleNameToSpawn = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 1]);

		_vehiclePreview = getText (configFile >> "cfgVehicles" >> _vehicleClassToSpawn >> "editorPreview");
		_parsedText = parseText format ["<img image='%1' size='12'/>",  _vehiclePreview];
		[_parsedText, "PLAIN DOWN", -1, true, true] remoteExec ["titleText", player, true];

		//Create display too choose reporter player
		_display = (findDisplay 46) createDisplay "RscDisplayEmpty";

		_backGround = _display ctrlCreate[ "ctrlStaticPicture", -1 ];
		_backGround ctrlSetPosition[ 0, 0, 0.75, 0.75 ];
		_backGround ctrlSetText "#(argb,8,8,3)color(0.35,0.35,0.35,1)";
		_backGround ctrlCommit 0;

		_RcsTitleDialog = _display ctrlCreate ["RscText", -1];
		_RcsTitleDialog ctrlSetText (format ["Preview for %1", _vehicleNameToSpawn]);
		_RcsTitleDialog ctrlSetPosition[ 0, 0, 0.75, 0.04 ];
		_RcsTitleDialog ctrlSetBackgroundColor [0,0,0,1];
		_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
		_RcsTitleDialog ctrlCommit 0;

		_RcsBodyLeftDialog = _display ctrlCreate ["RscStructuredText", -1];
		_RcsBodyLeftDialog ctrlSetStructuredText  (_parsedText);
		_RcsBodyLeftDialog ctrlSetPosition [ 0.05, 0.1, 0.75, 0.75 ];
		//_RcsBodyLeftDialog ctrlSetBackgroundColor [0,0,0,1];
		_RcsBodyLeftDialog ctrlSetTextColor [1, 1, 1, 1];
		_RcsBodyLeftDialog ctrlCommit 0;

		
		_ButtonRight = _display ctrlCreate ["RscButton", 7804];
		_ButtonRight ctrlSetPosition [(0.55 * safezoneW + safezoneX),(0.6 * safezoneH + safezoneY),(0.05 * safezoneW),(0.025* safezoneH)];
		_ButtonRight ctrlSetBackgroundColor [0,0,0,0.7];
		_ButtonRight ctrlCommit 0;
		ctrlSetFocus _ButtonRight;
		_ButtonRight ctrlSetText "Close";
		_ButtonRight ctrlAddEventHandler ["ButtonClick",{
			params ["_ctrl"];
			_display = ctrlParent _ctrl;
			_display closeDisplay 1;
		}];	
	}];