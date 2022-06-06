params ["_thisAvailableOpforGroup","_thisAvailableOpforCars","_thisAvailableOpforLightArmoredVehicle","_thisAvailableOpforHeavyArmoredVehicle","_thisAvailableCivGroup","_thisAvailablePosition","_thisDifficulty"];

currentRandomGroup = objNull;
currentGroup = objNull;
diag_log format ["Begin generation AO %1",_thisAvailablePosition];

//Generate enemy infantry on AO
diag_log format ["Infantry generation start on AO %1",_thisAvailablePosition];
for [{_i = 0}, {_i < _thisDifficulty+2}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom _thisAvailableOpforGroup;
	currentGroup = [currentRandomGroup, getPos _thisAvailablePosition, east, "DefenseInfantry"] call doGenerateEnemyGroup;
	
	//Spawn group
	[currentGroup, currentGroup, 75, [], true, (round random 3 == 0), -2, true] call lambs_wp_fnc_taskGarrison;
};


diag_log format ["Light vehicle generation start on AO %1",_thisAvailablePosition];
//Generate enemy light vehicle on AO
for [{_i = 0}, {_i < _thisDifficulty+1}, {_i = _i + 1}] do 
{
	//Generate light vehicle
	if (count _thisAvailableOpforCars != 0) then 
	{
		_safeVehicleSpawn = [getPos _thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
		{
			_currentEnemyCars = [[selectRandom _thisAvailableOpforCars], _safeVehicleSpawn, east, "Car"] call doGenerateEnemyGroup;
		};
	};
};

diag_log format ["Heavy vehicle generation start on AO %1",_thisAvailablePosition];
//Generate heavy enemy light vehicle on AO
for [{_i = 0}, {_i < _thisDifficulty}, {_i = _i + 1}] do 
{
	//Generate heavy vehicle
	if (count _thisAvailableOpforLightArmoredVehicle != 0 && enableArmored == 1) then 
	{
		//Light armored vehicle spawn chance 50%
		if (round random 1 == 0) then 
		{
			_safeVehicleSpawn = [getPos _thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
			{
				_currentEnemyCars = [[selectRandom _thisAvailableOpforLightArmoredVehicle], _safeVehicleSpawn, east, "LightArmored"] call doGenerateEnemyGroup;
			};
		};

		//Heavy armored vehicle spawn chance 50%
		if (count _thisAvailableOpforHeavyArmoredVehicle != 0 && round random 1 == 0) then 
		{
			_safeVehicleSpawn = [getPos _thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
			{
				_currentEnemyCars = [[selectRandom _thisAvailableOpforHeavyArmoredVehicle], _safeVehicleSpawn, east, "HeavyArmored"] call doGenerateEnemyGroup;
			};
		};
	};
};

diag_log format ["Civilian generation start on AO %1",_thisAvailablePosition];
//Add chance to spawn civilian 33%
if (round (random 2) != 0 && count _thisAvailableCivGroup > 0) then 
{
	for [{_i = 0}, {_i < _thisDifficulty+1}, {_i = _i + 1}] do 
	{
		currentGroup = [_thisAvailableCivGroup, getPos _thisAvailablePosition, civilian, "Civilian"] call doGenerateEnemyGroup;
		if (round (random 2) != 0) then 
		{
			diag_log "Task_Garrison civilian !";
			[currentGroup, currentGroup, 75, [], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
			
		} 
		else 
		{
			diag_log "Task_Camp civilian !";
			[currentGroup, getPos (leader currentGroup), 75, [], true, true] call lambs_wp_fnc_taskCamp;
		};
	};
};

diag_log format ["End generation AO %1",_thisAvailablePosition];