#include "..\..\objectGenerator\vehicleManagement.sqf"

//Based on the work of 7erra
//Github : https://github.com/7erra/LNBSort
params ["_mode", "_this"];

private _mainDisplay = (findDisplay 50000);
private _buttonOK = _mainDisplay displayCtrl 50001;
private _buttonPreview = _mainDisplay displayCtrl 50003;
private _vehicleShopTitle = _mainDisplay displayCtrl 49999;

_vehicleShopTitle ctrlSetText (format ["Vehicle shop | Credits %1", missionNamespace getVariable "bluforVehicleAvalaibleSpawn"]);

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

		if (_vehicleClassToSpawn != "") then 
		{
			if (_bluforVehicleAvalaibleSpawnCounter>=_vehiclePriceToSpawn) then 
			{
				//Check if this is a plane
				if (_vehicleClassToSpawn isKindOf "Plane" && _vehicleIsUAV == false) then 
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

								//Add action to take off
								[_spawnedVehicle, [format ["Jump"],{
										params ["_object","_caller","_ID","_thisParams"];

										moveOut _caller;
										cutText ["", "BLACK IN", 5];
										uiSleep 3;

										//Halo jump script of pierremgi
										0 = _caller spawn {
											private _plyr = _this;
											private "_whs";
											_plyr setVariable ["bpk",unitBackpack _plyr];
											_bpktype = backpack _plyr;
											if (_bpktype != "") then {
												_whs = createVehicle ["WeaponHolderSimulated_Scripted",[0,0,0],[],0,"can_collide"];
												_plyr action ["DropBag", _whs, _bpktype];
												_plyr addBackpackGlobal "B_parachute";
												waitUntil {0.5; !isNull objectParent _plyr or isTouchingGround _plyr};  
												waitUntil {0.5; isNull objectParent _plyr or isTouchingGround _plyr};
												uiSleep 0.5;
												if (!isNull _whs) then {
													_plyr action ["AddBag",objectParent (_plyr getVariable "bpk"), _bpktype];
													_plyr setVariable ["bpk",nil];
													uiSleep 3;
													deleteVehicle _whs;
												};
											} else 
											{
												_plyr addBackpackGlobal "B_parachute";
											};
										};


									},[],1.5,true,true,"","(_target distance _this < 15) && ((assignedVehicleRole player)#0 == 'cargo')"]] remoteExec ["addAction", 0, true];

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

						//Spawn the vehicle around the player or on blufor initial position if called from server
						if (hasInterface) then 
						{
							[getPos player, [[_vehicleClassToSpawn, _vehicleIsUAV]], 30, 100] call doGenerateVehicleForFOB;	
						} else 
						{
							[initBlueforLocation, [[_vehicleClassToSpawn, _vehicleIsUAV]], 30, 100] call doGenerateVehicleForFOB;	
						};
					};	

					missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, true];
					//hint format ["A %2 has spawned, %1 avdvanced spawn credit left.", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, _vehicleNameToSpawn];
				};


				//Close mission setup
				_display closeDisplay 1;
			} else 
			{
				_textToSpeech = "You don't have enough credit left.";
				[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", player, true];
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