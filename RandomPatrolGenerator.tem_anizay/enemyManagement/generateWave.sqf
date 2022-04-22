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
	while {sleep 20; waveCounter < (count _thisAvailableWaveGroups)} do 
	{
		
		while {sleep 20; count (missionNamespace getVariable ["completedObjectives",[]]) == CompletedObjectivesWave} do
		{
			diag_log format ["Wave start : %1", waveCounter ];
			
			if (  waveCounter < count _thisAvailableWaveGroups) then
			{
				_thisAvailableGroups = _thisAvailableWaveGroups select waveCounter;
			} else 
			{
				_thisAvailableGroups = _thisAvailableWaveGroups select ((count _thisAvailableWaveGroups)-1);
			};
			
			[EnemyWaveSpawnPositions,getPos initCityLocation,_thisAvailableGroups,[],difficultyParameter] execVM 'enemyManagement\doAmbush.sqf'; 
			
			diag_log format ["Wave end : %1", waveCounter ];
			
			sleep 120;
			[["Vos informateurs vous signalent qu'une attaque est en cours sur votre ville",independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
			CompletedObjectivesWave = CompletedObjectivesWave + 1;
			waveCounter = waveCounter + 1;
		};
		sleep 20;
		//sleep (700+round (random 240));
		
	};
	diag_log format ["All wave completed"];
};