params ['_endingName'];

//Process players stats 
playersNames = "";
playersXPProgress = "";

//Get all players info
{
	_startingXP = _x getVariable ["startingXP", 0];
	_currentXP = _x getVariable ["currentXP", 0];
	_playerName = name _x;
	_playerProgressXP = _currentXP - _startingXP;
	playersNames = format ["%1%2", playersNames, format ["%1  ", _playerName]];
	playersXPProgress = format ["%1<br />%2", playersXPProgress, format ["%1 has earned %2 experience points", _playerName, _playerProgressXP]];
} foreach allPlayers;


//Thanks player
[format ["<t color='#ffffff' size='1.5'>Random Patrol Generator</t><br /><t color='#ffffff' size='0.8'> Starring <br />%1</t>", playersNames],-1,-1,3,1,0,789] remoteExec ['BIS_fnc_dynamicText', 0];

//Wait
sleep 10;

//Display rank
[format ["<t color='#ffffff' size='1'>Player's progression :</t><t color='#ffffff' size='.7'><br />%1</t>", playersXPProgress],0,0,6,1,0,789] remoteExec ['BIS_fnc_dynamicText', 0];

//Wait
sleep 5;

//Get all players info for custom ranking
{
	_currentExpType = _x#0;
	_currentExpTypeName = _x#1;
	playersXPProgress = "";
	_isUseFull = false;

	//Search player's custom ranking
	{
		_startingXP = _x getVariable [_currentExpType, 0];
		_playerName = name _x;
		_playerProgressXP = _startingXP;

		//If someone earn experience in this section, display the section
		if (_startingXP != 0) then 
		{
			_isUseFull = true;
		};

		playersNames = format ["%1%2", playersNames, format ["%1  ", _playerName]];
		playersXPProgress = format ["%1<br />%2", playersXPProgress, format ["%1 has earned %2 %3 experience points", _playerName, _playerProgressXP, _currentExpTypeName]];
	} foreach allPlayers;

	//Display rank
	if (_isUseFull) then 
	{

		//Display experience
		[format ["<t color='#ffffff' size='1'>Player's %2 experience :</t><t color='#ffffff' size='.7'><br />%1</t>", playersXPProgress, _currentExpTypeName],0,0,6,1,0,789] remoteExec ['BIS_fnc_dynamicText', 0];
		
		//Wait last display
		sleep 10;
	};	
	
} foreach [["RPG_ranking_infantry_kill","infantry kill"],
			["RPG_ranking_vehicle_kill","vehicle kill"],
			["RPG_ranking_suppress","suppress"],
			["RPG_ranking_heal","heal"],
			["RPG_ranking_repair","repair"],
			["RPG_ied_defuse","IED defuse"],
			["RPG_ranking_intel_collect","intel collect"],
			["RPG_ranking_objective_complete","objective complete"]];
			


//End Mission
if (isMultiplayer) then {
	[_endingName] remoteExec ["BIS_fnc_endMission"];
} else {
	_endingName call BIS_fnc_endMission;
};