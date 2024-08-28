//Respawn the players
[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];

//Clean RTB Task and map
["taskRTB"] call BIS_fnc_deleteTask;
[{findDisplay 12 displayCtrl 51 ctrlRemoveEventHandler ["Draw", player getVariable "TaskRTBSquareDrawID"]}] remoteExec ["call", -2];

_missionNumber = missionNamespace getVariable ["missionNumber", 0];
missionNamespace setVariable ["missionNumber", _missionNumber+1, true];

//Wait player respawn 
sleep 2;


//Delete tasks
([format ["%1 cleaning tasks", time]]) remoteExec ["systemChat", 0, true];
{
	[_x#2] call BIS_fnc_deleteTask;
} foreach (missionNamespace getVariable ["MissionObjectives",[]]);

//Clean side tasks
([format ["%1 cleaning side tasks", time]]) remoteExec ["systemChat", 0, true];
{
	[_x] call BIS_fnc_deleteTask;
} foreach (missionNamespace getVariable ["currentSideObjectives", []]);


[] spawn {
	//Suprimer les event et les actions
	([format ["%1 cleaning players", time]]) remoteExec ["systemChat", 0, true];
	{
		_x setVariable ["canRTB", false, true];
		_x setVariable ["isSetupMission", false];
		[_x] remoteExec ["removeAllActions", 0, true];

		//Delete personal task Survive
		[format ["RPG_%1_Death", name _x]] call BIS_fnc_deleteTask;
		_x setVariable ["deathNumber", 0, true];

		//Heal player
		if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
		{
			[objNull, _x] call ace_medical_treatment_fnc_fullHeal;
		} else 
		{
			_x setDamage 0;
		};
	} foreach allPlayers;

	//Remove all custom EH
	[{player removeEventHandler ["Killed", player getVariable "KilledEH"];}] remoteExec ["call", -2];
	[{player removeEventHandler ["Fired", player getVariable "FiredEH"];}] remoteExec ["call", -2];
	[{player removeEventHandler ["HandleDamage", player getVariable "HandleDamageEH"];}] remoteExec ["call", -2];
	[{player removeEventHandler ["Respawn", player getVariable "RespawnEH"];}] remoteExec ["call", -2];
	[{player removeEventHandler ["AnimDone", player getVariable "AnimDoneEH"];}] remoteExec ["call", -2];

	//Clean objects
	([format ["%1 cleaning vehicles and objects", time]]) remoteExec ["systemChat", 0, true];
	{
		deleteVehicle _x;
	} foreach (nearestObjects [[0,0], ["all"], worldSize]);

	//Clean vehicles
	([format ["%1 cleaning units", time]]) remoteExec ["systemChat", 0, true];
	{
		if (!(isPlayer _x )) then 
		{
			deleteVehicle _x;
		};
	} foreach allUnits;

	//Clean screen
	[1,["", "PLAIN", 0.5]] remoteExec ["cutText", 0];
};

//Exec start on the server
([format ["%1 reinit mission", time]]) remoteExec ["systemChat", 0, true];
[[], "initServer.sqf"] remoteExec ['BIS_fnc_execVM', 2];

sleep 5;

//ExecInitPlayer
([format ["%1 reinit player", time]]) remoteExec ["systemChat", 0, true];
[[], "initPlayerLocal.sqf"] remoteExec ['BIS_fnc_execVM', 0];

