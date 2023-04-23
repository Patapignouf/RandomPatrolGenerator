disableSerialization;

//Create GUI
createDialog "DialogSetupLocationParams";

//Specify all GUI items
//Define a comboBox foreach faction
private _mainDisplay = (findDisplay 10000);
private _buttonNext = _mainDisplay displayCtrl 10200;

//Next loadout
_buttonNext ctrlAddEventHandler[ "ButtonClick", 
	{ 
		//Close mission setup
		params ["_ctrl"];
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;

		//Go to objective selection
		[[], 'GUI\setupGUI\startGUIMenuObjectives.sqf'] remoteExec ['BIS_fnc_execVM', player];
	}];

//Init locations if necessary
if (isNil "initCityLocationPosition") then 
{
	initCityLocationPosition = objNull;
	publicVariable "initCityLocationPosition";
};

if (isNil "initBlueforLocationPosition") then 
{
	initBlueforLocationPosition = objNull;
	publicVariable "initBlueforLocationPosition";
};


//Create list of button to find locations

//////////////Random Ind Button/////////////////////
_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", 10201];
_RcsButtonObjective ctrlSetText "Random Civilian City";

//Precheck with loaded settings
if (typeName initCityLocationPosition != "ARRAY") then 
{
	_RcsButtonObjective ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green seems enable
} else 
{
	_RcsButtonObjective ctrlSetTextColor [1, 1, 1, 1]; //White seems disable
};

//Position and size
_coordinateX = 0.30 * safezoneW + safezoneX;
_coordinateY = 0.18 * safezoneH + safezoneY;
_weight = 0.2* safezoneW;
_height = 0.02 *safezoneH;


_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
_RcsButtonObjective ctrlCommit 0;

//Add control logic (enable or disable objective)
_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;

	initCityLocationPosition = objNull; //Add objective to avalaible objective
	publicVariable "initCityLocationPosition";

	_ctrl ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //White

	_mainDisplay = (findDisplay 10000);
	_buttonToDisable = _mainDisplay displayCtrl 10202;
	_buttonToDisable ctrlSetTextColor [1, 1, 1, 1];
}];


//////////////Locate Ind Button/////////////////////
_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", 10202];
_RcsButtonObjective ctrlSetText "Locate on map";

//Precheck with locate settings
if (typeName initCityLocationPosition == "ARRAY") then 
{
	_RcsButtonObjective ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green seems enable
} else 
{
	_RcsButtonObjective ctrlSetTextColor [1, 1, 1, 1]; //White seems disable
};

//Position and size
_coordinateX = 0.55 * safezoneW + safezoneX;
_coordinateY = 0.18 * safezoneH + safezoneY;
_weight = 0.2* safezoneW;
_height = 0.02 *safezoneH;

_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
_RcsButtonObjective ctrlCommit 0;

//Add control logic (enable or disable objective)
_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;

	//Open Map and select objective location
	[] spawn { 	
			closeDialog 1;
			openMap true;
			titleCut ["", "BLACK IN", 5];
			hint "Click on map to select a starting area";
			onMapSingleClick "initCityLocationPosition = _pos; onMapSingleClick ''; openMap false; true;";
			waitUntil{!(visibleMap)}; 
			publicVariable "initCityLocationPosition";
			//Show black screen
			titleCut ["Please wait while mission is generating", "BLACK FADED", 5];
			[[], 'GUI\setupGUI\startGUIMenuLocation.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};

	//Update UI
	_ctrl ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green
	_mainDisplay = (findDisplay 10000);
	_buttonToDisable = _mainDisplay displayCtrl 10204;
	_buttonToDisable ctrlSetTextColor [1, 1, 1, 1];
}];


//////////////Random Blu Button/////////////////////
_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", 10203];
_RcsButtonObjective ctrlSetText "Random Blufor FOB";

//Precheck with loaded settings
if (typeName initBlueforLocationPosition != "ARRAY") then 
{
	_RcsButtonObjective ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green seems enable
} else 
{
	_RcsButtonObjective ctrlSetTextColor [1, 1, 1, 1]; //White seems disable
};

//Position and size
_coordinateX = 0.30 * safezoneW + safezoneX;
_coordinateY = 0.22 * safezoneH + safezoneY;
_weight = 0.2* safezoneW;
_height = 0.02 *safezoneH;


_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
_RcsButtonObjective ctrlCommit 0;

//Add control logic (enable or disable objective)
_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;

	initBlueforLocationPosition = objNull; //Add objective to avalaible objective
	publicVariable "initBlueforLocationPosition";

	_ctrl ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //White

	_mainDisplay = (findDisplay 10000);
	_buttonToDisable = _mainDisplay displayCtrl 10202;
	_buttonToDisable ctrlSetTextColor [1, 1, 1, 1];
}];


//////////////Locate Blu Button/////////////////////
_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", 10204];
_RcsButtonObjective ctrlSetText "Locate on map";

//Precheck with locate settings
if (typeName initBlueforLocationPosition == "ARRAY") then 
{
	_RcsButtonObjective ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green seems enable
} else 
{
	_RcsButtonObjective ctrlSetTextColor [1, 1, 1, 1]; //White seems disable
};

//Position and size
_coordinateX = 0.55 * safezoneW + safezoneX;
_coordinateY = 0.22 * safezoneH + safezoneY;
_weight = 0.2* safezoneW;
_height = 0.02 *safezoneH;

_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
_RcsButtonObjective ctrlCommit 0;

//Add control logic (enable or disable objective)
_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;

	//Open Map and select objective location
	[] spawn { 	
			closeDialog 1;
			openMap true;
			titleCut ["", "BLACK IN", 5];
			hint "Click on map to select a starting area";
			onMapSingleClick "initBlueforLocationPosition = _pos; onMapSingleClick ''; openMap false; true;";
			waitUntil{!(visibleMap)}; 
			publicVariable "initBlueforLocationPosition";
			//Show black screen
			titleCut ["Please wait while mission is generating", "BLACK FADED", 5];
			[[], 'GUI\setupGUI\startGUIMenuLocation.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};

	//Update UI
	_ctrl ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green
	_mainDisplay = (findDisplay 10000);
	_buttonToDisable = _mainDisplay displayCtrl 10203;
	_buttonToDisable ctrlSetTextColor [1, 1, 1, 1];
}];



//Disable space button in dialog
waituntil {!(IsNull (findDisplay 10000))};
_keyDown = (findDisplay 10000) displayAddEventHandler ["KeyDown", {
	params ["_control", "_dikCode", "_shift", "_ctrl", "_alt"];

	private _handled = false;

	switch (_dikCode) do {
		case 57: {
			// case 1 for ESC -> https://community.bistudio.com/wiki/DIK_KeyCodes
			// open your dialog
			_control closeDisplay 1;
			[[], 'GUI\setupGUI\startGUIMenuLocation.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	};

	_handled
}];