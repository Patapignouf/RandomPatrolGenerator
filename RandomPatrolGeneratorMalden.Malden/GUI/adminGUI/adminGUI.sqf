player setSpeaker "noVoice";

// Display variables
_startingXDialog = -0.15;
_dialogWidth = 1.3;
// Bottom buttons variables
_startingPos = _startingXDialog + 0.01;
_buttonWidth = 0.15;
_spacingX = 0.005;

disableSerialization;
_display = (findDisplay 46) createDisplay "RscDisplayEmpty";

_backGround = _display ctrlCreate[ "ctrlStatic", -1];
_backGround ctrlSetPosition[ _startingXDialog, 0, _dialogWidth, 1 ];
_backGround ctrlSetBackgroundColor[0.208, 0.208, 0.208, 1];
_backGround ctrlCommit 0;

_RcsTopBackgroundDialog = _display ctrlCreate ["RscText", -1];
_RcsTopBackgroundDialog ctrlSetPosition[ _startingXDialog, 0, _dialogWidth, 0.02 ];
_RcsTopBackgroundDialog ctrlSetBackgroundColor [1, 0.729, 0.031, 1];
_RcsTopBackgroundDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsTopBackgroundDialog ctrlCommit 0;

_RcsBottomBackgroundDialog = _display ctrlCreate ["RscText", -1];
_RcsBottomBackgroundDialog ctrlSetPosition[ _startingXDialog, 1, _dialogWidth, 0.05 ];
_RcsBottomBackgroundDialog ctrlSetBackgroundColor [0.133, 0.133, 0.133, 1];
_RcsBottomBackgroundDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsBottomBackgroundDialog ctrlCommit 0;

_RcsTitleDialog = _display ctrlCreate ["RscStructuredText", -1];
_RcsTitleDialog ctrlSetText "Admin menu";
_RcsTitleDialog ctrlSetPosition[ _startingXDialog, 0.03, 0.4, 0.8 ];
_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsTitleDialog ctrlCommit 0;


_RcsTabContentBackGround = _display ctrlCreate[ "RscText", -1 ];
_RcsTabContentBackGround ctrlSetPosition[ _startingXDialog + 0.01, 0.17, _dialogWidth - 0.02, 0.75 ];
_RcsTabContentBackGround ctrlSetBackgroundColor[0, 0, 0, 0.5];
_RcsTabContentBackGround ctrlCommit 0;

_RcsPlayersTabButton = _display ctrlCreate ["RscButton", -1];
_RcsPlayersTabButton ctrlSetText "Players";
_RcsPlayersTabButton ctrlSetPosition[ _startingXDialog + 0.01, 0.1, _buttonWidth, 0.06 ];
_RcsPlayersTabButton ctrlSetBackgroundColor [0.133, 0.133, 0.133, 1];
_RcsPlayersTabButton ctrlSetTextColor [1, 1, 1, 1];
_RcsPlayersTabButton ctrlCommit 0;

_RcsPlayersTabControlsGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_RcsPlayersTabControlsGroup ctrlSetPosition[ _startingXDialog + 0.01, 0.17, _dialogWidth - 0.02, 0.75 ];
_RcsPlayersTabControlsGroup ctrlShow true;

// text
RcsPlayersListTitle = _display ctrlCreate ["RscText", -1];
RcsPlayersListTitle ctrlSetText "Players list";
RcsPlayersListTitle ctrlSetPosition[ _startingXDialog + 0.02, 0.17, 0.3, 0.05 ];
RcsPlayersListTitle ctrlSetTextColor [1, 1, 1, 1];
RcsPlayersListTitle ctrlCommit 0;

RcsPlayersList = _display ctrlCreate ["RscListBox", -1];
RcsPlayersList ctrlSetPosition[ _startingXDialog + 0.02, 0.22, 0.3, 0.69 ];
RcsPlayersList ctrlSetTextColor [1, 1, 1, 1];
RcsPlayersList ctrlCommit 0;

RcsPlayersCommandsListTitle = _display ctrlCreate ["RscText", -1];
RcsPlayersCommandsListTitle ctrlSetText "Commands list";
RcsPlayersCommandsListTitle ctrlSetPosition[ _startingXDialog + 0.3 + 0.03, 0.17, 0.3, 0.05 ];
RcsPlayersCommandsListTitle ctrlSetTextColor [1, 1, 1, 1];
RcsPlayersCommandsListTitle ctrlCommit 0;

RcsPlayersCommandsList = _display ctrlCreate ["RscListBox", -1];
RcsPlayersCommandsList ctrlSetPosition[ _startingXDialog + 0.3 + 0.03, 0.22, 0.3, 0.69 ];
RcsPlayersCommandsList ctrlSetTextColor [1, 1, 1, 1];
RcsPlayersCommandsList ctrlCommit 0;

RcsPlayersDescriptionTitle = _display ctrlCreate ["RscText", -1];
RcsPlayersDescriptionTitle ctrlSetText "Description";
RcsPlayersDescriptionTitle ctrlSetPosition[ _startingXDialog + 0.6 + 0.04, 0.17, 0.6, 0.05 ];
RcsPlayersDescriptionTitle ctrlSetTextColor [1, 1, 1, 1];
RcsPlayersDescriptionTitle ctrlCommit 0;

RcsPlayersDescription = _display ctrlCreate ["RscStructuredText", -1];
RcsPlayersDescription ctrlSetPosition[ _startingXDialog + 0.6 + 0.04, 0.22, 0.64, 0.69 ];
RcsPlayersDescription ctrlSetBackgroundColor [0, 0, 0, 0.3];
RcsPlayersDescription ctrlSetTextColor [1, 1, 1, 1];
RcsPlayersDescription ctrlCommit 0;

_RcsOtherTabButton = _display ctrlCreate ["RscButton", -1];
_RcsOtherTabButton ctrlSetText "Others";
_RcsOtherTabButton ctrlSetPosition[ (_startingXDialog + 0.01) + _buttonWidth + 0.01, 0.1, _buttonWidth, 0.06 ];
_RcsOtherTabButton ctrlSetBackgroundColor [0.133, 0.133, 0.133, 1];
_RcsOtherTabButton ctrlSetTextColor [1, 1, 1, 1];
_RcsOtherTabButton ctrlCommit 0;

RcsOthersCommandsListTitle = _display ctrlCreate ["RscText", -1];
RcsOthersCommandsListTitle ctrlSetText "Commands list";
RcsOthersCommandsListTitle ctrlSetPosition[ _startingXDialog + 0.02, 0.17, 0.3, 0.05 ];
RcsOthersCommandsListTitle ctrlSetTextColor [1, 1, 1, 1];
RcsOthersCommandsListTitle ctrlCommit 0;

RcsOthersCommandsList = _display ctrlCreate ["RscListBox", -1];
RcsOthersCommandsList ctrlSetPosition[ _startingXDialog + 0.02, 0.22, 0.3, 0.69 ];
RcsOthersCommandsList ctrlSetTextColor [1, 1, 1, 1];
RcsOthersCommandsList ctrlCommit 0;

RcsOthersDescriptionTitle = _display ctrlCreate ["RscText", -1];
RcsOthersDescriptionTitle ctrlSetText "Description";
RcsOthersDescriptionTitle ctrlSetPosition[ _startingXDialog + 0.3 + 0.03, 0.17, 0.3, 0.05 ];
RcsOthersDescriptionTitle ctrlSetTextColor [1, 1, 1, 1];
RcsOthersDescriptionTitle ctrlCommit 0;

RcsOthersDescription = _display ctrlCreate ["RscStructuredText", -1];
RcsOthersDescription ctrlSetPosition[ _startingXDialog + 0.3 + 0.03, 0.22, 0.95, 0.69 ];
RcsOthersDescription ctrlSetBackgroundColor [0, 0, 0, 0.3];
RcsOthersDescription ctrlSetTextColor [1, 1, 1, 1];
RcsOthersDescription ctrlCommit 0;

RcsExecuteCommandButton = _display ctrlCreate ["RscButton", -1];
RcsExecuteCommandButton ctrlSetText "Execute";
RcsExecuteCommandButton ctrlSetPosition[1 - (_spacingX + 0.04), 0.93, _buttonWidth + 0.03, 0.06 ];
RcsExecuteCommandButton ctrlSetBackgroundColor [0.133, 0.133, 0.133, 1];
RcsExecuteCommandButton ctrlSetTextColor [1, 1, 1, 1];
RcsExecuteCommandButton setVariable ["currentTab", "players"];
RcsExecuteCommandButton ctrlCommit 0;

_RcsLogsTabButton = _display ctrlCreate ["RscButton", -1];
_RcsLogsTabButton ctrlSetText "Admin logs";
_RcsLogsTabButton ctrlSetPosition[ 1 - 0.01, 0.1, _buttonWidth, 0.06 ];
_RcsLogsTabButton ctrlSetBackgroundColor [0.133, 0.133, 0.133, 1];
_RcsLogsTabButton ctrlSetTextColor [1, 1, 1, 1];
_RcsLogsTabButton ctrlCommit 0;

RcsLogsListTitle = _display ctrlCreate ["RscText", -1];
RcsLogsListTitle ctrlSetText "Logs";
RcsLogsListTitle ctrlSetPosition[ _startingXDialog + 0.02, 0.17, 0.3, 0.05 ];
RcsLogsListTitle ctrlSetTextColor [1, 1, 1, 1];
RcsLogsListTitle ctrlCommit 0;

RcsLogsList = _display ctrlCreate ["RscListBox", -1];
RcsLogsList ctrlSetPosition[ _startingXDialog + 0.02, 0.22, _dialogWidth - 0.04, 0.69 ];
RcsLogsList ctrlSetTextColor [1, 1, 1, 1];
RcsLogsList ctrlCommit 0;

playersRscList = [RcsPlayersListTitle, RcsPlayersList, RcsPlayersCommandsListTitle, RcsPlayersCommandsList, RcsPlayersDescriptionTitle, RcsPlayersDescription];
othersRscList = [RcsOthersCommandsListTitle,RcsOthersCommandsList,RcsOthersDescriptionTitle,RcsOthersDescription];
logsRscList = [RcsLogsListTitle, RcsLogsList];

{
	_x ctrlShow false;
} forEach (othersRscList + logsRscList);

// Tab Others
_RcsOtherTabButton ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];
	RcsExecuteCommandButton setVariable ["currentTab", "others"];
	{
		_x ctrlShow false;
	} forEach (playersRscList + logsRscList);
	{
		_x ctrlShow true;
	} forEach othersRscList;
}];

// Tab Players
_RcsPlayersTabButton ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];
	RcsExecuteCommandButton setVariable ["currentTab", "players"];
	{
		_x ctrlShow false;
	} forEach (othersRscList + logsRscList);
	{
		_x ctrlShow true;
	} forEach playersRscList;
}];

// Tab Logs
_RcsLogsTabButton ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];
	RcsExecuteCommandButton setVariable ["currentTab", "logs"];
	{
		_x ctrlShow false;
	} forEach (othersRscList + playersRscList);
	{
		_x ctrlShow true;
	} forEach logsRscList;

	_logs = missionNamespace getVariable ["adminLogs", []];

	lbClear RcsLogsList;

	{
		RcsLogsList lbAdd _x;
	} forEachReversed _logs;
}];

_RcsCloseButton = _display ctrlCreate ["RscButton", -1];
_RcsCloseButton ctrlSetText "Close";
_RcsCloseButton ctrlSetPosition[ _startingPos, 0.93, _buttonWidth, 0.06 ];
_RcsCloseButton ctrlSetBackgroundColor [0.4, 0, 0, 1];
_RcsCloseButton ctrlSetTextColor [1, 1, 1, 1];
_RcsCloseButton ctrlCommit 0;
_RcsCloseButton ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];
	_display = ctrlParent _ctrl;
	_display closeDisplay 1;
}];




[_display, RcsExecuteCommandButton, RcsPlayersList, RcsPlayersCommandsList, RcsPlayersDescription, RcsOthersCommandsList, RcsOthersDescription] execVM "GUI\adminGUI\initAdminGUI.sqf";