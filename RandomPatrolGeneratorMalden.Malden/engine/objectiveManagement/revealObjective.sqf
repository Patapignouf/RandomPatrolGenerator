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
			_revealedObjectives pushBack _objectiveToReveal;
			missionNamespace setVariable ["revealedObjectives",_revealedObjectives,true];
		};
		
		if (_realismMode == 1) then 
		{
			//Search the nearestLocation from the intel
			_thisObject = _objectiveToReveal select 0;
			_nearestLocs = nearestLocations [getPos (_thisObject), ["NameLocal","NameVillage","NameCity","NameCityCapital"], 300];

			_objectiveLocationName = "";
			_currentObjectiveDescription = "";

			//Get objective position name
			if (count _nearestLocs == 0) then 
			{
				_objectiveLocationName = mapGridPosition (getPos (_thisObject));
			} else 
			{
				_objectiveLocationName = text (_nearestLocs#0);
			};

			//Get initCityLocationName 
			_initCityLocationLocs = nearestLocations [initCityLocation, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 300];
			_initCityLocationName = mapGridPosition initCityLocation;
			if (count initCityLocationLocs >=1) then 
			{
				_initCityLocationName = text (initCityLocationLocs#0);
			};
			

			//Display custom dialogs according to the enemy position
			switch (_objectiveToReveal select 1) do
				{
					case "supply":
						{	
							_currentObjectiveDescription = format ["There's %1 near %2. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Supply case", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"refuel"] call BIS_fnc_taskSetType;
						};
					case "ammo":
						{
							_currentObjectiveDescription = format ["There's %1 near %2. Can you bring it to %3 or destroy it...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Ammo cache", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"rearm"] call BIS_fnc_taskSetType;
						};
					case "hvt":
						{
							_currentObjectiveDescription = format ["There's an enemy %1 near %2. You have to kill him...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "HVT", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"target"] call BIS_fnc_taskSetType;
						};
					case "vip":
						{
							_currentObjectiveDescription = format ["I have a friend who's captured near %2. He looks like %1. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "VIP", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"talk1"] call BIS_fnc_taskSetType;
						};
					case "hostage":
						{
							_currentObjectiveDescription = format ["I have a spotted the hostage captured near %2. He looks like %1.", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Hostage", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"talk1"] call BIS_fnc_taskSetType;
						};
					case "steal":
						{
							_currentObjectiveDescription = format ["Some people stole our vehicle %1. I think it's located in %2. Can you bring it to %3...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Steal vehicle", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"car"] call BIS_fnc_taskSetType;
						};
					case "informant":
						{
							_currentObjectiveDescription = format ["I have a friend who lives near %2. He looks like %1. Can you talk to him...", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Talk to the informant", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"listen"] call BIS_fnc_taskSetType;
						};
					case "clearArea":
						{
							_currentObjectiveDescription = format ["There is a lot of enemies in %1, you have to clear the location...", _objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Clear area", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"destroy"] call BIS_fnc_taskSetType;
						};
					case "defendArea":
						{
							_currentObjectiveDescription = format ["You have to defend ammobox at %1, go to the location, find it and defend it against enemy reinforcement", _objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Defend area", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"defend"] call BIS_fnc_taskSetType;
						};
					case "takeAndHold":
						{
							_currentObjectiveDescription = format ["There is some enemies in %1, you have to take the location and defend it against enemy reinforcement", _objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Take And Hold", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"upload"] call BIS_fnc_taskSetType;
						};
					case "collectIntel":
						{
							_currentObjectiveDescription = format ["I drop my %1 with a lot of intel about enemy's location in %2. Can you pick it up ?", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Collect intel", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"intel"] call BIS_fnc_taskSetType;
						};
					case "captureFlag":
						{
							_currentObjectiveDescription = format ["You have to capture the flag of the location %2, this place has to be conquered !", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, "Capture the location", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"map"] call BIS_fnc_taskSetType;
						};
					default { 
						//hint "default" 
						};
				};

				//Display dialog on screen if necessary
				if (!isNil "_caller") then 
				{					
					//[1,[_currentObjectiveDescription, "PLAIN", 0.5]] remoteExec ["titleText", _caller];
					[[format ["<t align = 'center' shadow = '2' color='#00ff00' size='1.5' font='PuristaMedium' >Civilian</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _currentObjectiveDescription], "PLAIN", -1, true, true]] remoteExec ["titleText", _caller];
				};
		};
};
	