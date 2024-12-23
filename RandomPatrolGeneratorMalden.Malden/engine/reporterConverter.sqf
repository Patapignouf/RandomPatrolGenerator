params ["_choosenPlayer"];

//Add end mission on reporter killed
diag_log format ["Reporter is set to player : %1", name _choosenPlayer];
_choosenPlayer addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	diag_log format ["Reporter has been killed by : %1", _killer];
	diag_log format ["Mission end !"];
	[['REP_DEAD'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
}];

//Add XP reward
[_choosenPlayer] spawn {
	params ["_choosenPlayer"];

	while {sleep 120; true} do 
	{
		//Get number of player under 30 meters (min 3 reporter included)
		if (count ((allPlayers) select {(_choosenPlayer distance _x) < 30}) > 3) then
		{
			[{[2, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", _choosenPlayer];
		};
	};
};

//Make player looks like a reporter 
_choosenPlayer setUnitLoadout (selectRandom ["C_journalist_F", "C_Journalist_01_War_F"]);

//Weapon forbidden script 
[_choosenPlayer] spawn {
	params ["_choosenPlayer"];

	while {sleep 30; true} do 
	{
		//Get reporter weapon
		_primaryWeapon = primaryWeapon _choosenPlayer;
		_secondaryWeapon = secondaryWeapon _choosenPlayer;

		//Get number of player under 30 meters (min 3 reporter included)
		if (_primaryWeapon != "" || _secondaryWeapon != "") then
		{
			[["<t color='#ff0000' size='5'>REPORTER CANNOT CARRY ANY WEAPON</t><br/>", "PLAIN", -1, true, true]] remoteExec ['cutText', _choosenPlayer];
		};
	};
};