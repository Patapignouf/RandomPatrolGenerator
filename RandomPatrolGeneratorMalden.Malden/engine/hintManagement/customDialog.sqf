doDialog = {
	params ["_speaker", "_message", "_customParam1", "_customParam2"];
	_textToSpeech = format [localize _message, _customParam1, _customParam2];
	_colorAndPos = [_speaker] call getSpeakerColorAndPosition;
	titleText [format ["<t align = 'center' shadow = '2' color='%3' size='1.5' font='PuristaMedium' >%2</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, localize _speaker, _colorAndPos#0], _colorAndPos#1, -1, true, true];
};

doDialogWithCustomParam = {
	params ["_speaker", "_message"];
	_message set [0, localize (_message#0)];
	_textToSpeech = format _message;
	_colorAndPos = [_speaker] call getSpeakerColorAndPosition;
	titleText [format ["<t align = 'center' shadow = '2' color='%3' size='1.5' font='PuristaMedium' >%2</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, localize _speaker, _colorAndPos#0], _colorAndPos#1, -1, true, true];
};

getSpeakerColorAndPosition = {
	params ["_speaker"];
	_color = "";
	_position = "";
	switch (_speaker) do 
	{
		case "STR_RPG_OBJ_HOSTAGE";
		case "STR_RPG_CHOPPER_NAME";
		case "STR_RPG_HC_NAME":
		{
			_color = "#0046ff";
			_position = "PLAIN DOWN";
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
			//Not a normal behaviour
		};
	};
	[_color, _position];
};