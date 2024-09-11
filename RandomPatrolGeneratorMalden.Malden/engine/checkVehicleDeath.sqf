params ["_vehicle"];

diag_log format ["The vehicle %1 is on death checking", _vehicle];

while {alive _vehicle} do 
{
	//Just wait
	sleep 30;
};

_instigator = _vehicle getVariable "vehicleLastHit";

diag_log format ["The vehicle %1 has been destroyed by %2", _vehicle, _instigator];

if (isPlayer _instigator) then 
{
	[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
};

//Clean vehicle
[_vehicle] spawn {
	params ["_unit"];
	sleep 600;
	deleteVehicle _unit;
};

[_vehicle] remoteExec ["removeAllActions", 0, true];