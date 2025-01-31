params ["_position", "_caller", "_itemsList"];

//Check if the player is allowed to shoot
_airDropSupportCounter = missionNamespace getVariable ["airDropSupportCounter", 0];
if (_airDropSupportCounter > 0) then 
{
	//Remove the action if there is no avalaible credit
	_airDropSupportID = _caller getVariable ["airDropSupportID", -1];
	if (_airDropSupportID != -1 && _airDropSupportCounter == 1) then 
	{
		[_caller, _airDropSupportID] remoteExec ["BIS_fnc_removeCommMenuItem", _caller];
		_caller setVariable ["airDropSupportID", -1, true];
	};

	missionNamespace setVariable ["airDropSupportCounter", _airDropSupportCounter-1, true];
	
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

	//Search items if necessary
	if (count _itemsList == 0) then 
	{
		//Add medic items
		//Check if ACE is enable on the server
		if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
		{
			//Setup medic ACE box 
			_crate addItemCargoGlobal ["ACE_surgicalKit", 1];
			_crate addItemCargoGlobal ["ACE_epinephrine", 10];
			_crate addItemCargoGlobal ["ACE_splint", 10];
			_crate addItemCargoGlobal ["ACE_elasticBandage", 50];
			_crate addItemCargoGlobal ["ACE_quikclot", 50];
			_crate addItemCargoGlobal ["ACE_morphine", 10];
			_crate addItemCargoGlobal ["ACE_bloodIV_500", 10];
			_crate addItemCargoGlobal ["ACE_bloodIV", 5];
			_crate addItemCargoGlobal ["ACE_tourniquet", 5];
			_crate addItemCargoGlobal ["ACE_Suture", 40];

		} else 
		{
			_crate addItemCargoGlobal ["FirstAidKit", 20];
			//_crate addItemCargoGlobal ["Medikit", 5];
		};

	} else 
	{
		//add basic medecine
		{
			_crate addItemCargoGlobal [_x#0, _x#1];
		} foreach _itemsList;
	};

	//init 
	_tempMagazine = []; 
	_weaponsToCheck = [];

	//Detect every player on the same side and check their weapons
	{
		_weaponsToCheck append (weapons _x);
	} foreach allPlayers select {side _x == side _caller};

	//Keep unique weapons
	_weaponsToCheck = _weaponsToCheck arrayIntersect _weaponsToCheck;

	//Detect magazines
	{
		_currentWeaponMagazineList = getArray (configfile >> "CfgWeapons" >> _x >> "magazines");
		if (count _currentWeaponMagazineList != 0) then 
		{
			//Add every magazines
			{
				_tempMagazine pushBackUnique _x;
			} foreach _currentWeaponMagazineList;
		};
	} foreach _weaponsToCheck;

	//Add magazines into crate
	for [{_i = 0}, {_i < 10}, {_i = _i + 1}] do
	{
		{
			if (load _crate < 1) then 
			{
				_crate addItemCargoGlobal [_x, 2];
			};
		}	foreach _tempMagazine;
	};

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