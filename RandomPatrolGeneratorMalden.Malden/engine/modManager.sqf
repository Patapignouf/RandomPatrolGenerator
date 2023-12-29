modToCheck = [
	["task_force_radio", "MOD_TFAR", "Task Force Radio"],
	["ace_common", "MOD_ACE", "[ACE] Advanced Combat Environment"],
	["CUP_BaseData", "MOD_CUP", "[CUP] Cummunity Upgrade Project"],
	["IFA3_Core", "MOD_IFA3", "IFA3 Iron Front"],
	["uns_main", "MOD_UNSUNG", "UNSUNG"],
	["AMF_Patches", "MOD_AMF", "AMF"]
];

doCheckRunningModsOnServer = {

	//Check mods on the server
	{
		if (isClass (configFile >> "CfgPatches" >> _x#0)) then {
			missionNamespace setVariable [_x#1, true, true];
		};
	} foreach modToCheck;
	if (gettext ( configfile >> "CfgSurfaces" >> "arm_rock" >> "RTTYPE") != "") then 
	{
		missionNamespace setVariable ["RealisticDriving", true, true];
	}
};

doDisplayModsAlert = {
	params ["_modNotPresent"];

	//Display alert if there is one mod needed not present
	if (count _modNotPresent != 0) then 
	{
		_modsCheckToDisplay = "";
		{
			_currentNotPresentMod = _x;
			{
				if ([_x#1, _currentNotPresentMod] call BIS_fnc_areEqual) then {
					_modsCheckToDisplay = format ["%1<br />%2", _modsCheckToDisplay, format ["MOD : %1",_x#2]];
				};
			} foreach modToCheck;
		} foreach _modNotPresent;
		[format ["<t color='#ff0000' size='1.5'>Needed mods :</t><t color='#ff0000' size='0.8'><br />%1</t>", _modsCheckToDisplay],0,0,10,1,0,789] call BIS_fnc_dynamicText;
	};
};

doCheckRunningModsOnClient = {

	//Check every server mod on the client
	_modNotPresent = [];
	{
		if (missionNamespace getVariable [_x#1, false]) then 
		{
			if (!(isClass (configFile >> "CfgPatches" >> _x#0))) then {
				_modNotPresent pushBack _x#1;
			};
		};
	} foreach modToCheck;
	if (missionNamespace getVariable ["RealisticDriving", false]) then 
	{
		if (gettext ( configfile >> "CfgSurfaces" >> "arm_rock" >> "RTTYPE") == "") then 
		{
			_modNotPresent pushBack "Realistic Driving Terrains";
		};
	};
	[_modNotPresent] call doDisplayModsAlert;
};


