params ["_thisVehicle"];

//Refuel when fuel under 80%
while {true} do
{
	if ((fuel (_thisVehicle)) < 0.8) then
	{
		(_thisVehicle) setFuel 1;
		diag_log format ["%1 has been refueled !", _thisVehicle];
	};
	sleep 120;
};