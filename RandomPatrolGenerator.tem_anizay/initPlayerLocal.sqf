//Arsenal without save/load
[missionNamespace, "arsenalOpened", {
	disableSerialization;
	params ["_display"];
	_display displayAddEventHandler ["keydown", "_this select 3"];
	{(_display displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44146, 44147, 44148, 44149, 44346];
}] call BIS_fnc_addScriptedEventHandler;


//Init disableThermal
[] execVM 'engine\disableThermal.sqf';

if (hasInterface) then
{
	waituntil {!isNil "isBluforAttacked"};
	if (side player == independent) then 
	{
		player setPos ([getPos initCityLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		if (player == (leader (group player))) then
		{
			diag_log format ["Warlord is set to player : %1", name player];
			player addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				diag_log format ["Warlord has been killed by : %1", _killer];
				diag_log format ["Mission end !"];
				if (isMultiplayer) then {
					'IND_DEAD' call BIS_fnc_endMissionServer;
				} else {
					'IND_DEAD' call BIS_fnc_endMission;
				};
			}];
		};
	};
	if (side player == blufor) then
	{
		player setPos ([initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		if (isBluforAttacked) then
		{
				[["Le QG vous informe qu'une attaque est possiblement en cours sur vos positions dans quelques de minutes, quittez les lieux avant leur arrivée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
	};
};



if (didJIP) exitWith {};

if (hasInterface) then
{	
	if (player getUnitTrait "Medic" == false) then 
	{
		for "_i" from 0 to 7 do { player addItem "ACE_elasticBandage" };	
		for "_i" from 0 to 1 do { player addItem "ACE_tourniquet" };
		for "_i" from 0 to 1 do { player addItem "ACE_splint" };
	}
	else 
	{
		player addItem "ACE_surgicalKit";
		for "_i" from 0 to 7 do { player addItem "ACE_epinephrine" };
		for "_i" from 0 to 7 do { player addItem "ACE_splint" };
		for "_i" from 0 to 29 do { player addItem "ACE_elasticBandage" };
		for "_i" from 0 to 29 do { player addItem "ACE_quikclot" };
		for "_i" from 0 to 9 do { player addItem "ACE_morphine" };
		for "_i" from 0 to 5 do { player addItem "ACE_bloodIV_500" };
		for "_i" from 0 to 2 do { player addItem "ACE_bloodIV" };
		for "_i" from 0 to 5 do { player addItem "ACE_tourniquet" };	
	};
	for "_i" from 0 to 1 do { player addItem "ACE_CableTie" };
	player addItem "ACE_MapTools";	
	player addItem "ACE_morphine";	
	player addItem "ACE_WaterBottle";
	player addItem "ACE_EarPlugs";
	player addItem "ACE_microDAGR";
	player unassignItem "itemRadio";
	player removeItem "itemRadio";
	//player addItem "TFAR_anprc148jem";
	//player assignItem "TFAR_anprc148jem";
	player addItem "TFAR_anprc152";
	player assignItem "TFAR_anprc152";
	player setSpeaker "noVoice";
};