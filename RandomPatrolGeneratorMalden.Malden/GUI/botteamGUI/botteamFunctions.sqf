//botteamFunctions.sqf 
#include "..\..\database\arsenalLibrary.sqf"

doAddBot = {
params ["_caller", "_currentFaction", "_botteamClass", "_botteamType"];
	botResult = objNull;
	switch (_botteamType) do
	{
		case "Infantry":
		{
			//Spawn random unit
			_customPos = [];
			
			//Determine if the player is on FOB/USS or Advance FOB
			if ((initBlueforLocation distance (getPos _caller)) < 150) then 
			{
				//Define good position on blufor spawn 
				if (isNil "USS_FREEDOM_CARRIER") then 
				{
					//Custom spawn on ground outside the FOB
					_customPos = (position _caller) findEmptyPosition [20, 150, "Land_HelipadCircle_F"];
				} else 
				{
					//Custom spawn on carrier
					_customPos = getPosASL _caller;
				};
			} else 
			{
				//Define a good position on advance fob 
				_customPos = (position _caller) findEmptyPosition [2, 100];
			};

			private _botUnit = (createGroup (side _caller)) createUnit ["B_Soldier_F", _customPos, [], 0, "NONE"];
			
			//Add teamkilled XP penalty event
			_botUnit addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				diag_log format ["%1 has been killed by : %2", name _unit, name _instigator];
				if (isPlayer _instigator) then 
				{
					// [[format ["%1 has been killed by his teammate %2",name _unit, name _instigator], "teamkill"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', side _instigator];
					_textToSpeech = format ["%1 has been killed by his teammate %2, watch your fire",name _unit, name _instigator];
					[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", side _instigator, true];
					
					if (_instigator != _unit) then 
					{
						[[-50,5], 'engine\rankManagement\rankPenalty.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
					};
				};
			}];

			//Get custom stuff 
			_listOfAvalaibleRole =[];
			_listOfAvalaibleRole = [_currentFaction] call setupRoleSwitchToList;
			
			//hint format ["_currentFaction %1\n _botteamClass %2",_currentFaction, _botteamClass];

			if (_botteamClass == "random") then 
			{
				_botteamClass = (selectRandom ((loadout_db select {_x #1 == _currentFaction}) #0 #0)) #0;
			};

			_stuffToApply = ((loadout_db select {_x select 1 == _currentFaction}) select 0 select 0) select {_x select 0 == _botteamClass} select 0 select 1;
			[_botUnit, _botUnit, _currentFaction , _botteamClass, false, true] call switchToRole;
			//[TODO] Add ACE adjust stuff

			//apply custom stuff 
			_botUnit setUnitLoadout _stuffToApply;

			botResult = _botUnit;

			//Notify player
			//sleep 1;
			
		};
		default
		{
			//Do nothing
		};
	};
	botResult;
};


addInfantryBots = {
	params ["_ctrl"];

	//get list of avalaible role for player's faction
	_listOfAvalaibleRole =[];
	if (player getVariable "sideBeforeDeath" == "independent") then 
	{
		//Independent
		_listOfAvalaibleRole = [indFaction] call setupRoleSwitchToList;

	} else 
	{
		//Blufor
		_listOfAvalaibleRole = [bluFaction] call setupRoleSwitchToList;
	};

	//Load every class for current player's faction
	//Define list of role in the combo box
	{
		//Add infantry
		_price = 50;
		_supportName = _x;
		_supportNameCode = _x;
		_supportIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
		_supportType = "Infantry";

		[_ctrl, _supportName, _supportNameCode, _supportIcon, _price, _supportType] call addBotteamOption;

	} foreach _listOfAvalaibleRole;
};

addBotteamOption = {
	params ["_ctrl", "_supportName", "_supportNameCode", "_supportIcon", "_price", "_supportType"];

	//Add row for support
	_ind = _ctrl lnbAddRow ["", _supportName, _supportType, str _price];

	//Set picture
	_ctrl lnbSetPicture [[_ind, 0], _supportIcon];

	//Set data
	_ctrl lnbSetData [[_ind, 0], _supportNameCode];
	_ctrl lnbSetData [[_ind, 1], _supportType];
	_ctrl lnbSetData [[_ind, 2], str _price];
};