//add fortify action
addFortifyAction = 
{
	//Create action
	_fortifyActionID = [
		player,
		localize "STR_ACTIONS_PLACE_BARRICADE",
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
		"
			(_this getVariable 'role' == 'engineer')
			&&
			(vehicle _this == _this)
			&&
			(lineIntersectsSurfaces [eyePos _this, (eyePos _this) vectorAdd (getCameraViewDirection _this vectorMultiply 2.5), _this, objNull, true, 1, 'GEOM']) isNotEqualTo [] 
			&& 
			{((lineIntersectsSurfaces [eyePos _this, (eyePos _this) vectorAdd (getCameraViewDirection _this vectorMultiply 2.5), _this, objNull, true, 1, 'GEOM'] select 0 select 0 select 2) < ((getPosASL _this select 2) + 0.5))}
		",
		
		"true",
		{	params ["_target", "_caller", "_actionId", "_arguments"];
			_caller playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
		},
		{},
		{ 
			params ["_object","_caller","_ID","_avalaibleVehicle"];


			//Check faction credit
			//Tent placement cost 100 credits
			_price = 50;
			_haveCredits = false;
			if (side _caller == blufor) then 
			{
				bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
				if (_price <= bluforVehicleAvalaibleSpawnCounter) then 
				{
					_haveCredits = true;
					bluforVehicleAvalaibleSpawnCounter = bluforVehicleAvalaibleSpawnCounter - _price;
					missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter, true];
				};	
			} else 
			{
				independentVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
				if (_price <= independentVehicleAvalaibleSpawnCounter) then 
				{
					_haveCredits = true;
					independentVehicleAvalaibleSpawnCounter = independentVehicleAvalaibleSpawnCounter - _price;
					missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", independentVehicleAvalaibleSpawnCounter, true];
				};					
			};

			if (_haveCredits) then 
			{
				//Create tent
				_futurPos = (_caller modelToWorld [0, 1, 0]);
				_createFortification = createVehicle ["Land_BagFence_Long_F", _futurPos, [], 0, "CAN_COLLIDE"];

				
				_createFortification setDir (getDir _caller);
				_createFortification setVectorUp (surfaceNormal _futurPos);

				//Create action to authorize tent disassembly
				[
					_createFortification, 
					"Disassemble fortification", 
					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", 
					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", 
					"(_this distance _target < 3) && (_this getVariable 'role' == 'engineer') && (vehicle _this == _this)",
					"true", 
					{
						// Action start code
					}, 
					{
						// Action on going code
					},  
					{
						// Action successfull code
						params ["_object","_caller","_ID","_param"];

						//Refund fortification
						_price = 50;
						if (side _caller == blufor) then 
						{
							bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
							if (_price <= bluforVehicleAvalaibleSpawnCounter) then 
							{
								_haveCredits = true;
								bluforVehicleAvalaibleSpawnCounter = bluforVehicleAvalaibleSpawnCounter + _price;
								missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", bluforVehicleAvalaibleSpawnCounter, true];
							};	
						} else 
						{
							independentVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
							if (_price <= independentVehicleAvalaibleSpawnCounter) then 
							{
								_haveCredits = true;
								independentVehicleAvalaibleSpawnCounter = independentVehicleAvalaibleSpawnCounter + _price;
								missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", independentVehicleAvalaibleSpawnCounter, true];
							};					
						};

						//Destroy fortification
						deleteVehicle _object;
					}, 
					{
						// Action failed code
					}, 
					[],  
					2,
					1000, 
					false,
					false
				] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
			}
			else
			{
				hint "Not enough credits";
			};
		}, //Success
		{}, //Failed
		[],
		10,
		2,
		false,
		false
	] call BIS_fnc_holdActionAdd;

	//Set player fortifyAction ID
	player setVariable ["fortifyActionID", _fortifyActionID];

	_fortifyActionID
};
