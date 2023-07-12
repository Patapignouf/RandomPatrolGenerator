params ["_thisGroup", "_position", "_distance","_allowCamp"];

diag_log format ["doGarrison : %1 on position %2", _thisGroup,_position];

//Test if lambs IA Mod is enabled on the server
if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
{
	if (!isNull _thisGroup) then
	{
		//Randomly place IA group in garrison or camp
		if (round (random 3) != 0 && _allowCamp) then 
		{
			diag_log "Task_Camp ! [LAMBS]";
			[_thisGroup, _position, _distance, [], true, true] call lambs_wp_fnc_taskCamp;
		} 
		else 
		{
			diag_log "Task_Garrison ! [LAMBS]";
			[_thisGroup, _position, _distance, [], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
		};
	};
} else 
{
	diag_log "Task_Garrison !";
	//Determine building avalaible positions
	_allBuildings = nearestTerrainObjects [_position, ["house"], _distance, false, true];
	_allPositions = [];
	_allBuildings apply {_allPositions append (_x buildingPos -1)};
	//_allPositions = call BIS_fnc_arrayShuffle; 

	//diag_log format ["Avalaible _allPositions position %1", _allPositions];

	//Place units in building (garrison)
	_units = units _thisGroup; 
	if (count _units > count _allPositions) then {_units resize (count _allPositions);};
	{
		//_x disableAI "PATH";
		_x setUnitPos selectRandom ["UP","UP","MIDDLE"];
		_x setPos (selectRandom _allPositions);
		_x addEventHandler["Fired",{params ["_unit"];_unit enableAI "PATH";_unit setUnitPos "AUTO";_unit removeEventHandler ["Fired",_thisEventHandler];}];
	} foreach _units; 
};