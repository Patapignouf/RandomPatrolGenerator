params ["_position", "_caller"];

//Check if the player is allowed to shoot
_artlillerySupportCounter = missionNamespace getVariable ["artlillerySupportCounter", 0];
if (_artlillerySupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_artillerySupportID = _caller getVariable ["artillerySupportID", -1];
	if (_artillerySupportID != -1 && _artlillerySupportCounter == 0) then 
	{
		[_caller, _artillerySupportID] call BIS_fnc_removeCommMenuItem;
	};

	missionNamespace setVariable ["artlillerySupportCounter", _artlillerySupportCounter-1, true];

	//Hint to artillery call
	[format ["Artillery support called on position %1", mapGridPosition _position], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];  

	//Simulate waiting for shots
	sleep (60 + random 60);

	//Call 3 shots
	for [{_i = 0}, {_i <= 2}, {_i = _i + 1}] do //Peut être optimisé
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