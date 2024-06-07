modToCheck = [
	["task_force_radio", "MOD_TFAR", "Task Force Radio","CfgPatches"],
	["ace_common", "MOD_ACE", "[ACE] Advanced Combat Environment","CfgPatches"],
	["CUP_BaseData", "MOD_CUP", "[CUP] Community Upgrade Project","CfgPatches"],
	["IFA3_Core", "MOD_IFA3", "IFA3 Iron Front","CfgPatches"],
	["uns_main", "MOD_UNSUNG", "UNSUNG","CfgPatches"],
	["AMF_Patches", "MOD_AMF", "AMF","CfgPatches"],
	["vtf_kf_main", "MOD_KORSAC", "KORSAC TERRAIN","CfgPatches"],
	["rhs_main", "MOD_RHS", "[RHS] RED HAMMER STUDIOS","CfgPatches"],
	["RT", "MOD_RT", "Realistic Driving Terrains","CfgPatches"]
];

doCheckRunningModsOnServer = {

	//Check mods on the server
	{
		if (_x#3 == "CfgPatches") then 
		{
			if (isClass (configFile >> "CfgPatches" >> _x#0)) then {
				missionNamespace setVariable [_x#1, true, true];
			};
		} else 
		{
			//Do nothing
		};
	} foreach modToCheck;
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
					(format ["%2 doesn't have the mod : %1", _x#2, name player]) remoteExec ["systemChat", 0, true]; //Display message to every client
				};
			} foreach modToCheck;
		} foreach _modNotPresent;
		[format ["<t color='#ff0000' size='1.5'>Needed mods :</t><t color='#ff0000' size='0.8'><br />%1</t>", _modsCheckToDisplay],0,0,10,1,0,789] call BIS_fnc_dynamicText;
		sleep 2;
		[] call showDownloadLinks;
	};
};

doCheckRunningModsOnClient = {

	//Check every server mod on the client
	_modNotPresent = [];
	{
		//Check server running mods
		if (missionNamespace getVariable [_x#1, false]) then 
		{	
			//Check standard content mods
			if (_x#3 == "CfgPatches") then 
			{
				if (!(isClass (configFile >> "CfgPatches" >> _x#0))) then {
					_modNotPresent pushBack _x#1;
				};
			} else 
			{
				//Check custom mods
						//Do nothing
			
			};
		};
	} foreach modToCheck;

	//Display alert
	[_modNotPresent] call doDisplayModsAlert;
};

showDownloadLinks = 
{
	_ctrl = findDisplay 46 createDisplay "RscDisplayEmpty" ctrlCreate ["RscStructuredText", -1];
	_ctrl ctrlSetPosition [0,0,1,1];
	_ctrl ctrlCommit 0;
	_ctrl ctrlSetStructuredText parseText "<a color='#ff0000' size='4' href='https://steamcommunity.com/sharedfiles/filedetails/?id=2224111992'><t color='#ff0000'>Download mods needed here !</t></a>";
};
