nb_ind_alive = {isPlayer _x && side _x == independent} count allUnits;
nb_blu_alive = {isPlayer _x && side _x == blufor} count allUnits;
nb_blu_init = nb_blu_alive;
nb_civ_alive = {side _x == civilian} count allUnits;
nb_civ_init =  nb_civ_alive;
missionOver = false;

//Get independent leader
initWarlord = objNull;
{
	if (isPlayer _x && side _x == independent && _x == (leader (group _x))) then
	{
		initWarlord = _x;
	};
} foreach allPlayers;

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
while {!missionOver} do
{
	sleep 10;
	
	//Obsolète
	if (nb_ind_alive == 0) then 
	{
		missionOver = true;
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'IND_DEAD' call BIS_fnc_endMissionServer;
		} else {
			'IND_DEAD' call BIS_fnc_endMission;
		};
	} else 
	{
		nb_ind_alive = {isPlayer _x && side _x == independent} count allUnits;
		publicvariable "nb_ind_alive";
	};
	
	if (!alive initWarlord) then 
	{
		missionOver = true;
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'IND_DEAD' call BIS_fnc_endMissionServer;
		} else {
			'IND_DEAD' call BIS_fnc_endMission;
		};
	};
	
	if (!alive logiTruck) then
	{
		missionOver = true;
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'VEHICLE_DEAD' call BIS_fnc_endMissionServer;
			
		} else {
			'VEHICLE_DEAD' call BIS_fnc_endMission;
		};
	};
	if (count (obj_must_be_alive select {alive _x}) != count obj_must_be_alive) then
	{
		missionOver = true;
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'OBJ_DEAD' call BIS_fnc_endMissionServer;
		} else {
			'OBJ_DEAD' call BIS_fnc_endMission;
		};
	};
	if ( nb_blu_alive < round(nb_blu_init/2)) then
	{ 
		missionOver = true;
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'BLUFOR_DEAD' call BIS_fnc_endMissionServer;
		} else {
			'BLUFOR_DEAD' call BIS_fnc_endMission;
		};
	} else 
	{
		nb_blu_alive = {isPlayer _x && side _x == blufor} count allUnits;
		publicvariable "nb_blu_alive";
	};
	if (nb_civ_init - nb_civ_alive >=5) then 
	{
		missionOver = true;
		diag_log format ["Mission end !"];
		if (isMultiplayer) then {
			'CIV_DEAD' call BIS_fnc_endMissionServer;
		} else {
			'CIV_DEAD' call BIS_fnc_endMission;
		};
	} else {
		nb_civ_alive = {side _x == civilian} count allUnits;
		publicvariable "nb_civ_alive";
	};
};



