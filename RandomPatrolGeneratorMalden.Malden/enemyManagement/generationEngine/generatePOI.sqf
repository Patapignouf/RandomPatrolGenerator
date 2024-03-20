params ["_thisAvailableOpforGroup","_thisAvailableOpforCars","_thisAvailableOpforLightArmoredVehicle","_thisAvailableOpforHeavyArmoredVehicle","_thisAvailableCivGroup","_thisAvailablePosition", "_thisObjective"];

currentRandomGroup = objNull;
currentGroup = objNull;
diag_log format ["Begin generation AO %1",_thisAvailablePosition];
_thisDifficulty = missionNamespace getVariable "missionDifficultyParam"; //Default medium

//Try to find position with building if avalaible
_tempAvailablePosition = getPos (nearestBuilding _thisAvailablePosition);
if (_tempAvailablePosition distance _thisAvailablePosition < 200) then 
{
	_thisAvailablePosition = _tempAvailablePosition;
};

//Generate enemy infantry on AO
diag_log format ["Infantry generation start on AO %1",_thisAvailablePosition];
_baseRadius = 60;
for [{_i = 0}, {_i < ((_thisDifficulty-1)*2)+1}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom _thisAvailableOpforGroup;
	currentGroup = [currentRandomGroup, _thisAvailablePosition, east, "DefenseInfantry"] call doGenerateEnemyGroup;

	//Add intel to enemy
	if ((typeName _thisObjective) == "ARRAY") then 
	{
		[currentGroup,_thisObjective] execVM 'engine\objectiveManagement\addObjectiveIntel.sqf';
	} else 
	{
		diag_log format ["generatePOI : _thisObjective is null"];
	};

	//Spawn group
	[currentGroup, getPos (leader currentGroup), _baseRadius, false] execVM 'enemyManagement\behaviorEngine\doGarrison.sqf';
	_baseRadius = _baseRadius + 30;
};


//75% chance enemy have vehicle
if (random 100 < 75) then 
{
	_numberOfVehicle = _thisDifficulty;

	//Generate vehicle
	for [{_i = 0}, {_i < _numberOfVehicle}, {_i = _i + 1}] do 
	{	
		//50% chance to spawn armored vehicle
		if (random 100 < 50 && enableArmoredVehicle) then 
		{
			//50% chance to spawn light armored vehicle
			if (random 100 < 50) then 
			{
				if (count _thisAvailableOpforLightArmoredVehicle != 0 ) then 
				{
					_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
					if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
					{
						_currentEnemyCars = [[selectRandom _thisAvailableOpforLightArmoredVehicle], _safeVehicleSpawn, east, "LightArmored"] call doGenerateEnemyGroup;
					};
				};
			} else {
				//50% generate heavy vehicle
				if (count _thisAvailableOpforHeavyArmoredVehicle != 0) then 
				{
					_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
					if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
					{
						_currentEnemyCars = [[selectRandom _thisAvailableOpforHeavyArmoredVehicle], _safeVehicleSpawn, east, "HeavyArmored"] call doGenerateEnemyGroup;
					};
				};
			};
		} else 
		{
			//50% generate light vehicle
			if (count _thisAvailableOpforCars != 0) then 
			{
				_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 10, 1, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
				{
					_currentEnemyCars = [[selectRandom _thisAvailableOpforCars], _safeVehicleSpawn, east, "Car"] call doGenerateEnemyGroup;
				};
			};
		};
	};
};

diag_log format ["Civilian generation start on AO %1", _thisAvailablePosition];
//Add chance to spawn civilian 25%
if (random 100 < 25 && count _thisAvailableCivGroup > 0) then 
{
	for [{_i = 0}, {_i < _thisDifficulty}, {_i = _i + 1}] do 
	{
		currentGroup = [_thisAvailableCivGroup, _thisAvailablePosition, civilian, "Civilian"] call doGenerateEnemyGroup;
		[currentGroup, getPos (leader currentGroup), 80, true] execVM 'enemyManagement\behaviorEngine\doGarrison.sqf';
	};
};

diag_log format ["End generation AO %1",_thisAvailablePosition];