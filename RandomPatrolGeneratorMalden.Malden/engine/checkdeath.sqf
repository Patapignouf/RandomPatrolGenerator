//Wait mission generation to init deatch check
waituntil {count allPlayers != 0};

nb_ind_alive = {isPlayer _x && side _x == independent && _x getVariable "isDead" == false} count allUnits;
nb_blu_alive = {isPlayer _x && side _x == blufor && _x getVariable "isDead" == false} count allUnits;
nb_blu_init = nb_blu_alive;
missionOver = false;
initWarlord = objNull;
publicvariable "initWarlord";
respawnSettings = ["Respawn",1] call BIS_fnc_getParamValue;

diag_log format ["Init calculated values : nb_blu_alive %1", nb_blu_alive];

//Obj management
obj_supply_or_ammo = [];
obj_supply = [];
obj_ammo = [];
obj_hvt = [];
obj_vip = [];
obj_must_be_alive = [];

{
	switch (_x select 1) do
	{
		case "supply":
			{
				obj_supply pushBack (_x select 0);
				obj_supply_or_ammo pushBack (_x select 0);
				obj_must_be_alive pushBack (_x select 0);
			};
		case "ammo":
			{
				obj_ammo pushBack (_x select 0);
				obj_supply_or_ammo pushBack (_x select 0);
			};
		case "hvt":
			{
				obj_hvt pushBack (_x select 0);
			};
		case "vip":
			{
				obj_vip pushBack (_x select 0);
				obj_must_be_alive pushBack (_x select 0);
			};
		default { hint "default" };
	};
} foreach SupplyObjects;


//TODO Remplacer la plupart de ces tests par des eventHandler
while {sleep 10; !missionOver} do
{
	//Define objective temp variable
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives", []];
	_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];
	
	//Obsolète
	if (nb_ind_alive == 0) then 
	{
		// missionOver = true;
		// diag_log format ["Mission end !"];
		// if (isMultiplayer) then {
			// 'IND_DEAD' call BIS_fnc_endMissionServer;
		// } else {
			// 'IND_DEAD' call BIS_fnc_endMission;
		// };
	} else 
	{
		nb_ind_alive = {isPlayer _x && side _x == independent && _x getVariable "isDead" == false} count allUnits;
		publicvariable "nb_ind_alive";
	};
	
	if (!isNull initWarlord && !alive initWarlord) then 
	{
		missionOver = true;
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'IND_DEAD' call BIS_fnc_endMissionServer;
		} else {
			'IND_DEAD' call BIS_fnc_endMission;
		};
	};
	//TODO : Improve failed condition to match with the future campaign feature
	if (count _missionFailedObjectives > 1 ) then 
	{
		missionOver = true;
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'OBJ_DEAD' call BIS_fnc_endMissionServer;
		} else {
			'OBJ_DEAD' call BIS_fnc_endMission;
		};
	};
	if ((nb_blu_alive < round(nb_blu_init/2) && respawnSettings == 0) || ((nb_blu_alive == 0)&&(nb_blu_init!=0))) then
	{ 
		missionOver = true;
		diag_log format ["Counter blufor alive %1 vs blufor min count %2",nb_blu_alive,round(nb_blu_init/2)];
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'BLUFOR_DEAD' call BIS_fnc_endMissionServer;
		} else {
			'BLUFOR_DEAD' call BIS_fnc_endMission;
		};
	} else 
	{
		nb_blu_alive = {isPlayer _x && side _x == blufor && _x getVariable "isDead" == false} count allUnits;
		publicvariable "nb_blu_alive";
	};
};



