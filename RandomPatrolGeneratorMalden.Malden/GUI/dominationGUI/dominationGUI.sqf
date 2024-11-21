//To test 
//_trgAOC = createTrigger ["EmptyDetector", getPos player];
//_trgAOC setTriggerArea [200, 200, 0, true];
//[[_trgAOC] , "GUI\dominationGUI\dominationGUI.sqf"] remoteExec ['BIS_fnc_execVM', 0];
//player enableSimulation false;
params ["_thisAreaTrigger"];

disableSerialization;

diag_log format ["Domination GUI : %1", getPos _thisAreaTrigger];

with uiNamespace do {

	(format ["%1%2", getPos _thisAreaTrigger, random 1000]) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
	private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

	_backGround = _display ctrlCreate[ "ctrlStaticPicture", -1 ];
	_RcsBackDialog = _display ctrlCreate ["RscPicture", -1];
	_ProgressBar = _display ctrlCreate ["RscProgress", -1];
	_RcsTitleDialog = _display ctrlCreate ["RscText", -1];

	while {sleep 5; true} do 
	{
		//Prepare data
		_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisAreaTrigger);
		_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisAreaTrigger);
		_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisAreaTrigger); 

		_isPlayerInArea = (count ([player] inAreaArray _thisAreaTrigger)) == 1;

		_playerCounter = _nbBluePlayer + _nbIndPlayer;
		_total = _playerCounter + _nbOpfor;

		//Prepare progressbar background display
		_RcsBackDialog ctrlSetText "#(argb,8,8,3)color(1,0,0,1)";
		_RcsBackDialog ctrlSetPosition[ 1, 0, 0.25, 0.03 ];
		_RcsBackDialog ctrlSetBackgroundColor [0,0,0,1];
		_RcsBackDialog ctrlSetForegroundColor [1, 0, 0, 1];
		_RcsBackDialog ctrlSetTextColor [1, 1, 1, 1];
		_RcsBackDialog ctrlCommit 1;

		//Prepare background
		_backGround ctrlSetPosition[ 0.98, -0.05, 0.30, 0.10 ];
		_backGround ctrlSetText "#(argb,8,8,3)color(0.35,0.35,0.35,0.5)";
		_backGround ctrlCommit 1;

		//Prepare title display
		_RcsTitleDialog ctrlSetText "Sector control";
		_RcsTitleDialog ctrlSetPosition[ 1, -0.08, 0.25, 0.1 ];
		_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
		_RcsTitleDialog ctrlCommit 1;

		//Prepare progressbar
		_ProgressBar ctrlSetPosition [1,0,0.25,0.03];
		_ProgressBar ctrlSetBackgroundColor [0,0,0,1];
		_ProgressBar ctrlSetForegroundColor [1, 0, 0, 1];
		_ProgressBar ctrlSetTextColor [0, 0, 1, 1];
		_ProgressBar ctrlCommit 1;

		//Prepare progression state
		if (_total != 0) then 
		{
			_ProgressBar progressSetPosition _playerCounter/_total;
		};

		//Display or not
		if (_isPlayerInArea) then
		{
			_ProgressBar ctrlShow true;
			_RcsBackDialog ctrlShow true;
			_RcsTitleDialog ctrlShow true;
			_backGround ctrlShow true;
		} else 
		{
			_ProgressBar ctrlShow false;
			_RcsBackDialog ctrlShow false;
			_RcsTitleDialog ctrlShow false;
			_backGround ctrlShow false;
		};
	};
};


