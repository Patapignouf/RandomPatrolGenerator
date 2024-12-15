params ["_objective"];

objectiveID = _objective # 2;

diag_log format ["The task %1 has been completed", objectiveID];

//Remove objective circle
if (missionNameSpace getVariable ["enableObjectiveExactLocation",0] == 1) then 
{
	// [
	// 	{
	// 		_taskIDEH = format ["%1_EH", objectiveID];
	// 		_EHID = player getVariable _taskIDEH;
	// 		findDisplay 12 displayCtrl 51 ctrlRemoveEventHandler ["Draw", _EHID];
	// 	}
	// ] remoteExec ["call", 0];
	[objectiveID] remoteExec ["deleteMarker", 0, true];
};

//remove Uncompleted objectives
_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
_foundMissionUncompletedObjectives = _missionUncompletedObjectives select {_x#2 == objectiveID};

//Manage UncompletedObjective
if (count _foundMissionUncompletedObjectives != 0) then 
{
	_missionUncompletedObjectives = _missionUncompletedObjectives - _foundMissionUncompletedObjectives;
	missionNamespace setVariable ["missionUncompletedObjectives", _missionUncompletedObjectives, true];
};


//Reveal and complete objective if unrevealed 
if ([objectiveID] call BIS_fnc_taskExists) then 
{
	[objectiveID,"SUCCEEDED"] call BIS_fnc_taskSetState;
} else 
{
	_mainPlayerSide = blufor;
	if ({isPlayer _x && side _x == independent} count allPlayers != 0) then 
	{
		_mainPlayerSide = independent;
	};
	[objNull, _objective, _mainPlayerSide] execVM 'engine\objectiveManagement\revealObjective.sqf';
	sleep 5;
	[objectiveID,"SUCCEEDED"] call BIS_fnc_taskSetState;
};