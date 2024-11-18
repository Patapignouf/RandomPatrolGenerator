//[[], 'GUI\setupGUI\advancedSetup.sqf'] remoteExec ['BIS_fnc_execVM', player];
#include "..\..\database\missionParameters.sqf"

params ["_NextParamsToManage"];

paramsToManage = [];

if !(isNil "_NextParamsToManage") then 
{
	paramsToManage = _NextParamsToManage;
} else 
{
	paramsToManage = [civiliansOnObjectivesParam, sideRelationParam, enableObjectiveExactLocationParam, enablePersistentParam, enableRegularIncomeParam, disableZoomParam, enableAutoDifficultyBalanceParam, civJoinableFactionParam, enableLoadoutRestrictionParam, enableOpforVehicleParam, enableHaloParam, timeOfDayParam, civSuicideBomberParam, civSuicideBomberProbabilityParam, endlessMissionParam, enableOpforMortarParam];
};


paramsToManageNow = +paramsToManage ;
paramsToManageNow resize 10; //max 7 parameters per page
paramsToManageNow = paramsToManageNow arrayIntersect paramsToManage;
paramsToManageLater = paramsToManage - paramsToManageNow;

//Create display too choose reporter player
_display = (findDisplay 46) createDisplay "RscDisplayEmpty";

_backGround = _display ctrlCreate[ "ctrlStaticPicture", -1 ];
_backGround ctrlSetPosition[ -0.1, -0.1, 1.2, 1.2 ];
_backGround ctrlSetText "#(argb,8,8,3)color(0.35,0.35,0.35,1)";
_backGround ctrlCommit 0;

_RcsTitleDialog = _display ctrlCreate ["RscStructuredText", -1];
_RcsTitleDialog ctrlSetStructuredText parseText "<t size='0.5'>&#160;</t><br/><t size='1' align='center'>Advanced Settings&#160;&#160;</t>";
_RcsTitleDialog ctrlSetPosition [ -0.1, -0.1, 1.2, 0.07 ];
_RcsTitleDialog ctrlSetBackgroundColor [0,0,0,0.8];
_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsTitleDialog ctrlCommit 0;

_yPosition = 0.10;

{
	_paramsList = _x#0;
	_paramsName = _x#1;
	_paramsDefaultValue = _x#2;
	_paramsSettingName = _x#3;

	//Create dropdownlist title on the left side
	_RcsBodyLeftDialog = _display ctrlCreate ["RscStructuredText", -1];
	_RcsBodyLeftDialog ctrlSetStructuredText  (parseText _paramsName);
	_RcsBodyLeftDialog ctrlSetPosition[-0.07, _yPosition, 0.5, 0.07 ];
	_RcsBodyLeftDialog ctrlSetTextColor [1, 1, 1, 1];
	//_RcsBodyLeftDialog ctrlSetBackgroundColor [0,0,0,0.8];
	_RcsBodyLeftDialog ctrlCommit 0;
 
	//Create dropdownlist next to the param title on the right side
	_dropdown = _display ctrlCreate ["RscCombo", 100];
	_dropdown ctrlSetPosition [0.5, _yPosition, 0.4, 0.04];
	_dropdown ctrlCommit 0;

	//Populate dropdownlist with params
	{
		_item = _dropdown lbAdd _x#1;
		_dropdown lbSetData [_item, format ["%1", _x#0]];
	} forEach _paramsList;

	//Set default value
	_saveSetting = profileNameSpace getVariable [_paramsSettingName, _paramsDefaultValue];
	_dropdown lbSetCurSel (_paramsList apply {_x#0} find _saveSetting);
	_dropdown setVariable ["dataTitle", _paramsName];
	missionNamespace setVariable [_paramsSettingName, _saveSetting, true];

	//Change setting value dynamically
	_dropdown ctrlAddEventHandler ["LBSelChanged",
	{
		params ["_control", "_selectedIndex"];
		_label = _control getVariable "dataTitle";
		_selectedSetting = _control lbData (lbCurSel _control);

		//Select specific player
		_diffusionParamName = (paramsToManageNow select {_x#1 == _label})#0#3;
		//hint format ["%2 : %1 : %3", _selectedSetting, _selectedIndex, _diffusionParamName];

		missionNamespace setVariable [_diffusionParamName, parseNumber _selectedSetting, true];
		profileNameSpace setVariable [_diffusionParamName, parseNumber _selectedSetting];
		saveProfileNamespace;
	}];

	//Move next input down 
	_yPosition = _yPosition + 0.06;

} foreach paramsToManageNow;


//Button to go on the next setup
_ButtonRight = _display ctrlCreate ["RscButton", 7804];
_ButtonRight ctrlSetPosition [(0.45 * safezoneW + safezoneX),(0.75 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonRight ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonRight ctrlCommit 0;
ctrlSetFocus _ButtonRight;
_ButtonRight ctrlEnable true;
_ButtonRight ctrlSetText "Next";
_ButtonRight ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;
		if (count paramsToManageLater == 0) then 
		{
			[[], 'GUI\setupGUI\startGUIMenuLocation.sqf'] remoteExec ['BIS_fnc_execVM', player];
		} else 
		{
			[[paramsToManageLater], 'GUI\setupGUI\advancedSetup.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	}];	
