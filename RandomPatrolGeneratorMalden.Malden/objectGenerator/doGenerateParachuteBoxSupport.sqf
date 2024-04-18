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
	_textToSpeech = format ["Air drop support called on position %1", mapGridPosition _position];
	[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", side _caller, true];

	//Play random radio sound
	[] spawn {
		playMusic ["RadioAmbient5", 1];
		sleep 4;
		playMusic "";
	};

	//Wait for the drop
	sleep 30+(random 30);

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
			_crate addItemCargoGlobal ["ACE_Suture", 20];

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

	//Add magazines
	_tempMagazine = bluforMagazineList;
	_faction = missionNamespace getVariable ["bluforFaction", 0]; //Default blufor
	//Add magazine foreach class 
	_virtualWeaponList = [];
	_virtualWeaponList = _virtualWeaponList + (rifleList_db select {_x select 1  == (_faction)} select 0 select 0);
	_virtualWeaponList = _virtualWeaponList + (smgList_db select {_x select 1  == (_faction)} select 0 select 0);
	_virtualWeaponList = _virtualWeaponList + (launcherList_db select {_x select 1  == (_faction)} select 0 select 0);
	_virtualWeaponList = _virtualWeaponList + (autorifleList_db select {_x select 1  == (_faction)} select 0 select 0);
	_virtualWeaponList = _virtualWeaponList + (marksmanrifleList_db select {_x select 1  == (_faction)} select 0 select 0);

	diag_log format ["Generate air supply drop weaponList : %1", _virtualWeaponList];

	_listOfLargeMagazineText = []; //
	{
		_currentWeaponMagazineList = getArray (configfile >> "CfgWeapons" >> _x >> "magazines");
		if (count _currentWeaponMagazineList != 0) then 
		{
			if ((_tempMagazine) findIf {_x == (_currentWeaponMagazineList#0)} == -1) then 
			{
				//Add only if this is not a large magazine
				// if (!([_currentWeaponMagazineList#0, _listOfLargeMagazineText] call isElementOfArrayInString)) then 
				// {
					_tempMagazine pushBack _currentWeaponMagazineList#0;
				// };
			};
		};
	} foreach _virtualWeaponList;

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
	
} else 
{
	//Not suppose to be triggered
	hint "No air drop support avalaible";
};