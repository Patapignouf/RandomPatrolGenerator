//check if player has to see a hint
//queuing multiple hints
while {sleep 5; true} do {
	_messageToDisplay = player getVariable ["messageToDisplay", []];

	if ((count _messageToDisplay)!=0) then 
	{
		//Block other messages
		_message = _messageToDisplay#0;

		//hint message
		hint "";
		sleep 0.25;
		hint _message;

		//Allow other message
		player setVariable ["messageToDisplay", _messageToDisplay-[_message]];
	};
};



