getIconByRole = {
	params ["_roleID"];

	_iconResult = "";
	switch (_roleID) do
		{
			case c_leader:
				{
					_iconResult = "iconManLeader";
				};
			case c_at:
				{
					_iconResult = "iconManAT";
				};
			case c_engineer:
				{
					_iconResult = "iconManEngineer";
				};
			case c_autorifleman:
				{
					_iconResult = "iconManMG";
				};
			case c_medic:
				{
					_iconResult = "iconManMedic";
				};	
			case c_grenadier:
				{
					_iconResult = "iconManExplosive";
				};
			default
				{
					//Non implemented role
					_iconResult = "iconMan";
				};
		};

	_iconResult
};

getIconColor = {
	params ["_currentUnit"];
	_color = [0,0,1,1]; //Base color same group

	if (group _currentUnit != group player) then 
	{
		_color = [0,0,1,0.5]; //Base color different group
	};
	_color
};


getPlayerToDisplay = {
	params ["_unitToCheck"];

	_resultUnits = [];
	_listOfJammedArea = missionNameSpace getVariable ["jammedArea", []];

	if ([_unitToCheck, _listOfJammedArea] call isInJammedArea) then 
	{
		//["Vous êtes entré dans une zone interdite."] remoteExec ["hint", _unitToCheck];
		//cutText ["<t color='#ff0000' size='2'>GPS Jammed</t><br/>***********", "PLAIN DOWN", 0.5, false, true];
		// ["<t color='#ffffff' size='.8'>GPS Jammed</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
		// systemChat "GPS Jammed";
	} else 
	{
		_resultUnitsToCheck = allPlayers select {(side _x == side _unitToCheck) && (lifeState _x != "INCAPACITATED")};
		_nearResult = [];

		{
			if (!([_x, _listOfJammedArea] call isInJammedArea)) then 
			{
				_nearResult pushBack _x;
			};
		} foreach _resultUnitsToCheck;
		_resultUnits = _nearResult;
	};

	_resultUnits
};



//Add map players marker
if (missionNameSpace getVariable "playerMarkerAllowed" == 1) then 
{
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
	{ 
		_role = (_x getVariable "role");
		_this select 0 drawIcon [
			[_role] call getIconByRole, // custom images can also be used: getMissionPath "\myFolder\myIcon.paa"
			[_x] call getIconColor,
			getPosASLVisual _x,
			24,
			24,
			getDirVisual _x,
			format ["%1 (%2)", name _x, [_role] call getClassInformation],
			1,
			0.03,
			"TahomaB",
			"right"
		]
		} foreach ([player] call getPlayerToDisplay);
	}];
};
