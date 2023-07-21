params ["_thisAvailableOpforGroup","_thisAvailableOpforCars","_thisAvailableOpforLightArmoredVehicle","_thisAvailableOpforHeavyArmoredVehicle", "_thisAvailableOpforUnarmedChopperVehicle","_thisAvailableOpforFixedWing","_thisDifficulty"];

nb_ind_player_alive = 0;
nb_blu_player_alive = 0;

currentRandomAttack = objNull;
currentGroupAttack = objNull;
positionToAttack = [];

//Init sleep before spawn
diag_log "Init harass !";
sleep 300;

if (isServer) then
{
	while {sleep 60; true} do  
	{
		//Test if there are too much IA
		//Test if IA are already in combat mode to simulate reinforcement
		if (({alive _x && side _x == opfor} count allUnits) <=175 && {side _x == opfor && behaviour _x == "COMBAT"} count allUnits > 5) then
		{
			diag_log "RPG : Reinforcement wave begin !";

			nb_ind_player_alive = {side _x == independent} count allPlayers;
			nb_blu_player_alive = {side _x == blufor} count allPlayers;

			//Prioritize attack on independent 
			if (nb_blu_player_alive != 0) then
			{
				{
					if (isPlayer _x && alive _x && side _x == blufor) exitWith
					{
						positionToAttack = getPos _x;
					};
				} foreach allPlayers;
			};
			if (nb_ind_player_alive != 0) then
			{
				{
					if (isPlayer _x && alive _x && side _x == independent) exitWith
					{
						positionToAttack = getPos _x;
					};
				} foreach allPlayers;
			};

			//Define harass group 
			_tempVehicleGroup = [];

			//Generate light vehicle 33% chance to spawn
			if (count _thisAvailableOpforCars != 0 && random 100 < 33) then 
			{
				_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforCars];
			};

			//Generate Light armored vehicle spawn chance 
			if (count _thisAvailableOpforLightArmoredVehicle != 0 && enableArmoredVehicle && random 100 < 20) then 
			{
				//Light armored vehicle spawn chance 20%
				_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforLightArmoredVehicle];
			};

			//Generate Light armored vehicle spawn chance
			if (count _thisAvailableOpforHeavyArmoredVehicle != 0 && enableArmoredVehicle && random 100 < 15) then 
			{
				//Heavy armored vehicle spawn chance 15%
				_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforHeavyArmoredVehicle];
			};

			//Chopper reinforcement 65%
			if (count _thisAvailableOpforUnarmedChopperVehicle != 0 &&  random 100 < 65) then 
			{
				//Generate enemy wave
				[_thisAvailableOpforGroup#0, selectRandom _thisAvailableOpforUnarmedChopperVehicle, positionToAttack] execVM 'enemyManagement\behaviorEngine\doVehicleReinforcement.sqf'; 
			};

			//Plane reinforcement 30%
			if (missionNamespace getVariable ["enableArmedAicraft", false] && (count _thisAvailableOpforFixedWing != 0 &&  random 100 < 30)) then 
			{
				//Generate enemy wave
				[selectRandom _thisAvailableOpforFixedWing, positionToAttack] execVM 'enemyManagement\behaviorEngine\doVehicleAttackOnPosition.sqf'; 
			};

			AvalaibleInitAttackPositions = [];
			AvalaibleInitAttackPositions = [positionToAttack, 1200, 2000, _thisDifficulty] call getListOfPositionsAroundTarget;
			[ AvalaibleInitAttackPositions, positionToAttack, _thisAvailableOpforGroup, _tempVehicleGroup, _thisDifficulty] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
			diag_log format ["Harass start on position %1", positionToAttack];

			sleep (600+round (random 600));
		};
	};
};