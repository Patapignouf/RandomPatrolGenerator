params ["_caller"];

_revealedObjectives = missionNamespace getVariable ["revealedObjectives",[]];
_tempMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
_revealedMissionEnemyInfo = missionNamespace getVariable ["revealedMissionEnemyInfo",[]];
_MissionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];
_realismMode = "RealismMode" call BIS_fnc_getParamValue;
if (count _revealedObjectives != count _tempMissionObjectives) then
{
	//Check if there are independent avalaible
	if (_realismMode == 1) then 
	{
		//Reveal objective to the player
		_mainPlayerSide = blufor;
		if ({isPlayer _x && side _x == independent} count allUnits != 0) then 
		{
			_mainPlayerSide = independent;
		};
		[_caller, [], _mainPlayerSide] execVM 'engine\objectiveManagement\revealObjective.sqf';
	} else 
	{ 
		_tempMissionObjectives = _tempMissionObjectives - _revealedObjectives;
		_objectiveToReveal = selectRandom _tempMissionObjectives;
		_revealedObjectives pushBack _objectiveToReveal;
		missionNamespace setVariable ["revealedObjectives", _revealedObjectives, true];
		//Add marker to player's map and display dialogs on screen
		[[_objectiveToReveal, getPos (_objectiveToReveal select 0), side _caller], 'objectGenerator\doGeneratePOIMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		[1,["Fine ! I'll show you something, look on your map !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
	};
} else 
{
	//Reveal minor intel for the caller
	[[_caller, "civilianAsking"], 'engine\objectiveManagement\revealMinorIntel.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
};
	