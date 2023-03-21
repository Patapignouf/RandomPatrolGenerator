disableSerialization;
#include "..\..\database\objectLibrary.sqf"
#include "loadSettings.sqf"

//Create GUI
createDialog "DialogSetupObjectivesParams";

//Specify all GUI items
//Define a comboBox foreach faction
private _mainDisplay = (findDisplay 9000);
private _buttonLoad = _mainDisplay displayCtrl 9200;

//Load loadout
_buttonLoad ctrlAddEventHandler[ "ButtonClick", 
	{ 
		//Close mission setup
		params ["_ctrl"];
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;

		//Select random objective if no objective are selected in GUI
		if (count avalaibleTypeOfObj == 0) then 
		{
			avalaibleTypeOfObj = [(selectRandom (avalaibleTypeOfObjectives)) select 0];
		};

		//Publish avalaible objectives types
		publicVariable "avalaibleTypeOfObj";

		//Save player's settings
		[[], 'GUI\setupGUI\saveSettings.sqf'] remoteExec ['BIS_fnc_execVM', player];

		//Begin mission generation
		missionNamespace setVariable ["generationSetup", true, true]; 
	}];


//Create list of button to find avalaible objectives
_coordinateButtonRatioY = 0.20;
{
	//Define objective params
	_currentObjectiveKey = _x select 0;  //Objective type
	_currentObjectiveName = _x select 1; //Objective display name
	_currentObjectiveType = _x select 2; //Unused for the moment

	_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", -1];
	_RcsButtonObjective ctrlSetText _currentObjectiveName;

	//Precheck with loaded settings
	if (avalaibleTypeOfObj_loaded find _currentObjectiveKey != -1) then 
	{
		_RcsButtonObjective ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green seems enable
		avalaibleTypeOfObj pushBack _currentObjectiveKey; //Add objective to avalaible objective
	} else 
	{
		_RcsButtonObjective ctrlSetTextColor [1, 1, 1, 1]; //White seems disable
	};

	//Position and size
	_coordinateX = 0.30 * safezoneW + safezoneX;
	_coordinateY = (_coordinateButtonRatioY) * safezoneH + safezoneY;
	_weight = 1;
	_height = 0.05;

	_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
	_RcsButtonObjective ctrlCommit 0;

	_coordinateButtonRatioY = _coordinateButtonRatioY + (safezoneH)/((count avalaibleTypeOfObjectives)*4);

	//Add control logic (enable or disable objective)
	_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
	{
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		_currentButtonObjective = avalaibleTypeOfObjectives select {(_x select 1) == (ctrlText _ctrl)} select 0; //Search objective parameters
		if ((_currentButtonObjective select 0) in avalaibleTypeOfObj) then 
		{
			_ctrl ctrlSetTextColor [1, 1, 1, 1]; //White
			avalaibleTypeOfObj = avalaibleTypeOfObj - [_currentButtonObjective select 0]; //Add objective to avalaible objective
		} else 
		{
			_ctrl ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green
			avalaibleTypeOfObj pushBack (_currentButtonObjective select 0); //Add objective to avalaible objective
		};
	}];
} foreach avalaibleTypeOfObjectives;


//Disable space button in dialog
waituntil {!(IsNull (findDisplay 9000))};
_keyDown = (findDisplay 9000) displayAddEventHandler ["KeyDown", {
	params ["_control", "_dikCode", "_shift", "_ctrl", "_alt"];

	private _handled = false;

	switch (_dikCode) do {
		case 57: {
			// case 1 for ESC -> https://community.bistudio.com/wiki/DIK_KeyCodes
			// open your dialog
			_control closeDisplay 1;
			[[], 'GUI\setupGUI\startGUIMenuObjectives.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	};

	_handled
}];