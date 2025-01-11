sleep 180;

enablePersistent = missionNameSpace getVariable "enablePersistent";

//Wait mission generation to init deatch check
waituntil {count allPlayers != 0};

_nb_ind_alive = {alive _x && side _x == independent} count allPlayers;
_nb_blu_alive = {alive _x && side _x == blufor} count allPlayers;
missionOver = false;


//TODO Remplacer la plupart de ces tests par des eventHandler
while {sleep 5; !missionOver} do
{
	_nb_ind_alive = {alive _x && side _x == independent} count allPlayers;
	_nb_blu_alive = {alive _x && side _x == blufor} count allPlayers;
	_allPlayersNotIncapacited = {alive _x && (lifeState _x != "INCAPACITATED")} count allPlayers;

	if (_nb_blu_alive == 0 && _nb_ind_alive == 0) then
	{ 
		//Check if persistent mode is enable
		if (enablePersistent == 1) then 
		{
			//On persistent mode there is no mission fail when every player is dead

			//Respawn all players
			[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
		} else 
		{
			//End mission
			missionOver = true;
			[['PLY_DEAD'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
			[99999999] remoteExec ['setPlayerRespawnTime', 2];
		};
	} else 
	{
		//Ask player if they want to abort game if nobody is standing up
		if (_allPlayersNotIncapacited == 0) then
		{ 
				[[], 'GUI\playerAbortGUI\playerAbortGUI.sqf'] remoteExec ['BIS_fnc_execVM', allPlayers select {alive _x}, true];
		};
	};
};