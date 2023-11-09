//rankUpdater.sqf

#include "rankFunctions.sqf"
params ["_experienceBonus", "_experienceType"];

//add experience
[_experienceBonus, _experienceType] call addExperience;

//adjustrank
[player, false] call adjustRank;