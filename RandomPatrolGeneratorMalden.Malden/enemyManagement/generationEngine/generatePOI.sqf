params ["_thisAvailableOpforGroup","_thisAvailableOpforCars","_thisAvailableOpforLightArmoredVehicle","_thisAvailableOpforHeavyArmoredVehicle","_thisAvailableCivGroup","_thisAvailablePosition","_thisDifficulty"];

currentRandomGroup = objNull;
currentGroup = objNull;
diag_log format ["Begin generation AO %1",_thisAvailablePosition];

//Try to find position with building if avalaible
_tempAvailablePosition = getPos (nearestBuilding _thisAvailablePosition);
if (_tempAvailablePosition distance _thisAvailablePosition < 200) then 
{
	_thisAvailablePosition = _tempAvailablePosition;
};

//Generate enemy infantry on AO
diag_log format ["Infantry generation start on AO %1",_thisAvailablePosition];
_baseRadius = 60;
for [{_i = 0}, {_i < _thisDifficulty+3}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom _thisAvailableOpforGroup;
	currentGroup = [currentRandomGroup, _thisAvailablePosition, east, "DefenseInfantry"] call doGenerateEnemyGroup;
	
	//Spawn group
	[currentGroup, getPos (leader currentGroup), _baseRadius, false] execVM 'enemyManagement\behaviorEngine\doGarrison.sqf';
	_baseRadius = _baseRadius + 30;
};


diag_log format ["Light vehicle generation start on AO %1",_thisAvailablePosition];
//Generate enemy light vehicle on AO
for [{_i = 0}, {_i < round((_thisDifficulty-0.5)/2)+1}, {_i = _i + 1}] do 
{
	//Generate light vehicle
	if (count _thisAvailableOpforCars != 0) then 
	{
		_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
		{
			_currentEnemyCars = [[selectRandom _thisAvailableOpforCars], _safeVehicleSpawn, east, "Car"] call doGenerateEnemyGroup;
		};
	};
};

diag_log format ["Heavy vehicle generation start on AO %1",_thisAvailablePosition];
//Generate heavy enemy light vehicle on AO
for [{_i = 0}, {_i < round((_thisDifficulty-0.5)/2) + 1}, {_i = _i + 1}] do 
{
	//Generate heavy vehicle
	if (count _thisAvailableOpforLightArmoredVehicle != 0 && enableArmoredVehicle) then 
	{
		//Light armored vehicle spawn chance 33%
		if (round random 2 == 0) then 
		{
			_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
			{
				_currentEnemyCars = [[selectRandom _thisAvailableOpforLightArmoredVehicle], _safeVehicleSpawn, east, "LightArmored"] call doGenerateEnemyGroup;
			};
		};

		//Heavy armored vehicle spawn chance 33%
		if (count _thisAvailableOpforHeavyArmoredVehicle != 0 && round random 2 == 0) then 
		{
			_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
			{
				_currentEnemyCars = [[selectRandom _thisAvailableOpforHeavyArmoredVehicle], _safeVehicleSpawn, east, "HeavyArmored"] call doGenerateEnemyGroup;
			};
		};
	};
};

diag_log format ["Civilian generation start on AO %1",_thisAvailablePosition];
//Add chance to spawn civilian 33%
if (round (random 3) == 0 && count _thisAvailableCivGroup > 0) then 
{
	for [{_i = 0}, {_i < _thisDifficulty+1}, {_i = _i + 1}] do 
	{
		currentGroup = [_thisAvailableCivGroup, _thisAvailablePosition, civilian, "Civilian"] call doGenerateEnemyGroup;
		[currentGroup, getPos (leader currentGroup), 80, true] execVM 'enemyManagement\behaviorEngine\doGarrison.sqf';
	};
};

diag_log format ["End generation AO %1",_thisAvailablePosition];