params ["_position", "_caller"];

//Check if the player is allowed to shoot
_reinforcementSupportCounter = missionNamespace getVariable ["reinforcementSupportCounter", 0];
if (_reinforcementSupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_reinforcementSupportID = _caller getVariable ["reinforcementSupportID", -1];
	if (_reinforcementSupportID != -1 && _reinforcementSupportCounter == 1) then 
	{
		[_caller, _reinforcementSupportID] remoteExec ["BIS_fnc_removeCommMenuItem", _caller];
		_caller setVariable ["reinforcementSupportID", -1, true]
	};

	//Hint to extract call
	_textToSpeech = format ["Copy %1, we will send you reinforcement in 60 seconds", name _caller];
	[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", blufor, true];

	//Play random radio sound
	[] spawn {
		playMusic ["RadioAmbient5", 1];
		sleep 4;
		playMusic "";
	};

	missionNamespace setVariable ["reinforcementSupportCounter", _reinforcementSupportCounter-1, true];

	//Wait 1 minute before respawn
	sleep 60;
	[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
	
} else 
{
	//Not suppose to be triggered
	hint "No reinforcement support avalaible";
};