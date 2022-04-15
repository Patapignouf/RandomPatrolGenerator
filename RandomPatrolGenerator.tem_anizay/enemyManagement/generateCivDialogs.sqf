// ask civilian for intel
_civs = allUnits select {alive _x AND side _x isEqualTo civilian};


{
	_x linkItem "ItemRadio"; //so they can "talk" if they're editor placed civilian units

	_ID = _x addAction ["Talk to civilian",{

		params ["_object","_caller","_ID","_civs"];
		_reveal = (missionNamespace getVariable ["TAG_fnc_civsAsked",0]) >= 3;//will return true on the third unit
		if (_reveal) exitWith {
			_revealedObjectives = missionNamespace getVariable ["revealedObjectives",[]];
			_tempMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
			_realismMode = "RealismMode" call BIS_fnc_getParamValue;
			if ((count _revealedObjectives != count _tempMissionObjectives) && side _caller != independent) then
			{
				//Check if there are independent avalaible
				if ({isPlayer _x && side _x == independent} count allUnits == 0) then
				{
					_tempMissionObjectives = _tempMissionObjectives - _revealedObjectives;
					_objectiveToReveal = selectRandom _tempMissionObjectives;
					_revealedObjectives pushBack _objectiveToReveal;
					missionNamespace setVariable ["revealedObjectives",_revealedObjectives,true];
					if (_realismMode == 1) then 
					{
						//Search the nearestLocation from the intel
						_nearestLoc = nearestLocations [getPos (_objectiveToReveal select 0), ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
						_thisObject = _objectiveToReveal select 0;
						//Display custom dialogs according to the enemy position
						switch (_objectiveToReveal select 1) do
						{
							case "supply":
								{
									[1,[format ["There's %1 near %2. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
								};
							case "ammo":
								{
									[1,[format ["There's %1 near %2. Can you bring it to %3 or destroy it...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
								};
							case "hvt":
								{
									[1,[format ["There's an enemy %1 near %2. You have to kill him...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
								};
							case "vip":
								{
									[1,[format ["I have a friend who's captured near %2. He looks like %1. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
								};
							default { hint "default" };
						};
					} else 
					{ 
						//Add marker to player's map and display dialogs on screen
						[[_objectiveToReveal, getPos (_objectiveToReveal select 0), side _caller], 'objectGenerator\doGeneratePOIMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
						[1,["Fine ! I'll show you something, look on your map !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
					};
				} else
				{
					_groupToReveal = selectRandom (allGroups select  {side _x == opfor});
					if (_realismMode == 1) then 
					{
						//Search the nearestLocation from the intel
						_nearestLoc = nearestLocations [getPos (leader _groupToReveal), ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
						//Display custom dialogs according to the enemy position
						[1,[format ["Oh, there's an %1 near %2. It may interest you...","enemy group",text _nearestLoc], "PLAIN", 0.5]] remoteExec ["cutText", _caller];

					} else 
					{ 
						//Add marker to player's map and display dialogs on screen
						[1,["Fine ! I'll show you something, look on your map !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
						[["Enemy spotted","ColorRed","hd_warning",getPos (leader _groupToReveal), side _caller], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
					};
				};
			} else 
			{
					_groupToReveal = selectRandom (allGroups select  {side _x == opfor});
					if (_realismMode == 1) then 
					{
						//Search the nearestLocation from the intel
						_nearestLoc = nearestLocations [getPos (leader _groupToReveal), ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
						//Display custom dialogs according to the enemy position
						[1,[format ["Oh, there's an %1 near %2. It may interest you...","enemy group",text _nearestLoc], "PLAIN", 0.5]] remoteExec ["cutText", _caller];

					} else 
					{ 
						//Add marker to player's map and display dialogs on screen
						[1,["Fine ! I'll show you something, look on your map !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
						[["Enemy spotted","ColorRed","hd_warning",getPos (leader _groupToReveal), side _caller], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
					};	
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