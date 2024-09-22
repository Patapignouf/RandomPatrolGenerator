healPlayer = {
	params ["_player"];
	[_player] call ACE_medical_treatment_fnc_fullHealLocal;
	hint str format ["%1 healed", name _player];

	[format["%1 healed by %2", name _player, name player]] call addLogs;
};

revivePlayer = {
	params ["_player"];
	[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', _player];
	hint str format ["%1 revived", name _player];

	[format["%1 revived by %2", name player, name _player]] call addLogs;
};

setConscious = {
	params ["_player"];
	[_player, false] call ace_medical_fnc_setUnconscious;
	hint str format ["%1 is now concious", name _player];
	[format["%1 has been restored by %2", name _player, name player]] call addLogs;
};

setInconcious = {
	params ["_player"];
	[_player, true] call ace_medical_fnc_setUnconscious;
	hint str format ["%1 is now concious", name _player];
	[format["%1 was knocked out by %2", name _player, name player]] call addLogs;
};

instantKillPlayer = {
	params ["_player"];
	_player setDamage 1;
	hint str format ["%1 killed", name _player];
	[format["%1 was killed by %2", name _player, name player]] call addLogs;
};

teleportToYou = {
	params ["_player"];
	private _targetPos = getPos player;
	_player setPos _targetPos;
	hint str format ["%1 teleported to you", name _player];
	[format["%1 was teleport to %2", name _player, name player]] call addLogs;
};

teleportToHim = {
	params ["_player"];
	private _targetPos = getPos _player;
	player setPos _targetPos;
	hint str format ["You teleported to %1", name _player];
	[format["%1 was teleport to %2", name player, name _player]] call addLogs;
};

rankManager = {
	params ["_player"];
	[[_player], 'GUI\rankGUI\rankGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];
};

playersCommands = [];
playersCommands pushBack ["Heal", "Heal player", healPlayer];
playersCommands pushBack ["Revive", "Revive player", revivePlayer];
playersCommands pushBack ["Concious", "Set player concious", setConscious];
playersCommands pushBack ["Inconcious", "Set player inconcious", setInconcious];
playersCommands pushBack ["Instant kill", "Instant kill player", instantKillPlayer];
playersCommands pushBack ["Teleport to you", "Teleport player to you", teleportToYou];
playersCommands pushBack ["Teleport to him", "Teleport you player to him", teleportToHim];
playersCommands pushBack ["Rank manager", "See rank of player", rankManager];