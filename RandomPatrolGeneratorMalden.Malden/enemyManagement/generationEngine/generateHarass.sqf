params ["_thisAvailableOpforGroup","_thisAvailableOpforCars","_thisAvailableOpforLightArmoredVehicle","_thisAvailableOpforHeavyArmoredVehicle", "_thisAvailableOpforUnarmedChopperVehicle","_thisDifficulty"];

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
	while {sleep 20; true} do  
	{
		//Test if there are too much IA
		//Test if IA are already in combat mode to simulate reinforcement
		if (({alive _x && side _x == opfor} count allUnits) <=175 && {side _x == opfor && behaviour _x == "COMBAT"} count allUnits > 5) then
		{
			diag_log "RPG : Reinforcement wave begin !";

			nb_ind_player_alive = {side _x == independent && _x getVariable "isDead" == false} count allPlayers;
			nb_blu_player_alive = {side _x == blufor && _x getVariable "isDead" == false} count allPlayers;

			//Prioritize attack on independent 
			if (nb_blu_player_alive != 0) then
			{
				{
					if (isPlayer _x && alive _x && side _x == blufor && _x getVariable "isDead" == false) exitWith
					{
						positionToAttack = getPos _x;
					};
				} foreach allPlayers;
			};
			if (nb_ind_player_alive != 0) then
			{
				{
					if (isPlayer _x && alive _x && side _x == independent && _x getVariable "isDead" == false) exitWith
					{
						positionToAttack = getPos _x;
					};
				} foreach allPlayers;
			};

			//Define harass group 
			_tempGroup = _thisAvailableOpforGroup; //Init group with basic infantry
			_tempVehicleGroup = [];

			//Generate light vehicle 33% chance to spawn
			if (count _thisAvailableOpforCars != 0 && random 100 < 33) then 
			{
				_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforCars];
			};

			//Generate heavy vehicle
			if (count _thisAvailableOpforLightArmoredVehicle != 0 && enableArmoredVehicle) then 
			{
				//Light armored vehicle spawn chance 33%
				_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforLightArmoredVehicle];

				//Heavy armored vehicle spawn chance 17%
				//Remove heavy armor enemy reinforcement to balance gameplay
				// if (count _thisAvailableOpforHeavyArmoredVehicle != 0 && random 100 < 50) then 
				// {
				// 	_tempVehicleGroup pushBack [selectRandom _thisAvailableOpforHeavyArmoredVehicle];
				// };
			};

			//Chopper reinforcement 65%
			hint format ["%1",_thisAvailableOpforUnarmedChopperVehicle];
			if (count _thisAvailableOpforUnarmedChopperVehicle != 0 &&  random 100 < 65) then 
			{
				//Generate enemy wave
				diag_log "Begin chopper landing on operation area !";
				[_thisAvailableOpforGroup#0, selectRandom _thisAvailableOpforUnarmedChopperVehicle, positionToAttack] execVM 'enemyManagement\behaviorEngine\doVehicleReinforcement.sqf'; 
			};

			AvalaibleInitAttackPositions = [];
			AvalaibleInitAttackPositions = [positionToAttack, 1200, 2000, round((_thisDifficulty-0.5)/2)+1] call getListOfPositionsAroundTarget;
			[ AvalaibleInitAttackPositions, positionToAttack, _tempGroup,_tempVehicleGroup, round((_thisDifficulty-0.5)/2)+1] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
			diag_log format ["Harass start on position %1", positionToAttack];
		};
		sleep (600+round (random 300));
	};
};