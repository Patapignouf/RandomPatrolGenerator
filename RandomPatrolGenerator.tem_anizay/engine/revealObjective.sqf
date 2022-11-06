params ["_caller","_objectiveToRevealSelected", "_side"];

_revealedObjectives = missionNamespace getVariable ["revealedObjectives",[]];
_tempMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
_revealedMissionEnemyInfo = missionNamespace getVariable ["revealedMissionEnemyInfo",[]];
_MissionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];
_realismMode = "RealismMode" call BIS_fnc_getParamValue;

if ((count _revealedObjectives != count _tempMissionObjectives)) then
{
		_objectiveToReveal = objNull;

		if (count _objectiveToRevealSelected == 0) then 
		{
			_tempMissionObjectives = _tempMissionObjectives - _revealedObjectives;
			_objectiveToReveal = selectRandom _tempMissionObjectives;
			_revealedObjectives pushBack _objectiveToReveal;
			missionNamespace setVariable ["revealedObjectives",_revealedObjectives,true];
		} else 
		{
			_objectiveToReveal = _objectiveToRevealSelected;
		};
		if (_realismMode == 1) then 
		{
			//Search the nearestLocation from the intel
			_thisObject = _objectiveToReveal select 0;
			_nearestLoc = nearestLocations [getPos (_thisObject), ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
			_currentObjectiveDescription = "";

			//Display custom dialogs according to the enemy position
			switch (_objectiveToReveal select 1) do
				{
					case "supply":
						{	
							_currentObjectiveDescription = format ["There's %1 near %2. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Supply case", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
						};
					case "ammo":
						{
							_currentObjectiveDescription = format ["There's %1 near %2. Can you bring it to %3 or destroy it...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Ammo cache", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
						};
					case "hvt":
						{
							_currentObjectiveDescription = format ["There's an enemy %1 near %2. You have to kill him...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "HVT", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
						};
					case "vip":
						{
							_currentObjectiveDescription = format ["I have a friend who's captured near %2. He looks like %1. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "VIP", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
						};
					case "steal":
						{
							_currentObjectiveDescription = format ["Some people stole our vehicle %1. I think it's located in %2. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc, text initCityLocation];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Steal vehicle", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
						};
					case "informant":
						{
							_currentObjectiveDescription = format ["I have a friend who lives near %2. He looks like %1. Can you talk to him...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Talk to the informant", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
						};
					case "clearArea":
						{
							_currentObjectiveDescription = format ["There is a lot of enemies in %1, you have to clear the location...", text _nearestLoc];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Clear area", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
						};
					case "collectIntel":
						{
							_currentObjectiveDescription = format ["I drop my %1 with a lot of intel about enemy's location in %2. Can you pick it up ?", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),text _nearestLoc];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Collect intel", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
						};
					default { hint "default" };
				};

				//Display dialog on screen if necessary
				if (!isNil "_caller") then 
				{
					[1,[_currentObjectiveDescription, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
				};
		};
};
	