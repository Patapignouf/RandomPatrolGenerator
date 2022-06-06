while {sleep 1000; true} do {
	{
		deleteVehicle _x;
		sleep 0.01;
	} forEach allDeadMen;
	
};