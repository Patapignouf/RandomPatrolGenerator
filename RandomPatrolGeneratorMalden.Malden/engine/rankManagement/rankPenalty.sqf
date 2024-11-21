#include "rankFunctions.sqf"
params ["_experienceMalus", "_losePercentage"];

_currentUnitExperience = [] call getExperience;

//Determine potential lose
_potentialExperienceLose = floor (-_currentUnitExperience*_losePercentage/100);

//add experience
[_potentialExperienceLose min _experienceMalus, "RPG_ranking_player_death"] call addExperience;

//adjustrank
[player, false] call adjustRank;

diag_log format ["RPG_XP_Reward : %1 %2 %3", name player, _potentialExperienceLose min _experienceMalus, "RPG_ranking_player_death"];