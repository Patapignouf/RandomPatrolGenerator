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
		[_caller, [], _mainPlayerSide] execVM 'engine\revealObjective.sqf';
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
	//Same code here, needs to be factorize
	_potentialMissionEnemyInfo = _MissionEnemyInfo - _revealedMissionEnemyInfo;
	_infoToReveal = selectRandom _potentialMissionEnemyInfo;
	_revealedMissionEnemyInfo pushBack _infoToReveal;
	missionNamespace setVariable ["revealedMissionEnemyInfo",_revealedMissionEnemyInfo,true];
	_infoName = _infoToReveal select 0;
	_infoPos = _infoToReveal select 1;
	_infoGroup = _infoToReveal select 2;
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
				[1,[format ["I've heard there's soldiers patrolling around %1. About %2 men.",text _nearestCity, count units _infoGroup], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
			};
			case "Car":
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
				[1,[format ["I know there is a group of %2 soldiers defending %1, this location seems dangerous",text _nearestCity, count units _infoGroup], "PLAIN", 0.5]] remoteExec ["cutText", _caller];
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
	