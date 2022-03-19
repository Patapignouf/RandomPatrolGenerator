_thisAvailableWaveGroups = _this select 0;
_thisAvailablePosition = _this select 1;
_thisTargerPosition = _this select 2;
_thisDifficulty = _this select 3;

currentRandomAttack = objNull;
currentGroupAttack = objNull;

//Init sleep before spawn

diag_log "Init wave !";

//Adjust difficulty for the first level


_thisAvailableGroups = objNull;

if (isServer) then
{
	waveCounter = 0;
	CompletedObjectivesWave = 1;
	while {true or waveCounter < (count _thisAvailableWaveGroups)} do 
	{
		while {count CompletedObjectives == CompletedObjectivesWave} do
		{
			sleep 60;
			diag_log format ["Wave start : %1", waveCounter ];
			
			if (  waveCounter < count _thisAvailableWaveGroups) then
			{
				_thisAvailableGroups = _thisAvailableWaveGroups select waveCounter;
			} else 
			{
				_thisAvailableGroups = _thisAvailableWaveGroups select ((count _thisAvailableWaveGroups)-1);
			};
			
			
			for [{_k = 0}, {_k < (count _thisAvailablePosition)}, {_k = _k + 1}] do 
			{
				for [{_j = 0}, {_j < 1 + _thisDifficulty}, {_j = _j + 1}] do 
				{
					
					currentRandomAttack = selectRandom _thisAvailableGroups;
					currentGroupAttack = [getPos selectRandom _thisAvailablePosition, east, currentRandomAttack,[],[],[],[],[],0] call BIS_fnc_spawnGroup;
					diag_log format ["Create group : %1 at position %2 and assault to position %3", currentGroupAttack, getPos (leader currentGroupAttack), getPos _thisTargerPosition];
					[currentGroupAttack, getPos _thisTargerPosition] spawn lambs_wp_fnc_taskAssault;
					
					diag_log format ["Group %1 ready to assault", _j ];
				};
			};

			diag_log format ["Wave end : %1", waveCounter ];
			
			sleep 20;
			[["Vos informateurs vous signalent qu'une attaque est en cours sur Qalandar",independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
			CompletedObjectivesWave = CompletedObjectivesWave + 1;
			waveCounter = waveCounter + 1;
		};
		sleep 20;
		//sleep (700+round (random 240));
		
	};
	diag_log format ["All wave completed"];
};