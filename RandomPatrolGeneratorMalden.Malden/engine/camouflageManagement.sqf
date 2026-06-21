/*
    Author: AI Collaborator
    Description: Dynamically modifies a unit's camouflage coefficient based on stance, surface type, and surrounding cover.
    Usage: [player] spawn fn_dynamicCamouflage;
*/

params [["_unit", objNull, [objNull]]];

// Safety checks: exit if the unit doesn't exist, is dead, or already has the script running
if (isNull _unit || {!alive _unit} || {!isPlayer player}) exitWith {};
if (_unit getVariable ["dynamicCamo_active", false]) exitWith {};
_unit setVariable ["dynamicCamo_active", true, true];

systemChat "Dynamic Camouflage System Activated.";

while {alive _unit && _unit getVariable ["dynamicCamo_active", false]} do {
    private _baseCamo = 1.0; // Default value (1.0 = standard AI detection)
    
    // 1. STANCE ANALYSIS
    private _stance = stance _unit;
    private _stanceMod = switch (_stance) do {
        case "PRONE":   { 0.1 }; // 60% visibility reduction while prone
        case "CROUCH":  { 0.4 }; // 30% visibility reduction while crouching
        case "STAND":   { 0.8 }; // Standard visibility while standing
        default         { 1.0 };
    };

    // 2. ENVIRONMENT ANALYSIS (SURFACE TYPE)
    private _surface = surfaceType (getPosWorld _unit);
    private _surfaceMod = 1.0;

    // Adjust based on ground type (Works on vanilla maps like Altis, Stratis, Tanoa)
    if ("#Gras" in _surface || "#Forest" in _surface) then {
        _surfaceMod = 0.8; // Better camouflage in grass/forest
    };
    if ("#Road" in _surface || "#Asph" in _surface || "#Concrete" in _surface) then {
        _surfaceMod = 1.3; // More visible on roads or concrete
    };

    // 3. COVER ANALYSIS (PROXIMITY TO VEGETATION)
    private _coverMod = 1.0;
    // Scans for trees and bushes within a 5-meter radius
    private _nearPlants = nearestTerrainObjects [_unit, ["TREE", "SMALL TREE", "BUSH"], 5, false];
    
    if (count _nearPlants > 0) then {
        // More nearby plants = lower visibility modifier (caps at 5 objects max)
        _coverMod = 1.0 - ((count _nearPlants min 5) * 0.1); 
    };

    // 4. MOVEMENT SPEED ANALYSIS
    private _speed = speed _unit;
    private _speedMod = 1.0;
    if (_speed > 2) then { _speedMod = 1.2; };  // Slow movement / jogging
    if (_speed > 15) then { _speedMod = 1.6; }; // Sprinting

    // 5. FINAL COEFFICIENT CALCULATION
    // Formula: Base * Stance * Surface * Cover * Speed
    private _finalCamo = _baseCamo * _stanceMod * _surfaceMod * _coverMod * _speedMod;

    // Clamp values so the unit doesn't become totally invisible (0) or excessively exposed
    _finalCamo = (_finalCamo max 0.15) min 2.0;

    // Apply the trait to the unit (directly affects Enemy AI detection)
    _unit setUnitTrait ["camouflageCoef", _finalCamo];

    /* --- DEBUGGING (Optional: uncomment to test in-game values) --- */
    //hintSilent format ["Stance: %1\nSurface: %2\nPlants Near: %3\nFinal Camo: %4", _stance, _surface, count _nearPlants, _finalCamo];
    /* --------------------------------------------------------------- */

    sleep 2; // Checked every second to optimize performance
};