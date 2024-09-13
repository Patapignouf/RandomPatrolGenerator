params ["_civilian"];

// Put a vest
removeVest _civilian;
_civilian addVest "V_TacChestrig_grn_F";

// Change side of civilian
private _eastGroup = createGroup east;
[_civilian] joinSilent _eastGroup;

// 
_eastGroup setBehaviour "CARELESS";


while { alive _civilian } do {
	_PlayerInArea = (_civilian nearEntities ["Man", 30]) select {
		isPlayer _x
	};
	_count = count _PlayerInArea;

	if (_count > 0) then {
		// Set Variables
		_unit = _PlayerInArea select 0;
		_distance = _unit distance _civilian;

		// Delete last waypoint
		{ deleteWaypoint _x } forEachReversed waypoints _eastGroup;

		// Set waypoint
		_GroupWayPoint = _eastGroup addWaypoint [(position _unit), 0];
		_GroupWayPoint setWaypointType "MOVE";

		// Check distance
		if (_distance <= 10) then {
			[_civilian, "suicideBomber"] remoteExec ["say3D"];
		};

		// Boom
		if (_distance <= 5) exitWith {
			"Bo_GBU12_LGB" createVehicle position _civilian;
			deleteVehicle _civilian;
		};
	};

	sleep 0.2;
};

// [civil_1] spawn civils_fnc_suicidebomber;