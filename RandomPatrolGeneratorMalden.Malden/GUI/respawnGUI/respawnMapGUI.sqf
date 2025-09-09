/*
  spawn_selection.sqf
  POI avec marqueurs "animés" (pulsation) + sélection du POI le plus proche.

  Usage minimal :
    execVM "spawn_selection.sqf";
    _sel = [ position player ] call spawnSelection_selectNearest;  // [_idx, _name, _pos]
    [] call spawnSelection_cleanup; // nettoie (affiche rien)
    [false] call spawnSelection_cleanup; // nettoie et affiche un hint
    [[], 'GUI\respawnGUI\respawnMapGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];

  Remarque : ce fichier est autonome.
*/

/* --------------------------
   CONFIGURATION
   -------------------------- */
private _poiList = [
    // ["Nom", position, couleur]
    ["Base Alpha", [1500, 2350, 0], "ColorRed"],
    ["Village",    [1650, 2100, 0], "ColorBrown"],
    ["Colline",    [1450, 2500, 0], "ColorGreen"],
    ["Aéroport",   [1800, 2300, 0], "ColorBlue"],
    ["Port",       [1700, 2450, 0], "ColorBlack"]
];

_poiList = [];
baseSpawn = [];

if (side player == blufor) then 
{
    _poiList pushBack ["", initBlueforLocation, "colorBLUFOR"];
    baseSpawn = initBlueforLocation;
} else 
{
    _poiList pushBack ["Base Independent", initCityLocation, "colorIndependent"];
    baseSpawn = initCityLocation;
};  

{
    if (typeName _x == "ARRAY" ) then 
    {
        if (3 < count _x) then 
        {
            _currentObjectivePosition = (_x)#3;
            _poiList pushBack ["Mission checkpoint", _currentObjectivePosition, "ColorGreen"];
        };
    };
} foreach ((missionNameSpace getVariable ["completedObjectives",[]]));

_tentFOBLocation = missionNamespace getVariable [format ['bluforPositionAdvancedRespawn%1', str (group player)], [0,0,0]];
if (playerSide == blufor && !([_tentFOBLocation, [0,0,0]] call BIS_fnc_areEqual)) then 
{
    _poiList pushBack ["", _tentFOBLocation, "colorBLUFOR"];
};

_advFOBLocation = missionNamespace getVariable ["advancedBlueforLocation", [0,0,0]];
if (playerSide == blufor && !([_advFOBLocation, [0,0,0]] call BIS_fnc_areEqual)) then 
{
    _poiList pushBack ["Advanced FOB", _advFOBLocation, "colorBLUFOR"];
};

private _markerPrefix = "SPAWN_POI_";

/* Animation */
private _pulsePeriod = 1;        // durée d'un cycle (s)
private _pulseSteps  = 24;          // nb d'étapes dans un cycle

/* --------------------------
   NETTOYAGE
   -------------------------- */
/*
  [] call spawnSelection_cleanup;
  [false] call spawnSelection_cleanup; // non silencieux (affiche un hint)
*/
spawnSelection_cleanup = {
    params [ ["_silent", true, [true]] ];

    // Stopper l’animation si elle tourne
    if (!isNil "_animHandle") then {
        terminate _animHandle;
        _animHandle = nil;
    };

    // Supprimer les marqueurs créés
    if (isNil "_markersMeta") exitWith {
        if (!_silent) then { hint "Rien à nettoyer (aucun POI initialisé)."; };
    };

    { deleteMarker (_x select 1); } forEach _markersMeta;
    _markersMeta = nil;

    if (!_silent) then { hint "POI supprimés et animation arrêtée."; };
};

/* --------------------------
   API
   -------------------------- */
spawnSelection_selectNearest = {
    params ["_pos", ["_maxDist", 10000]];
    private _best = -1;
    private _bestDist = _maxDist;
    private _majorPulseType = "mil_dot";
    private _minorPulseType = "hd_dot";

    if (isNil "_markersMeta") exitWith {
        hint "Aucun POI disponible (markers non init).";
        baseSpawn
    };

    {
        private _mPos = _x select 3;
        private _d = _pos distance _mPos;
        if (_d < _bestDist) then {
            _best = _x select 0;
            _bestDist = _d;
        };
    } forEach _markersMeta;

    if (_best >= 0) then {
        private _resMeta = (_markersMeta select { _x select 0 == _best }) select 0;
        private _res = [_resMeta select 0, _resMeta select 2, _resMeta select 3];

        // Mise en évidence visuelle
        private _selMarkerName = _resMeta select 1;
        _selMarkerName setMarkerType _majorPulseType;

        _res
    } else {
        baseSpawn
    };
};



/* --------------------------
   HELPERS
   -------------------------- */
private _createMarkers = {
    private _arr = [];
    private _i = 0;
    {
        private _name  = _markerPrefix + str _i;
        private _label = _x select 0;
        private _pos   = _x select 1;
        private _color = _x select 2;

        createMarkerLocal [_name, _pos];
        _name setMarkerType  "selector_selectedMission";
        _name setMarkerText  _label;
        _name setMarkerColor _color;

        _arr pushBack [_i, _name, _label, _pos, _color];
        _i = _i + 1;
    } forEach _poiList;
    _arr
};

applyPulseToMarker = {
    params ["_markerMeta", "_step", "_steps"];

    private _majorPulseType = "mil_dot";
    private _minorPulseType = "hd_dot";
    private _baseSize = 3;

    private _mName = _markerMeta select 1;
    if ((_step < _steps/2)) then {
        //_mName setMarkerType _majorPulseType;
        _mName setMarkerSize [_baseSize*_step/_steps, _baseSize*_step/_steps];

    } else {
        //_mName setMarkerType _minorPulseType;
         _mName setMarkerSize [_baseSize*(_steps-_step)/_steps, _baseSize*(_steps-_step)/_steps];
    };
};

/* --------------------------
   MAIN
   -------------------------- */
if (!isDedicated) then {
    _markersMeta = call _createMarkers;

	["<t color='#ffffff' size='.8'>Select your respawn location<br /></t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;

    //Open map
    openMap true;
    uiSleep 1;

    _animTask = {
        params ["_markersMeta", "_period", "_steps"];
        private _step = 0;
        private _sleep = _period / _steps;

        while {true} do {
            {
                [_x, _step, _steps] spawn {
                    params ["_markerMeta","_s","_steps"];
                    [_markerMeta, _s, _steps] call applyPulseToMarker;
                };
            } forEach _markersMeta;

            _step = (_step + 1) mod _steps;
            sleep _sleep;
        };
    };
    _animHandle = [_markersMeta, _pulsePeriod, _pulseSteps] spawn _animTask;

    //When user clicked
    onMapSingleClick "selectedLoc = _pos; onMapSingleClick ''; openMap false; true;";
    waitUntil{!(visibleMap)};  

    _selectedSpawn = [ selectedLoc, 1000] call spawnSelection_selectNearest;  

    player setPos ([_selectedSpawn#2, 1, 30, 1, 0, 30, 0, [], [_selectedSpawn#2, _selectedSpawn#2]] call BIS_fnc_findSafePos);
    
    [] call spawnSelection_cleanup;
};

