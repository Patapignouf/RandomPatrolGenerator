/*
    bombDefuseGUI.sqf — Mini-jeu de désamorçage de bombe en GUI (version "count")
    Usage : [ _bombObjOrObjNull, _durationSec, _wiresCount (4..6), _seed ] execVM "bomb_minigame.sqf";
    Exemple : [player, 45, 5] execVM "bomb_minigame.sqf";
*/

params [
    ["_bombObj", objNull, [objNull]],
    ["_duration", 45, [0]],
    ["_wiresCount", -1, [0]],
    ["_seed", -1, [0]]
];

BIS_fnc_padNumber = {
        params ["_num","_digits", ["_padChar","0"]];
        _digits = _digits max 0;
        _num = floor _num;

        // Converti en chaîne, gère les négatifs proprement
        private _neg = (_num < 0);
        private _s = str (abs _num);

        // Sécurise le caractère de padding
        if (!(_padChar isEqualType "")) then { _padChar = str _padChar; };
        if ((count _padChar) == 0) then { _padChar = "0"; };
        _padChar = _padChar select [0,1];  // ne garde que 1 caractère

        // Calcule et construit le padding
        private _padLen = _digits - (count _s);
        if (_padLen > 0) then {
            private _pad = "";
            for "_i" from 1 to _padLen do { _pad = _pad + _padChar; };
            _s = _pad + _s;
        };

        if (_neg) then { "-" + _s } else { _s }
    };

RPG_Bomb_Finish = {
	params ["_disp","_success","_msg", "_bombObj"];
	if (_disp getVariable ["BOMB_finished", false]) exitWith {};
	_disp setVariable ["BOMB_finished", true];

	private _msgCtrl = _disp ctrlCreate ["RscStructuredText", 3000];
	private _x = safeZoneX + safeZoneW*0.35;
	private _y = safeZoneY + safeZoneH*0.45;
	_msgCtrl ctrlSetPosition [_x,_y,safeZoneW*0.30,safeZoneH*0.10];
	_msgCtrl ctrlCommit 0;
	_msgCtrl ctrlSetBackgroundColor (if (_success) then {[0.1,0.5,0.1,0.85]} else {[0.6,0.1,0.1,0.85]});
	_msgCtrl ctrlSetStructuredText parseText format ["<t align='center' size='1.2'>%1</t>", _msg];

	if (!_success && !isNull _bombObj) then {
	    //systemChat format ["in", getPos _bombObj];

		//Objective management 
		//Objective failed
		_thisTaskID = _bombObj getVariable "thisTask";

		_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
		_missionFailedObjectives = _missionFailedObjectives + [_thisTaskID]; //needs to be improved
		missionNamespace setVariable ["missionFailedObjectives", _missionFailedObjectives, true];

		//Delete task marker
		if (missionNameSpace getVariable ["enableObjectiveExactLocation",0] == 1) then 
		{
			[_thisTaskID] remoteExec ["deleteMarker", 0, true];
		};

		//Manage task system
		if ("RealismMode" call BIS_fnc_getParamValue == 1 ) then 
		{
			[_thisTaskID, "FAILED"] call BIS_fnc_taskSetState;
		};



		[_bombObj] spawn {
			params ["_bombObj"];
			uiSleep 0.6;
			if (!isNull _bombObj) then {
				createVehicle ["Bo_GBU12_LGB", getPosATL _bombObj, [], 0, "CAN_COLLIDE"];
			};
		};
	} else 
	{
		//Objective success

		_thisObjective = _bombObj getVariable "thisObjective";
	    //systemChat format ["_thisObjective = %1", _thisObjective];

		//Manage Completed Objective	
		_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
		_completedObjectives pushBack _thisObjective;
		missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
		//Manage UncompletedObjective
		_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
		_missionUncompletedObjectives = _missionUncompletedObjectives - [_thisObjective];
		missionNamespace setVariable ["missionUncompletedObjectives",_missionUncompletedObjectives,true];

		//Manage player's feedback
		if ("RealismMode" call BIS_fnc_getParamValue == 1) then 
		{
			[] call doIncrementAllCredits;	
			[_thisObjective] execVM 'engine\objectiveManagement\completeObjective.sqf'; 
			[{[50, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", 0];
		};
		//Manage respawn and delete object
		deleteVehicle _bombObj;
		if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
		{
			[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
		};
	};
	//systemChat format ["end"];

	[_disp] spawn {params ["_disp"]; uiSleep 3; if (!isNull _disp) then { _disp closeDisplay 2; }; };
};

_duration    = _duration max 5 min 600;
_wiresCount  = if (_wiresCount in [4,5,6]) then {_wiresCount} else {4 + floor random 3};
_seed        = if (_seed >= 0) then {_seed} else {round (diag_tickTime * 1000)};

// RNG LCG (pas d'opérateurs bitwise en SQF)
private _rndState = _seed;
private _rand = {
    _rndState = (12345 * _rndState + 67890) mod 2147483647;
    (_rndState / 2147483647)
};

// Couleurs de fils
private _palette = [
    [localize "RPG_GUI_BOMB_COLOR_RED",    [0.90,0.10,0.10,1]],
    [localize "RPG_GUI_BOMB_COLOR_BLUE",   [0.10,0.35,0.95,1]],
    [localize "RPG_GUI_BOMB_COLOR_GREEN",  [0.10,0.75,0.30,1]],
    [localize "RPG_GUI_BOMB_COLOR_YELLOW", [0.95,0.85,0.10,1]],
    [localize "RPG_GUI_BOMB_COLOR_WHITE",  [0.95,0.95,0.95,1]],
    [localize "RPG_GUI_BOMB_COLOR_BLACK",  [0.10,0.10,0.10,1]],
    [localize "RPG_GUI_BOMB_COLOR_ORANGE", [0.95,0.55,0.10,1]],
    [localize "RPG_GUI_BOMB_COLOR_PURPLE", [0.55,0.25,0.75,1]]
];

// Sélection unique avec count
private _colors = +_palette;
private _pick = [];
for "_i" from 1 to _wiresCount do {
    private _idx = floor ((call _rand) * (count _colors));
    _idx = _idx min ((count _colors) - 1);
    _pick pushBack (_colors deleteAt _idx);
};

// Règles
private _correctIdx = floor ((call _rand) * _wiresCount) min (_wiresCount - 1);
private _badIdx     = (_correctIdx + 1 + floor ((call _rand) * (_wiresCount - 1))) mod _wiresCount;
private _trapCount  = if (_wiresCount >= 6) then {2} else {1};
private _trapIdxs   = [];

{
    if !(_x in [_correctIdx,_badIdx]) then {
        _trapIdxs pushBackUnique _x;
        if ((count _trapIdxs) == _trapCount) exitWith {};
    };
} forEach (([0,1,2,3,4,5] select {_x < _wiresCount}) call BIS_fnc_arrayShuffle);

// Indices affichés
private _colorsNames = _pick apply {_x#0};
private _hintA = format [localize "RPG_GUI_BOMB_CLUE1", _colorsNames#_badIdx];
private _hintB = format [localize "RPG_GUI_BOMB_CLUE2",
    _colorsNames#_correctIdx, _colorsNames#((_correctIdx + 1) mod _wiresCount)
];

// GUI
private _disp = (findDisplay 46) createDisplay "RscDisplayEmpty";
if (isNull _disp) exitWith {hint "Impossible de créer la GUI.";};

private _make = {
    params ["_type","_idc","_x","_y","_w","_h"];
    private _ctrl = _disp ctrlCreate [_type, _idc];
    _ctrl ctrlSetPosition [_x, _y, _w, _h];
    _ctrl ctrlCommit 0;
    _ctrl
};

private _sx = safeZoneX; private _sy = safeZoneY; private _sw = safeZoneW; private _sh = safeZoneH;
private _panelX = _sx + _sw * 0.30; private _panelY = _sy + _sh * 0.20; private _panelW = _sw * 0.40; private _panelH = _sh * 0.60;

private _bg = ["RscText",1000,_panelX,_panelY,_panelW,_panelH] call _make;
_bg ctrlSetBackgroundColor [0,0,0,0.7];

private _title = ["RscStructuredText",1001,_panelX,_panelY - _sh*0.04,_panelW,_sh*0.04] call _make;
_title ctrlSetStructuredText parseText (format ["<t align='center' size='1.2'>%1</t>", localize "RPG_GUI_BOMB_TITLE"]);

private _timerCtrl = ["RscStructuredText",1002,_panelX + _panelW*0.70,_panelY + _sh*0.01,_panelW*0.28,_sh*0.05] call _make;
_timerCtrl ctrlSetStructuredText parseText "<t align='right' size='1.2'>--:--</t>";

private _hintCtrl = ["RscStructuredText",1003,_panelX + _panelW*0.03,_panelY + _sh*0.01,_panelW*0.64,_sh*0.10] call _make;
_hintCtrl ctrlSetBackgroundColor [0,0,0,0.3];
_hintCtrl ctrlSetStructuredText parseText format ["<t size='0.95'>%1<br/>%2</t>", _hintA, _hintB];

private _areaX = _panelX + _panelW*0.05;
private _areaY = _panelY + _sh*0.14;
private _areaW = _panelW * 0.90;
private _areaH = _panelH * 0.70;

// State
_disp setVariable ["BOMB_finished", false];
_disp setVariable ["BOMB_canClick", true];
_disp setVariable ["BOMB_cut", []];
_disp setVariable ["BOMB_correct", _correctIdx];
_disp setVariable ["BOMB_bad", _badIdx];
_disp setVariable ["BOMB_traps", _trapIdxs];

// Fils
private _gap = (_areaH - (_wiresCount * (_sh*0.07))) / (_wiresCount + 1) max 0;
for "_i" from 0 to (_wiresCount - 1) do {
	private _rowY = _areaY + _gap * (_i + 1) + (_sh*0.07)*_i;

	private _cBody = ["RscText", 2000 + _i, _areaX, _rowY, _areaW*0.70, _sh*0.06] call _make;
	_cBody ctrlSetBackgroundColor (_pick#_i#1);

	private _lab = ["RscStructuredText", 2100 + _i, _areaX + _areaW*0.02, _rowY, _areaW*0.30, _sh*0.06] call _make;
	_lab ctrlSetStructuredText parseText format ["<t size='0.9' align='left'>%2 %1</t>", _pick#_i#0, localize "RPG_GUI_BOMB_WIRE"];

	private _btn = ["RscButton", 2200 + _i, _areaX + _areaW*0.75, _rowY, _areaW*0.20, _sh*0.06] call _make;
	bombObj = _bombObj;
	_btn ctrlSetText (localize "RPG_GUI_BOMB_CUT");
	_btn ctrlAddEventHandler ["ButtonClick", {
		params ["_ctrl"];
		private _bombObj = bombObj;
		private _disp = ctrlParent _ctrl;
		private _idx  = (ctrlIDC _ctrl) - 2200;

		if !(_disp getVariable ["BOMB_canClick", true]) exitWith {};
		_disp setVariable ["BOMB_canClick", false];

		private _cut = +(_disp getVariable ["BOMB_cut", []]);
		if (_idx in _cut) exitWith { _disp setVariable ["BOMB_canClick", true]; };

		_cut pushBack _idx;
		_disp setVariable ["BOMB_cut", _cut];

		((_disp displayCtrl (2000 + _idx))) ctrlSetBackgroundColor [0.2,0.2,0.2,0.6];
		((_disp displayCtrl (2200 + _idx))) ctrlEnable false;

		private _correct = _disp getVariable ["BOMB_correct", -1];
		private _bad     = _disp getVariable ["BOMB_bad", -1];
		private _traps   = _disp getVariable ["BOMB_traps", []];

		if (_idx == _bad) exitWith {
			playSound "AddItemFailed";
			[_disp, false, localize "RPG_GUI_BOMB_WRONG_CUT",_bombObj] call RPG_Bomb_Finish;
		};

	 	//systemChat format ["bombPos = %1 on ", _bombObj getVariable "thisObjective", getPos _bombObj];


		if (_idx == _correct) exitWith {
			playSound "ClickSoft";
			[_disp, true, localize "RPG_GUI_BOMB_SUCCESS",_bombObj] call RPG_Bomb_Finish;
		};

		if (_idx in _traps) then {
			private _hint = _disp displayCtrl 1003;
			_hint ctrlSetStructuredText parseText (format ["<t size='0.95'>%1<br/>???</t>", localize "RPG_GUI_BOMB_JAM"]);
		};

		playSound "ClickSoft";
		_disp setVariable ["BOMB_canClick", true];
	}];
};

// Timer + bip
_disp setVariable ["BOMB_endTime", time + _duration];
[_disp, _duration, _bombObj] spawn {
    params ["_disp","_dur","_bombObj"];
    private _timerCtrl = _disp displayCtrl 1002;
    private _lastBeep = 0;
    while { !(_disp getVariable ["BOMB_finished", false]) } do {
        private _remain = (_disp getVariable ["BOMB_endTime", time]) - time;
        if (_remain <= 0) exitWith {
            [_disp, false, localize "RPG_GUI_BOMB_END_TIMER",_bombObj] call RPG_Bomb_Finish;
        };

        private _m = floor (_remain / 60);
        private _s = floor (_remain mod 60);
        private _mStr = [_m,2] call BIS_fnc_padNumber;
        private _sStr = [_s,2] call BIS_fnc_padNumber;
        _timerCtrl ctrlSetStructuredText parseText format ["<t align='right' size='1.2'>%1:%2</t>", _mStr, _sStr];

        private _t = 1 - (_remain / _dur) max 0 min 1;
        private _interval = 0.8 - 0.6*_t; // accélère vers la fin
        if (time - _lastBeep >= _interval) then {
            _lastBeep = time;
            playSound "FD_Timer_F";
        };

        uiSleep 0.02;
    };
};

// Bloquer ESC (optionnel)
_disp displayAddEventHandler ["KeyDown", {
    params ["_disp","_key"];
    if (_key in actionKeys "MenuBack") then { true } else { false };
}];
