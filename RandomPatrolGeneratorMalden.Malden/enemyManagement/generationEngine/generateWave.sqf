params ["_thisAvailableWaveGroups","_thisAvailablePosition","_thisTargerPosition","_thisDifficulty"];

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
	while {sleep 20; waveCounter < (count _thisAvailableWaveGroups)} do 
	{
		//Reduce difficulty of enemy wave if opfor FOB are cleared
		_numberOfClearedFOB = missionNamespace getVariable ["OpforFOBCleared", 0];
		if (_thisDifficulty > _numberOfClearedFOB) then 
		{
			_thisDifficulty = _thisDifficulty - _numberOfClearedFOB;
		};

		while {sleep 20; count (missionNamespace getVariable ["completedObjectives",[]]) == CompletedObjectivesWave} do
		{
			diag_log format ["Wave start : %1", waveCounter ];
			
			//Randomize attack on independent city (20%)
			if (random 100 < 20) then 
			{
				if (  waveCounter < count _thisAvailableWaveGroups) then
				{
					_thisAvailableGroups = _thisAvailableWaveGroups select waveCounter;
				} else 
				{
					_thisAvailableGroups = _thisAvailableWaveGroups select ((count _thisAvailableWaveGroups)-1);
				};
				
				[EnemyWaveSpawnPositions, initCityLocation,_thisAvailableGroups,[], _thisDifficulty] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
				
				diag_log format ["Wave end : %1", waveCounter ];
				
				sleep 120;
				[["Vos informateurs vous signalent qu'une attaque est en cours sur votre ville",independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
			};

			//Increase attack counter
			CompletedObjectivesWave = CompletedObjectivesWave + 1;
			waveCounter = waveCounter + 1;
		};
		sleep 20;	
	};
	diag_log format ["All wave completed"];
};