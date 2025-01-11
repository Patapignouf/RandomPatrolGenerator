params ["_position", "_caller"];

//Check if the player is allowed to shoot
_reinforcementSupportCounter = missionNamespace getVariable ["reinforcementSupportCounter", 0];
if (_reinforcementSupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_reinforcementSupportID = _caller getVariable ["reinforcementSupportID", -1];
	if (_reinforcementSupportID != -1 && _reinforcementSupportCounter == 1) then 
	{
		[_caller, _reinforcementSupportID] remoteExec ["BIS_fnc_removeCommMenuItem", _caller];
		_caller setVariable ["reinforcementSupportID", -1, true]
	};

	//Hint to extract call
	[[_caller], {params ["_caller"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_REINFORCEMENT_CALL", name _caller] call doDialog}] remoteExec ["spawn", side blufor]; 
	
	//Play random radio sound
	[] spawn {
		playMusic ["RadioAmbient5", 1];
		sleep 4;
		playMusic "";
	};

	missionNamespace setVariable ["reinforcementSupportCounter", _reinforcementSupportCounter-1, true];

	//Wait 1 minute before respawn
	sleep 60;
	[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
	
} else 
{
	//Not suppose to be triggered
	hint "No reinforcement support avalaible";
};