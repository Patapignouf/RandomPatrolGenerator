//check if player has to see a hint
//queuing multiple hints
while {sleep 5; true} do {
	_messageToDisplay = player getVariable ["messageToDisplay", []];

	if ((count _messageToDisplay)!=0) then 
	{
		//Block other messages
		_messageArray = _messageToDisplay#0;

		_message = _messageArray#0;
		_messageType = _messageArray#1;

		//hint message
		hint "";
		sleep 0.25;
		hint _message;

		//Play sound
		switch (_messageType) do 
		{
			case "intel":
			{
				playSoundUI ["a3\sounds_f\sfx\hint-5.wss"];
			};
			case "alert":
			{
				playSoundUI ["a3\sounds_f\sfx\beep_target.wss"];
			};
			case "teamkilled";
			case "civiliankilled":
			{
				playSoundUI ["A3\Sounds_F\sfx\blip1.wss"];
			};
			default
			{
				//Do nothing
			};
		};

		//Allow other message
		player setVariable ["messageToDisplay", _messageToDisplay-[_messageArray]];
	};
};



