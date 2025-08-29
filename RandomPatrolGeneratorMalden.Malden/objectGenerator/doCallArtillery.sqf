params ["_position", "_caller"];

//Check if the player is allowed to shoot
_artlillerySupportCounter = missionNamespace getVariable ["artlillerySupportCounter", 0];
if (_artlillerySupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_artillerySupportID = _caller getVariable ["artillerySupportID", -1];
	if (_artillerySupportID != -1 && _artlillerySupportCounter == 1) then 
	{
		[_caller, _artillerySupportID] remoteExec ["BIS_fnc_removeCommMenuItem", _caller];
		_caller setVariable ["artillerySupportID", -1, true]
	};

	missionNamespace setVariable ["artlillerySupportCounter", _artlillerySupportCounter-1, true];

	//Hint to artillery call
	[[_position], {params ["_position"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_ARTILLERY", mapGridPosition _position] call doDialog}] remoteExec ["spawn", blufor]; 

	//Play random radio sound
	[] spawn {
		playMusic ["RadioAmbient5", 1];
		sleep 4;
		playMusic "";
	};

	//Simulate waiting for shots
	sleep (15 + random 25);

	//Call random shots waves
	for [{_i = 0}, {_i < 5}, {_i = _i + 1}] do
	{
		[_position] spawn {
			params ["_position"];
			sleep (random 4);
			[_position, "Bo_Mk82", 30, (floor (random 3))+2, 5] spawn BIS_fnc_fireSupportVirtual;
		};
	};

} else 
{
	//Not suppose to be triggered
	hint "No artillery support avalaible";
};