_thisAvailablePosition = _this select 0;
_thisTargetPosition = _this select 1;
_thisAvailableGroups = _this select 2;
_thisDifficulty = _this select 3;

currentAttackGroup = objNull;
currentGroup = objNull;
currentPosition = [];
if (isServer) then
{
	diag_log format ["Avalaible spawn position %1", _thisAvailablePosition ];
	for [{_k = 0}, {_k < (count _thisAvailablePosition)}, {_k = _k + 1}] do 
	{
		for [{_j = 0}, {_j < 1 + _thisDifficulty}, {_j = _j + 1}] do 
		{
			
			currentAttackGroup = selectRandom _thisAvailableGroups;
			currentPosition = selectRandom _thisAvailablePosition;
			currentGroup = [([currentPosition,1,60,10,0] call BIS_fnc_findSafePos), east, currentAttackGroup,[],[],[],[],[],0] call BIS_fnc_spawnGroup;
			diag_log format ["Create group : %1 at position %2 and assault to position %3", currentGroup, getPos (leader currentGroup), _thisTargetPosition];
			//Assault for vehicle
			currentGroup move (_thisTargetPosition);
			currentGroup setBehaviour "SAFE";
			//currentGroup limitSpeed 20;
			//Assault for infantry
			[currentGroup, _thisTargetPosition] spawn lambs_wp_fnc_taskAssault;
			
			//[currentGroup, currentPosition distance _thisTargetPosition] spawn lambs_wp_fnc_taskHunt;
			currentGroup setFormation "DIAMOND";
			diag_log format ["Group %1 ready to assault", _j ];
		};
	};
};