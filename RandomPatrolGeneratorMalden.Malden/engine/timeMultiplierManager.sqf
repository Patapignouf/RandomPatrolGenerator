/*
    Author: ArmA 3 Time Acceleration Script
    Description: Accelerates time with the night multiplier doubled compared to daytime.
    
    Example: 
    1    -> Day x1    | Night x2
    5    -> Day x5    | Night x10
*/

params [["_dayMultiplier", 1, [0]]]; // Default value: x1 day, x2 night

if (!isServer) exitWith {};

[_dayMultiplier] spawn {
    params ["_baseMultiplier"];
    
    private _nightMultiplier = _baseMultiplier * 2;

    while {sleep 30; true} do {
        // BIS_fnc_sunriseSunsetTime returns [sunriseHour, sunsetHour] in decimal hours
        private _sunInfo = date call BIS_fnc_sunriseSunsetTime;
        private _sunrise = _sunInfo#0;
        private _sunset = _sunInfo#1;
        
        // Check if it is currently nighttime (accounting for night crossing midnight)
        private _isNight = false;
        if (_sunrise < _sunset) then {
            _isNight = (daytime < _sunrise) || (daytime > _sunset);
        } else {
            // Extreme polar conditions handling
            _isNight = (daytime < _sunrise) && (daytime > _sunset);
        };

        if (_isNight) then {
            if (timeMultiplier != _nightMultiplier) then {
                setTimeMultiplier _nightMultiplier;
            };
        } else {
            if (timeMultiplier != _baseMultiplier) then {
                setTimeMultiplier _baseMultiplier;
            };
        };
    };
};