params [];

nb_ind_player_alive = 0;
nb_blu_player_alive = 0;

currentRandomAttack = objNull;
currentGroupAttack = objNull;
positionToAttack = [];
_missionNumber = missionNamespace getVariable ["missionNumber", 0];

//Init sleep before spawn
diag_log "Init harass !";
sleep 800;

if (isServer) then
{

	_trgBluforFOB = createTrigger ["EmptyDetector", initBlueforLocation];
	_trgBluforFOB setTriggerArea [200, 200, 0, true];

	while {sleep 60; (_missionNumber == (missionNamespace getVariable ["missionNumber", 0]))} do  
	{
		//Redefine opfor reinforcement
		_thisAvailableOpforGroup = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup];
		_thisAvailableOpforCars= baseEnemyVehicleGroup;
		_thisAvailableOpforLightArmoredVehicle = baseEnemyLightArmoredVehicleGroup;
		_thisAvailableOpforHeavyArmoredVehicle = baseEnemyHeavyArmoredVehicleGroup;
		_thisAvailableOpforUnarmedChopperVehicle = baseEnemyUnarmedChopperGroup ;
		_thisAvailableOpforFixedWing = baseFixedWingGroup ;
		_thisAvailableOpforArmedChopperVehicle = baseEnemyArmedChopperGroup;
		_thisAvailableOpforFixedWingTransport = baseEnemyFixedWingTransport;


		_thisDifficulty = missionNamespace getVariable "missionDifficultyParam"; //Default medium

		//Test if there are too much IA
		//Test if IA are already in combat mode to simulate reinforcement
		if (({alive _x && side _x == opfor} count allUnits) < 300 && {side _x == opfor && behaviour _x == "COMBAT"} count allUnits > 5) then
		{
			positionToAttack = [0,0,0];
			diag_log "RPG : Reinforcement wave begin !";

			nb_ind_player_alive = {side _x == independent && alive _x} count allPlayers;

			nb_blu_player_alive_InFOB = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _trgBluforFOB);
			nb_blu_player_alive = {side _x == blufor && alive _x} count allPlayers;

			//Prioritize attack on blufor 
			if (nb_blu_player_alive != nb_blu_player_alive_InFOB) then
			{
				_happyPlayer = selectRandom (allPlayers select {side _x == blufor && alive _x && (_x distance initBlueforLocation >200)});
				positionToAttack = getPos _happyPlayer;
			};
			if (nb_ind_player_alive != 0) then
			{
				_happyPlayer = selectRandom (allPlayers select {side _x == independent && alive _x});
				positionToAttack = getPos _happyPlayer;
			};

			if (!([positionToAttack, [0,0,0]] call BIS_fnc_areEqual)) then 
			{
				//Alert players
				if (random 100>50) then 
				{
					[[positionToAttack], {params ["_positionToAttack"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_ENEMY_REINFORCEMENT", mapGridPosition (_positionToAttack)] call doDialog}] remoteExec ["spawn", 0]; 
				};
				
				//Chopper reinforcement 50%
				[positionToAttack] call doGenerateHarassWithChopper;


				//Check if there is a player in a plane then generate enemy plane
				[positionToAttack] call generatePlaneHarass;


				//Attack chopper reinforcement 25%
				[positionToAttack] call generateChopperHarass;

				AvalaibleInitAttackPositions = [];
				AvalaibleInitAttackPositions = [positionToAttack, 1200, 2000, _thisDifficulty] call getListOfPositionsAroundTarget;

				//Chopper reinforcement 33%
				diag_log format ["Harass start on position %1", positionToAttack];
				if (count _thisAvailableOpforUnarmedChopperVehicle != 0 &&  random 100 < 33) then 
				{
					[positionToAttack] call doGenerateHarassWithChopperOrPlane;
				} else 
				{
					//[positionToAttack] call doGenerateHarassWithVehicle;
				};

				switch (missionNamespace getVariable ["opforReinforcement", 1])  do
				{
					//Few
					case 0:
					{
						sleep (1800+round (random 600));
					};
					//Normal
					case 1:
					{
						sleep (1200+round (random 600));
					};
					//Often
					case 2:
					{
						sleep (600+round (random 600));
					};
					default
					{
						//Bug ?
					};
				};
			};
		};
	};
};