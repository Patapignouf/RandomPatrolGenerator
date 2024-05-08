params ['_endingName'];

//Test if there is already a mission ending running 
_isEndMissionRunning = missionNamespace getVariable ["isEndMissionRunning", false];

if (!_isEndMissionRunning) then 
{
	//Setup endmission
	missionNamespace setVariable ["isEndMissionRunning", true, true];

	//Building data for scoreboard
	_categories = [];
	_dataToDisplay = [];
	_basicInfoToGather = ["rank", "name", "progression"];
	_basicXPToGather = [["RPG_ranking_infantry_kill","infantry kill"],
						["RPG_ranking_vehicle_kill","vehicle kill"],
						["deathNumber","death"],
						["RPG_ranking_suppress","suppress"],
						["RPG_ranking_heal","heal"],
						["RPG_ranking_repair","repair"],
						["RPG_ied_defuse","IED defuse"],
						["RPG_ranking_intel_collect","intel collect"],
						["RPG_ranking_objective_complete","objective complete"]
						];
	
	//Process players stats 
	playersNames = "";
	playersRankName = "";

	//Get all players info for thanks credit
	{
		_playerName = name _x;
		playersRankName = format ["%1<br />%2", playersRankName, format ["%2 %1", _playerName, rank _x]];
	} foreach ([allPlayers, [], {_x getVariable ["currentXP", 0]}, "DESCEND"] call BIS_fnc_sortBy);

	//Thanks player
	[format ["<t color='#ffffff' size='1.5'>Random Patrol Generator</t><br /><t color='#ffffff' size='0.8'> Starring <br />%1</t>", playersRankName],0,0,5,1,0,789] remoteExec ['BIS_fnc_dynamicText', 0];

	//Wait before display scoreboard
	sleep 10;
	
	//Get all players info for custom ranking
	{
		_currentPlayerScore = [];
		_currentPlayer = _x;
		_playerName = name _currentPlayer;
		_playerRank = rank _currentPlayer;
		_startingXP = _currentPlayer getVariable ["startingXP", 0];
		_currentXP = _currentPlayer getVariable ["currentXP", 0];
		_playerProgressXP = _currentXP - _startingXP;

		_currentPlayerScore pushBack _playerRank;
		_currentPlayerScore pushBack _playerName;
		_currentPlayerScore pushBack (format ["%1", _playerProgressXP]);
		
		//Get information from all XP categories
		{
			_currentExpType = _x;
			_startingXP = _currentPlayer getVariable [_currentExpType, 0];		
			_currentPlayerScore pushBack (format ["%1", _startingXP]);	
		} foreach (_basicXPToGather apply {_x # 0});
		
		//Add current player XP info to global XP
		_dataToDisplay pushBack _currentPlayerScore;
	} foreach ([allPlayers, [], {_x getVariable ["currentXP", 0]}, "DESCEND"] call BIS_fnc_sortBy);
	
	_categories = _basicInfoToGather + (_basicXPToGather apply {_x # 1});
				
	//Display scoreboard
	//Show a black screen and disable damage
	[["", "BLACK OUT", 5]] remoteExec ["cutText",-2];
	[[_categories, _dataToDisplay], 'GUI\scoreBoardGUI\displayScoreBoard.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	[{ player allowDamage false;}] remoteExec ["call", -2];

	//Wait for player to read
	sleep 20;

	//End Mission
	if (isMultiplayer) then {
		[_endingName] remoteExec ["BIS_fnc_endMission"];
	} else {
		_endingName call BIS_fnc_endMission;
	};
};
