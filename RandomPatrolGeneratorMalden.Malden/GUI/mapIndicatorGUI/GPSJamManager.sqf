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
				if (call TFAR_fnc_haveLRRadio) then 
				{
					// LR radio - channel 1
					_mainFrequency =  (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency;
					player setVariable ["RPG_TFAR_LR_FREQ", _mainFrequency];
					[(call TFAR_fnc_activeLrRadio), 1, str (floor (random 50+40))] call TFAR_fnc_SetChannelFrequency;
					[(call TFAR_fnc_activeLrRadio), 2, str (floor (random 50+40))] call TFAR_fnc_SetChannelFrequency;

					// _volume = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrVolume;
					// player setVariable ["RPG_TFAR_LR_RADIO_VOL", _volume];
					// [(call TFAR_fnc_activeLrRadio), 0] call TFAR_fnc_setLrVolume;
					// [(call TFAR_fnc_activeLrRadio), (call TFAR_fnc_activeLrRadio) call TFAR_fnc_getSwSettings, 5] call TFAR_fnc_setLrVolume;
					// "TFAR_anprc152_1" call TFAR_fnc_getSwSettings
					// _activeRadio = (call TFAR_fnc_activeSwRadio);
					// _activeSettings = _activeRadio call TFAR_fnc_getSwSettings;
					// [_activeRadio, _activeRadio call TFAR_fnc_getSwSettings, 5] call TFAR_fnc_setSwVolume;
				};

				if (call TFAR_fnc_haveSWRadio) then 
				{
					// SW radio - channel 1
					_mainFrequency =  (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
					player setVariable ["RPG_TFAR_SW_FREQ", _mainFrequency];
					[(call TFAR_fnc_activeSwRadio), 1, str (floor (random 50+40))] call TFAR_fnc_SetChannelFrequency;
					[(call TFAR_fnc_activeSwRadio), 2, str (floor (random 50+40))] call TFAR_fnc_SetChannelFrequency;
					// _volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;
					// player setVariable ["RPG_TFAR_SW_RADIO_VOL", _volume];
					// [(call TFAR_fnc_activeSwRadio), 0] call TFAR_fnc_setSwVolume;
				};
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

				if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then 
				{

					if (call TFAR_fnc_haveLRRadio) then 
					{
						// _volume = player getVariable ["RPG_TFAR_LR_RADIO_VOL", 10];
						// [(call TFAR_fnc_activeLrRadio), _volume] call TFAR_fnc_setLrVolume;
						
						_mainFrequency = player getVariable ["RPG_TFAR_LR_FREQ", 0];
						[(call TFAR_fnc_activeLrRadio), 1, str _mainFrequency] call TFAR_fnc_SetChannelFrequency;

					};

					if (call TFAR_fnc_haveSWRadio) then 
					{
						// _volume = player getVariable ["RPG_TFAR_SW_RADIO_VOL", 10];
						// [(call TFAR_fnc_ActiveSWRadio), _volume] call TFAR_fnc_setSwVolume;

						_mainFrequency = player getVariable ["RPG_TFAR_SW_FREQ", 0];
						[(call TFAR_fnc_activeSwRadio), 1, str _mainFrequency] call TFAR_fnc_SetChannelFrequency;
					};
				};
			};			
		};
	};
};

