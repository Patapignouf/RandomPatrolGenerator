// generateDropBox.sqf
// Usage (server only): [_randomPositionOnLand] spawn compile preprocessFileLineNumbers "enemyManagement\generationEngine\generateDropBox.sqf";
// Drops an empty crate with a parachute, spawns an enemy group that tries to capture it,
// and turns the crate into a side objective.

if (!isServer) exitWith {};

params [
    ["_dropPosition", [0, 0, 0], [[]]]
];

// ---------------------------------------------------------------------------
// Configuration
// ---------------------------------------------------------------------------
private _dropAltitude              = 200;      // Altitude at which the crate is released (m)
private _crateClassName            = "B_CargoNet_01_ammo_F";
private _parachuteClassName        = "B_Parachute_02_F";
private _lootActionDuration        = 10;       // Seconds needed to take the crate content
private _rewardRadius              = 30;       // Players within this radius get the reward (m)
private _objectiveTimeLimit        = 30 * 60;  // Crate disappears after 30 minutes
private _enemyLifetime             = 60 * 60;  // Enemies disappear after 1 hour
private _enemyMinSpawnDistance     = 600;
private _enemyMaxSpawnDistance     = 800;
private _enemyCaptureDistance      = 8;        // Enemy this close to the crate = crate captured
private _enemiesCanCaptureCrate    = true;     // Set to false if enemies should only attack players

private _taskId = format ["supplyDropTask_%1", round (random 1000000)];

// ---------------------------------------------------------------------------
// Create the crate and the parachute
// ---------------------------------------------------------------------------
private _spawnPosition = [_dropPosition select 0, _dropPosition select 1, _dropAltitude];

private _supplyCrate = createVehicle [_crateClassName, _spawnPosition, [], 0, "CAN_COLLIDE"];
private _parachute   = createVehicle [_parachuteClassName, _spawnPosition, [], 0, "FLY"];
_parachute setPosATL _spawnPosition;

private _sideTaskID = format ["%1%2","_sideQuestSupply", random 10000];
[[_sideTaskID,"SupplyDrop", _spawnPosition, _supplyCrate], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 2];


// Make sure the crate is empty
clearWeaponCargoGlobal _supplyCrate;
clearMagazineCargoGlobal _supplyCrate;
clearItemCargoGlobal _supplyCrate;
clearBackpackCargoGlobal _supplyCrate;

_supplyCrate attachTo [_parachute, [0, 0, -1.3]];

// ---------------------------------------------------------------------------
// Wait until the crate touches the ground
// ---------------------------------------------------------------------------
waitUntil {
    sleep 0.25;
    isNull _parachute || {(getPosATL _supplyCrate) select 2 < 1.5}
};

detach _supplyCrate;
private _landingPosition = getPosATL _supplyCrate;
_supplyCrate setPosATL [_landingPosition select 0, _landingPosition select 1, 0];
_supplyCrate setVelocity [0, 0, 0];

// Remove the parachute shortly after landing
[_parachute] spawn {
    params ["_parachuteToDelete"];
    sleep 5;
    if (!isNull _parachuteToDelete) then { deleteVehicle _parachuteToDelete };
};

// Red smoke on landing
[_supplyCrate] spawn {
    params ["_crate"];

    //Add smoke to crate
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{
		_supplyLight = "Chemlight_red" createVehicle (position _crate);
		_supplyLight attachTo [_crate, [0,0,0]];
		_supplySmoke = "SmokeShellRed" createVehicle (position _crate);
		_supplySmoke attachTo [_crate, [0,0,0]];
		sleep 30;
	};
};

private _cratePosition = getPosATL _supplyCrate;

// ---------------------------------------------------------------------------
// Side objective: map marker + task
// ---------------------------------------------------------------------------
// private _objectiveMarkerName = format ["supplyDropMarker_%1", _taskId];
// private _objectiveMarker = createMarker [_objectiveMarkerName, _cratePosition];
// _objectiveMarker setMarkerType "mil_objective";
// _objectiveMarker setMarkerColor "ColorRed";
// _objectiveMarker setMarkerText "Supply drop";


// ---------------------------------------------------------------------------
// Hold action (10 seconds) available for every player, including JIP.
// The JIP entry is bound to the crate, so it is removed when the crate is deleted.
// ---------------------------------------------------------------------------
[
    _supplyCrate,
    "Take the crate content",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loadDevice_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loadDevice_ca.paa",
    "(_this distance _target < 5) && !(_target getVariable ['crateLooted', false])",
    "_caller distance _target < 5",
    {},
    {},
    {
        // Executed on the machine of the player who completed the action
        params ["_target", "_caller", "_actionId", "_arguments"];
        _arguments params ["_rewardRadius"];

        // Flag the crate as looted (public) so the server can clean everything up
        _target setVariable ["crateLooted", true, true];

        // Players close enough to the crate receive the reward
        private _nearbyPlayers = allPlayers select {
            alive _x && {_x distance _target <= _rewardRadius}
        };

        [[],
        {
            params ["_unit", "_instigator"];
            [] call shopRelatedReward;
			[500] call doIncrementVehicleSpawnCounter;
        }
        ] remoteExec ["spawn", _nearbyPlayers];
    },
    {},
    [_rewardRadius],
    _lootActionDuration,
    10,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _supplyCrate];

// ---------------------------------------------------------------------------
// Enemy group: spawns 600-800 m away (on land) and goes for the crate
// ---------------------------------------------------------------------------
private _enemySpawnPosition = _cratePosition;
for "_attempt" from 1 to 30 do {
    private _candidatePosition = _cratePosition getPos [
        _enemyMinSpawnDistance + random (_enemyMaxSpawnDistance - _enemyMinSpawnDistance),
        random 360
    ];
    if (!surfaceIsWater _candidatePosition) exitWith {
        _enemySpawnPosition = _candidatePosition;
    };
};

private _enemyGroupTemplate = selectRandom EnemyWaveLevel_6;
private _enemyGroup = [_enemyGroupTemplate, _enemySpawnPosition, east, "DefenseInfantry"] call doGenerateEnemyGroup;

// Clear any existing waypoints
while { count waypoints _enemyGroup > 0 } do {
    deleteWaypoint [_enemyGroup, 0];
};

// Move to the crate, then search and destroy around it
private _moveWaypoint = _enemyGroup addWaypoint [_cratePosition, 10];
_moveWaypoint setWaypointType "MOVE";
_moveWaypoint setWaypointSpeed "FULL";
_moveWaypoint setWaypointBehaviour "AWARE";
_moveWaypoint setWaypointCombatMode "RED";

private _holdWaypoint = _enemyGroup addWaypoint [_cratePosition, 30];
_holdWaypoint setWaypointType "SAD";

// Enemies are removed after 1 hour, whatever happens to the crate
[_enemyGroup, _enemyLifetime] spawn {
    params ["_groupToClean", "_lifetime"];
    sleep _lifetime;

    private _vehiclesToDelete = (units _groupToClean) apply { vehicle _x };
    _vehiclesToDelete = _vehiclesToDelete select { !(_x isKindOf "CAManBase") };

    { deleteVehicle _x } forEach (units _groupToClean);
    { deleteVehicle _x } forEach (_vehiclesToDelete arrayIntersect _vehiclesToDelete);
    deleteGroup _groupToClean;
};

// ---------------------------------------------------------------------------
// Objective monitoring loop
// ---------------------------------------------------------------------------
private _objectiveDeadline = time + _objectiveTimeLimit;
private _objectiveResult = "TIMEOUT"; // LOOTED, CAPTURED or TIMEOUT

while { time < _objectiveDeadline } do {
    sleep 1;
    
    //Define status name 
    private _taskIDStatusName = format ["%1%2", _sideTaskID, "_status"];

    if (_supplyCrate getVariable ["crateLooted", false]) exitWith {
        _objectiveResult = "LOOTED";
        missionNameSpace setVariable [_taskIDStatusName, "LOOTED", true];
    };

    if (
        _enemiesCanCaptureCrate &&
        { (units _enemyGroup) findIf { alive _x && {_x distance2D _supplyCrate < _enemyCaptureDistance} } != -1 }
    ) exitWith {
        _objectiveResult = "CAPTURED";
        missionNameSpace setVariable [_taskIDStatusName, "CAPTURED", true];
    };
};


//deleteMarker _objectiveMarker;
deleteVehicle _supplyCrate;   // Also removes the JIP hold action
if (!isNull _smokeShell) then { deleteVehicle _smokeShell };

// Let players read the task result, then remove the task
sleep 10;
//[_taskId, true] call BIS_fnc_deleteTask;