doDialog = {
	params ["_speaker", "_message", "_customParam1", "_customParam2"];

	if (isNil "_customParam1") then 
	{
		_customParam1 = "";
	};

	if (isNil "_customParam2") then 
	{
		_customParam2 = "";
	};

	_textToSpeech = format [localize _message, _customParam1, _customParam2];
	_colorAndPos = [_speaker] call getSpeakerColorAndPosition;

	//Localize speaker if necessary
	_localizedSpeaker  = localize _speaker;
	if (_localizedSpeaker == "") then 
	{
		_localizedSpeaker = _speaker;
	};

	titleText [format ["<t align = 'center' shadow = '2' color='%3' size='1.5' font='PuristaMedium' >%2</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, _localizedSpeaker, _colorAndPos#0], _colorAndPos#1, -1, true, true];
};

doDialogWithCustomParam = {
	params ["_speaker", "_message"];
	_message set [0, localize (_message#0)];
	_textToSpeech = format _message;
	_colorAndPos = [_speaker] call getSpeakerColorAndPosition;

	//Localize speaker if necessary
	_localizedSpeaker  = localize _speaker;
	if (_localizedSpeaker == "") then 
	{
		_localizedSpeaker = _speaker;
	};

	titleText [format ["<t align = 'center' shadow = '2' color='%3' size='1.5' font='PuristaMedium' >%2</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, _localizedSpeaker, _colorAndPos#0], _colorAndPos#1, -1, true, true];
};

getSpeakerColorAndPosition = {
	params ["_speaker"];
	_color = "";
	_position = "";
	switch (_speaker) do 
	{
		case "STR_RPG_OBJ_HOSTAGE";
		case "STR_RPG_CHOPPER_NAME":
		{
			_color = "#0046ff"; //Blue
			_position = "PLAIN DOWN";
		};
		case "STR_RPG_HC_NAME":
		{
			_color = "#0046ff"; //Blue
			_position = "PLAIN DOWN";

			//Play random radio sound
			[] spawn {
				playMusic [selectRandom ["RadioAmbient1","RadioAmbient2","RadioAmbient3","RadioAmbient4","RadioAmbient5","RadioAmbient6","RadioAmbient7","RadioAmbient8","RadioAmbient9","RadioAmbient10","RadioAmbient11","RadioAmbient12","RadioAmbient13","RadioAmbient14","RadioAmbient15","RadioAmbient16","RadioAmbient17","RadioAmbient18"], 1];
				sleep 4;
				playMusic "";
			};
		};
		case "STR_RPG_CIVILIAN_NAME":
		{
			_color = "#00FF00";
			_position = "PLAIN";
		};
		case "STR_RPG_CORPSE_NAME":
		{
			_color = "#FF0000";
			_position = "PLAIN DOWN";

		};
		default
		{
			//Opfor talking waiting for better implementation
			_color = "#FF0000";
			_position = "PLAIN DOWN";
		};
	};
	[_color, _position];
};