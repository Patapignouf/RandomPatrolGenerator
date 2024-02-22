//rankUpdater.sqf

#include "rankFunctions.sqf"
params ["_experienceBonus", "_experienceType"];

//add experience
[_experienceBonus, _experienceType] call addExperience;

//adjustrank
[player, false] call adjustRank;

diag_log format ["RPG_XP_Reward : %1 %2 %3", name player, _experienceBonus, _experienceType];