//Wait mission generation
waitUntil {!isNil "missionGenerated"}; 

//Adapt difficulty
if (isServer) then
{
	diag_log "initialise DifficultyManagement";
	_initialPlayerCount = count allPlayers;
	
	while {sleep 120; true} do  
	{
		_newPlayerCount = count allPlayers;
		//_newPlayerCount = missionNamespace getVariable ["fakePlayerNumber", count allPlayers];
		_playerRatio = _newPlayerCount/_initialPlayerCount;
		//diag_log format ["DifficultyManagement test : _newPlayerCount = %1,  _initialPlayerCount = %2", _newPlayerCount, _initialPlayerCount];
		switch (true) do 
		{
			//Case where player count is almost the same
			case (_playerRatio>0.5&&_playerRatio<2):
			{
				//Do nothing
			};
			//Case where there are less players
			case (_playerRatio<=0.5):
			{
				_initialDifficulty = missionNamespace getVariable "missionDifficultyParam"; //Default medium
				_newDifficulty = (_initialDifficulty-1) max 1;
				missionNamespace setVariable ["missionDifficultyParam", _newDifficulty, true];
				_initialPlayerCount = count allPlayers;
				[[format ["OPFOR has reduced its presence in the area"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', 0];
			};
			//Case where there are more players
			case (_playerRatio>=2):
			{
				_initialDifficulty = missionNamespace getVariable "missionDifficultyParam"; //Default medium
				_newDifficulty = (_initialDifficulty+1) min 5;
				missionNamespace setVariable ["missionDifficultyParam", _newDifficulty, true];
				_initialPlayerCount = count allPlayers;
				[[format ["OPFOR has increased its presence in the area"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', 0];
			};
			default 
			{
				//Do nothing
			};
		};
	};
};