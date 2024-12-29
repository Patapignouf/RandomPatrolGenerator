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
	[{["STR_RPG_HC_NAME", "STR_RPG_HC_TRANSPORT", mapGridPosition _position] call doDialog}] remoteExec ["call", blufor];

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