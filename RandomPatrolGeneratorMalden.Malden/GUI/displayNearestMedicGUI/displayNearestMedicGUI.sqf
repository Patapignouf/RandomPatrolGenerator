//To test 
//_trgAOC = createTrigger ["EmptyDetector", getPos player];
//_trgAOC setTriggerArea [200, 200, 0, true];
//[[_trgAOC] , "GUI\dominationGUI\dominationGUI.sqf"] remoteExec ['BIS_fnc_execVM', 0];
//player enableSimulation false;
params ["_unit"];

disableSerialization;

// diag_log format ["Domination GUI : %1", getPos _thisAreaTrigger];

with uiNamespace do {

	//Exit if this is called on the wrong player
	if (player != _unit || !hasInterface) exitWith{};

	(format ["%1%2", getPos _unit, random 1000]) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
	private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

	_backGround = _display ctrlCreate[ "ctrlStaticPicture", -1 ];
	_Info = _display ctrlCreate ["RscStructuredText", -1];
	_Info2 = _display ctrlCreate ["RscStructuredText", -1];
	_RcsTitleDialog = _display ctrlCreate ["RscText", -1];
	_RcsTitleDialog2 = _display ctrlCreate ["RscText", -1];

	_baseY = 0.15;

	//Prepare background
	_backGround ctrlSetPosition[ 0.98, _baseY-0.05, 0.30, 0.20 ];
	_backGround ctrlSetText "#(argb,8,8,3)color(0.35,0.35,0.35,0.5)";
	_backGround ctrlCommit 0;

	//Prepare title display
	_RcsTitleDialog ctrlSetText "Nearest player";
	_RcsTitleDialog ctrlSetPosition[ 1, _baseY-0.08, 0.25, 0.1 ];
	_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
	_RcsTitleDialog ctrlCommit 0;

	//Prepare title display
	_RcsTitleDialog2 ctrlSetText "Nearest Medic player";
	_RcsTitleDialog2 ctrlSetPosition[ 1, _baseY+0.03, 0.25, 0.1 ];
	_RcsTitleDialog2 ctrlSetTextColor [1, 1, 1, 1];
	_RcsTitleDialog2 ctrlCommit 0;

	while {sleep 1; (lifeState _unit == "INCAPACITATED")} do 
	{
		//Prepare data 
		//Will crash if the player is alone 
		_allPlayersAlive = allPlayers select {alive _x && side _x == playerSide && lifeState _x != "INCAPACITATED"};
		_sortedPlayerList = [_allPlayersAlive, [], {_unit distance _x}, "ASCEND"] call BIS_fnc_sortBy;
		_nearestPlayer = "";
		if (count _sortedPlayerList != 0) then 
		{
			_nearestPlayer = _sortedPlayerList#0;
		};

		_allPlayersMedicAlive = allPlayers select {alive _x && side _x == playerSide && lifeState _x != "INCAPACITATED" && (_x getVariable ["role", "rifleman"]) == "medic"};
		_sortedPlayerMedicList = [_allPlayersMedicAlive, [], {_unit distance _x}, "ASCEND"] call BIS_fnc_sortBy;
		_nearestMedicPlayer = "";
		if (count _sortedPlayerMedicList != 0) then 
		{
			_nearestMedicPlayer = _sortedPlayerMedicList#0;
		};
		

		//Prepare progressbar
		_Info ctrlSetPosition [1,_baseY-0.01,0.5,0.04];
		_Info ctrlSetTextColor [1, 1, 1, 1];
		if (count _sortedPlayerList != 0) then 
		{
			_Info ctrlSetStructuredText parseText format ["%1 is at %2m", name _nearestPlayer, (round ((_nearestPlayer distance _unit)*100))/100];
		} else 
		{
			_Info ctrlSetStructuredText parseText format ["No player nearby"];
		};
		_Info ctrlCommit 0.5;

		//Prepare progressbar
		_Info2 ctrlSetPosition [1,_baseY+0.1,0.5,0.04];
		_Info2 ctrlSetTextColor [1, 1, 1, 1];
		if (count _sortedPlayerMedicList != 0) then 
		{
			_Info2 ctrlSetStructuredText parseText format ["%1 is at %2m", name _nearestMedicPlayer, (round ((_nearestMedicPlayer distance _unit)*100))/100];
		} else 
		{
			_Info2 ctrlSetStructuredText parseText format ["No medic nearby"];
		};
		_Info2 ctrlCommit 0.5;
	};

	_Info ctrlShow false;
	_Info2 ctrlShow false;
	_RcsTitleDialog ctrlShow false;
	_RcsTitleDialog2 ctrlShow false;
	_backGround ctrlShow false;
};


