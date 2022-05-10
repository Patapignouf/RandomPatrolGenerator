// ask civilian for intel
_civs = allUnits select {alive _x AND side _x isEqualTo civilian};

{
	_x linkItem "ItemRadio"; //so they can "talk" if they're editor placed civilian units

	_ID = _x addAction ["Talk to civilian",{

		params ["_object","_caller","_ID","_civs"];
		_reveal = (missionNamespace getVariable ["TAG_fnc_civsAsked",0]) >= 3;//will return true on the third unit
		if (_reveal) exitWith {
			[1,["Fine ! I'll show you something, look on your map !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
			_revealedObjectives = missionNamespace getVariable ["revealedObjectives",[]];
			_tempMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
			if ((count _revealedObjectives != count _tempMissionObjectives) && side _caller != independent) then
			{
				//Check if there are independent avalaible
				if ({isPlayer _x && side _x == independent} count allUnits == 0) then
				{
					_tempMissionObjectives = _tempMissionObjectives - _revealedObjectives;
					_objectiveToReveal = selectRandom _tempMissionObjectives;
					_revealedObjectives pushBack _objectiveToReveal;
					missionNamespace setVariable ["revealedObjectives",_revealedObjectives,true];
					[[_objectiveToReveal, getPos (_objectiveToReveal select 0), side _caller], 'objectGenerator\doGeneratePOIMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
				} else
				{
					_groupToReveal = selectRandom (allGroups select  {side _x == opfor});
					[["Enemy spotted","ColorRed","hd_warning",getPos (leader _groupToReveal), side _caller], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];	
				};
			} else 
			{
					_groupToReveal = selectRandom (allGroups select  {side _x == opfor});
					[["Enemy spotted","ColorRed","hd_warning",getPos (leader _groupToReveal), side _caller], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];	
			};
			missionNamespace setVariable ["TAG_fnc_civsAsked",(round random 1),true];
			//remove all actions from the remaining civs | Not necessary for the moment
			// {
			// 	_x removeAction (_x getVariable ["TAG_fnc_revealActionID",-1]);
			// } forEach _civs;
			_object removeAction _ID;
		};
	_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !","Get out of this area !"];
	[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
	_counter = missionNamespace getVariable ["TAG_fnc_civsAsked",0];
	_counter = _counter + 1;
	missionNamespace setVariable ["TAG_fnc_civsAsked",_counter,true];
	//_object removeAction _ID;
	[_object] remoteExec [ "RemoveAllActions", 0, true ];
	},_civs,1.5,true,true,"","_target distance _this <5"];

	_x setVariable ["TAG_fnc_revealActionID",_ID];

} forEach _civs;