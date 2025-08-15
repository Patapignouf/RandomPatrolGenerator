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

	//Call 6 shots on 6 waves
	[_position, "Bo_Mk82", 25, 2, 10] spawn BIS_fnc_fireSupportVirtual;
	sleep 0.5;
	[_position, "Bo_Mk82", 25, 2, 10] spawn BIS_fnc_fireSupportVirtual;
	sleep 0.5;
	[_position, "Bo_Mk82", 20, 3, 10] spawn BIS_fnc_fireSupportVirtual;
	sleep 1;
	[_position, "Bo_Mk82", 30, 1, 10] spawn BIS_fnc_fireSupportVirtual;
	[_position, "Bo_Mk82", 30, 1, 10] spawn BIS_fnc_fireSupportVirtual;
	sleep 0.5;
	[_position, "Bo_Mk82", 30, 1, 10] spawn BIS_fnc_fireSupportVirtual;

} else 
{
	//Not suppose to be triggered
	hint "No artillery support avalaible";
};