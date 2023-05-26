params ["_message"];

//Queue message with message to display
_messageToDisplay = player getVariable ["messageToDisplay", []];
_messageToDisplay pushBack _message;
player setVariable ["messageToDisplay", _messageToDisplay];


