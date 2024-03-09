params ["_position", "_caller"];

//Check if the player is allowed to shoot
_artlillerySupportCounter = missionNamespace getVariable ["artlillerySupportCounter", 0];
if (_artlillerySupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_artillerySupportID = _caller getVariable ["artillerySupportID", -1];
	if (_artillerySupportID != -1 && _artlillerySupportCounter == 1) then 
	{
		[_caller, _artillerySupportID] remoteExec ["BIS_fnc_removeCommMenuItem", _caller];
		_caller setVariable ["artillerySupportID", -1, true]
	};

	missionNamespace setVariable ["artlillerySupportCounter", _artlillerySupportCounter-1, true];

	//Hint to artillery call
	_textToSpeech = format ["Artillery support called on position %1", mapGridPosition _position];
	[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", blufor, true];
	
	//Play random radio sound
	[] spawn {
		playMusic ["RadioAmbient5", 1];
		sleep 4;
		playMusic "";
	};

	//Simulate waiting for shots
	sleep (60 + random 60);

	//Call 3 shots
	for [{_i = 0}, {_i <= 4}, {_i = _i + 1}] do //Peut être optimisé
	{
		//Randomize shot location around the targeted position
		_customRandomPos = [[[_position, 50]], []] call BIS_fnc_randomPos;
		sleep 2;
		"Bo_GBU12_LGB" createVehicle _customRandomPos;
	};

} else 
{
	//Not suppose to be triggered
	hint "No artillery support avalaible";
};