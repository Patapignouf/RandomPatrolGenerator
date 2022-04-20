params ["_thisAvailableOpforGroup","_thisAvailableOpforCars","_thisAvailableOpforLightArmoredVehicle","_thisAvailableOpforHeavyArmoredVehicle","_thisDifficulty"];

nb_ind_player_alive = 0;
nb_blu_player_alive = 0;

currentRandomAttack = objNull;
currentGroupAttack = objNull;
positionToAttack = [];

//Init sleep before spawn
diag_log "Init harass !";
sleep 1000;

if (isServer) then
{
	while {sleep 20; true} do 
	{
		nb_ind_player_alive = {isPlayer _x && side _x == independent} count allUnits;
		nb_blu_player_alive = {isPlayer _x && side _x == blufor} count allUnits;
		
		diag_log format ["Harass start on position %1", positionToAttack];
		if (({alive _x && side _x == opfor} count allUnits) <=175) then
		{
			//Prioritize attack on independent 
			if (nb_blu_player_alive != 0) then
			{
				{
					if (isPlayer _x && side _x == blufor) exitWith
					{
						positionToAttack = getPos _x;
					};
				} foreach allPlayers;
			};
			if (nb_ind_player_alive != 0) then
			{
				{
					if (isPlayer _x && side _x == independent) exitWith
					{
						positionToAttack = getPos _x;
					};
				} foreach allPlayers;
			};

			//Define harass group 
			_tempGroup = _thisAvailableOpforGroup; //Init group with basic infantry

			//Generate light vehicle 50% chance to spawn
			if (count _thisAvailableOpforCars != 0 && round random 1 == 0) then 
			{
				_tempGroup pushBack [selectRandom _thisAvailableOpforCars];
			};

			//Generate heavy vehicle
			if (count _thisAvailableOpforLightArmoredVehicle != 0 && enableArmored == 1) then 
			{
				//Light armored vehicle spawn chance 33%
				if (round random 2 == 0) then 
				{
					_tempGroup pushBack [selectRandom _thisAvailableOpforLightArmoredVehicle];
				};

				//Heavy armored vehicle spawn chance 17%
				if (count _thisAvailableOpforHeavyArmoredVehicle != 0 && round random 1 == 0) then 
				{
					_tempGroup pushBack [selectRandom _thisAvailableOpforHeavyArmoredVehicle];
				};
			};


			AvalaibleInitAttackPositions = [];
			AvalaibleInitAttackPositions = [ positionToAttack, 1200, 1600, difficultyParameter] call getListOfPositionsAroundTarget;
			[ AvalaibleInitAttackPositions, positionToAttack, _tempGroup, difficultyParameter] execVM 'enemyManagement\doAmbush.sqf'; 
			diag_log format ["Harass start on position %1", positionToAttack];
		};
		sleep (1000+round (random 300));
	};
};