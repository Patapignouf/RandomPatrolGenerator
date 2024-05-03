params ["_position", "_caller"];

//Check if the player is allowed to shoot
_transportSupportCounter = missionNamespace getVariable ["transportSupportCounter", 0];
if (_transportSupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_transportSupportID = _caller getVariable ["transportSupportID", -1];
	if (_transportSupportID != -1 && _transportSupportCounter == 1) then 
	{
		[_caller, _transportSupportID] remoteExec ["BIS_fnc_removeCommMenuItem", _caller];
		_caller setVariable ["transportSupportID", -1, true]
	};

	missionNamespace setVariable ["transportSupportCounter", _transportSupportCounter-1, true];
	[[selectRandom (bluforUnarmedVehicleChopper+bluforExtractVehicleChopper), _position], 'engine\doVehicleVehicleTransport.sqf'] remoteExec ['BIS_fnc_execVM', 2];

	//Hint to extract call
	_textToSpeech = format ["Transport called on position %1", mapGridPosition _position];
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
	hint "No transport support avalaible";
};