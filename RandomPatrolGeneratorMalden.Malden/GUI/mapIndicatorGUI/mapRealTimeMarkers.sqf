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
		} foreach (allPlayers select {(side _x == side player) && (lifeState player != "INCAPACITATED")});
	}];
};
