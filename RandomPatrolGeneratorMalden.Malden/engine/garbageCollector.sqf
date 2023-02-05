while {sleep 1000; true} do {
	{
		if (!(_x getVariable ["isObjectiveObject", false])) then 
		{
			deleteVehicle _x;
			sleep 0.01;
		};
	} forEach allDeadMen;
};