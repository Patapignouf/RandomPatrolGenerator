
//Create survivor task
[player, format ["RPG_%1_Death", name player], [localize "STR_RPG_OBJ_SURVIVE_TEXT", localize "STR_RPG_OBJ_SURVIVE", ""], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;

//Wait mission complete
[] spawn {
	waitUntil {missionNamespace getVariable ["isEndMissionRunning", false]};

	//Check if the player isn't dead 
	if (player getVariable ["deathNumber", 0] == 0) then 
	{
		//Complete task
		[format ["RPG_%1_Death", name player], "SUCCEEDED"] call BIS_fnc_taskSetState;

		//Give player 50 xp point
		[{[50, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", player];
	};

};

//Wait for player death
[] spawn {
	waitUntil {player getVariable ["deathNumber", 0] > 0};
	[format ["RPG_%1_Death", name player], "FAILED"] call BIS_fnc_taskSetState;
};


