/*
    File: challengeSystem.sqf
    Description:
        A simple challenge system to keep players engaged in the current mission.

        - Asks the player whether they want to take on a challenge.
        - Offers three challenges (one EASY, one MEDIUM, one HARD) picked at random
          from a pool, through a very simple dialog.
        - Once a challenge is picked, the player is committed to it until it is completed.
        - Progress is displayed on a small HUD on the left of the screen.
        - Completing a challenge triggers an internal reward function which spawns a
          supply crate (marked with green smoke) in front of the player and heals them.

    Setup:
        Run this file once on every client (e.g. from initPlayerLocal.sqf):
            call compile preprocessFileLineNumbers "challengeSystem.sqf";

        The player can also open the challenge board at any time (when no challenge
        is active) with the "Request a challenge" action, or by calling:
            [] call SCR_fnc_challenge_openBoard;

    Notes:
        - No description.ext / config entries are required (UI is created dynamically).
        - Progress is stored client-side in memory only (it is lost if the player disconnects).
        - Everything is prefixed with SCR_ to avoid name clashes.
*/

// Only players need this system (skip dedicated server / headless clients)
if (!hasInterface) exitWith {};

// Prevent double initialisation
if (!isNil "SCR_challenge_initDone") exitWith {};
SCR_challenge_initDone = true;

// ----------------------------------------------------------------------------
// Settings
// ----------------------------------------------------------------------------
SCR_challenge_autoPrompt      = true;  // Automatically ask the player once after joining
SCR_challenge_autoPromptDelay = 15;    // Seconds to wait before the automatic prompt
SCR_challenge_crateLifetime   = 600;   // Seconds before a reward crate is deleted

// ----------------------------------------------------------------------------
// State (do not edit)
// ----------------------------------------------------------------------------
SCR_challenge_current  = [];  // Active challenge definition, [] if none
SCR_challenge_progress = 0;   // Progress of the active challenge
SCR_challenge_streak   = [];  // Timestamps of recent kills (used by "streak" challenges)
SCR_challenge_offers   = [];  // The three challenges currently offered by the board

// ----------------------------------------------------------------------------
// Tier data: [label, RGBA colour, reward name]
// ----------------------------------------------------------------------------
SCR_challenge_tierData = [
    ["EASY",   [0.49, 0.99, 0.00, 1], "25 XP"],
    ["MEDIUM", [1.00, 0.65, 0.00, 1], "50 XP"],
    ["HARD",   [1.00, 0.30, 0.30, 1], "100 XP"]
];

// ----------------------------------------------------------------------------
// Challenge pool
// Format: [id, title, description, type, goal, parameter, tier]
//
// Types:
//   "kills"       - Kill <goal> enemy infantry
//   "killFar"     - Kill <goal> enemy infantry from <parameter> m or more
//   "killNear"    - Kill <goal> enemy infantry from <parameter> m or less
//   "vehicleKill" - Destroy <goal> enemy vehicles
//   "streak"      - Get <goal> kills within <parameter> seconds
//   "distance"    - Travel <goal> metres on foot
//   "survive"     - Stay alive for <goal> seconds (time spent dead is not counted)
// ----------------------------------------------------------------------------
SCR_challenge_pool = [
    // --- Tier 1: EASY ---
    ["warmUp",       "Warm-Up",         "Eliminate 5 enemy soldiers.",                                  "kills",       5,    0,  1],
    ["pathfinder",   "Pathfinder",      "Travel 3 km on foot. Vehicles do not count.",                  "distance",    3000, 0,  1],
    ["buddyUp",       "Buddy System",       "Stay within 30 m of a teammate for 5 minutes.",            "stayClose",  300,  [30, 1], 1],

    // --- Tier 2: MEDIUM ---
    ["sharpshooter", "Sharpshooter",    "Eliminate 5 enemy soldiers from 100 m or more.",               "killFar",     5,    100, 2],
    ["closeQuarters","Close Quarters",  "Eliminate 4 enemy soldiers from 20 m or less.",                "killNear",    4,    20, 2],
    ["survivor",     "Survivor",        "Stay alive for 15 minutes. Time spent dead does not count.",   "survive",     900,  0,  2],
    ["veteran",      "Veteran",         "Eliminate 12 enemy soldiers.",                                 "kills",       12,   0,  2],
    ["stickTogether", "Stick Together",     "Stay within 25 m of at least 2 teammates for 5 minutes.",           "stayClose",  300,  [25, 2], 2],
    ["huntingParty",  "Hunting Party",      "Eliminate 6 enemy soldiers while a teammate is within 30 m.",       "teamKills",  6,    [30, 1], 2],
    ["inFormation",   "In Formation",       "Travel 2 km on foot while staying within 25 m of a teammate.",      "teamMove",   2000, [25, 1], 2],


    // --- Tier 3: HARD ---
    ["vehicleHunter","Vehicle Hunter",  "Destroy 2 enemy vehicles.",                                    "vehicleKill", 2,    0,  3],
    ["killingSpree", "Killing Spree",   "Eliminate 3 enemy soldiers within 15 seconds.",                "streak",      3,    15, 3],
    ["rampage",      "Rampage",         "Eliminate 6 enemy soldiers within 60 seconds.",                "streak",      6,    60, 3],
    ["wolfPack",      "Wolf Pack",          "Your group eliminates 20 enemy soldiers together.",                 "groupKills", 20,   0,       3],
    ["brothers",      "Band of Brothers",   "Stay within 20 m of at least 2 teammates for 10 minutes.",          "stayClose",  600,  [20, 2], 3],
    ["assault",       "Coordinated Assault","Eliminate 10 enemy soldiers while 2 teammates are within 40 m.",    "teamKills",  10,   [40, 2], 3]
];

// ----------------------------------------------------------------------------
// Helper: format a progress value for display
// Params: 0: STRING - challenge type, 1: NUMBER - progress, 2: NUMBER - goal
// Returns: STRING
// ----------------------------------------------------------------------------
SCR_fnc_challenge_formatProgress = {
    params ["_type", "_progress", "_goal"];

    switch (_type) do {
        case "distance";
        case "teamMove": {
            format ["%1 / %2 m", round _progress, _goal]
        };
        case "survive";
        case "stayClose": {
            format [
                "%1 / %2",
                [round _progress, "MM:SS"] call BIS_fnc_secondsToString,
                [_goal, "MM:SS"] call BIS_fnc_secondsToString
            ]
        };
        default {
            format ["%1 / %2", floor _progress, _goal]
        };
    }
};

// ----------------------------------------------------------------------------
// HUD: small tracker showing the active challenge and its progress
// Params: 0: STRING - (Optional) custom HTML message to display instead of the tracker
// ----------------------------------------------------------------------------
SCR_fnc_challenge_updateHud = {
    params [["_message", ""]];

    private _display = findDisplay 46;
    if (isNull _display) exitWith {};

    // Create the HUD control once
    private _ctrl = uiNamespace getVariable ["SCR_challenge_hudCtrl", controlNull];
    if (isNull _ctrl) then {
        _ctrl = _display ctrlCreate ["RscStructuredText", -1];
        _ctrl ctrlSetPosition [
            safeZoneX + 0.01,
            safeZoneY + 0.28 * safeZoneH,
            0.15 * safeZoneW,
            0.09 * safeZoneH
        ];
        _ctrl ctrlSetBackgroundColor [0, 0, 0, 0.55];
        _ctrl ctrlCommit 0;
        uiNamespace setVariable ["SCR_challenge_hudCtrl", _ctrl];
    };

    // Nothing to show: hide the HUD
    if (SCR_challenge_current isEqualTo [] && {_message isEqualTo ""}) exitWith {
        _ctrl ctrlShow false;
    };

    private _text = if !(_message isEqualTo "") then {
        parseText _message
    } else {
        SCR_challenge_current params ["_id", "_title", "_desc", "_type", "_goal"];
        private _updatedText = [_type, SCR_challenge_progress, _goal] call SCR_fnc_challenge_formatProgress;
        player setVariable ["RPG_SideTaskStatus", _updatedText];
        player setVariable ["RPG_SideTaskType", _type];
        parseText format [
            "<t size='0.8' color='#FFD966'>CHALLENGE</t><br/><t size='0.9'>%1</t><br/><t size='0.9' color='#9FE2BF'>%2</t>",
            _title,
            _updatedText
        ]
    };

    _ctrl ctrlSetStructuredText _text;
    _ctrl ctrlShow true;

    //Display ctrl only 2 seconds
    [_ctrl] spawn 
    {
        params ["_ctrl"];
        sleep 3;
        _ctrl ctrlShow false;
    };
};

// ----------------------------------------------------------------------------
// Internal reward function: spawns a supply crate near the player and heals them.
// The content of the crate depends on the challenge tier.
// Params: 0: NUMBER - tier (1 = easy, 2 = medium, 3 = hard)
// ----------------------------------------------------------------------------
SCR_fnc_challenge_giveReward = {
    params [["_tier", 1, [0]]];

    private _index = (_tier - 1) max 0 min 2;

    [[25, 50, 100] select _index, "RPG_ranking_objective_complete"] call doUpdateRank;
};

// ----------------------------------------------------------------------------
// Sets the progress of the active challenge (completes it if the goal is reached)
// Params: 0: NUMBER - new progress value
// ----------------------------------------------------------------------------
SCR_fnc_challenge_setProgress = {
    params ["_value"];

    if (SCR_challenge_current isEqualTo []) exitWith {};

    private _goal = SCR_challenge_current select 4;
    SCR_challenge_progress = _value min _goal;

    if (SCR_challenge_progress >= _goal) exitWith {
        [] call SCR_fnc_challenge_complete;
    };

    [""] call SCR_fnc_challenge_updateHud;
};


// ----------------------------------------------------------------------------
// Completes the active challenge and gives the reward
// ----------------------------------------------------------------------------
SCR_fnc_challenge_complete = {
    if (SCR_challenge_current isEqualTo []) exitWith {};

    private _title = SCR_challenge_current select 1;
    private _tier  = SCR_challenge_current select 6;

    // Free the player: they may request a new challenge afterwards
    SCR_challenge_current  = [];
    SCR_challenge_progress = 0;
    SCR_challenge_streak   = [];

    [_tier] call SCR_fnc_challenge_giveReward;

    [format [
        "<t size='0.8' color='#7CFC00'>CHALLENGE COMPLETE</t><br/><t size='0.9'>%1</t>",
        _title
    ]] call SCR_fnc_challenge_updateHud;

    // Hide the HUD after a few seconds unless a new challenge was accepted
    [] spawn {
        uiSleep 6;
        if (SCR_challenge_current isEqualTo []) then {
            [""] call SCR_fnc_challenge_updateHud;
        };
    };
};


// ----------------------------------------------------------------------------
// Accepts a challenge: the player is now committed to it
// Params: 0: ARRAY - challenge definition from the pool
// ----------------------------------------------------------------------------
SCR_fnc_challenge_accept = {
    params ["_definition"];

    // Cannot accept a second challenge while one is active
    if !(SCR_challenge_current isEqualTo []) exitWith {};

    SCR_challenge_current  = _definition;
    SCR_challenge_progress = 0;
    SCR_challenge_streak   = [];
    SCR_challenge_offers   = [];

    systemChat format ["[Challenge] Accepted: %1. There is no turning back!", _definition select 1];
    [""] call SCR_fnc_challenge_updateHud;
};

// Count player alive around
// Params: 0: NUMBER - rayon en mètres
// Returns: NUMBER
SCR_fnc_challenge_countMates = {
    params [["_radius", 30]];

    private _all = (units group player) + allPlayers;
    _all = _all arrayIntersect _all; // supprime les doublons

    count (_all select {
        !(_x isEqualTo player)
        && {alive _x}
        && {side group _x isEqualTo side group player}
        && {_x distance player <= _radius}
    })
};

// ----------------------------------------------------------------------------
// Kill tracking (called by the EntityKilled mission event handler)
// Params: same as the EntityKilled event: victim, killer, instigator
// ----------------------------------------------------------------------------
SCR_fnc_challenge_onKill = {
    params ["_victim", "_killer", "_instigator"];

    if (SCR_challenge_current isEqualTo []) exitWith {};

    // Le vrai tireur est l'instigateur quand il est disponible
    private _shooter = if (isNull _instigator) then { _killer } else { _instigator };
    if (isNull _shooter) exitWith {};
    if (_victim isEqualTo player) exitWith {};

    private _byPlayer = _shooter isEqualTo player;
    private _byGroup  = _shooter in (units group player); // inclut le joueur
    if !(_byGroup) exitWith {};

    // Seuls les ennemis comptent
    private _victimSide = [_victim] call BIS_fnc_objectSide;
    if !(((side group player) getFriend _victimSide) < 0.6) exitWith {};

    private _isInfantry = _victim isKindOf "CAManBase";
    private _isVehicle  = !_isInfantry && {
        _victim isKindOf "LandVehicle" || {_victim isKindOf "Air"} || {_victim isKindOf "Ship"}
    };
    private _distance = player distance _victim;

    SCR_challenge_current params ["_id", "_title", "_desc", "_type", "_goal", "_parameter"];

    switch (_type) do {
        case "kills": {
            if (_byPlayer && _isInfantry) then { [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress };
        };
        case "killFar": {
            if (_byPlayer && _isInfantry && {_distance >= _parameter}) then { [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress };
        };
        case "killNear": {
            if (_byPlayer && _isInfantry && {_distance <= _parameter}) then { [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress };
        };
        case "vehicleKill": {
            if (_byPlayer && _isVehicle) then { [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress };
        };
        case "streak": {
            if (_byPlayer && _isInfantry) then {
                private _now = time;
                SCR_challenge_streak pushBack _now;
                SCR_challenge_streak = SCR_challenge_streak select { (_now - _x) <= _parameter };
                [count SCR_challenge_streak] call SCR_fnc_challenge_setProgress;
            };
        };
        case "teamKills": {
            if (_byPlayer && _isInfantry) then {
                _parameter params ["_radius", "_minMates"];
                if (([_radius] call SCR_fnc_challenge_countMates) >= _minMates) then {
                    [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
                };
            };
        };
        case "groupKills": {
            // Le kill de n'importe quel membre du groupe compte
            if (_isInfantry) then { [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress };
        };
    };
};

// ----------------------------------------------------------------------------
// Opens the challenge board: asks the player if they want a challenge and
// offers three of them (easy / medium / hard)
// ----------------------------------------------------------------------------
SCR_fnc_challenge_openBoard = {
    // Board already open
    if (!isNull (uiNamespace getVariable ["SCR_challenge_boardDisplay", displayNull])) exitWith {};

    // A challenge is already active
    if !(SCR_challenge_current isEqualTo []) exitWith {
        systemChat format ["[Challenge] You already have an active challenge: %1.", SCR_challenge_current select 1];
    };

    private _parent = findDisplay 46;
    if (isNull _parent) exitWith {};

    // Pick one random challenge per tier
    if (SCR_challenge_offers isEqualTo []) then {
        SCR_challenge_offers = [1, 2, 3] apply {
            private _tier = _x;
            selectRandom (SCR_challenge_pool select { (_x select 6) == _tier })
        };
    };

    // Create the display (the mouse cursor is shown automatically)
    private _display = _parent createDisplay "RscDisplayEmpty";
    uiNamespace setVariable ["SCR_challenge_boardDisplay", _display];

    // Layout
    private _w   = 0.42 * safeZoneW;
    private _h   = 0.72 * safeZoneH;
    private _x0  = safeZoneX + (safeZoneW - _w) / 2;
    private _y0  = safeZoneY + (safeZoneH - _h) / 2;
    private _pad = 0.015 * safeZoneW;
    private _innerW = _w - (_pad * 2);

    // Background
    private _background = _display ctrlCreate ["RscText", -1];
    _background ctrlSetPosition [_x0, _y0, _w, _h];
    _background ctrlSetBackgroundColor [0, 0, 0, 0.8];
    _background ctrlCommit 0;

    // Title
    private _titleCtrl = _display ctrlCreate ["RscStructuredText", -1];
    _titleCtrl ctrlSetPosition [_x0 + _pad, _y0 + 0.01 * safeZoneH, _innerW, 0.06 * safeZoneH];
    _titleCtrl ctrlSetStructuredText parseText "<t align='center' size='1.4' color='#FFD966'>CHALLENGE BOARD</t>";
    _titleCtrl ctrlCommit 0;

    // Question
    private _questionCtrl = _display ctrlCreate ["RscStructuredText", -1];
    _questionCtrl ctrlSetPosition [_x0 + _pad, _y0 + 0.075 * safeZoneH, _innerW, 0.08 * safeZoneH];
    _questionCtrl ctrlSetStructuredText parseText "<t align='center'>Would you like to take on a challenge?</t><br/><t align='center' size='0.85' color='#FF9999'>Choose carefully: once accepted, you must complete it.</t>";
    _questionCtrl ctrlCommit 0;

    // One card per offered challenge: a button (title) and a text (description + reward)
    {
        private _definition = _x;
        _definition params ["_id", "_title", "_desc", "_type", "_goal", "_parameter", "_tier"];
        (SCR_challenge_tierData select (_tier - 1)) params ["_tierLabel", "_tierColor", "_rewardName"];

        private _cardY = _y0 + (0.17 + _forEachIndex * 0.155) * safeZoneH;

        private _button = _display ctrlCreate ["RscButton", -1];
        _button ctrlSetPosition [_x0 + _pad, _cardY, _innerW, 0.06 * safeZoneH];
        _button ctrlSetText format ["[%1]  %2", _tierLabel, _title];
        _button ctrlSetTextColor _tierColor;
        _button setVariable ["SCR_offerIndex", _forEachIndex];
        _button ctrlAddEventHandler ["ButtonClick", {
            params ["_ctrl"];
            private _offer = SCR_challenge_offers param [_ctrl getVariable ["SCR_offerIndex", -1], []];
            if (_offer isEqualTo []) exitWith {};

            [_offer] call SCR_fnc_challenge_accept;
            (ctrlParent _ctrl) closeDisplay 1;
        }];
        _button ctrlCommit 0;

        private _descCtrl = _display ctrlCreate ["RscStructuredText", -1];
        _descCtrl ctrlSetPosition [_x0 + _pad, _cardY + 0.062 * safeZoneH, _innerW, 0.075 * safeZoneH];
        _descCtrl ctrlSetStructuredText parseText format [
            "<t size='0.85' color='#CCCCCC'>%1</t><br/><t size='0.85' color='#9FE2BF'>Reward: %2</t>",
            _desc,
            _rewardName
        ];
        _descCtrl ctrlCommit 0;
    } forEach SCR_challenge_offers;

    // Decline button
    private _decline = _display ctrlCreate ["RscButton", -1];
    _decline ctrlSetPosition [_x0 + _pad, _y0 + 0.645 * safeZoneH, _innerW, 0.05 * safeZoneH];
    _decline ctrlSetText "No thanks";
    _decline ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];
        (ctrlParent _ctrl) closeDisplay 2;
    }];
    _decline ctrlCommit 0;
};

// ----------------------------------------------------------------------------
// Adds the "Request a challenge" action to a unit
// Params: 0: OBJECT - unit
// ----------------------------------------------------------------------------
SCR_fnc_challenge_addAction = {
    params ["_unit"];

    _unit addAction [
        "<t color='#FFD966'>Request a challenge</t>",
        { [] call SCR_fnc_challenge_openBoard },
        [],
        0.5,
        false,
        true,
        "",
        "alive _this && {SCR_challenge_current isEqualTo []}"
    ];
};

// ----------------------------------------------------------------------------
// Initialisation
// ----------------------------------------------------------------------------

// Track kills (the active challenge decides whether they count)
addMissionEventHandler ["EntityKilled", {
    _this call SCR_fnc_challenge_onKill;
}];

// Re-add the action when the player respawns (a new unit is created)
addMissionEventHandler ["EntityRespawned", {
    params ["_newEntity"];
    if (_newEntity isEqualTo player) then {
        [_newEntity] call SCR_fnc_challenge_addAction;
    };
}];

// Add the action to the initial unit and optionally prompt the player once
// [] spawn {
//     waitUntil { !isNull player && {!isNull findDisplay 46} };

//     [player] call SCR_fnc_challenge_addAction;

//     if (SCR_challenge_autoPrompt) then {
//         sleep SCR_challenge_autoPromptDelay;
//         if (alive player && {SCR_challenge_current isEqualTo []}) then {
//             [] call SCR_fnc_challenge_openBoard;
//         };
//     };
// };

// Monitoring loop for time-based and distance-based challenges (1 tick per second)
[] spawn {
    waitUntil { !isNull player };

    private _lastPos = [];

    while { true } do {
        sleep 1;

        if (SCR_challenge_current isEqualTo [] || {!alive player}) then {
            _lastPos = [];
        } else {
            private _type      = SCR_challenge_current select 3;
            private _parameter = SCR_challenge_current select 5;

            switch (_type) do {
                case "survive": {
                    [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
                };
                case "stayClose": {
                    _parameter params ["_radius", "_minMates"];
                    if (([_radius] call SCR_fnc_challenge_countMates) >= _minMates) then {
                        [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
                    };
                };
                case "distance";
                case "teamMove": {
                    // Uniquement à pied, et groupé pour "teamMove"
                    private _ok = vehicle player isEqualTo player;
                    if (_ok && {_type isEqualTo "teamMove"}) then {
                        _parameter params ["_radius", "_minMates"];
                        _ok = ([_radius] call SCR_fnc_challenge_countMates) >= _minMates;
                    };

                    if (_ok) then {
                        private _pos = getPosATL player;
                        if !(_lastPos isEqualTo []) then {
                            private _delta = _lastPos distance2D _pos;
                            if (_delta < 20) then {
                                [SCR_challenge_progress + _delta] call SCR_fnc_challenge_setProgress;
                            };
                        };
                        _lastPos = _pos;
                    } else {
                        _lastPos = [];
                    };
                };
            };
        };
    };
};