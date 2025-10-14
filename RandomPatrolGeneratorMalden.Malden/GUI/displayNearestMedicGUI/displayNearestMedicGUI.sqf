//To test 
//_trgAOC = createTrigger ["EmptyDetector", getPos player];
//_trgAOC setTriggerArea [200, 200, 0, true];
//[[_trgAOC] , "GUI\dominationGUI\dominationGUI.sqf"] remoteExec ['BIS_fnc_execVM', 0];
//player enableSimulation false;
params ["_unit"];

disableSerialization;

checkUnconscious = {
	params ["_unit"];
	_resultUnconscious = false;
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		_resultUnconscious = ((alive _unit) && (_unit getVariable ["isUnconscious", false]));
	} else 
	{
		_resultUnconscious = (lifeState _unit == "INCAPACITATED");
	};
	_resultUnconscious;
};

goUnconscious = {
	params ["_unit"];
	[_unit, true] call ace_medical_fnc_setUnconscious;
	_unit setDamage 0.2;
	_unit setUnconscious true;
	_unit setVelocity [0, 0, 0];
};

//Fix ACE last update with bad unconscious state
if (missionNameSpace getVariable ["ACETryFixUnconscious", 1] == 1) then 
{
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		[_unit] spawn {
			params ["_unit"];
			
			for [{_i = 0}, {_i < 12}, {_i = _i + 1}] do
			{
				sleep 0.5;
				//Check if there is a bug, the player is "HEALTHY" if there is a bug
				if (lifeState _unit != "INCAPACITATED" && (_unit getVariable ["isUnconscious", false])) then 
				{
					[_unit] call goUnconscious;
				};
			}; 
		};
	};
};



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
	_RcsTitleDialog ctrlSetText localize "RPG_GUI_OVERLAY_NEAR";
	_RcsTitleDialog ctrlSetPosition[ 1, _baseY-0.08, 0.25, 0.1 ];
	_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
	_RcsTitleDialog ctrlCommit 0;

	//Prepare title display
	_RcsTitleDialog2 ctrlSetText localize "RPG_GUI_OVERLAY_NEAR_MEDIC";
	_RcsTitleDialog2 ctrlSetPosition[ 1, _baseY+0.03, 0.25, 0.1 ];
	_RcsTitleDialog2 ctrlSetTextColor [1, 1, 1, 1];
	_RcsTitleDialog2 ctrlCommit 0;

	while {sleep 1; ([_unit] call checkUnconscious)} do 
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
			_Info ctrlSetStructuredText parseText format [localize "RPG_GUI_OVERLAY_NEAR_PLAYER", name _nearestPlayer, (round ((_nearestPlayer distance _unit)*100))/100];
		} else 
		{
			_Info ctrlSetStructuredText parseText (localize "RPG_GUI_OVERLAY_NO_NEAR");
		};
		_Info ctrlCommit 0.5;

		//Prepare progressbar
		_Info2 ctrlSetPosition [1,_baseY+0.1,0.5,0.04];
		_Info2 ctrlSetTextColor [1, 1, 1, 1];
		if (count _sortedPlayerMedicList != 0) then 
		{
			_Info2 ctrlSetStructuredText parseText format [localize "RPG_GUI_OVERLAY_NEAR_PLAYER", name _nearestMedicPlayer, (round ((_nearestMedicPlayer distance _unit)*100))/100];
		} else 
		{
			_Info2 ctrlSetStructuredText parseText (localize "RPG_GUI_OVERLAY_NO_NEAR");
		};
		_Info2 ctrlCommit 0.5;
	};

	_Info ctrlShow false;
	_Info2 ctrlShow false;
	_RcsTitleDialog ctrlShow false;
	_RcsTitleDialog2 ctrlShow false;
	_backGround ctrlShow false;
};


