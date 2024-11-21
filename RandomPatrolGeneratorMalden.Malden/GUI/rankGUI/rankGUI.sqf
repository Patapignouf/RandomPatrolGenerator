//[[], 'GUI\rankGUI\rankGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
#include "..\..\engine\rankManagement\rankFunctions.sqf"

//Create display too choose reporter player
_display = (findDisplay 46) createDisplay "RscDisplayEmpty";

_backGround = _display ctrlCreate[ "ctrlStaticPicture", -1 ];
_backGround ctrlSetPosition[ 0, 0, 0.75, 0.75 ];
_backGround ctrlSetText "#(argb,8,8,3)color(0.35,0.35,0.35,1)";
_backGround ctrlCommit 0;

_RcsTitleDialog = _display ctrlCreate ["RscText", -1];
_RcsTitleDialog ctrlSetText (format ["Rank manager for %1", name player]);
_RcsTitleDialog ctrlSetPosition[ 0, 0, 0.75, 0.04 ];
_RcsTitleDialog ctrlSetBackgroundColor [0,0,0,1];
_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsTitleDialog ctrlCommit 0;

_RcsBodyLeftDialog = _display ctrlCreate ["RscStructuredText", -1];
_RcsBodyLeftDialog ctrlSetStructuredText  (parseText ([player] call getDisplayableCurrentRank));
_RcsBodyLeftDialog ctrlSetPosition[ 0, 0.10, 0.4, 0.7 ];
//_RcsBodyLeftDialog ctrlSetBackgroundColor [0,0,0,1];
_RcsBodyLeftDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsBodyLeftDialog ctrlCommit 0;

_RcsBodyRightDialog = _display ctrlCreate ["RscStructuredText", -1];
_RcsBodyRightDialog ctrlSetStructuredText  (parseText ([player] call getDisplayableCurrentXPPerCat));
_RcsBodyRightDialog ctrlSetPosition[ 0.4, 0.04, 0.35, 0.7 ];
//_RcsBodyRightDialog ctrlSetBackgroundColor [0,0.5,0,1];
_RcsBodyRightDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsBodyRightDialog ctrlCommit 0;

//Display prestige button
if ([player] call getPlayerRank == "Colonel") then 
{
	_ButtonLeft = _display ctrlCreate ["RscButton", 7803];
	_ButtonLeft ctrlSetPosition [(0.3 * safezoneW + safezoneX),(0.6 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
	_ButtonLeft ctrlSetBackgroundColor [0,0,0,0.7];
	_ButtonLeft ctrlCommit 0;
	_ButtonLeft ctrlEnable true;
	_ButtonLeft ctrlSetText "Go prestige";
	_ButtonLeft ctrlSetTooltip "Return to 0 XP but increase prestige level by 1";
	_ButtonLeft ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		//Do increase prestige and refresh display
		[] call increasePrestige;
		_display closeDisplay 1;
		[[], 'GUI\rankGUI\rankGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];
		}];	
	
};

_ButtonRight = _display ctrlCreate ["RscButton", 7804];
_ButtonRight ctrlSetPosition [(0.50 * safezoneW + safezoneX),(0.6 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonRight ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonRight ctrlCommit 0;
ctrlSetFocus _ButtonRight;
_ButtonRight ctrlEnable true;
_ButtonRight ctrlSetText "Close";
_ButtonRight ctrlAddEventHandler ["ButtonClick",{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;
	_display closeDisplay 1;
	}];	
