// ask civilian for intel
_civs = allUnits select {alive _x AND side _x isEqualTo civilian};


{
	_x linkItem "ItemRadio"; //so they can "talk" if they're editor placed civilian units

	_ID = _x addAction ["Talk to civilian",{

		params ["_object","_caller","_ID","_civs"];
		_reveal = (missionNamespace getVariable ["TAG_fnc_civsAsked",0]) >= 1;//will return true on the third unit
		if (_reveal) exitWith {
			[_caller] execVM 'engine\askCivilianIntel.sqf';
			missionNamespace setVariable ["TAG_fnc_civsAsked",(round random 1),true];
			[_object,_ID] remoteExec [ "removeAction", 0, true ];
		};
		
		//Case no intel given
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !","Get out of this area !"];
		[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
		_counter = missionNamespace getVariable ["TAG_fnc_civsAsked",0];
		_counter = _counter + 1;
		missionNamespace setVariable ["TAG_fnc_civsAsked",_counter,true];
		[_object,_ID] remoteExec [ "removeAction", 0, true ];
	},_civs,1.5,true,true,"","_target distance _this <5"];
	_x setVariable ["TAG_fnc_revealActionID",_ID]; //Can be used to remove all talk actions
} forEach _civs;