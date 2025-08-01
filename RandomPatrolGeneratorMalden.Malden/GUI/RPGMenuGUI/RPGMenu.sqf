params ["_someParameters"];

disableSerialization;

//Param exemple :
//[Type, Name, Description, {action}]

paramsToManageNow = [];

listOfMissionEventHandlerToDestroy = [];

//Prepare respawn countdown GUI on map
//Only avalaible if respawn is set to wave respawn 
if (missionNameSpace getVariable ["enableSelfRespawnTimer", 0] == 0) then 
{

	paramsToManageNow pushBack ["Text", "Next respawn", "", {
			params ["_thisCTRL"];

			//systemChat format ["_thisCTRL : %1", _thisCTRL];

			//No self respawn timer (directed by the server)
			_id = addMissionEventHandler ["EachFrame",
				{
					_currentRespawnTimer = missionNamespace getVariable "missionRespawnParam";
					_currentCounter = _currentRespawnTimer - (round (serverTime) % _currentRespawnTimer);
					_thisArgs#0 ctrlSetStructuredText parseText (format ["%1", [(_currentCounter/60)+.01,"HH:MM"] call BIS_fnc_timetostring]);
				},
				[_thisCTRL]
			];
			listOfMissionEventHandlerToDestroy pushBack ["EachFrame", _id];

		}];
};

//Add credit GUI
paramsToManageNow pushBack ["Text", localize "STR_GUI_BASE_CREDIT", format ["%1", missionNamespace getVariable "bluforVehicleAvalaibleSpawn"], {	}];

//Display current task
_currentTask = player call BIS_fnc_taskCurrent;
_currentTaskPosition = _currentTask call BIS_fnc_taskDestination;
_currentTaskDescriptionArray = _currentTask call BIS_fnc_taskDescription;
_currentTaskDirection = player getDirVisual _currentTaskPosition;
_currentTaskDirectionText = "";
switch (floor (_currentTaskDirection / 30)) do
{
	case 11;
	case 0:
	{
		_currentTaskDirectionText = "NORTH";
	};
	case 1:
	{
		_currentTaskDirectionText = "NORTH EAST";
	};
	case 2;	
	case 3:
	{
		_currentTaskDirectionText = "EAST";
	};
	case 4:
	{
		_currentTaskDirectionText = "SOUTH EAST";
	};
	case 5;
	case 6:
	{
		_currentTaskDirectionText = "SOUTH";
	};
	case 7:
	{
		_currentTaskDirectionText = "SOUTH WEST";
	};
	case 8;
	case 9:
	{
		_currentTaskDirectionText = "WEST";
	};
	case 10:
	{
		_currentTaskDirectionText = "NORTH WEST";
	};
	default 
	{
		//Impossible
	};
};
_currentTaskDistanceText = "";
switch (floor ((player distance _currentTaskPosition)/ 500)) do
{
	case 0:
	{
		_currentTaskDistanceText = "Very Close";
	};
	case 1:
	{
		_currentTaskDistanceText = "Close";
	};
	case 2:
	{
		_currentTaskDistanceText = "Moderate Distance";
	};
	case 3:
	{
		_currentTaskDistanceText = "Far";
	};
	case 4:
	{
		_currentTaskDistanceText = "Quite Far";
	};
	default
	{
		_currentTaskDistanceText = "Distant";
	};
};

_currentTaskDirectionInstructions = format ["Location : %1 %2",_currentTaskDirectionText, _currentTaskDistanceText];
paramsToManageNow pushBack ["Text", format ["Task : %1", localize (_currentTaskDescriptionArray#1#0)], _currentTaskDirectionInstructions, {	}];

//Add unstuck action
paramsToManageNow pushBack ["Button", "Unblock", "(10 sec)", {
		[] spawn 
		{
			cutText ["MOVING PLAYER OUT OF BUG", "BLACK FADED", 10];
			(format ["%1 is using unblock action", name player]) remoteExec ["systemChat", 0, true];
			uiSleep 10;
			_dir = getDir player;
			_dx = sin(_dir)*20;
			_dy = cos(_dir)*20;
			_currentPlayerPos = getPos player;
			player setPos [_currentPlayerPos#0+_dx,_currentPlayerPos#1+_dy,0];
			titleCut ["UNBLOCKED", "BLACK IN", 5];
		};
	}];

//Add tuto action
paramsToManageNow pushBack ["Button", "TUTO", "", {
		[] spawn 
		{
				localize "STR_RPG_TUTO_WELCOME" hintC [
					localize "STR_RPG_TUTO_OBJ",
					localize "STR_RPG_TUTO_LOADOUT",
					localize "STR_RPG_TUTO_VEHICLE",
					localize "STR_RPG_TUTO_RESPAWN"
				];	
		};
	}];

if (player getVariable ["isAdmin", false] || (hasInterface && isServer)) then 
{
	paramsToManageNow pushBack ["Button", "ADMIN MENU", "Open admin menu", {
			[] spawn 
			{
				[[], 'GUI\adminGUI\adminGUIInit.sqf'] remoteExec ['BIS_fnc_execVM', player];
			};
		}];
};

paramsToManageNow pushBack ["Button", localize "STR_RPG_LOADOUT_SHOWRANK", format ["Progression : %1", (player getVariable ["currentXP",0])-(player getVariable ["startingXP",0])], {
		if (player getVariable ["RankDisplayAvailable", true]) then 
		{
			[[], 'GUI\rankGUI\rankGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];
			[] spawn 
			{
				player setVariable ["RankDisplayAvailable", false];
				sleep 360;
				player setVariable ["RankDisplayAvailable", true];
			};
		} else 
		{
			hint "Not available, cooldown of 10 minutes";
		};
	}];


//Create display too choose reporter player
_display = (findDisplay 46) createDisplay "RscDisplayEmpty";

_backGround = _display ctrlCreate[ "ctrlStaticPicture", -1 ];
_backGround ctrlSetPosition[ -0.1, -0.1, 1.2, 1.2 ];
_backGround ctrlSetText "#(argb,8,8,3)color(0.35,0.35,0.35,1)";
_backGround ctrlCommit 0;

_RcsTitleDialog = _display ctrlCreate ["RscStructuredText", -1];
_RcsTitleDialog ctrlSetStructuredText parseText "<t size='0.5'>&#160;</t><br/><t size='1' align='center'>RPG Menu&#160;&#160;</t>";
_RcsTitleDialog ctrlSetPosition [ -0.1, -0.1, 1.2, 0.07 ];
_RcsTitleDialog ctrlSetBackgroundColor [0.8,0.5,0,1];
_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsTitleDialog ctrlCommit 0;

_yPosition = 0.10;

{
	_paramsType = _x#0;
	_paramsName = _x#1;
	_paramsDescription = _x#2;
	_paramsAction = _x#3;

	switch (_paramsType) do {
		case "Button":
		{
			_ButtonParam = _display ctrlCreate ["RscButton", -1];
			_ButtonParam ctrlSetPosition [-0.07, _yPosition, 0.5, 0.05 ];
			_ButtonParam ctrlSetBackgroundColor [0,0,0,0.7];
			_ButtonParam ctrlCommit 0;
			_ButtonParam ctrlEnable true;
			_ButtonParam ctrlSetText _paramsName;
			//Perform action + close menu
			_ButtonParam ctrlAddEventHandler ["ButtonClick", 
				toString _paramsAction +
				toString ({	params ["_ctrl"];
					_display = ctrlParent _ctrl;
					_display closeDisplay 1;
					})
			];

			_RcsBodyRightDialog = _display ctrlCreate ["RscStructuredText", -1];
			_RcsBodyRightDialog ctrlSetStructuredText  parseText (_paramsDescription);
			_RcsBodyRightDialog ctrlSetPosition [0.5, _yPosition, 0.4, 0.04];
			_RcsBodyRightDialog ctrlSetTextColor [1, 1, 1, 1];
			//_RcsBodyLeftDialog ctrlSetBackgroundColor [0,0,0,0.8];
			_RcsBodyRightDialog ctrlCommit 0;
		};
		case "Text":
		{
			//Create dropdownlist title on the left side
			_RcsBodyLeftDialog = _display ctrlCreate ["RscStructuredText", -1];
			_RcsBodyLeftDialog ctrlSetStructuredText  parseText (_paramsName);
			_RcsBodyLeftDialog ctrlSetPosition[-0.07, _yPosition, 0.5, 0.07 ];
			_RcsBodyLeftDialog ctrlSetTextColor [1, 1, 1, 1];
			//_RcsBodyLeftDialog ctrlSetBackgroundColor [0,0,0,0.8];
			_RcsBodyLeftDialog ctrlCommit 0;

			_RcsBodyRightDialog = _display ctrlCreate ["RscStructuredText", -1];
			_RcsBodyRightDialog ctrlSetStructuredText  parseText (_paramsDescription);
			_RcsBodyRightDialog ctrlSetPosition [0.5, _yPosition, 0.4, 0.04];
			_RcsBodyRightDialog ctrlSetTextColor [1, 1, 1, 1];
			//_RcsBodyLeftDialog ctrlSetBackgroundColor [0,0,0,0.8];
			_RcsBodyRightDialog ctrlCommit 0;

			//Call action to refresh description
			[_RcsBodyRightDialog] spawn _paramsAction; 
		};
		default
		{
			//Do nothing
		};
	};

	// DROPDOWNLIST is for a future update

	// //Create dropdownlist next to the param title on the right side
	// _dropdown = _display ctrlCreate ["RscCombo", 100];
	// _dropdown ctrlSetPosition [0.5, _yPosition, 0.4, 0.04];
	// _dropdown ctrlCommit 0;

	// //Populate dropdownlist with params
	// {
	// 	_item = _dropdown lbAdd _x#1;
	// 	_dropdown lbSetData [_item, format ["%1", _x#0]];
	// } forEach _paramsList;

	// //Set default value
	// _saveSetting = profileNameSpace getVariable [_paramsSettingName, _paramsDefaultValue];
	// _dropdown lbSetCurSel (_paramsList apply {_x#0} find _saveSetting);
	// _dropdown setVariable ["dataTitle", _paramsName];
	// missionNamespace setVariable [_paramsSettingName, _saveSetting, true];

	// //Change setting value dynamically
	// _dropdown ctrlAddEventHandler ["LBSelChanged",
	// {
	// 	params ["_control", "_selectedIndex"];
	// 	_label = _control getVariable "dataTitle";
	// 	_selectedSetting = _control lbData (lbCurSel _control);

	// 	//Select specific player
	// 	_diffusionParamName = (paramsToManageNow select {_x#1 == _label})#0#3;
	// 	//hint format ["%2 : %1 : %3", _selectedSetting, _selectedIndex, _diffusionParamName];

	// 	missionNamespace setVariable [_diffusionParamName, parseNumber _selectedSetting, true];
	// 	profileNameSpace setVariable [_diffusionParamName, parseNumber _selectedSetting];
	// 	saveProfileNamespace;
	// }];

	//Move next input down 
	_yPosition = _yPosition + 0.07;

} foreach paramsToManageNow;


//Button to go on the next setup
_ButtonRight = _display ctrlCreate ["RscButton", 7804];
_ButtonRight ctrlSetPosition [(0.45 * safezoneW + safezoneX),(0.75 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonRight ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonRight ctrlCommit 0;
ctrlSetFocus _ButtonRight;
_ButtonRight ctrlEnable true;
_ButtonRight ctrlSetText (localize "RPG_GUI_GENERAL_CLOSE");
_ButtonRight ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;
	}];	

//Disable space button in dialog
waituntil {(IsNull (_display))};

//Clean Mission EventHandler
{
	//Debug display
	//systemChat format ["listOfMissionEventHandlerToDestroy %1 %2", _x#0, _x#1];
    removeMissionEventHandler [_x#0, _x#1];
} foreach  listOfMissionEventHandlerToDestroy;