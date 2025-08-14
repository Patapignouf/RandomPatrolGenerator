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
			_thisObject = _objectiveToReveal#0;
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

			//Give tasks to all players of blufor and independent are enemies
			if ([blufor, independent] call BIS_fnc_sideIsEnemy) then 
			{
				_side = true;
			};

			//Display custom dialogs according to the enemy position
			switch (_objectiveToReveal select 1) do
				{
					case "supply":
						{	
							_currentObjectiveDescription = ["STR_RPG_OBJ_SUPPLY_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_SUPPLY"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"refuel"] call BIS_fnc_taskSetType;
						};
					case "ammo":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_AMMO_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_AMMO"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"rearm"] call BIS_fnc_taskSetType;
						};
					case "bomb":
						{
							_code = _thisObject getVariable "RPG_DefuseCode";
							_currentObjectiveDescription = ["STR_RPG_OBJ_BOMB_TEXT", _code, _objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_BOMB"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"mine"] call BIS_fnc_taskSetType;
						};
					case "hvt":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_HVT_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_HVT"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"target"] call BIS_fnc_taskSetType;
						};
					case "vip":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_VIP_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_VIP"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"talk1"] call BIS_fnc_taskSetType;
						};
					case "hostage":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_HOSTAGE_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_HOSTAGE"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"talk1"] call BIS_fnc_taskSetType;
						};
					case "steal":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_STEAL_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName, _initCityLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_STEAL"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"car"] call BIS_fnc_taskSetType;
						};
					case "informant":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_INFORMANT_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_INFORMANT"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"listen"] call BIS_fnc_taskSetType;
						};
					case "clearArea":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_CLEAR_TEXT", _objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_CLEAR"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"destroy"] call BIS_fnc_taskSetType;
						};
					case "defendArea":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_DEFEND_TEXT", _objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_DEFEND"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"defend"] call BIS_fnc_taskSetType;
						};
					case "takeAndHold":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_TAKE_TEXT", _objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_TAKE"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"upload"] call BIS_fnc_taskSetType;
						};
					case "collectIntel":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_INTEL_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_INTEL"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"intel"] call BIS_fnc_taskSetType;
						};
					case "captureFlag":
						{
							_currentObjectiveDescription = ["STR_RPG_OBJ_CAPTURE_TEXT", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"),_objectiveLocationName];
							[_side, _objectiveToReveal select 2, [_currentObjectiveDescription, ["STR_RPG_OBJ_CAPTURE"], "cookiemarker2"], objNull, "CREATED", 3, true] call BIS_fnc_taskCreate;
							[_objectiveToReveal select 2,"map"] call BIS_fnc_taskSetType;
						};
					default { 
						//hint "default" 
						};
				};

				//Set task exact location 
				[[_objectiveToReveal#2, getPos (_thisObject)], "engine\objectiveManagement\drawObjectiveLocation.sqf"] remoteExec ['BIS_fnc_execVM', 0, false];


				//Display dialog on screen if necessary
				if (!isNil "_caller") then 
				{					
					[[_currentObjectiveDescription], {params ["_currentObjectiveDescription"]; ["STR_RPG_CIVILIAN_NAME", _currentObjectiveDescription] call doDialogWithCustomParam}] remoteExec ["spawn", _caller]; 
				};
		};
};
	