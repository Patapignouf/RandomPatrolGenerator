params ["_position", "_caller"];

//Check if the player is allowed to shoot
_extractSupportCounter = missionNamespace getVariable ["extractSupportCounter", 0];
if (_extractSupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_extractSupportID = _caller getVariable ["extractSupportID", -1];
	if (_extractSupportID != -1 && _extractSupportCounter == 1) then 
	{
		[_caller, _extractSupportID] remoteExec ["BIS_fnc_removeCommMenuItem", _caller];
		_caller setVariable ["extractSupportID", -1, true]
	};

	missionNamespace setVariable ["extractSupportCounter", _extractSupportCounter-1, true];
	[[selectRandom (bluforUnarmedVehicleChopper+bluforExtractVehicleChopper), _position], 'engine\doVehicleVehicleExtract.sqf'] remoteExec ['BIS_fnc_execVM', 2];

	//Hint to extract call
	_textToSpeech = format ["Extract called on position %1", mapGridPosition _position];
	[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", blufor, true];

	//Play random radio sound
	[] spawn {
		playMusic ["RadioAmbient5", 1];
		sleep 4;
		playMusic "";
	};

	
} else 
{
	//Not suppose to be triggered
	hint "No extract support avalaible";
};