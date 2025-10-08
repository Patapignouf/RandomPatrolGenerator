isInJammedArea = {
	params ["_unitToCheckInArea", "_triggerList"];
	
	_isJammed = false;
	{
		scopeName "loop2";
		private _trigger = _x#1;

		// Vérifie si le joueur est dans le trigger
		//if (_unitToCheckInArea inArea _trigger) then {
		//Fix trigger cast
		if (_unitToCheckInArea distance _trigger < 400) then {
			// --- ACTION D’EXCLUSION ---
			// Option 1 : Expulser (kick)
			//["Vous êtes entré dans une zone interdite."] remoteExec ["hint", _player];
			//_player remoteExec ["endMission", _player, true];  // Fin de mission côté joueur

			// Option 2 (alternative) : Téléporter hors zone
			//_player setPos [0,0,0];

			// Option 3 (alternative) : Le tuer
			//_player setDamage 1;
			_isJammed = true;
			// On arrête la boucle après la première exclusion
			breakOut "loop2";
		};
	} forEach (_triggerList select {_x#0});

	_isJammed
};

[] spawn {
	player setVariable ["jammedGPS", false];
	sleep 1;
	while {sleep 0.5; true} do 
	{
		_listOfJammedArea = missionNameSpace getVariable ["jammedArea", []];
		_boolJammed = [player, _listOfJammedArea] call isInJammedArea;

		//Disable GPS and micro DAGR
		if (_boolJammed) then 
		{
			//Disable GPS view
    		openGPS false;

			//Disable ACE microDAGR view
			if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
			{
				[0] call ace_microdagr_fnc_openDisplay; //Close display
				[1] call ace_microdagr_fnc_saveCurrentAndSetNewMode; //Set kompass display
			};

			//Disable TFAR radio
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				(str (floor (random 50+40))) call TFAR_fnc_setPersonalRadioFrequency;
				(str (floor (random 50+40))) call TFAR_fnc_setLongRangeRadioFrequency;
			};

			if (!(player getVariable ["jammedGPS", true])) then 
			{
				player setVariable ["jammedGPS", true];
				hint "GPS and radio jammed";
			};	
		} else 
		{
			//Check with lower frequency
			sleep 15;
			if ((player getVariable ["jammedGPS", true])) then 
			{
				player setVariable ["jammedGPS", false];
			};			
		};
	};
};

