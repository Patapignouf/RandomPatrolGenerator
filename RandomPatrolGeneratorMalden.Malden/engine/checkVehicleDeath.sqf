params ["_vehicle"];

diag_log format ["The vehicle %1 is on death checking", _vehicle];


_vehicle addEventHandler ["GetOut", {
	params ["_veh", ["_role", ""], ["_unit", objNull], ["_turret", []]];

	// On vérifie le nombre de personnes vivantes encore à l'intérieur
	private _aliveCrew = (crew _veh) select { alive _x };

	if (count _aliveCrew == 0) then {
		_veh setVariable ["TAG_isCrewDismounted", true, true];
		systemChat "crew dismounted";
	};
}];


while {alive _vehicle || (!(_vehicle getVariable ["TAG_isCrewDismounted", false]))} do 
{
	//Just wait
	sleep 30;
};

_instigator = _vehicle getVariable "vehicleLastHit";

diag_log format ["The vehicle %1 has been destroyed by %2", _vehicle, _instigator];

if (isPlayer _instigator) then 
{
	[{[5, "RPG_ranking_vehicle_kill"] call doUpdateRank}] remoteExec ["call", _instigator];
};

//Clean vehicle
[_vehicle] spawn {
	params ["_unit"];
	sleep 600;
	deleteVehicle _unit;
};

[_vehicle] remoteExec ["removeAllActions", 0, true];