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
					[{["STR_RPG_HC_NAME", "STR_RPG_HC_TEAMKILL", name _unit, name _instigator] call doDialog}] remoteExec ["call", side _instigator];
					
					if (_instigator != _unit) then 
					{
						[{[-50,5] call doUpdateRankWithPenalty}] remoteExec ["call", _instigator];
					};
				};

				//Garbage collect unit  
				[_unit] spawn 
				{
					params ["_unit"];
					//Fix ACE locking place in vehicle when an IA dies
					sleep 20;
					moveOut _unit;

					//Free some memory usage by cleaning the corpse
					sleep 300;
					deleteVehicle _unit;
				};
			}];

			//Get custom stuff 
			_listOfAvalaibleRole =[];
			_listOfAvalaibleRole = [_currentFaction] call setupRoleSwitchToList;
			
			//hint format ["_currentFaction %1\n _botteamClass %2",_currentFaction, _botteamClass];

			if (_botteamClass == "random") then 
			{
				_botteamClass = (selectRandom (((loadout_db select {_x #1 == _currentFaction}) #0 #0) select {_x#0 != "pilot" })) #0;
			};

			_stuffToApply = ((loadout_db select {_x select 1 == _currentFaction}) select 0 select 0) select {_x select 0 == _botteamClass} select 0 select 1;
			[_botUnit, _botUnit, _currentFaction , _botteamClass, false, true] call switchToRole;
			//[TODO] Add ACE adjust stuff

			//apply custom stuff 
			_botUnit setUnitLoadout _stuffToApply;

			botResult = _botUnit;			
		};
		default
		{
			//Do nothing
		};
	};
	botResult;
};

doSpawnAttackSquad = {
	params ["_caller", "_locationToAttack", "_side"];

	_AvalaibleInitAttackPositionsToMove = [_locationToAttack, 800, 1300, 1] call getPositionAroundTargetNoSafeZone;
	_attackSquad = createGroup (_side);

	for [{_i = 0}, {_i < 4}, {_i = _i + 1}] do
	{
		//Spawn bot
		_currentFaction = 0;
		if (side _caller == independent) then 
		{
			//Independent
			_currentFaction = indFaction;

		} else 
		{
			//Blufor
			_currentFaction = bluFaction;
		};


		private _bot = [_caller, _currentFaction, "random", "Infantry"] call doAddBot;

		//If successfull bot spawn
		if (!isNull _bot) then 
		{
			[_bot] joinSilent _attackSquad; 

			//Move bot near attack position  
			_bot setPos ([_AvalaibleInitAttackPositionsToMove, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		};
	};

	// ask squad to attack position 
	[_attackSquad, _locationToAttack] call doAttack;
	_attackSquad
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