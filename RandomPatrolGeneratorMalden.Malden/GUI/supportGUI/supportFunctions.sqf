//supportFunctions.sqf 

doSupport = {
params ["_caller", "_supportType"];
	switch (_supportType) do
	{
		case "ReconIntel":
		{
			[[_caller, "HQ"], 'engine\objectiveManagement\revealMinorIntel.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
		};
		case "Reinforcement":
		{
			[_caller] spawn 
			{
				params ["_caller"];
				if (!(missionNamespace getVariable ["usedRespawnFewTimeAgo",false])) then 
				{
					//set morning
					skipTime 24;
					[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];

					//Send message to everyone
					_textToSpeech = format ["Copy %1, we send you some reinforcement",  name _caller];
					[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, name _caller], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", 0, true];
					
					missionNamespace setVariable ["usedRespawnFewTimeAgo",true,true];
					sleep 1200;
					missionNamespace setVariable ["usedRespawnFewTimeAgo",false,true];
				} else {
					_textToSpeech = "You must wait before call reinforcements";
					[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", _caller, true];
				};
			};
		};
		case "ForceReinforcement":
		{
			[_caller] spawn 
			{
				params ["_caller"];
				//set morning
				skipTime 24;

				_textToSpeech = format ["Copy %1, we send you some help quickly",  name _caller];
				[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, name _caller], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", side _caller, true];

				[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
				[format ["%1 needs reinforcement", name _caller]] remoteExec ["hint",0,true];
			};
		};
		case "Artillery":
		{
			_textToSpeech = "Artillery unit 1789, ready to fire";
			[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, name _caller], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", side _caller, true];

			_supportArtilleryCounter = missionNamespace getVariable ["artlillerySupportCounter", 0]; 
			missionNamespace setVariable ["artlillerySupportCounter", _supportArtilleryCounter+1, true];

			//Manage radio support 
			_artillerySupportID = _caller getVariable ["artillerySupportID", -1];

			if (_artillerySupportID == -1) then 
			{
				_artillerySupportID = [_caller, "myArtillery"] call BIS_fnc_addCommMenuItem;
				_caller setVariable ["artillerySupportID", _artillerySupportID, true];
			};
		};
		case "Extract":
		{
			_textToSpeech = "Helicopter unit 1515, ready for extract";
			[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, name _caller], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", side _caller, true];

			_supportextractCounter = missionNamespace getVariable ["extractSupportCounter", 0]; 
			missionNamespace setVariable ["extractSupportCounter", _supportextractCounter+1, true];

			//Manage radio support 
			_extractSupportID = _caller getVariable ["extractSupportID", -1];
			if (_extractSupportID == -1) then 
			{
				_extractSupportID = [_caller, "myExtract"] call BIS_fnc_addCommMenuItem;
				_caller setVariable ["extractSupportID", _extractSupportID, true];
			};
		};
		case "AirDrop":
		{
			_textToSpeech = "Logistic unit 1804, ready for air supply";
			[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech, name _caller], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", side _caller, true];

			_supportairDropCounter = missionNamespace getVariable ["airDropSupportCounter", 0]; 
			missionNamespace setVariable ["airDropSupportCounter", _supportairDropCounter+1, true];


			//Manage radio support 
			_airDropSupportID = _caller getVariable ["airDropSupportID", -1];
			if (_airDropSupportID == -1) then 
			{
				_airDropSupportID = [_caller, "myAirDrop"] call BIS_fnc_addCommMenuItem;
				_caller setVariable ["airDropSupportID", _airDropSupportID, true];
			};
		};
		case "HALOJump":
		{
			[_caller] spawn {
				params ["_caller"];
				//Click on map to Halo spawn
				selectedHaloLoc = [0,0,0];
				openMap true;
				uiSleep 1;
				["<t color='#ffffff' size='.8'>Click on map to spawn Halo jump<br />Your backpack will be saved</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					_caller setPos selectedHaloLoc;
					[_caller,1500] call BIS_fnc_halo;
					[format ["In the %1 airspace", worldName], format ["Year %1", date select 0], mapGridPosition player] spawn BIS_fnc_infoText;
				};
			};

			//Close support menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
		};
		case "DroneRecon":
		{
			[_caller] spawn {
				params ["_caller"];
				//Click on map to Halo spawn
				selectedHaloLoc = [0,0,0];
				openMap true;
				uiSleep 1;
				["<t color='#ffffff' size='.8'>Click on map to recon with a drone<br /></t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
				onMapSingleClick "selectedHaloLoc = _pos; onMapSingleClick ''; openMap false; true;";
				waitUntil{!(visibleMap)};  
				if (!([selectedHaloLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
				{
					
					private _savingEnabled = savingEnabled;
					_handle = [selectedHaloLoc, "", 250, 250, 75, 1, [], 0, true] spawn BIS_fnc_establishingShot;
					[_handle, _savingEnabled] spawn { 
						params ["_process", "_savingMode"];
						waitUntil { scriptDone _process }; 
						enableSaving [_savingMode, false];
						hint "Find script";
					 };
				};
			};

			//Close support menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
		};
		default
		{
			//Do nothing
		};
	};
};

addSupportOption = {
	params ["_ctrl", "_supportName", "_supportNameCode", "_supportIcon", "_price", "_supportType"];

	//Add row for support
	_ind = _ctrl lnbAddRow ["", _supportName, _supportType, str _price];

	//Set picture
	_ctrl lnbSetPicture [[_ind, 0], _supportIcon];

	//Set data
	_ctrl lnbSetData [[_ind, 0], _supportNameCode];
	_ctrl lnbSetData [[_ind, 1], _supportNameCode];
	_ctrl lnbSetData [[_ind, 2], str _price];
};


addSupportForIntel = {
	params ["_ctrl"];
	//Add support for INTEL
	_price = 25;
	_supportName = "Recon for intel";
	_supportNameCode = "ReconIntel";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Recon";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForReinforcement = {
	params ["_ctrl"];
	//Add support for INTEL
	_price = 0;
	_supportName = "Call reinforcement (every 20 mins)";
	_supportNameCode = "Reinforcement";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Reinforcement";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForForceReinforcement = {
	params ["_ctrl"];
	//Add support for INTEL
	_price = 500;
	_supportName = "Force reinforcement";
	_supportNameCode = "ForceReinforcement";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Reinforcement";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForArtillery = {
	params ["_ctrl"];
	//Add support for INTEL
	_price = 200;
	_supportName = "Artillery (radio)";
	_supportNameCode = "Artillery";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa";
	_supportType = "Artillery";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForHALO = {
	params ["_ctrl"];
	//Add support for INTEL
	_price = 0;
	_supportName = "Halo Jump";
	_supportNameCode = "HALOJump";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa";
	_supportType = "Movement";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForExtract = {
	params ["_ctrl"];
	//Add support for INTEL
	_price = 200;
	_supportName = "Extract helicopter (radio)";
	_supportNameCode = "Extract";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
	_supportType = "Movement";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};

addSupportForAirDrop = {
	params ["_ctrl"];
	//Add support for Air drop
	_price = 200;
	_supportName = "Logistic supply drop (radio)";
	_supportNameCode = "AirDrop";
	_supportIcon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa";
	_supportType = "Logistic";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};


addSupportForDroneRecon = {
	params ["_ctrl"];
	//Add support for Air drop
	_price = 100;
	_supportName = "Send drone for recon";
	_supportNameCode = "DroneRecon";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Recon";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addSupportOption;
};