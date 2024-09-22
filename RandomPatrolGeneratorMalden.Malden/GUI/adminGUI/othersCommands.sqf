Increasedifficulty = {
	_actualDifficulty = missionNamespace getVariable "missionDifficultyParam";
	missionNamespace setVariable ["missionDifficultyParam", _actualDifficulty+1, true];
	[[format ["OPFOR has increased its presence in the area"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	[format["%1 increase difficulty", name player]] call addLogs;
};

Decreasedifficulty = {
	_actualDifficulty = missionNamespace getVariable "missionDifficultyParam";
	missionNamespace setVariable ["missionDifficultyParam", _actualDifficulty-1, true];
	[[format ["OPFOR has reduced its presence in the area"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	[format["%1 decrease difficulty", name player]] call addLogs;
};

ImmediateRespawn = {
	[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
	[format["%1 invoke immediate respawn for all players", name player]] call addLogs;
};

VehicleShop = {
	adminDisplay closeDisplay 1;
	[["bluforVehicleAvalaibleSpawn", bluforUnarmedVehicle, bluforArmedVehicle, bluforArmoredVehicle, bluforUnarmedVehicleChopper, bluforArmedChopper, bluforDrone, bluforFixedWing, bluforBoat], 'GUI\vehicleSpawnerGUI\vehicleSpawner.sqf'] remoteExec ['BIS_fnc_execVM', player];
};

SupportShop = {
	adminDisplay closeDisplay 1;
	[[true], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];
};

ClearWeather = {
	[[], 'engine\clearWeather.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	hint "Weather cleared";
	[format["%1 clear weather", name player]] call addLogs;
};

AddCredit = {
	[] call doIncrementVehicleSpawnCounter; 
	[format["%1 added 1000 credits", name player]] call addLogs;
};

EndGame = {
	[['PLY_DEAD'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
};

_deadPlayers = [];
{
	if(!alive _x) then {
		_deadPlayers pushBack (name _x);
	};
} forEach allPlayers - entities "HeadlessClient_F";
_immediateRespawnDesc = format ["Immediate Respawn\n\nDead player count : %1\nPlayers :", count _deadPlayers];
{
	_immediateRespawnDesc = format ["%1\n- %2", _immediateRespawnDesc, _x];
} forEach _deadPlayers;

othersCommands = [];
othersCommands pushBack ["Increase difficulty", format["Increase difficulty\n\nCurrent difficulty : %1", missionNamespace getVariable "missionDifficultyParam"], Increasedifficulty];
othersCommands pushBack ["Decrease difficulty", format["Decrease difficulty\n\nCurrent difficulty : %1", missionNamespace getVariable "missionDifficultyParam"], Decreasedifficulty];
othersCommands pushBack ["Immediate Respawn", _immediateRespawnDesc, ImmediateRespawn];
othersCommands pushBack ["Vehicle Shop", "Open Vehicle Shop", VehicleShop];
othersCommands pushBack ["Support Shop", "Open Support Shop", SupportShop];
othersCommands pushBack ["Clear Weather", "Clear Weather", ClearWeather];
othersCommands pushBack ["Add 1000 Credits", format["Add 1000 Credits\n\nCurrent credit : %1", missionNamespace getVariable "bluforVehicleAvalaibleSpawn"], AddCredit];
othersCommands pushBack ["End Mission", "End Mission", EndGame];