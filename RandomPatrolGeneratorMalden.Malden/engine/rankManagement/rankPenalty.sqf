#include "rankFunctions.sqf"
params ["_experienceMalus", "_losePercentage"];

_currentUnitExperience = [] call getExperience;

//Determine potential lose
_potentialExperienceLose = floor (-_currentUnitExperience*_losePercentage/100);

//add experience
[_potentialExperienceLose min _experienceMalus] call addExperience;

//adjustrank
[player, false] call adjustRank;