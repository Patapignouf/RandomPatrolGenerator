//To test 
//_trgAOC = createTrigger ["EmptyDetector", getPos player];
//_trgAOC setTriggerArea [200, 200, 0, true];
//[[_trgAOC] , "GUI\dominationGUI\dominationGUI.sqf"] remoteExec ['BIS_fnc_execVM', 0];
//player enableSimulation false;
params ["_trigger"];

disableSerialization;

diag_log format ["Domination GUI : %1", getPos _trigger];

//Fix trigger area
_trigger setTriggerArea [200, 200, 0, false];

#define UPDATE_DELAY 1

if (hasInterface) then 
{
	private _display = findDisplay 46;
	if (isNull _display) exitWith {};

	// Size and position (safezone coordinates)
	private _barW = 0.45;
	private _barH = 0.03;
	private _yOffset = 0;
	private _barX = safezoneX + safezoneW * 0.5 - _barW * 0.5;
	private _barY = safezoneY + 0.04 + _yOffset;

	// Bar background
	private _ctrlBg = _display ctrlCreate ["RscText", -1];
	_ctrlBg ctrlSetPosition [_barX, _barY, _barW, _barH];
	_ctrlBg ctrlSetBackgroundColor [0, 0, 0, 0.6];
	_ctrlBg ctrlCommit 0;

	// Title above the bar
	private _ctrlTitle = _display ctrlCreate ["RscText", -1];
	_ctrlTitle ctrlSetPosition [_barX, _barY - 0.025, _barW, 0.02];
	_ctrlTitle ctrlSetText localize "RPG_GUI_OVERLAY_SECTOR";
	_ctrlTitle ctrlSetTextColor [1, 1, 1, 1];
	_ctrlTitle ctrlSetBackgroundColor [0, 0, 0, 0];
	_ctrlTitle ctrlCommit 0;

	// Blue segment (BLUFOR) - grows from the left
	private _ctrlBlue = _display ctrlCreate ["RscText", -1];
	_ctrlBlue ctrlSetBackgroundColor [0.1, 0.4, 1, 1];
	_ctrlBlue ctrlSetPosition [_barX, _barY, 0, _barH];
	_ctrlBlue ctrlCommit 0;

	// Red segment (OPFOR) - grows from the right
	private _ctrlRed = _display ctrlCreate ["RscText", -1];
	_ctrlRed ctrlSetBackgroundColor [1, 0.15, 0.15, 1];
	_ctrlRed ctrlSetPosition [_barX + _barW, _barY, 0, _barH];
	_ctrlRed ctrlCommit 0;

	// Text showing the unit count for each side
	private _ctrlCount = _display ctrlCreate ["RscText", -1];
	_ctrlCount ctrlSetPosition [_barX, _barY, _barW, _barH];
	_ctrlCount ctrlSetBackgroundColor [0, 0, 0, 0];
	_ctrlCount ctrlSetTextColor [1, 1, 1, 1];
	_ctrlCount ctrlSetText "";
	_ctrlCount ctrlCommit 0;

	//Check settings value to display or not text XX vs YY
	private _isVSTextEnabled = (missionNameSpace getVariable ["playerCounterSectorControl", 1] == 1);

	private _allControls = [_ctrlBg, _ctrlTitle, _ctrlBlue, _ctrlRed, _ctrlCount];
	private _isShown = true;

	while {!isNull _trigger && !isNull _ctrlBg} do {
		// Show/hide the bar depending on whether the local player is inside the zone
		private _inZone = (player inArea _trigger);

		if (_inZone && !_isShown) then {
			{ _x ctrlShow true } forEach _allControls;
			_isShown = true;
		};
		if (!_inZone && _isShown) then {
			{ _x ctrlShow false } forEach _allControls;
			_isShown = false;
		};

		if (_inZone) then {
			private _blue = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _trigger);
			private _nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _trigger);
			private _red = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _trigger); 
			private _total = _blue + _red + _nbIndPlayer;

			private _blueRatio = if (_total > 0) then { (_blue+_nbIndPlayer) / _total } else { 0 };
			private _redRatio  = if (_total > 0) then { _red  / _total } else { 0 };

			_ctrlBlue ctrlSetPosition [_barX, _barY, _barW * _blueRatio, _barH];
			_ctrlBlue ctrlCommit UPDATE_DELAY;

			_ctrlRed ctrlSetPosition [_barX + _barW * (1 - _redRatio), _barY, _barW * _redRatio, _barH];
			_ctrlRed ctrlCommit UPDATE_DELAY;
			
			if (_isVSTextEnabled) then 
			{
				_ctrlCount ctrlSetText format ["%1 vs %2", _blue, _red];
			};
		};

		sleep UPDATE_DELAY;
	};

	// Cleanup controls at the end of the script
	{
		if (!isNull _x) then { ctrlDelete _x };
	} forEach _allControls;
};

