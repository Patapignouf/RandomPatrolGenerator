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

//End Mission
if (isMultiplayer) then {
	[_endingName] remoteExec ["BIS_fnc_endMission"];
} else {
	_endingName call BIS_fnc_endMission;
};