params ["_thisVehicleUnlimitedFuel"];

//Refuel when fuel under 80%
while {true && alive _thisVehicleUnlimitedFuel} do
{
	if ((fuel (_thisVehicleUnlimitedFuel)) < 0.8) then
	{
		[_thisVehicleUnlimitedFuel, 1] remoteExec ["setFuel", _thisVehicleUnlimitedFuel];
		diag_log format ["%1 has been refueled !", _thisVehicleUnlimitedFuel];
	};
	sleep 120;
};