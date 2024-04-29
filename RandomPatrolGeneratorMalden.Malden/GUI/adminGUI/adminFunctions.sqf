//adminFunctions.sqf 

doAdminStuff = {
params ["_supportType"];
	switch (_supportType) do
	{
		case "Increasedifficulty":
		{
			_actualDifficulty = missionNamespace getVariable "missionDifficultyParam";
			missionNamespace setVariable ["missionDifficultyParam", _actualDifficulty+1, true];
			[[format ["OPFOR has increased its presence in the area"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', 0];

			[[format ["OPFOR has reduced its presence in the area"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
		case "Decreasedifficulty":
		{
			_actualDifficulty = missionNamespace getVariable "missionDifficultyParam";
			missionNamespace setVariable ["missionDifficultyParam", _actualDifficulty-1, true];
			[[format ["OPFOR has reduced its presence in the area"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
		case "ImmediateRespawn":
		{
			[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
		};
		case "VehicleShop":
		{
			//Close admin menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
			[[], 'GUI\vehicleSpawnerGUI\vehicleSpawner.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
		case "SupportShop":
		{
			//Close admin menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;
			[[], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
		case "ClearWeather":
		{
			//Close admin menu
			_mainDisplay = (findDisplay 60000);
			_mainDisplay closeDisplay 1;

			//Clear weather without transition
			0 setOvercast 0;
			0 setRain 0;
			forceWeatherChange;

			hint "Weather cleared";
		};
		case "AddCredit":
		{
			[] call doIncrementVehicleSpawnCounter; 
		};
		default
		{
			//Do nothing
		};
	};
};

addSupportOption = {
	params ["_ctrl", "_supportName", "_supportNameCode", "_supportIcon", "_supportType"];

	//Add row for support
	_ind = _ctrl lnbAddRow ["", _supportName, _supportType];

	//Set picture
	_ctrl lnbSetPicture [[_ind, 0], _supportIcon];

	//Set data
	_ctrl lnbSetData [[_ind, 0], _supportNameCode];
	_ctrl lnbSetData [[_ind, 1], _supportNameCode];
};


addDifficultyIncrease = {
	params ["_ctrl"];

	_supportName = "Increase difficulty";
	_supportNameCode = "Increasedifficulty";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Difficulty";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _supportType] call addSupportOption;
};

addDifficultyDecrease = {
	params ["_ctrl"];

	_supportName = "Decrease difficulty";
	_supportNameCode = "Decreasedifficulty";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Difficulty";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _supportType] call addSupportOption;
};

addRespawn = {
	params ["_ctrl"];

	_supportName = "Immediate respawn";
	_supportNameCode = "ImmediateRespawn";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Respawn";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _supportType] call addSupportOption;
};

addVehicleSpawnerGUI = {
	params ["_ctrl"];

	_supportName = "Open Vehicle Shop";
	_supportNameCode = "VehicleShop";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Vehicle";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _supportType] call addSupportOption;
};

addSupportGUI = {
	params ["_ctrl"];

	_supportName = "Open Support Shop";
	_supportNameCode = "SupportShop";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Support";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _supportType] call addSupportOption;
};

addCredit = {
	params ["_ctrl"];

	_supportName = "Add 1000 credits";
	_supportNameCode = "AddCredit";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Credit";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _supportType] call addSupportOption;
};

addClearWeather = {
	params ["_ctrl"];

	_supportName = "Clear weather";
	_supportNameCode = "ClearWeather";
	_supportIcon = "\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa";
	_supportType = "Weather";

	[_ctrl, _supportName, _supportNameCode, _supportIcon, _supportType] call addSupportOption;
};