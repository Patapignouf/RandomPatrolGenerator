#include "rankFunctions.sqf"
params ["_experienceBonus"];

//add experience
[_experienceBonus] call addExperience;

//adjustrank
[player, false] call adjustRank;