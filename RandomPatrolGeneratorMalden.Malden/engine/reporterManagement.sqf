//Create display too choose reporter player
_display = (findDisplay 46) createDisplay "RscDisplayEmpty";

_dropdown = _display ctrlCreate ["RscCombo", 100];
_dropdown ctrlSetPosition [0, 0, 1, 0.04];
_dropdown ctrlCommit 0;

{
	_item = _dropdown lbAdd format ["Player %1 - %2", (_forEachIndex + 1), name _x];
	_dropdown lbSetData [_item, name _x];
} forEach allPlayers;

_dropdown ctrlAddEventHandler ["LBSelChanged",
{
	params ["_control", "_selectedIndex"];
	if (_control lbData (lbCurSel _control) != "") then 
	{
		//Select specific player
		_choosenPlayer = (allPlayers select {name _x == (_control lbData (lbCurSel _control))})#0;

		//Transform player to reporter
		[[_choosenPlayer], 'engine\reporterConverter.sqf'] remoteExec ['BIS_fnc_execVM', _choosenPlayer];
	}
}];