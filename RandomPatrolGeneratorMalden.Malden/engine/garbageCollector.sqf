while {sleep 1000; true} do {
	{
		if (!(_x getVariable ["isObjectiveObject", false]) && !(_x getVariable ["isPlayerObject", false]) && ( _x == vehicle _x)) then 
		{
			deleteVehicle _x;
			sleep 0.01;
		};
	} forEach allDeadMen;
};