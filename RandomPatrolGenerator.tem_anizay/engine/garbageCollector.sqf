while {sleep 600; true} do {
	{
		deleteVehicle _x;
		sleep 0.01;
	} forEach allDeadMen;
	
};