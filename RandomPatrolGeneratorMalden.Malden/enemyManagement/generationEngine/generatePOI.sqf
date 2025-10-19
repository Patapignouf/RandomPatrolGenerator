params ["_thisAvailableOpforCars","_thisAvailableOpforLightArmoredVehicle","_thisAvailableOpforHeavyArmoredVehicle", "_thisAvailableOpforTurret","_thisAvailableCivGroup","_thisAvailablePosition", "_thisObjective"];

currentRandomGroup = objNull;
currentGroup = objNull;
_basicEnemyGroups = [[opFaction, "BASIC"] call getBasicUnitsGroup, [opFaction, "AT"] call getBasicUnitsGroup];
// systemChat str _basicEnemyGroups;
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
for [{_i = 0}, {_i < ((_thisDifficulty)*2)}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom _basicEnemyGroups;
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
	[currentGroup, getPos (leader currentGroup), _baseRadius, false] call doGarrison;
	_baseRadius = _baseRadius + 30;
};

//Add a patrol 
currentGroup = [_basicEnemyGroups#0, _thisAvailablePosition, east, "DefenseInfantry"] call doGenerateEnemyGroup;

//Add intel to enemy
if ((typeName _thisObjective) == "ARRAY") then 
{
	[currentGroup,_thisObjective] execVM 'engine\objectiveManagement\addObjectiveIntel.sqf';
} else 
{
	diag_log format ["generatePOI : _thisObjective is null"];
};

//Spawn group
[currentGroup, _thisAvailablePosition, 150, false] call doPatrol;


//50% chance to spawn opfor turret
if (random 100 <50) then 
{
	for [{_i = 0}, {_i < _thisDifficulty}, {_i = _i + 1}] do 
	{	
		if (count _thisAvailableOpforTurret >0) then 
		{
			_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 0, 0, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
			{
				_selectedTurret = selectRandom _thisAvailableOpforTurret;

				_currentEnemyCars = [[_selectedTurret#0], _safeVehicleSpawn, east, "Turret"] call doGenerateEnemyGroup;

				_thisUnit = (units _currentEnemyCars)#0;

				if (_selectedTurret#1 != "NOTHING") then 
				{
					_spawnFOBObjects = [_safeVehicleSpawn, random 360, selectRandom avalaibleTurretBunker] call BIS_fnc_ObjectsMapper;
					_OpforFobStandardOpforLocation = nearestObjects [_safeVehicleSpawn, ["Sign_Arrow_Large_F"], 100];
					_turretPos = _OpforFobStandardOpforLocation#0;

					// _thisUnit setPosATL (getPosATL _turretPos);
					// _thisUnit setDir (getDir _turretPos);
				
					deleteVehicle _turretPos;
				};

			};
		};
	};
};


//Add weapon shop
if (missionNameSpace getVariable ["enableOpforWeaponShop",1] == 2) then 
{
	_boxLocation = ([_thisAvailablePosition, 1, 60, 1, 0, 20, 0, [], [_thisAvailablePosition, _thisAvailablePosition]] call BIS_fnc_findSafePos);

	_boxObject = createVehicle ["Box_FIA_Wps_F", _boxLocation, [], 0, "NONE"];

	clearWeaponCargoGlobal _boxObject;
	clearMagazineCargoGlobal _boxObject;
	clearItemCargoGlobal _boxObject;
	clearBackpackCargoGlobal _boxObject;

	//Add shop to the box
	[_boxObject, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa'/><t size='1'>%1</t>", localize "RPG_GUI_GENERAL_WEAPON_SHOP"],{
			params ["_object","_caller","_ID","_thisObjective"];
			[[[false, "OPFOR"]], "GUI\weaponShopGUI\weaponShopGUI.sqf"] remoteExec ['BIS_fnc_execVM', _caller];
		},[],10,true,false,"","_target distance _this <4"]] remoteExec ["addAction", 0, true];

	//Remove weapon shop if the box has been destroyed
	_boxObject addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		//Remove all actions
		[_unit] remoteExec ["removeAllEventHandlers", 0, true];
		[_unit] remoteExec ["removeAllActions", 0, true];
	}];


};


//Generate vehicle
if ((missionNameSpace getVariable ["enableOpforVehicle", 0]) != 0) then 
{
	_numberOfVehicle = _thisDifficulty;

	//Increase the number of vehicule on specific settings
	switch ((missionNameSpace getVariable ["enableOpforVehicle", 0])) do
	{
		//few
		case 1:
		{
			_numberOfVehicle = round (_numberOfVehicle/2);
		};
		//Normal
		case 2:
		{
			_numberOfVehicle = _numberOfVehicle;
		};
		//Crazy
		case 3:
		{
			_numberOfVehicle = floor (_numberOfVehicle*2);
		};
		//Insane
		case 4:
		{
			_numberOfVehicle = round (_numberOfVehicle*3);;
		};
	};

	//75% chance enemy have vehicle
	if ((random 100 < 75 && (missionNameSpace getVariable ["enableOpforVehicle", 0] != 0)) || (missionNameSpace getVariable ["enableOpforVehicle", 0]) > 2) then 
	{
		for [{_i = 0}, {_i < _numberOfVehicle}, {_i = _i + 1}] do 
		{	
			//80% chance to spawn armored vehicle
			if (random 100 < 80 && enableArmoredVehicle) then 
			{
				//Add light armored to heavy armored if needed (balance armored vehicle generation)

				// if (count _thisAvailableOpforLightArmoredVehicle == 0 && count _thisAvailableOpforCars != 0) then 
				// {
				// 	_thisAvailableOpforLightArmoredVehicle = _thisAvailableOpforCars;
				// };

				if (count _thisAvailableOpforHeavyArmoredVehicle == 0 && count _thisAvailableOpforLightArmoredVehicle != 0) then 
				{
					_thisAvailableOpforHeavyArmoredVehicle = _thisAvailableOpforLightArmoredVehicle;
				};

				//50% chance to spawn light armored vehicle
				if (random 100 < 50) then 
				{
					if (count _thisAvailableOpforLightArmoredVehicle != 0 ) then 
					{
						_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 0, 0, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
						if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
						{
							_currentEnemyCars = [[selectRandom _thisAvailableOpforLightArmoredVehicle], _safeVehicleSpawn, east, "LightArmored"] call doGenerateEnemyGroup;
						};
					};
				} else {
					//50% generate heavy vehicle
					if (count _thisAvailableOpforHeavyArmoredVehicle != 0) then 
					{
						_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 0, 0, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
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
					_safeVehicleSpawn = [_thisAvailablePosition, 2, 200, 7, 0, 0, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
					if !([_safeVehicleSpawn , [0,0,0]] call BIS_fnc_areEqual) then 
					{
						_currentEnemyCars = [[selectRandom _thisAvailableOpforCars], _safeVehicleSpawn, east, "Car"] call doGenerateEnemyGroup;
					};
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
		[currentGroup, getPos (leader currentGroup), 80, true] call doGarrison;
	};
};

diag_log format ["End generation AO %1",_thisAvailablePosition];