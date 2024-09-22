params ["_display", "_RcsExecuteCommandButton", "_RcsPlayersList", "_RcsPlayersCommandsList", "_RcsPlayersDescription", "_RcsOthersCommandsList", "_RcsOthersDescription"];

adminDisplay = _display;
RcsPlayersList = _RcsPlayersList;
RcsPlayersCommandsList = _RcsPlayersCommandsList;

RcsOthersCommandsList = _RcsOthersCommandsList;
RcsOthersDescription = _RcsOthersDescription;

addLogs = {
	params ["_display"];

	// Convertir 'time' (en secondes) en heures, minutes et secondes
	_hours = floor (time / 3600);
	_minutes = floor ((time % 3600) / 60);
	_seconds = round (time % 60);

	// Formater l'heure comme "HH:MM:SS"
	_timeString = format ["%1:%2:%3", _hours, if (_minutes < 10) then { "0" + str _minutes } else { str _minutes }, if (_seconds < 10) then { "0" + str _seconds } else { str _seconds }];

	_currentLogs = missionNamespace getVariable ["adminLogs", []];
	_currentLogs pushBack format["[%1] - %2", _timeString, _display];
	missionNamespace setVariable ["adminLogs", _currentLogs, true];
};

playersRegistered = [];
{
	_RcsPlayersList lbAdd format["%1", name _x];
	playersRegistered pushBack _x;
} forEach allPlayers - entities "HeadlessClient_F";

#include ".\playersCommands.sqf"
#include ".\othersCommands.sqf"

_playersCommandsIndex = 0;
{
	_RcsPlayersCommandsList lbAdd _x#0;
	_RcsPlayersCommandsList lbSetData [(lbSize _RcsPlayersCommandsList) - 1, str _playersCommandsIndex];
	_playersCommandsIndex = _playersCommandsIndex + 1;
} forEach playersCommands;

_othersCommandsIndex = 0;
{
	RcsOthersCommandsList lbAdd _x#0;
	RcsOthersCommandsList lbSetData [(lbSize RcsOthersCommandsList) - 1, str _othersCommandsIndex];
	_othersCommandsIndex = _othersCommandsIndex + 1;
} forEach othersCommands;

_RcsExecuteCommandButton ctrlAddEventHandler ["ButtonClick", {
	params ["_ctrl"];

	_currentTab = _ctrl getVariable "currentTab";

	if (_currentTab == "players") then {
		_selectedCommandId = (RcsPlayersCommandsList lbData (lbCurSel RcsPlayersCommandsList));
		_selectedCommand = playersCommands select (parseNumber _selectedCommandId);
		_selectedPlayer = playersRegistered select (lbCurSel RcsPlayersList);
		[_selectedPlayer] call (_selectedCommand select 2);
	} else {
		_selectedCommandId = (RcsOthersCommandsList lbData (lbCurSel RcsOthersCommandsList));
		_selectedCommand = othersCommands select (parseNumber _selectedCommandId);

		[_selectedCommand select 2] call (_selectedCommand select 2);
	};
}];

RcsPlayersCommandsList ctrlAddEventHandler ["LBSelChanged", {
	params ["_ctrl"];

	_selectedCommandId = (RcsPlayersCommandsList lbData (lbCurSel RcsPlayersCommandsList));
	_selectedCommand = playersCommands select (parseNumber _selectedCommandId);
	RcsPlayersDescription ctrlSetText (_selectedCommand select 1);
}];

RcsOthersCommandsList ctrlAddEventHandler ["LBSelChanged", {
	params ["_ctrl"];

	_selectedCommandId = (RcsOthersCommandsList lbData (lbCurSel RcsOthersCommandsList));
	_selectedCommand = othersCommands select (parseNumber _selectedCommandId);
	RcsOthersDescription ctrlSetText (_selectedCommand select 1);
}];