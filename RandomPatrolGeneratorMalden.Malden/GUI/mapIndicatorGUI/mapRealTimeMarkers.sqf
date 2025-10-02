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
	_listOfJammedArea = missionNameSpace getVariable ["jammedArea", []];

	_resultUnits = [];

	if ([_unitToCheck, _listOfJammedArea] call isInJammedArea) then 
	{
		//["Vous êtes entré dans une zone interdite."] remoteExec ["hint", _unitToCheck];
		//cutText ["<t color='#ff0000' size='2'>GPS Jammed</t><br/>***********", "PLAIN DOWN", 0.5, false, true];
		// ["<t color='#ffffff' size='.8'>GPS Jammed</t>",0,0,4,1,0,789] spawn BIS_fnc_dynamicText;
		// systemChat "GPS Jammed";
		[0] call ace_microdagr_fnc_openDisplay;
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
