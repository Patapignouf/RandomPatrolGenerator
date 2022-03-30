_thisSpawnGroups = _this select 0;
_thisDifficulty = _this select 1;

nb_ind_player_alive = 0;
nb_blu_player_alive = 0;

currentRandomAttack = objNull;
currentGroupAttack = objNull;
positionToAttack = [];

//Init sleep before spawn
diag_log "Init harass !";
sleep 600;

if (isServer) then
{
	while {true} do 
	{
		nb_ind_player_alive = {isPlayer _x && side _x == independent} count allUnits;
		nb_blu_player_alive = {isPlayer _x && side _x == blufor} count allUnits;
		sleep 20;
		diag_log format ["Harass start on position %1", positionToAttack];
		
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
		AvalaibleInitAttackPositions = [];
		AvalaibleInitAttackPositions = [positionToAttack, 1200,1600,difficultyParameter] call getListOfPositionsAroundTarget;
		[AvalaibleInitAttackPositions,positionToAttack,_thisSpawnGroups,difficultyParameter] execVM 'enemyManagement\doAmbush.sqf'; 
		diag_log format ["Harass start on position %1", positionToAttack];
		sleep (800+round (random 300));
	};
};