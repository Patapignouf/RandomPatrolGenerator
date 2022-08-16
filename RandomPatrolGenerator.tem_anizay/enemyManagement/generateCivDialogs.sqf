// ask civilian for intel
_civs = allUnits select {alive _x AND side _x isEqualTo civilian};


{
	_x linkItem "ItemRadio"; //so they can "talk" if they're editor placed civilian units


	//Add action to ask civilian for intel
	_ID = _x addAction ["Talk to civilian",{

		params ["_object","_caller","_ID","_civ"];
		_reveal = (missionNamespace getVariable ["TAG_fnc_civsAsked",0]) >= 1;//will return true on the third unit
		if (_reveal) exitWith {
			[_caller] execVM 'engine\askCivilianIntel.sqf';
			missionNamespace setVariable ["TAG_fnc_civsAsked",(round random 1),true];
			[_object,_ID] remoteExec [ "removeAction", 0, true ];
		};
		
		//Case no intel given
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
		_counter = missionNamespace getVariable ["TAG_fnc_civsAsked",0];
		_counter = _counter + 1;
		missionNamespace setVariable ["TAG_fnc_civsAsked",_counter,true];
		[_object,_ID] remoteExec [ "removeAction", 0, true ];
	},_x,1.5,true,true,"","_target distance _this <5"];
	_x setVariable ["TAG_fnc_revealActionID",_ID]; //Can be used to remove all talk actions


	//Add action to ask civilian to join player team
	_ID = _x addAction ["Ask civilian to join your team",{

		params ["_object","_caller","_ID","_civ"];
		_civJoinableFaction = "CivJoinableFaction" call BIS_fnc_getParamValue;
		_hasToJoin = false;
		switch (_civJoinableFaction) do
		{
			case 1:
				{
					_hasToJoin = (side player == independent);
				};
			case 2:
				{
					_hasToJoin = (side player == blufor);
				};
			case 3:
				{
					_hasToJoin = true;
				};
			default
				{
					//
				};
		};
		if (_hasToJoin) then 
		{
			[1,["Ok let's go !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
			[_civ] joinSilent (group player);	//Civ join player squad
			_civ addWeapon ((weapons player) select 0); //Give to civ the same weapon as player
			for "_i" from 0 to 7 do { _civ addItem (currentMagazine _civ); };	//Give civ some ammunitions
		} else 
		{
			_randomAnswers = ["Oh please leave me alone !","I don't trust you !"];
			[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
		};

		[_object,_ID] remoteExec [ "removeAction", 0, true ];
	},_x,1.5,true,true,"","_target distance _this <5"];
	_x setVariable ["TAG_fnc_joinActionID",_ID]; //Can be used to remove all talk actions


} forEach _civs;