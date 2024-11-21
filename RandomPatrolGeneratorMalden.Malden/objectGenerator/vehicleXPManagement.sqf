
addVehicleXPSetup = {
	params ["_vehicle"];

	//Check vehicle death on server side
	[[_vehicle], 'engine\checkVehicleDeath.sqf'] remoteExec ['BIS_fnc_execVM', 2];

	//Check who did the last hit
	_vehicle addEventHandler ["HandleDamage", {
		params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

		if (isPlayer _instigator) then 
		{
			_unit setVariable ["vehicleLastHit", _instigator];
		};
	}];

	//Add sabotage on vehicle 
	//Engineer only
	[
		_vehicle, 
		"Sabotage the vehicle", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
		"(_this distance _target < 5) && (_this getVariable 'role' == 'engineer') && (({alive _x} count (crew _target))==0)",		// Condition for the action to be shown
		"_caller distance _target < 5",		// Condition for the action to progress
		{
			// Action start code
		}, 
		{
			// Action on going code
		},  
		{
			// Action successfull code
			params ["_object","_caller","_ID","_objectParams","_progress","_maxProgress"];
			
			_object setVariable ["vehicleLastHit", _caller];
			
			//destroy vehicle
			[_object] spawn {
				params ["_object"];
				sleep 10;
				_object setVehicleArmor 0;

				//Clean vehicle
				sleep 600;
				deleteVehicle _object;
			};
		}, 
		{
			// Action failed code
		}, 
		[],  
		15,
		5, 
		true, 
		false
	] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
};