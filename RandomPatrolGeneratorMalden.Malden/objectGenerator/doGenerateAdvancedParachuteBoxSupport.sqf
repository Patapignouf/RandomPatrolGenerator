params ["_position", "_caller", "_itemsList"];

//Check if the player is allowed to shoot
_advancedAirDropSupportCounter = missionNamespace getVariable ["advancedAirDropSupportCounter", 0];
if (_advancedAirDropSupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_airDropSupportID = _caller getVariable ["advancedAirDropSupportID", -1];
	if (_airDropSupportID != -1 && _advancedAirDropSupportCounter == 1) then 
	{
		[_caller, _airDropSupportID] remoteExec ["BIS_fnc_removeCommMenuItem", _caller];
		_caller setVariable ["advancedAirDropSupportID", -1, true];
	};

	missionNamespace setVariable ["advancedAirDropSupportCounter", _advancedAirDropSupportCounter-1, true];
	
	//Hint to airDrop call
	[[_position], {params ["_position"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_AIR_SUPPORT", mapGridPosition _position] call doDialog}] remoteExec ["spawn", blufor]; 

	//Wait for the drop
	sleep 15+(random 30);

	//Call air drop 
	_positionLZ = _position findEmptyPosition [0, 200,"Land_HelipadCircle_F"];

	_parachute = createVehicle ["B_Parachute_02_F", [(_positionLZ select 0), (_positionLZ select 1), ((_positionLZ select 2)+300)], [], 0, 'FLY'];
	_crate = createVehicle ["B_supplyCrate_F", position _parachute, [], 0, 'NONE'];

	//Clear crate
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;

	_crate attachTo [_parachute, [0, 0, -1.3]];
	_crate allowdamage false;

	//Wait for care almost hit ground
	//Fix bug where crate go under the ground
	waitUntil {((((position _crate)#2) < 0.6) || (isNil "_parachute"))};
	detach _crate;
	_crate setVelocity [0,0,-5];
	sleep 0.3;
	
	//Place crate on the ground
	_crate setPos [(position _crate)#0, (position _crate)#1, 1];
	_crate setVelocity [0,0,0];  

	//TODO FIX Mobile HQ Arsenal action
	if (ironMan) then 
	{
		[[_crate], {params ["_crate"]; [_crate] call setupPlayerLoadout;	}] remoteExec ["spawn", blufor]; 
	} else 
	{
		[[_crate], {params ["_crate"]; [_crate] call setupPlayerLoadoutWithoutConditionRemake;	}] remoteExec ["spawn", blufor]; 
	};


	//Add smoke to crate
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{
		_supplyLight = "Chemlight_green" createVehicle (position _crate);
		_supplyLight attachTo [_crate, [0,0,0]];
		_supplySmoke = "SmokeShellGreen" createVehicle (position _crate);
		_supplySmoke attachTo [_crate, [0,0,0]];
		sleep 30;
	};
	
} else 
{
	//Not suppose to be triggered
	hint "No air drop support avalaible";
};