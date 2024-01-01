params ["_message", "_messageType"];

//Queue message with message to display
_messageToDisplay = player getVariable ["messageToDisplay", []];
_messageToDisplay pushBack [_message, _messageType];
player setVariable ["messageToDisplay", _messageToDisplay];


