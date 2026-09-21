

doQTE = {


	/*
    File: fn_qte.sqf
    Description: Helldivers-style QTE with GUI, dynamic arrows, movement keys support (WASD/ZQSD + Arrows), sound effects, and clean guaranteed cleanup.

    Parameters:
    0 : NUMBER - Number of keys in the sequence (default: 4)
    1 : NUMBER - Time limit in seconds to succeed (default: 5)

    Returns:
    BOOL - True if successful, False if failed or timeout.
	*/

	params [
		["_length", 4, [0]],
		["_timeOut", 5, [0]]
	];

	// Key configuration: [Array of KeyCodes (Arrows + WASD/ZQSD equivalents), Angle, Key Name]
	private _keysData = [
		[[200, 17], 0,   "UP"],    // Arrow Up, W (17), Z (17)
		[[208, 31], 180, "DOWN"],  // Arrow Down, S (31)
		[[203, 30, 16], 270, "LEFT"], // Arrow Left, A (30), Q (16)
		[[205, 32], 90,  "RIGHT"]  // Arrow Right, D (32)
	];

	// Generate random sequence
	private _sequence = [];
	for "_i" from 1 to _length do {
		_sequence pushBack (selectRandom _keysData);
	};

	// Temporary global variables for the event handler
	qte_sequence = _sequence;
	qte_currentIndex = 0;
	qte_success = false;
	qte_failed = false;
	qte_wrongIndex = -1;

	private _display = findDisplay 46;

	// Create GUI background centered at the bottom of the screen
	private _ctrlGroupBg = _display ctrlCreate ["RscText", -1];
	_ctrlGroupBg ctrlSetPosition [0.29, 0.64, 0.42, 0.13];
	_ctrlGroupBg ctrlSetBackgroundColor [0, 0, 0, 0.7];
	_ctrlGroupBg ctrlCommit 0;

	// QTE Title
	private _ctrlTitle = _display ctrlCreate ["RscStructuredText", -1];
	_ctrlTitle ctrlSetPosition [0.29, 0.65, 0.42, 0.03];
	_ctrlTitle ctrlSetStructuredText parseText "<t align='center' size='0.9' color='#FFFF00'>SEQUENCE REQUIRED</t>";
	_ctrlTitle ctrlCommit 0;

	// Countdown Progress Bar
	private _ctrlProgress = _display ctrlCreate ["RscProgress", -1];
	_ctrlProgress ctrlSetPosition [0.32, 0.70, 0.36, 0.015];
	_ctrlProgress progressSetPosition 1;
	_ctrlProgress ctrlCommit 0;

	// Dynamic graphical arrows creation (RscPicture)
	private _arrowControls = [];
	private _totalWidth = _length * 0.04;
	private _startX = 0.5 - (_totalWidth / 2);

	{
		_x params ["_keyCodes", "_angle", "_name"];

		private _ctrlArrow = _display ctrlCreate ["RscPicture", -1];
		_ctrlArrow ctrlSetPosition [_startX + (_forEachIndex * 0.04), 0.735, 0.03, 0.03];
		_ctrlArrow ctrlSetText "\a3\ui_f\data\map\markers\military\arrow_ca.paa";
		_ctrlArrow ctrlSetAngle [_angle, 0.5, 0.5];
		_ctrlArrow ctrlSetTextColor [1, 1, 1, 1]; // White by default
		_ctrlArrow ctrlCommit 0;

		_arrowControls pushBack _ctrlArrow;
	} forEach qte_sequence;

	// Function to update icon colors and messages
	private _updateDisplay = {
		{
			private _ctrl = _arrowControls select _forEachIndex;
			if (_forEachIndex == qte_wrongIndex) then {
				_ctrl ctrlSetTextColor [1, 0, 0, 1]; // Red if wrong key
			} else {
				if (_forEachIndex < qte_currentIndex) then {
					_ctrl ctrlSetTextColor [0, 1, 0, 1]; // Green if validated
				} else {
					_ctrl ctrlSetTextColor [1, 1, 1, 1]; // White if waiting
				};
			};
			_ctrl ctrlCommit 0;
		} forEach qte_sequence;

		if (qte_failed) then {
			_ctrlTitle ctrlSetStructuredText parseText "<t align='center' size='0.9' color='#FF0000'>ACTION FAILED</t>";
		};
		if (qte_success) then {
			_ctrlTitle ctrlSetStructuredText parseText "<t align='center' size='0.9' color='#00FF00'>ACTION SUCCESSFUL</t>";
			{
				_x ctrlSetTextColor [0, 1, 0, 1];
				_x ctrlCommit 0;
			} forEach _arrowControls;
		};
	};

	// Keydown event handler
	private _eh = _display displayAddEventHandler ["KeyDown", {
		params ["_display", "_key", "_code", "_shift", "_ctrl", "_alt"];

		if (qte_success || qte_failed) exitWith { false; };

		private _currentExpectedKeys = (qte_sequence select qte_currentIndex) select 0;

		if (_key in _currentExpectedKeys) then {
			// Correct input sound (Volume: 2, Pitch: 1.0)
			playSound3D ["A3\Sounds_F\sfx\blip1.wss", player, false, getPosASL player, 2, 1.0];

			qte_currentIndex = qte_currentIndex + 1;
			if (qte_currentIndex >= count qte_sequence) then {
				qte_success = true;
			};
		} else {
			// Wrong input sound immediately (Deep, loud error buzz - Volume: 4, Pitch: 0.4)
			playSound3D ["A3\Sounds_F\sfx\blip1.wss", player, false, getPosASL player, 4, 0.4];

			qte_wrongIndex = qte_currentIndex;
			qte_failed = true;
		};

		false
	}];

	// Wait loop and timeout management
	private _startTime = time;
	private _absoluteStartTime = time;
	private _result = false;
	private _frozenProgress = 1;
	private _ended = false;
	private _soundPlayed = false;

	waitUntil {
		sleep 0.01;

		// Absolute failsafe
		if ((time - _absoluteStartTime) > (_timeOut + 2)) then {
			if (!qte_success && !qte_failed) then {
				qte_failed = true;
			};
		};

		if (!qte_failed && !qte_success) then {
			private _elapsed = time - _startTime;
			_frozenProgress = 1 - (_elapsed / _timeOut);
			_ctrlProgress progressSetPosition _frozenProgress;
		} else {
			_ctrlProgress progressSetPosition _frozenProgress;
		};

		if (_frozenProgress <= 0) then {
			if (!qte_success && !qte_failed) then {
				// Timeout failure sound
				playSound3D ["A3\Sounds_F\sfx\blip1.wss", player, false, getPosASL player, 4, 0.4, 3];
				qte_failed = true;
			};
		};

		call _updateDisplay;

		if (qte_success) then {
			if (!_soundPlayed) then {
				// Success sound: High-pitched clear beep (Volume: 3, Pitch: 1.2)
				playSound3D ["A3\Sounds_F\sfx\beep_target.wss", player, false, getPosASL player, 3, 1.2, 3];
				_soundPlayed = true;
			};
			_result = true;
			_ended = true;
		};

		if (qte_failed) then {
			if (!_soundPlayed) then {
				// Fallback failure sound if triggered by timeout
				playSound3D ["A3\Sounds_F\sfx\blip1.wss", player, false, getPosASL player, 4, 0.4, 3];
				_soundPlayed = true;
			};
			_result = false;
			_ended = true;
		};

		_ended
	};

	// Final update display and short pause before clearing GUI
	call _updateDisplay;
	uiSleep 0.5;

	// Guaranteed Cleanup
	if (!isNull _display) then {
		_display displayRemoveEventHandler ["KeyDown", _eh];
	};

	{
		if (!isNull _x) then { ctrlDelete _x; };
	} forEach _arrowControls;

	if (!isNull _ctrlGroupBg) then { ctrlDelete _ctrlGroupBg; };
	if (!isNull _ctrlTitle) then { ctrlDelete _ctrlTitle; };
	if (!isNull _ctrlProgress) then { ctrlDelete _ctrlProgress; };

	// Cleanup global variables
	qte_sequence = nil;
	qte_currentIndex = nil;
	qte_success = nil;
	qte_failed = nil;
	qte_wrongIndex = nil;

	_result
};