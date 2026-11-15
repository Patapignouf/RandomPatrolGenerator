/*
    File: challengeSystem.sqf
    Description:
        A simple challenge system to keep players engaged in the current mission.

        - Asks the player whether they want to take on a challenge.
        - Offers three challenges (one EASY, one MEDIUM, one HARD) picked at random
          from a pool, through a very simple dialog.
        - Once a challenge is picked, the player is committed to it until it is completed.
        - Progress is displayed on a small HUD on the left of the screen.
        - Completing a challenge gives XP through doUpdateRank.
        - Dying while a challenge is active resets it and applies an XP penalty.

    Setup:
        Run this file once on every client (e.g. from initPlayerLocal.sqf):
            call compile preprocessFileLineNumbers "challengeSystem.sqf";

        The player can also open the challenge board at any time (when no challenge
        is active) with the "Request a challenge" action, or by calling:
            [] call SCR_fnc_challenge_openBoard;

    Notes:
        - All texts come from stringtable.xml (keys start with STR_RPG_Challenge_).
          Title/description keys are built from the challenge id:
              STR_RPG_Challenge_T_<id>  and  STR_RPG_Challenge_D_<id>
        - Accuracy challenges are only offered when
              missionNamespace getVariable ["enableAccuracyTrack", 1] == 1
        - Challenges only progress when the player is far enough from "initBlueforLocation".
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
SCR_challenge_accuracyIsFraction = false; // true if RPG_Accuracy is 0..1 instead of 0..100
SCR_challenge_minBaseDistance = 200;   // Minimum distance (m) to "initBlueforLocation" for challenges to progress
SCR_challenge_deathPenaltyRatio = 0.5; // XP lost on death = tier reward * ratio (0 disables the penalty)
SCR_challenge_penaltyReason   = "RPG_ranking_objective_failed"; // Reason passed to doUpdateRank for the penalty (adapt to your ranking system)
SCR_challenge_teamTypes = [
    "stayClose",
    "teamKills",
    "teamMove",
    "groupKills",
    "healMates",
    "protectKills",
    "vehicleTeam",
    "holdArea",
    "noLoss",
    "groupStreak"
];

// Test if ACE medical has been enabled
SCR_challenge_hasACE = isClass (configFile >> "CfgPatches" >> "ace_medical_treatment")
    || {isClass (configFile >> "CfgPatches" >> "ace_medical")};

// ----------------------------------------------------------------------------
// State (do not edit)
// ----------------------------------------------------------------------------
SCR_challenge_current  = [];  // Active challenge definition, [] if none
SCR_challenge_progress = 0;   // Progress of the active challenge
SCR_challenge_streak   = [];  // Timestamps of recent kills (used by "streak" challenges)
SCR_challenge_offers   = [];  // The three challenges currently offered by the board
SCR_challenge_anchor   = [];  // Reference position for "holdArea" challenges
SCR_challenge_deathNotice = "";   // Message shown to the player after respawning following a death penalty
// Anti-abuse: the same injured player only counts once every 60 s
SCR_challenge_healCooldowns = createHashMap;
SCR_challenge_lastBlockedMsg = -100;  // Anti-spam for the "progress paused" message

// ----------------------------------------------------------------------------
// Tier data: [label stringtable key, RGBA colour, XP reward]
// ----------------------------------------------------------------------------
SCR_challenge_tierData = [
    ["STR_RPG_Challenge_Tier_Easy",   [0.49, 0.99, 0.00, 1], 25],
    ["STR_RPG_Challenge_Tier_Medium", [1.00, 0.65, 0.00, 1], 50],
    ["STR_RPG_Challenge_Tier_Hard",   [1.00, 0.30, 0.30, 1], 100]
];

// ----------------------------------------------------------------------------
// Challenge definitions (compact)
// Format: [id, type, goal, parameter, tier, descriptionArgs]
//
// descriptionArgs are injected in STR_RPG_Challenge_D_<id> (%1, %2, %3...)
//
// Types:
//   "kills"        - Kill <goal> enemy infantry
//   "killFar"      - Kill <goal> enemy infantry from <parameter> m or more
//   "killNear"     - Kill <goal> enemy infantry from <parameter> m or less
//   "vehicleKill"  - Destroy <goal> enemy vehicles
//   "streak"       - Get <goal> kills within <parameter> seconds
//   "distance"     - Travel <goal> metres on foot
//   "survive"      - Stay alive for <goal> seconds (time spent dead is not counted)
//   "stayClose"    - Stay <goal> seconds near teammates. parameter = [radius, minMates, (optional) minDistance]
//   "healMates"    - Heal <goal> injured teammates
//   "protectKills" - Kill <goal> infantry within [radius] of at least [minMates] teammates
//   "vehicleTeam"  - Travel <goal> metres in a vehicle with <parameter> teammates aboard
//   "holdArea"     - Stay <goal> seconds in the same spot with [radius, minMates]; leaving resets
//   "noLoss"       - Kill <goal> infantry with the group; progress resets if a group member dies
//   "groupStreak"  - Group gets <goal> kills within <parameter> seconds
//   "teamKills"    - Kill <goal> infantry with at least [minMates] teammates within [radius]
//   "teamMove"     - Travel <goal> metres on foot with [minMates] teammates within [radius]
//   "groupKills"   - Group kills <goal> infantry
//   "accuracy"     - Play <goal> seconds, then accuracy (RPG_Accuracy) must be >= <parameter> %
//                    (only offered when enableAccuracyTrack == 1)
// ----------------------------------------------------------------------------
SCR_challenge_poolDef = [
    // --- Tier 1: EASY ---
    ["warmUp",        "kills",        5,    0,          1, [5]],
    ["pathfinder",    "distance",     3000, 0,          1, [3]],
    ["buddyUp",       "stayClose",    1800, [30, 1],    1, [30, 30]],
    ["fieldMedic",    "healMates",    5,    0,          1, [5]],
    ["spacing",       "stayClose",    1800, [40, 1, 10],1, [10, 40, 30]],
    ["steadyAim",     "accuracy",     1800, 40,         1, ["40%", 30]],

    // --- Tier 2: MEDIUM ---
    ["sharpshooter",  "killFar",      5,    100,        2, [5, 100]],
    ["closeQuarters", "killNear",     6,    20,         2, [6, 20]],
    ["survivor",      "survive",      900,  0,          2, [15]],
    ["veteran",       "kills",        12,   0,          2, [12]],
    ["stickTogether", "stayClose",    1800, [25, 2],    2, [2, 25, 30]],
    ["huntingParty",  "teamKills",    6,    [30, 1],    2, [6, 30]],
    ["inFormation",   "teamMove",     3000, [25, 1],    2, [3, 25]],
    ["guardian",      "protectKills", 5,    [30, 1],    2, [5, 30]],
    ["shuttle",       "vehicleTeam",  3000, 2,          2, [3, 2]],
    ["combatMedic",   "healMates",    10,   0,          2, [10]],
    ["holdLine",      "holdArea",     1800, [30, 2],    2, [2, 30, 30]],
    ["marksman",      "accuracy",     1800, 60,         2, ["60%", 30]],

    // --- Tier 3: HARD ---
    ["vehicleHunter", "vehicleKill",  2,    0,          3, [2]],
    ["killingSpree",  "streak",       3,    15,         3, [3, 15]],
    ["rampage",       "streak",       6,    60,         3, [6, 60]],
    ["wolfPack",      "groupKills",   20,   0,          3, [20]],
    ["brothers",      "stayClose",    2700, [20, 2],    3, [2, 20, 45]],
    ["assault",       "teamKills",    10,   [40, 2],    3, [10, 2, 40]],
    ["flawless",      "noLoss",       12,   0,          3, [12]],
    ["syncStrike",    "groupStreak",  5,    20,         3, [5, 20]],
    ["ultraMedic",    "healMates",    20,   0,          3, [20]],
    ["lastStand",     "holdArea",     600,  [25, 3],    3, [3, 25, 10]],
    ["deadEye",       "accuracy",     1800, 80,         3, ["80%", 30]]
];

// Final pool, same layout as before:
// [id, titleKey, descKey, type, goal, parameter, tier, descArgs]
SCR_challenge_pool = SCR_challenge_poolDef apply {
    _x params ["_id", "_type", "_goal", "_parameter", "_tier", "_args"];
    [
        _id,
        format ["STR_RPG_Challenge_T_%1", _id],
        format ["STR_RPG_Challenge_D_%1", _id],
        _type, _goal, _parameter, _tier, _args
    ]
};

// ----------------------------------------------------------------------------
// Helpers: localized title / description of a challenge definition
// ----------------------------------------------------------------------------
SCR_fnc_challenge_getTitle = {
    params ["_definition"];
    localize (_definition select 1)
};

SCR_fnc_challenge_getDesc = {
    params ["_definition"];
    format ([localize (_definition select 2)] + (_definition select 7))
};

// ----------------------------------------------------------------------------
// Accuracy helpers
// ----------------------------------------------------------------------------
// Is the accuracy computation engine available?
SCR_fnc_challenge_accuracyEnabled = {
    (missionNamespace getVariable ["enableAccuracyTrack", 1]) == 1
};

// Current accuracy of the player, in percent (0..100)
SCR_fnc_challenge_getAccuracy = {
    private _value = player getVariable ["RPG_Accuracy", 0];
    if (SCR_challenge_accuracyIsFraction) then { _value = _value * 100 };
    _value
};

// Challenges that can currently be offered (accuracy ones need the tracking engine)
SCR_fnc_challenge_getAvailablePool = {
    private _enabled = call SCR_fnc_challenge_accuracyEnabled;
    SCR_challenge_pool select { _enabled || {!((_x select 3) isEqualTo "accuracy")} }
};

// ----------------------------------------------------------------------------
// Helper: format a progress value for display
// Params: 0: STRING - challenge type, 1: NUMBER - progress, 2: NUMBER - goal, 3: ANY - parameter
// Returns: STRING
// ----------------------------------------------------------------------------
SCR_fnc_challenge_formatProgress = {
    params ["_type", "_progress", "_goal", ["_parameter", 0]];

    switch (_type) do {
        case "distance";
        case "teamMove";
        case "vehicleTeam": {
            format [localize "STR_RPG_Challenge_Progress_Meters", round _progress, _goal]
        };
        case "survive";
        case "stayClose";
        case "holdArea": {
            format [
                "%1 / %2",
                [round _progress, "MM:SS"] call BIS_fnc_secondsToString,
                [_goal, "MM:SS"] call BIS_fnc_secondsToString
            ]
        };
        case "accuracy": {
            format [
                localize "STR_RPG_Challenge_Progress_Accuracy",
                [round _progress, "MM:SS"] call BIS_fnc_secondsToString,
                [_goal, "MM:SS"] call BIS_fnc_secondsToString,
                (str round (call SCR_fnc_challenge_getAccuracy)) + "%",
                (str _parameter) + "%"
            ]
        };
        default {
            format ["%1 / %2", floor _progress, _goal]
        };
    }
};

// Items counted as treatments on the ACE side (bandages only)
SCR_challenge_aceTreatments = [
    "ACE_fieldDressing",
    "ACE_packingBandage",
    "ACE_elasticBandage",
    "ACE_quikclot",
    "ACE_splint"
    // "ACE_epinephrine",
    // "ACE_tourniquet",
    // "ACE_bloodIV_250",
    // "ACE_bloodIV_500",
    // "ACE_bloodIV"
];

// ----------------------------------------------------------------------------
// Base distance restriction
// ----------------------------------------------------------------------------
// Base position (initBlueforLocation): accepts a position, an object or a marker name
// Returns: ARRAY - position, or [] if the variable is not (yet) defined
SCR_fnc_challenge_getBasePos = {
    private _loc = missionNamespace getVariable ["initBlueforLocation", []];

    switch (typeName _loc) do {
        case "ARRAY":  { if (count _loc >= 2) then { _loc } else { [] } };
        case "OBJECT": { if (isNull _loc) then { [] } else { getPosATL _loc } };
        case "STRING": { if (_loc isEqualTo "") then { [] } else { getMarkerPos _loc } };
        default { [] };
    }
};

// Is the player far enough from the base for challenges to progress?
// If the variable is not defined, there is no restriction.
SCR_fnc_challenge_canProgress = {
    private _base = call SCR_fnc_challenge_getBasePos;
    if (_base isEqualTo []) exitWith { true };

    (player distance2D _base) >= SCR_challenge_minBaseDistance
};

// Tells the player (at most every 10 s) that progress is paused
SCR_fnc_challenge_notifyBlocked = {
    if (time - SCR_challenge_lastBlockedMsg < 10) exitWith {};
    SCR_challenge_lastBlockedMsg = time;

    [format [
        "<t size='0.8' color='#FFD966'>%1</t><br/><t size='0.85' color='#FF9999'>%2</t>",
        localize "STR_RPG_Challenge_Hud_Title",
        format [localize "STR_RPG_Challenge_Hud_Paused", SCR_challenge_minBaseDistance]
    ]] call SCR_fnc_challenge_updateHud;
};

// ----------------------------------------------------------------------------
// Healing
// ----------------------------------------------------------------------------
// Validates a treatment and advances the challenge (healer side)
// Params: 0: OBJECT - injured unit
SCR_fnc_challenge_registerHeal = {
    params ["_injured"];

    if (SCR_challenge_current isEqualTo []) exitWith {};
    if !((SCR_challenge_current select 3) isEqualTo "healMates") exitWith {};
    if !(call SCR_fnc_challenge_canProgress) exitWith { call SCR_fnc_challenge_notifyBlocked };

    private _key  = netId _injured;
    private _last = SCR_challenge_healCooldowns getOrDefault [_key, -1000];
    if (time - _last < 60) exitWith {};

    SCR_challenge_healCooldowns set [_key, time];
    [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
};

// --- Vanilla mode: called on the healer's machine through remoteExecCall ---
SCR_fnc_challenge_onMateHealed = {
    params [["_injured", objNull]];
    [_injured] call SCR_fnc_challenge_registerHeal;
};

SCR_fnc_challenge_addHealHandler = {
    params ["_unit"];

    // With ACE, HandleHeal is not used: do not add it
    if (SCR_challenge_hasACE) exitWith {};

    _unit addEventHandler ["HandleHeal", {
        params ["_injured", "_healer"];

        if (!(_healer isEqualTo _injured) && {isPlayer _healer} && {damage _injured > 0.05}) then {
            [_injured] remoteExecCall ["SCR_fnc_challenge_onMateHealed", _healer];
        };
        false
    }];
};

// --- ACE mode: local event on the healer's machine ---
SCR_fnc_challenge_initACE = {
    if (!SCR_challenge_hasACE) exitWith {};

    // The CBA handler is global to the client: register it only once (not on every respawn)
    if (!isNil "SCR_challenge_aceInitDone") exitWith {};
    SCR_challenge_aceInitDone = true;

    ["ace_treatmentSucceded", {
        params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

        if (_target isEqualTo _caller) exitWith {};            // no self-treatment
        if !(isPlayer _target) exitWith {};                    // players only
        if !(isPlayer _caller) exitWith {};                    // players only
        if !(side group _target isEqualTo side group _caller) exitWith {};
        if !(_usedItem in SCR_challenge_aceTreatments) exitWith {};

        [_target] call SCR_fnc_challenge_registerHeal;
    }] call CBA_fnc_addEventHandler;
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
            0.11 * safeZoneH
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
        SCR_challenge_current params ["_id", "_titleKey", "_descKey", "_type", "_goal", "_parameter"];
        private _updatedText = [_type, SCR_challenge_progress, _goal, _parameter] call SCR_fnc_challenge_formatProgress;
        player setVariable ["RPG_SideTaskStatus", _updatedText];
        player setVariable ["RPG_SideTaskType", _type];
        parseText format [
            "<t size='0.8' color='#FFD966'>%1</t><br/><t size='0.9'>%2</t><br/><t size='0.9' color='#9FE2BF'>%3</t>",
            localize "STR_RPG_Challenge_Hud_Title",
            localize _titleKey,
            _updatedText
        ]
    };

    _ctrl ctrlSetStructuredText _text;
    _ctrl ctrlShow true;

    // Display the control for 3 seconds only
    [_ctrl] spawn
    {
        params ["_ctrl"];
        sleep 3;
        _ctrl ctrlShow false;
    };
};

// ----------------------------------------------------------------------------
// Internal reward function: gives XP depending on the challenge tier.
// Params: 0: NUMBER - tier (1 = easy, 2 = medium, 3 = hard)
// ----------------------------------------------------------------------------
SCR_fnc_challenge_giveReward = {
    params [["_tier", 1, [0]]];

    private _index = (_tier - 1) max 0 min 2;
    private _xp    = (SCR_challenge_tierData select _index) select 2;

    [_xp, "RPG_ranking_objective_complete"] call doUpdateRank;
};

// ----------------------------------------------------------------------------
// Internal penalty function: removes XP depending on the challenge tier.
// The amount is the tier reward multiplied by SCR_challenge_deathPenaltyRatio.
// Params: 0: NUMBER - tier (1 = easy, 2 = medium, 3 = hard)
// Returns: NUMBER - XP removed
// ----------------------------------------------------------------------------
SCR_fnc_challenge_applyPenalty = {
    params [["_tier", 1, [0]]];

    private _index   = (_tier - 1) max 0 min 2;
    private _xp      = (SCR_challenge_tierData select _index) select 2;
    private _penalty = round (_xp * SCR_challenge_deathPenaltyRatio);

    //Use reason for further developement SCR_challenge_penaltyReason

    //Add penalty to player XP
    if (_penalty > 0) then {
        [-_penalty, 0] call doUpdateRankWithPenalty;
    };

    _penalty
};

// ----------------------------------------------------------------------------
// Clears the active challenge and all its tracking data (no reward, no penalty)
// Params: 0: OBJECT - (Optional) unit holding the side task variables, default: player
// ----------------------------------------------------------------------------
SCR_fnc_challenge_reset = {
    params [["_unit", player]];

    SCR_challenge_current  = [];
    SCR_challenge_progress = 0;
    SCR_challenge_streak   = [];
    SCR_challenge_anchor   = [];

    _unit setVariable ["RPG_SideTaskType", ""];
    _unit setVariable ["RPG_SideTaskStatus", ""];

    // Hide the tracker
    [""] call SCR_fnc_challenge_updateHud;
};

// ----------------------------------------------------------------------------
// The player died while committed to a challenge:
// the challenge is reset and an XP penalty is applied.
// Safe to call several times: it does nothing when no challenge is active.
// ----------------------------------------------------------------------------
SCR_fnc_challenge_onPlayerDeath = {
    if (SCR_challenge_current isEqualTo []) exitWith {};

    private _title = [SCR_challenge_current] call SCR_fnc_challenge_getTitle;
    private _tier  = SCR_challenge_current select 6;

    [] call SCR_fnc_challenge_reset;
    private _penalty = [_tier] call SCR_fnc_challenge_applyPenalty;

    // Shown right away in the chat and again as a hint after the respawn
    SCR_challenge_deathNotice = format [localize "STR_RPG_Challenge_Msg_DeathPenalty", _title, _penalty];
    systemChat SCR_challenge_deathNotice;
};

// ----------------------------------------------------------------------------
// Sets the progress of the active challenge (completes it if the goal is reached)
// Params: 0: NUMBER - new progress value
// ----------------------------------------------------------------------------
SCR_fnc_challenge_setProgress = {
    params ["_value"];

    if (SCR_challenge_current isEqualTo []) exitWith {};

    // Too close to the base: progress is ignored
    if !(call SCR_fnc_challenge_canProgress) exitWith { call SCR_fnc_challenge_notifyBlocked };

    private _goal = SCR_challenge_current select 4;
    SCR_challenge_progress = _value min _goal;

    if (SCR_challenge_progress >= _goal) exitWith {
        // Accuracy challenges: the timer is over, the result decides
        if ((SCR_challenge_current select 3) isEqualTo "accuracy") then {
            [] call SCR_fnc_challenge_resolveAccuracy;
        } else {
            [] call SCR_fnc_challenge_complete;
        };
    };

    [""] call SCR_fnc_challenge_updateHud;
};

// ----------------------------------------------------------------------------
// Accuracy challenge: end of the timer, check the accuracy reached
// ----------------------------------------------------------------------------
SCR_fnc_challenge_resolveAccuracy = {
    if (SCR_challenge_current isEqualTo []) exitWith {};

    private _required = SCR_challenge_current select 5;
    private _accuracy = call SCR_fnc_challenge_getAccuracy;

    if (_accuracy >= _required) then {
        [] call SCR_fnc_challenge_complete;
    } else {
        [format [
            localize "STR_RPG_Challenge_Msg_AccuracyFailed",
            (str round _accuracy) + "%",
            (str _required) + "%"
        ]] call SCR_fnc_challenge_fail;
    };
};

// ----------------------------------------------------------------------------
// Fails the active challenge (no reward, the player is free again)
// Params: 0: STRING - reason displayed to the player
// ----------------------------------------------------------------------------
SCR_fnc_challenge_fail = {
    params [["_reason", ""]];

    if (SCR_challenge_current isEqualTo []) exitWith {};

    private _title = [SCR_challenge_current] call SCR_fnc_challenge_getTitle;

    SCR_challenge_current  = [];
    SCR_challenge_progress = 0;
    SCR_challenge_streak   = [];
    SCR_challenge_anchor   = [];

    [format [
        "<t size='0.8' color='#FF6666'>%1</t><br/><t size='0.9'>%2</t><br/><t size='0.8'>%3</t>",
        localize "STR_RPG_Challenge_Hud_Failed",
        _title,
        _reason
    ]] call SCR_fnc_challenge_updateHud;

    systemChat _reason;
};

// ----------------------------------------------------------------------------
// Completes the active challenge and gives the reward
// ----------------------------------------------------------------------------
SCR_fnc_challenge_complete = {
    if (SCR_challenge_current isEqualTo []) exitWith {};

    private _title = [SCR_challenge_current] call SCR_fnc_challenge_getTitle;
    private _tier  = SCR_challenge_current select 6;

    // Free the player: they may request a new challenge afterwards
    SCR_challenge_current  = [];
    SCR_challenge_progress = 0;
    SCR_challenge_streak   = [];
    SCR_challenge_anchor   = [];

    [_tier] call SCR_fnc_challenge_giveReward;

    [format [
        "<t size='0.8' color='#7CFC00'>%1</t><br/><t size='0.9'>%2</t>",
        localize "STR_RPG_Challenge_Hud_Complete",
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
    SCR_challenge_anchor   = [];
    SCR_challenge_offers   = [];

    systemChat format [localize "STR_RPG_Challenge_Msg_Accepted", [_definition] call SCR_fnc_challenge_getTitle];
    [""] call SCR_fnc_challenge_updateHud;
};

// Counts the living teammates around a position
// Params: 0: NUMBER - radius (m), 1: NUMBER - min distance from player, 2: OBJECT/ARRAY - centre
// Returns: NUMBER
SCR_fnc_challenge_countMates = {
    params [["_radius", 30], ["_minDist", 0], ["_center", player]];

    private _all = (units group player) + allPlayers;
    _all = _all arrayIntersect _all;

    count (_all select {
        !(_x isEqualTo player)
        && {alive _x}
        && {side group _x isEqualTo side group player}
        && {_x distance _center <= _radius}
        && {_x distance player >= _minDist}
    })
};

// ----------------------------------------------------------------------------
// Kill tracking (called by the EntityKilled mission event handler)
// Params: same as the EntityKilled event: victim, killer, instigator
// ----------------------------------------------------------------------------
SCR_fnc_challenge_onKill = {
    params ["_victim", "_killer", "_instigator"];

    if (SCR_challenge_current isEqualTo []) exitWith {};

    // The player died while committed to a challenge: reset it and apply the penalty
    if (_victim isEqualTo player) exitWith { [] call SCR_fnc_challenge_onPlayerDeath };

    // A group member died: the "noLoss" challenge restarts from zero (also applies near the base)
    if ((SCR_challenge_current select 3) isEqualTo "noLoss" && {(group _victim) isEqualTo (group player)}) exitWith {
        SCR_challenge_progress = 0;
        [""] call SCR_fnc_challenge_updateHud;
        systemChat localize "STR_RPG_Challenge_Msg_MateFallen";
    };

    // Too close to the base: kills do not count
    if !(call SCR_fnc_challenge_canProgress) exitWith {};

    // The real shooter is the instigator when available
    private _shooter = if (isNull _instigator) then { _killer } else { _instigator };
    if (isNull _shooter) exitWith {};

    private _byPlayer = _shooter isEqualTo player;
    private _byGroup  = _shooter in (units group player); // includes the player
    if !(_byGroup) exitWith {};

    // Only enemies count
    private _victimSide = [_victim] call BIS_fnc_objectSide;
    if !(((side group player) getFriend _victimSide) < 0.6) exitWith {};

    private _isInfantry = _victim isKindOf "CAManBase";
    private _isVehicle  = !_isInfantry && {
        _victim isKindOf "LandVehicle" || {_victim isKindOf "Air"} || {_victim isKindOf "Ship"}
    };
    private _distance = player distance _victim;

    SCR_challenge_current params ["_id", "_titleKey", "_descKey", "_type", "_goal", "_parameter"];

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
        case "protectKills": {
            // The kill counts if the enemy was close to one or more teammates
            if (_byPlayer && _isInfantry) then {
                _parameter params ["_radius", "_minMates"];
                if (([_radius, 0, _victim] call SCR_fnc_challenge_countMates) >= _minMates) then {
                    [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
                };
            };
        };
        case "noLoss": {
            if (_isInfantry) then { [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress };
        };
        case "groupStreak": {
            if (_isInfantry) then {
                private _now = time;
                SCR_challenge_streak pushBack _now;
                SCR_challenge_streak = SCR_challenge_streak select { (_now - _x) <= _parameter };
                [count SCR_challenge_streak] call SCR_fnc_challenge_setProgress;
            };
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
            // The kill of any group member counts
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
        systemChat format [
            localize "STR_RPG_Challenge_Msg_Active",
            [SCR_challenge_current] call SCR_fnc_challenge_getTitle
        ];
    };

    private _parent = findDisplay 46;
    if (isNull _parent) exitWith {};

    // Pending offers containing an accuracy challenge are dropped if tracking got disabled
    if (
        !(SCR_challenge_offers isEqualTo [])
        && {!(call SCR_fnc_challenge_accuracyEnabled)}
        && {(SCR_challenge_offers findIf { (_x select 3) isEqualTo "accuracy" }) >= 0}
    ) then {
        SCR_challenge_offers = [];
    };

    // Pick one random challenge per tier (only if no offers are pending)
    if (SCR_challenge_offers isEqualTo []) then {
        private _available = call SCR_fnc_challenge_getAvailablePool;
        private _teamTier  = selectRandom [1, 2, 3];

        SCR_challenge_offers = [1, 2, 3] apply {
            private _tier = _x;
            private _list = _available select { (_x select 6) == _tier };

            // Force at least one team challenge in one of the tiers
            if (_tier == _teamTier) then {
                private _teamList = _list select { (_x select 3) in SCR_challenge_teamTypes };
                if !(_teamList isEqualTo []) then { _list = _teamList };
            };
            selectRandom _list
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
    _titleCtrl ctrlSetStructuredText parseText format [
        "<t align='center' size='1.4' color='#FFD966'>%1</t>",
        localize "STR_RPG_Challenge_Board_Title"
    ];
    _titleCtrl ctrlCommit 0;

    // Question
    private _questionCtrl = _display ctrlCreate ["RscStructuredText", -1];
    _questionCtrl ctrlSetPosition [_x0 + _pad, _y0 + 0.075 * safeZoneH, _innerW, 0.08 * safeZoneH];
    _questionCtrl ctrlSetStructuredText parseText format [
        "<t align='center'>%1</t><br/><t align='center' size='0.85' color='#FF9999'>%2</t>",
        localize "STR_RPG_Challenge_Board_Question",
        localize "STR_RPG_Challenge_Board_Warning"
    ];
    _questionCtrl ctrlCommit 0;

    // One card per offered challenge: a button (title) and a text (description + reward)
    {
        private _definition = _x;
        _definition params ["_id", "_titleKey", "_descKey", "_type", "_goal", "_parameter", "_tier"];
        (SCR_challenge_tierData select (_tier - 1)) params ["_tierLabelKey", "_tierColor", "_xp"];

        private _title     = localize _titleKey;
        private _desc      = [_definition] call SCR_fnc_challenge_getDesc;
        private _rewardTxt = format [localize "STR_RPG_Challenge_Reward_XP", _xp];

        private _cardY = _y0 + (0.17 + _forEachIndex * 0.155) * safeZoneH;

        private _button = _display ctrlCreate ["RscButton", -1];
        _button ctrlSetPosition [_x0 + _pad, _cardY, _innerW, 0.06 * safeZoneH];
        _button ctrlSetText format ["[%1]  %2", localize _tierLabelKey, _title];
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
            "<t size='0.85' color='#CCCCCC'>%1</t><br/><t size='0.85' color='#9FE2BF'>%2</t>",
            _desc,
            format [localize "STR_RPG_Challenge_Reward", _rewardTxt]
        ];
        _descCtrl ctrlCommit 0;
    } forEach SCR_challenge_offers;

    // Decline button
    private _decline = _display ctrlCreate ["RscButton", -1];
    _decline ctrlSetPosition [_x0 + _pad, _y0 + 0.645 * safeZoneH, _innerW, 0.05 * safeZoneH];
    _decline ctrlSetText (localize "STR_RPG_Challenge_Board_Decline");
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
        format ["<t color='#FFD966'>%1</t>", localize "STR_RPG_Challenge_Action"],
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
// Respawn handling
// ----------------------------------------------------------------------------
SCR_fnc_challenge_addRespawnHandler = {
    params ["_unit"];

    _unit addEventHandler ["Respawn", {
        params ["_unit", "_corpse"];

        // Fallback: the death was not caught by the EntityKilled handler
        if !(SCR_challenge_current isEqualTo []) then {
            [] call SCR_fnc_challenge_onPlayerDeath;
        };

        // Make sure the new unit starts without any side task data
        _unit setVariable ["RPG_SideTaskType", ""];
        _unit setVariable ["RPG_SideTaskStatus", ""];

        // Inform the player that the challenge was lost
        if !(SCR_challenge_deathNotice isEqualTo "") then {
            [[SCR_challenge_deathNotice, "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _unit];
            SCR_challenge_deathNotice = "";
        };
    }];
};

// ----------------------------------------------------------------------------
// Initialisation
// ----------------------------------------------------------------------------

// Track kills and player death (the active challenge decides whether they count)
addMissionEventHandler ["EntityKilled", {
    _this call SCR_fnc_challenge_onKill;
}];

// Re-add the handlers when the player respawns (a new unit is created)
addMissionEventHandler ["EntityRespawned", {
    params ["_newEntity"];
    if (_newEntity isEqualTo player) then {
//        [_newEntity] call SCR_fnc_challenge_addAction;
        [_newEntity] call SCR_fnc_challenge_addHealHandler;
        [_newEntity] call SCR_fnc_challenge_initACE;   // ACE handler (registered once)
    };
}];

[] spawn {
    waitUntil { !isNull player };
    [player] call SCR_fnc_challenge_addHealHandler; // Standard handler
    [player] call SCR_fnc_challenge_initACE;        // ACE handler
    [player] call SCR_fnc_challenge_addRespawnHandler;
};

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
            SCR_challenge_anchor = [];
        } else {
            private _type      = SCR_challenge_current select 3;
            private _parameter = SCR_challenge_current select 5;

            switch (_type) do {
                case "survive": {
                    [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
                };

                case "accuracy": {
                    // Timer: the accuracy is checked when it reaches the goal
                    [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
                };

                case "stayClose": {
                    _parameter params ["_radius", "_minMates", ["_minDist", 0]];
                    if (([_radius, _minDist] call SCR_fnc_challenge_countMates) >= _minMates) then {
                        [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
                    };
                };

                case "holdArea": {
                    _parameter params ["_radius", "_minMates"];
                    private _mates = [_radius] call SCR_fnc_challenge_countMates;

                    if (SCR_challenge_anchor isEqualTo []) then {
                        // The zone is fixed as soon as the team is gathered
                        if (_mates >= _minMates) then { SCR_challenge_anchor = getPosATL player };
                    } else {
                        if (player distance2D SCR_challenge_anchor > _radius) then {
                            // The player left the zone: start over
                            SCR_challenge_anchor = [];
                            SCR_challenge_progress = 0;
                            [""] call SCR_fnc_challenge_updateHud;
                        } else {
                            if (_mates >= _minMates) then {
                                [SCR_challenge_progress + 1] call SCR_fnc_challenge_setProgress;
                            };
                        };
                    };
                };

                case "distance";
                case "teamMove";
                case "vehicleTeam": {
                    private _veh    = vehicle player;
                    private _onFoot = _veh isEqualTo player;
                    private _ok     = false;
                    private _max    = 20;   // Max distance per tick, ignores teleports / respawns

                    switch (_type) do {
                        case "distance": { _ok = _onFoot };
                        case "teamMove": {
                            _parameter params ["_radius", "_minMates"];
                            _ok = _onFoot && {([_radius] call SCR_fnc_challenge_countMates) >= _minMates};
                        };
                        case "vehicleTeam": {
                            _max = 100; // Vehicles move faster
                            private _crew = (crew _veh) select {
                                !(_x isEqualTo player) && {alive _x} && {side group _x isEqualTo side group player}
                            };
                            _ok = !_onFoot && {count _crew >= _parameter};
                        };
                    };

                    if (_ok) then {
                        private _pos = getPosATL _veh;
                        if !(_lastPos isEqualTo []) then {
                            private _delta = _lastPos distance2D _pos;
                            if (_delta < _max) then {
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
