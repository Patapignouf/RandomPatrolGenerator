// ask civilian for intel
_civs = allUnits select {alive _x AND side _x isEqualTo civilian};


{
	_x linkItem "ItemRadio"; //so they can "talk" if they're editor placed civilian units

	_ID = _x addAction ["Talk to civilian",{

		params ["_object","_caller","_ID","_civs"];
		_reveal = (missionNamespace getVariable ["TAG_fnc_civsAsked",0]) >= 2;//will return true on the third unit
		if (_reveal) exitWith {
			//Case intel given to player
			_revealedObjectives = missionNamespace getVariable ["revealedObjectives",[]];
			_tempMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
			_revealedMissionEnemyInfo = missionNamespace getVariable ["revealedMissionEnemyInfo",[]];
			_MissionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];
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
									_currentObjectiveDescription = format ["There's %1 near %2. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation];
									[1,[_currentObjectiveDescription, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
									[blufor, format ["task%1",random 1000], [_currentObjectiveDescription, "Supply case", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
								};
							case "ammo":
								{
									_currentObjectiveDescription = format ["There's %1 near %2. Can you bring it to %3 or destroy it...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation];
									[1,[_currentObjectiveDescription, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
									[blufor, format ["task%1",random 1000], [_currentObjectiveDescription, "Ammo cache", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
								};
							case "hvt":
								{
									_currentObjectiveDescription = format ["There's an enemy %1 near %2. You have to kill him...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc];
									[1,[_currentObjectiveDescription, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
									[blufor, format ["task%1",random 1000], [_currentObjectiveDescription, "HVT", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
								};
							case "vip":
								{
									_currentObjectiveDescription = format ["I have a friend who's captured near %2. He looks like %1. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation];
									[1,[_currentObjectiveDescription, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
									[blufor, format ["task%1",random 1000], [_currentObjectiveDescription, "VIP", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
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
					
					_potentialMissionEnemyInfo = _MissionEnemyInfo - _revealedMissionEnemyInfo;
					_infoToReveal = selectRandom _potentialMissionEnemyInfo;
					_revealedMissionEnemyInfo pushBack _infoToReveal;
					missionNamespace setVariable ["revealedMissionEnemyInfo",_revealedMissionEnemyInfo,true];
					_infoName = _infoToReveal select 0;
					_infoPos = _infoToReveal select 1;
					_nearestCity = nearestLocations [_infoPos, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
					if (_realismMode == 1) then 
					{
						switch (_infoName) do 
						{
							case "Mortar":
							{
								[1,[format ["This morning i saw a mortar position near %1. I don't know if they are there for you, be careful.",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
							case "Patrol":
							{
								[1,[format ["I've heard there's soldiers patrolling around %1.",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
							case "Cars":
							{
								[1,[format ["I saw an unknown car leaving here for %1 this morning...",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
							case "LightArmored";
							case "HeavyArmored":
							{
								[1,[format ["I've heard there's military vehicles next to %1. They seem to prepare an attack.",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};

							case "DefenseInfantry":
							{
								[1,[format ["I know there's'soldiers defending %1, this location seems dangerous",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
							case "Civilian":
							{
								[1,[format ["Be careful, there are civilian in %1. Watch your fire...",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
						};
					} else 
					{ 
						_groupToReveal = selectRandom (allGroups select  {side _x == opfor});
						//Add marker to player's map and display dialogs on screen
						[1,["Fine ! I'll show you something, look on your map !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
						[["Enemy spotted","ColorRed","hd_warning",getPos (leader _groupToReveal), side _caller], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
					};
				};
			} else 
			{
				//Same code here, needs to be factorize
					_potentialMissionEnemyInfo = _MissionEnemyInfo - _revealedMissionEnemyInfo;
					_infoToReveal = selectRandom _potentialMissionEnemyInfo;
					_revealedMissionEnemyInfo pushBack _infoToReveal;
					missionNamespace setVariable ["revealedMissionEnemyInfo",_revealedMissionEnemyInfo,true];
					_infoName = _infoToReveal select 0;
					_infoPos = _infoToReveal select 1;
					_nearestCity = nearestLocations [_infoPos, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
					if (_realismMode == 1) then 
					{
						switch (_infoName) do 
						{
							case "Mortar":
							{
								[1,[format ["This morning i saw a mortar position near %1. I don't know if they are there for you, be careful.",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
							case "Patrol":
							{
								[1,[format ["I've heard there's soldiers patrolling around %1.",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
							case "Cars":
							{
								[1,[format ["I saw an unknown car leaving here for %1 this morning...",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
							case "LightArmored";
							case "HeavyArmored":
							{
								[1,[format ["I've heard there's military vehicles next to %1. They seem to prepare an attack.",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};

							case "DefenseInfantry":
							{
								[1,[format ["I know there's'soldiers defending %1, this location seems dangerous",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
							case "Civilian":
							{
								[1,[format ["Be careful, there are civilian in %1. Watch your fire...",text _nearestCity], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
							};
						};
					} else 
					{ 
						_groupToReveal = selectRandom (allGroups select  {side _x == opfor});
						//Add marker to player's map and display dialogs on screen
						[1,["Fine ! I'll show you something, look on your map !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
						[["Enemy spotted","ColorRed","hd_warning",getPos (leader _groupToReveal), side _caller], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
					};
				};

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