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
				
				//Define harass group 
				_tempVehicleGroup = [];

				if ((missionNameSpace getVariable ["enableOpforVehicle", 0]) < 3) then 
				{
					//Generate light vehicle 33% chance to spawn
					if (count _thisAvailableOpforCars != 0 && random 100 < 33) then 
					{
						_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforCars];
					};

					//Generate Light armored vehicle spawn chance 
					if (count _thisAvailableOpforLightArmoredVehicle != 0 && enableArmoredVehicle && random 100 < 30) then 
					{
						//Light armored vehicle spawn chance 20%
						_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforLightArmoredVehicle];
					};

					//Generate Light armored vehicle spawn chance
					if (count _thisAvailableOpforHeavyArmoredVehicle != 0 && enableArmoredVehicle && random 100 < 25) then 
					{
						//Heavy armored vehicle spawn chance 15%
						_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforHeavyArmoredVehicle];
					};
				} else 
				{
					//Force at least one vehicle to spawn
					_tempVehicleGroup pushBack [selectRandom (_thisAvailableOpforCars+_thisAvailableOpforLightArmoredVehicle+_thisAvailableOpforHeavyArmoredVehicle)];
				};


				//Chopper reinforcement 50%
				if (count _thisAvailableOpforUnarmedChopperVehicle != 0 &&  random 100 < 50) then 
				{
					//Generate enemy wave
					[_thisAvailableOpforGroup#0, selectRandom _thisAvailableOpforUnarmedChopperVehicle, positionToAttack] execVM 'enemyManagement\behaviorEngine\doVehicleReinforcement.sqf'; 
				};

				//Check if there is a player in a plane
				if (count (allPlayers select {(vehicle _x ) isKindOf "Plane"}) > 0) then 
				{
					//Plane reinforcement 75%
					//Increase the probability of enemy air reinforcement when there are players in the air
					if (missionNamespace getVariable ["enableArmedAicraft", false] && (count _thisAvailableOpforFixedWing != 0 &&  random 100 < 75)) then 
					{
						//Generate enemy wave
						[selectRandom _thisAvailableOpforFixedWing, positionToAttack] execVM 'enemyManagement\behaviorEngine\doVehicleAttackOnPosition.sqf'; 
					};
				} else 
				{
					//Plane reinforcement 25%
					if (missionNamespace getVariable ["enableArmedAicraft", false] && (count _thisAvailableOpforFixedWing != 0 &&  random 100 < 25)) then 
					{
						//Generate enemy wave
						[selectRandom _thisAvailableOpforFixedWing, positionToAttack] execVM 'enemyManagement\behaviorEngine\doVehicleAttackOnPosition.sqf'; 
					};
				};


				//Attack chopper reinforcement 25%
				if (missionNamespace getVariable ["enableArmedAicraft", false] && (count _thisAvailableOpforArmedChopperVehicle != 0 &&  random 100 < 25)) then 
				{
					//Generate enemy attack chopper wave
					[selectRandom _thisAvailableOpforArmedChopperVehicle, positionToAttack] execVM 'enemyManagement\behaviorEngine\doVehicleAttackOnPosition.sqf'; 
				};

				AvalaibleInitAttackPositions = [];
				AvalaibleInitAttackPositions = [positionToAttack, 1200, 2000, _thisDifficulty] call getListOfPositionsAroundTarget;

				//Chopper reinforcement 33%
				diag_log format ["Harass start on position %1", positionToAttack];
				if (count _thisAvailableOpforUnarmedChopperVehicle != 0 &&  random 100 < 33) then 
				{
					//Generate enemy wave
					_closedAvalaibleInitAttackPositions = [positionToAttack, 300, 1000, _thisDifficulty] call getListOfPositionsAroundTarget;
					for [{_numberOfChopper = 0}, {_numberOfChopper < _thisDifficulty}, {_numberOfChopper = _numberOfChopper + 1}] do
					{
						[selectRandom _thisAvailableOpforGroup, selectRandom (_thisAvailableOpforUnarmedChopperVehicle+_thisAvailableOpforFixedWingTransport), selectRandom _closedAvalaibleInitAttackPositions] execVM 'enemyManagement\behaviorEngine\doParadrop.sqf'; 
						sleep 1; //Avoid chopper crash
					};

					[_thisAvailableOpforGroup#0, selectRandom _thisAvailableOpforUnarmedChopperVehicle, positionToAttack] execVM 'enemyManagement\behaviorEngine\doVehicleReinforcement.sqf'; 
				} else 
				{
					[ AvalaibleInitAttackPositions, positionToAttack, _thisAvailableOpforGroup, _tempVehicleGroup, (floor (_thisDifficulty/4))+1] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
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