sleep 180;

//Wait mission generation to init deatch check
waituntil {count allPlayers != 0};

_nb_ind_alive = {alive _x && side _x == independent} count allPlayers;
_nb_blu_alive = {alive _x && side _x == blufor} count allPlayers;
missionOver = false;


//TODO Remplacer la plupart de ces tests par des eventHandler
while {sleep 3; !missionOver} do
{
	_nb_ind_alive = {alive _x && side _x == independent} count allPlayers;
	_nb_blu_alive = {alive _x && side _x == blufor} count allPlayers;

	if (_nb_blu_alive == 0 && _nb_ind_alive == 0) then
	{ 
		missionOver = true;
		[['PLY_DEAD'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
		[99999999] remoteExec ['setPlayerRespawnTime', 2];
	};
};



