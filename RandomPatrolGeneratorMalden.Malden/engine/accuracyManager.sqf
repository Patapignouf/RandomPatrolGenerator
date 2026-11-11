/*
    ArmA 3 — Real-time accuracy counter (lightweight)
    -------------------------------------------------
    Usage: in init.sqf (or initPlayerLocal.sqf):
        execVM "accuracy.sqf";

    How it works:
- No loops: the display is updated only upon firing / impact.
- Accuracy = hits / shots.
- Only weapon shots are counted (grenades and charges ignored).
- A projectile counts for a single impact only.
*/

if (!hasInterface) exitWith {};

// ---------------- Configuration ----------------
ACC_ONLY_HOSTILE = false;   // true = count impacts on enemies only ; false = any target (unit/vehicle)
ACC_DEBUG = false; 
// -----------------------------------------------

waitUntil {!isNull player && {!isNull findDisplay 46}};

ACC_shots = 0;
ACC_hits  = 0;

// // --- Interface (right side of the screen) ---
// ACC_ctrl = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
// ACC_ctrl ctrlSetPosition [
//     safeZoneX + safeZoneW - 0.32,
//     safeZoneY + safeZoneH * 0.45,
//     0.30,
//     0.12
// ];
// ACC_ctrl ctrlSetBackgroundColor [0, 0, 0, 0.45];
// ACC_ctrl ctrlCommit 0;

// --- Display update ---
ACC_fnc_update = {
    private _acc = if (ACC_shots > 0) then {round (ACC_hits / ACC_shots * 1000) / 10} else {0};
    private _col = if (_acc >= 50) then {"#66ff66"} else {if (_acc >= 25) then {"#ffd966"} else {"#ff6666"}};

	player setVariable ["RPG_Accuracy", _acc];
    // ACC_ctrl ctrlSetStructuredText parseText format [
    //     "<t size='0.9' align='right'>Accuracy: <t color='%1'>%2 %%</t><br/>Shots: %3 | Hits: %4</t>",
    //     _col, _acc, ACC_shots, ACC_hits
    // ];
};

// --- Reset (manual call: call ACC_fnc_reset) ---
ACC_fnc_reset = {
    ACC_shots = 0;
    ACC_hits  = 0;
    call ACC_fnc_update;
};

// --- Handler registration on a unit (also handles respawn) ---
ACC_fnc_attach = {
    params ["_unit"];
    if (_unit getVariable ["ACC_attached", false]) exitWith {};
    _unit setVariable ["ACC_attached", true];

    _unit addEventHandler ["FiredMan", {
        params ["_unit", "_weapon", "", "", "", "", "_projectile"];
        if (_weapon in ["Throw", "Put"] || {isNull _projectile}) exitWith {};

        ACC_shots = ACC_shots + 1;
        call ACC_fnc_update;

        // EH of PROJECTILE
        _projectile addEventHandler ["HitPart", {
            params ["_proj", "_target", "_shooter"];

            if (ACC_DEBUG) then {systemChat format ["[ACC] HitPart : %1 -> %2", typeOf _proj, typeOf _target]};

            if (_proj getVariable ["ACC_done", false]) exitWith {};
            if (isNull _target || {_target isEqualTo _shooter}) exitWith {};
            if (!(_target isKindOf "AllVehicles") || {!alive _target}) exitWith {};
            if (ACC_ONLY_HOSTILE && {(side group _target) getFriend (side group _shooter) >= 0.6}) exitWith {};

            _proj setVariable ["ACC_done", true];
            ACC_hits = ACC_hits + 1;
            call ACC_fnc_update;
        }];
    }];

    _unit addEventHandler ["Respawn", {
        params ["_new"];
        [_new] call ACC_fnc_attach;
    }];
};

[player] call ACC_fnc_attach;
call ACC_fnc_update;