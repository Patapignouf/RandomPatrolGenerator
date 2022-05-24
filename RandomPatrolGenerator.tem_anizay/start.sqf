//Init Location functions
#include "engine\searchLocation.sqf"
#include "database\objectLibrary.sqf"
#include "objectGenerator\vehicleManagement.sqf"
#include "enemyManagement\groupGenerator.sqf"


//Init base mission parameters 
difficultyParameter = "Difficulty" call BIS_fnc_getParamValue;
enableArmored = "EnableArmored" call BIS_fnc_getParamValue;
enablePlane = "EnablePlane" call BIS_fnc_getParamValue;
lengthParameter = "MissionLength" call BIS_fnc_getParamValue;
civFaction = "CivFaction" call BIS_fnc_getParamValue;
opFaction = "OpFaction" call BIS_fnc_getParamValue;
bluFaction = "BluFaction" call BIS_fnc_getParamValue;
indFaction = "IndFaction" call BIS_fnc_getParamValue;
enableInitAttack = "EnableInitAttack" call BIS_fnc_getParamValue;
enableInitBluAttack = "EnableInitBluAttack" call BIS_fnc_getParamValue;
enableOpforMortar = "EnableOpforMortar" call BIS_fnc_getParamValue;
initBluforBase = "InitBluforBase" call BIS_fnc_getParamValue;
missionInitSetup = "MissionInitSetup" call BIS_fnc_getParamValue;



/////////////////////////
////Setup IA Opti////////
/////////////////////////
enableDynamicSimulationSystem true; 
"Group" setDynamicSimulationDistance 1500;
"Vehicle" setDynamicSimulationDistance 2500;
"EmptyVehicle" setDynamicSimulationDistance 1000;



/////////////////////////
//////Find Assets////////
/////////////////////////

//FriendlyGroupDefinition
bluforUnarmedVehicle = bluforUnarmedVehicle_db select {_x select 1  == bluFaction} select 0 select 0;
missionNamespace setVariable ["bluforUnarmedVehicle", bluforUnarmedVehicle, true];

bluforArmedVehicle = bluforArmedVehicle_db select {_x select 1  == bluFaction} select 0 select 0;
missionNamespace setVariable ["bluforArmedVehicle", bluforArmedVehicle, true];

bluforUnarmedVehicleChopper = bluforUnarmedVehicleChopper_db select {_x select 1  == bluFaction} select 0 select 0;
missionNamespace setVariable ["bluforUnarmedVehicleChopper", bluforUnarmedVehicleChopper, true];

bluforDrone = bluforDrone_db select {_x select 1  == bluFaction} select 0 select 0;

bluforBoat = bluforBoat_db select {_x select 1  == bluFaction} select 0 select 0;

//CivilianGroupDefinition
civilian_group = civilian_group_db select {_x select 1  == civFaction} select 0 select 0;

civilian_big_group = civilian_big_group_db select {_x select 1  == civFaction} select 0 select 0;

civilianTruck = civilianTruck_db select {_x select 1  == civFaction} select 0 select 0;

//EnemyGroupDefinition
baseEnemyGroup = baseEnemyGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyATGroup = baseEnemyATGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyDemoGroup = baseEnemyDemoGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyMortarGroup = baseEnemyMortarGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyVehicleGroup = baseEnemyVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyLightArmoredVehicleGroup = baseEnemyLightArmoredVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyHeavyArmoredVehicleGroup = baseEnemyHeavyArmoredVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;

//Enemy Wave Composition, needs to be completely rework
EnemyWaveLevel_1 = [baseEnemyGroup,baseEnemyATGroup];
EnemyWaveLevel_2 = [baseEnemyGroup,baseEnemyATGroup];
EnemyWaveLevel_3 = [baseEnemyGroup,baseEnemyATGroup];
EnemyWaveLevel_4 = [baseEnemyGroup,baseEnemyATGroup];
EnemyWaveLevel_5 = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup];
EnemyWaveLevel_6 = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup];
EnemyWaveLevel_7 = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup];
EnemyWaveLevel_8 = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup,baseEnemyMortarGroup];
EnemyWaveLevel_9 = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup,baseEnemyMortarGroup];
EnemyWaveLevel_10 = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup,baseEnemyMortarGroup];

EnemyWaveGroups = [EnemyWaveLevel_1,EnemyWaveLevel_6,EnemyWaveLevel_8];
publicvariable "EnemyWaveGroups";

/////////////////////////
/////Find locations//////
/////////////////////////



//InitLogicDefinition 
possibleInitLocation = [] call getRandomCenterLocations;
initCityLocation = selectRandom possibleInitLocation;
publicvariable "initCityLocation";
possiblePOILocation = ([initCityLocation, 2500] call getLocationsAround) - [initCityLocation];
dangerAreaList = [];

if ( count possiblePOILocation < lengthParameter + 1) then 
{
	possiblePOILocation = ([initCityLocation, 4000] call getLocationsAround) - [initCityLocation];
};

//Search road around AO
possibleAmbushPosition = [];
tempPossibleAmbush = [];
currentAO = objNull;
_distance = 0;
{
	currentAO = _x;
	tempPossibleAmbush = (getPos _x) nearRoads 750;
	{
		_distance = (getPos _x) distance (getPos currentAO);
		if (350<_distance && _distance<750) then	//Il faudrait tester si ce n'est pas trop près des villes adjacentes
		{
			possibleAmbushPosition pushBack _x;
		};		
	}
	foreach tempPossibleAmbush;
} foreach possiblePOILocation;

numberOfAmbush = (lengthParameter+1)*4;
AmbushPositions = [];
for [{_i = 0}, {_i < numberOfAmbush}, {_i = _i + 1}] do
{
	AmbushPositions pushBack (selectRandom possibleAmbushPosition);
	possibleAmbushPosition = possibleAmbushPosition - [AmbushPositions select ((count AmbushPositions)-1)];
};
PossibleObjectivePosition = possiblePOILocation;

for [{_i = 0}, {_i <= 2}, {_i = _i + 1}] do //Peut être optimisé
{
	_currentTruckType = selectRandom civilianTruck;
	_currentTruckPosition = [getPos initCityLocation, 2, 100, 10, 10, 0.25, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if !([_currentTruckPosition , [0,0,0]] call BIS_fnc_areEqual) then 
	{
		_currentTruck = createVehicle [_currentTruckType, _currentTruckPosition, [], 0, "NONE"];
	};
};

/////////////////////////
///Generate Objectives///
/////////////////////////

//Define 3 objectives
SupplyPositions = [];
SelectedObjectivePosition = objNull;
SupplyObjects = [];
currentObjType = nil;
currentRandomPos = [];
currentObj = objNull;
currentRandObj = objNull;
for [{_i = 0}, {_i <= lengthParameter}, {_i = _i + 1}] do //Peut être optimisé
{
	currentObjType = selectRandom avalaibleTypeOfObj;
	currentRandomPos = [] call BIS_fnc_randomPos;
	switch (currentObjType) do
	{
		case "supply":
			{
				currentObj = createVehicle [selectRandom avalaibleSupplyBox, currentRandomPos, [], 0, "NONE"];
			};
		case "ammo":
			{
				currentObj = createVehicle [selectRandom avalaibleAmmoBox, currentRandomPos, [], 0, "NONE"];
			};
		case "hvt":
			{
				currentObj = leader ([currentRandomPos, east, [selectRandom avalaibleHVT],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
			};
		case "vip":
			{
				currentObj = leader ([currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
			};
		case "steal":
			{
				currentObj = createVehicle [selectRandom avalaibleStealVehicle, currentRandomPos, [], 0, "NONE"];
			};
		case "clearArea":
			{
				//Add trigger to detect cleared area
				currentObj = createTrigger ["EmptyDetector", currentRandomPos]; //create a trigger area created at object with variable name my_object
			};
		case "collectIntel":
			{
				//Add intel action to the intel case
				currentObj = createVehicle [selectRandom avalaibleCollectIntel, currentRandomPos, [], 0, "NONE"];
			};
		case "informant":
			{
				//Add dialog to the informant
				currentObj = leader ([currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup);
			};
		default { hint "default" };
	};
	SupplyObjects pushBack [currentObj, currentObjType];
};

publicvariable "SupplyObjects";
SelectedObjectives = [];
publicvariable "SelectedObjectives";

tempSupplyObjects = SupplyObjects;
for [{_i = 0}, {_i <= lengthParameter}, {_i = _i + 1}] do //Peut être optimisé en fusionnant cette boucle avec la boucle précédente
{
	SelectedObjectives pushBack (selectRandom tempSupplyObjects);
	tempSupplyObjects = tempSupplyObjects - [SelectedObjectives select (count SelectedObjectives - 1)];
	SelectedObjectivePosition = selectRandom PossibleObjectivePosition;
	SupplyPositions pushBack SelectedObjectivePosition;
	PossibleObjectivePosition = PossibleObjectivePosition - [SelectedObjectivePosition];
};


//check wave spawn 
EnemyWaveSpawnPositions = [];
numberOfSpawnWave = 4;
possibleEnemyWaveSpawnPositions = (([initCityLocation, 2000] call getLocationsAround) - [initCityLocation]) - SupplyPositions;

for [{_i = 0}, {_i < numberOfSpawnWave}, {_i = _i + 1}] do
{
	EnemyWaveSpawnPositions pushBack (getPos (selectRandom possibleEnemyWaveSpawnPositions));
};


//Init checkobjective
[SelectedObjectives,initCityLocation] execVM 'engine\checkobjective.sqf';


/////////////////////////
////Generate Civ/////////
/////////////////////////

//IA civilian taskGarrison
diag_log format ["Begin generation of civilian AO : %1 on position %2", civilian_big_group, initCityLocation];
currentCivGroup = objNull;
civsGroup = [];
for [{_i = 0}, {_i <= 2}, {_i = _i + 1}] do
{ 
	
	currentCivGroup = [((getPos initCityLocation) findEmptyPosition [5, 60]), civilian, civilian_big_group,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	civsGroup pushBack currentCivGroup;
	diag_log format ["Generation of civilian group : %1 on position %2 has been completed", currentCivGroup, initCityLocation];
};

[civsGroup, false] execVM 'enemyManagement\doGarrison.sqf';

{
	if (side _x == civilian) then
	{
		_x addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			diag_log format ["Civilian has been killed by : %1", name _killer];
			[[format ["Civilian has been killed by : %1", name _killer],independent], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		}];
	};
} foreach allUnits;

//Init VA
VA1 = createVehicle ["Box_IND_Wps_F", [getPos initCityLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal VA1;
clearMagazineCargoGlobal VA1;
clearItemCargoGlobal VA1;
clearBackpackCargoGlobal VA1;
publicvariable "VA1";


/////////////////////////
////Generate Ind/////////
/////////////////////////

//Init attack management on ind
isIndAttacked = false;
publicvariable "isIndAttacked";
AvalaibleInitAttackPositions = [];
AvalaibleInitAttackPositions = [getPos initCityLocation, 1200,1400,difficultyParameter] call getListOfPositionsAroundTarget;
if ( count AvalaibleInitAttackPositions != 0 && (enableInitAttack == 1 || ((enableInitAttack == 2) && (round (random 1))==0))) then
{
	diag_log "Init attack on independent city";
	_handleCivGeneration = [AvalaibleInitAttackPositions,getPos initCityLocation,[baseEnemyGroup,baseEnemyATGroup],baseEnemyVehicleGroup,difficultyParameter] execVM 'enemyManagement\doAmbush.sqf'; 
	isIndAttacked = true;
	publicvariable "isIndAttacked";
	waitUntil {isNull _handleCivGeneration};
};

//Init prema harass on player
[[baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup],baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup] execVM 'enemyManagement\generateHarass.sqf'; 

/////////////////////////
///////Generate AO///////
/////////////////////////
tempSupplyObjects = SelectedObjectives;
currentObject = objNull;
// Get smallest distance to an AO
areaOfOperation = [possiblePOILocation] call getAreaOfMission;
aoSize = 1500;

{
	currentObject = selectRandom tempSupplyObjects;
	tempSupplyObjects = tempSupplyObjects - [currentObject];
	diag_log format ["Objective generation started : %1 on position %2", currentObject, _x];
	
	//Generate mission environement
	_handlePOIGeneration = [EnemyWaveLevel_1, baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, civilian_group ,_x,difficultyParameter] execVM 'enemyManagement\generatePOI.sqf'; 
	waitUntil {isNull _handlePOIGeneration};

	//Generate mission objectives
	_handlePOIGeneration = [currentObject, _x] execVM 'engine\doGenerateObjective.sqf'; 
	waitUntil {isNull _handlePOIGeneration};

} forEach SupplyPositions;


//IA taskPatrol with level 1 enemy
[EnemyWaveLevel_1,AmbushPositions,difficultyParameter] execVM 'enemyManagement\generatePatrol.sqf'; 

//Generate Wave
if (1 <= (count EnemyWaveSpawnPositions)) then 
{
	[EnemyWaveGroups,EnemyWaveSpawnPositions,initCityLocation,difficultyParameter] execVM 'enemyManagement\generateWave.sqf'; 
};

//Generate mortar
for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
{ 
	_mortarSpawnPosition = [getPos initCityLocation, (800), (aoSize+700), 3, 10, 0.25, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if !([_mortarSpawnPosition , [0,0,0]] call BIS_fnc_areEqual) then 
	{
		_mortarGroup = [baseEnemyMortarGroup, _mortarSpawnPosition, east, "Mortar"] call doGenerateEnemyGroup;
	};
};

//Generate Civs dialogs
//[] execVM 'enemyManagement\generateCivDialogs.sqf'; 
//[] remoteExec ['enemyManagement\generateCivDialogs.sqf',0];

/////////////////////////
////Generate Blufor//////
/////////////////////////

//Generate blufor FOB Location


//Init
selectedBluforVehicle =[];
selectedBluforAirDroneVehicle = [];
vehicleGoodPosition = [];
initBlueforLocation = [];
bluforShortFrequencyTFAR = (((round random 400)+400)/10);
publicvariable "bluforShortFrequencyTFAR";

//TODO create the random option
if (initBluforBase == 0 || (initBluforBase == 2 && (round random 1 == 0))) then
{
	initBlueforLocation = [getPos initCityLocation, (aoSize+400), (aoSize+700), 3, 0, 0.25, 0, [areaOfOperation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if ([initBlueforLocation , [0,0,0]] call BIS_fnc_areEqual) then
	{
		initBlueforLocation = [getPos initCityLocation, (aoSize+400), (aoSize+1500), 3, 0, 0.25, 0, [areaOfOperation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	};
	
	//Safe position
	initBlueforLocation = [selectMax [selectMin [initBlueforLocation select 0, worldSize-50 ],50],selectMax [selectMin [initBlueforLocation select 1, worldSize-50],50]]; 
	
	//Clean area WIP
	waitUntil {count allPlayers != 0};
	
	//Generate FOB
	spawnFOBObjects = [initBlueforLocation, (random 360), selectRandom avalaibleFOB] call BIS_fnc_ObjectsMapper;
	sleep 3;

	initBlueforLocation = getPos (spawnFOBObjects select 0);	
	publicvariable "initBlueforLocation";
	waitUntil {!isNil "spawnFOBObjects"};
} else 
{
	initBlueforLocation = [getPos initCityLocation, (aoSize+2000), (aoSize+4000), 3, 0, 0.25, 0, [areaOfOperation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	//Safe position
	initBlueforLocation = [selectMax [selectMin [initBlueforLocation select 0, worldSize-50 ],50],selectMax [selectMin [initBlueforLocation select 1, worldSize-50],50]]; 
	
	//Generate FOB
	spawnFOBObjects = [initBlueforLocation, (random 360), selectRandom avalaibleFOB] call BIS_fnc_ObjectsMapper;
	sleep 3;
		
	initBlueforLocation = getPos (spawnFOBObjects select 0);
	publicvariable "initBlueforLocation";
	waitUntil {!isNil "spawnFOBObjects"};
	
	//Generate air vehicle
	if (0 < count bluforUnarmedVehicleChopper ) then 
	{
		for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
		{
			selectedBluforVehicle pushBack (selectRandom bluforUnarmedVehicleChopper);
		};
	};
		
    //Generate air drone vehicle
	if (0 < count bluforDrone ) then 
	{
		selectedBluforAirDroneVehicle pushBack (selectRandom bluforDrone);
		{
			currentGroup = [([[initBlueforLocation select 0, initBlueforLocation select 1, (initBlueforLocation select 2)+400],1,60,10,0] call BIS_fnc_findSafePos), blufor, [_x],[],[],[],[],[],0] call BIS_fnc_spawnGroup;
		}
		foreach selectedBluforAirDroneVehicle;
	};
};
[["FOB","ColorBlue","loc_Fortress",initBlueforLocation, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	
//Clean area WIP
[initBlueforLocation, 150] execVM 'objectGenerator\doCleanArea.sqf'; 				

//Generate ground vehicle
vehicleGoodPosition = [];
if (0 < count bluforUnarmedVehicle ) then 
{
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{
		selectedBluforVehicle pushBack (selectRandom bluforUnarmedVehicle);
	};
};

if (0 < count bluforArmedVehicle ) then 
{
	for [{_i = 0}, {_i < 1}, {_i = _i + 1}] do
	{
		selectedBluforVehicle pushBack (selectRandom bluforArmedVehicle);
	};
};

//Generate Boat
if (0 < count bluforBoat ) then 
{
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{
		selectedBluforVehicle pushBack (selectRandom bluforBoat);
	};
};


//Generate all vehicles
diag_log format ["Generating blufor vehicle : %1",selectedBluforVehicle];
[initBlueforLocation, selectedBluforVehicle, 30, 100] call doGenerateVehicleForFOB;	

//Init VA
VA2 = createVehicle ["B_supplyCrate_F", [initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal VA2;
clearMagazineCargoGlobal VA2;
clearItemCargoGlobal VA2;
clearBackpackCargoGlobal VA2;
publicvariable "VA2";

//Place empty box to blufor camp
{
	_tempBox = createVehicle [_x, [ initBlueforLocation, 1, 15, 2, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
	clearWeaponCargoGlobal _tempBox;
	clearMagazineCargoGlobal _tempBox;
	clearItemCargoGlobal _tempBox;
	clearBackpackCargoGlobal _tempBox;
} foreach ["Box_NATO_Uniforms_F", "ACE_Box_82mm_Mo_Combo", "Box_NATO_Equip_F"];


//Setup view distance changer
SettingsComputer =  createVehicle ["Land_MultiScreenComputer_01_olive_F", [initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
{
	[SettingsComputer, [format ["Set view distance to %1",_x],{
				params ["_object","_caller","_ID","_viewDistance"];
				//Select ViewDistance
				setViewDistance _viewDistance;
			},_x,1.5,true,true,"","_target distance _this <5"]] remoteExec ["addAction"];
} foreach [-1,300,500,1000,1500,2000,2500];

TPFlag1 = createVehicle ["Flag_Blue_F", [initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
publicvariable "TPFlag1";

//Setup random attack on blufor at the beginning
isBluforAttacked = false;
publicvariable "isBluforAttacked";

AvalaibleInitAttackPositions = [];
AvalaibleInitAttackPositions = [initBlueforLocation, 800,1000,difficultyParameter] call getListOfPositionsAroundTarget;
if ( count AvalaibleInitAttackPositions != 0 && (enableInitBluAttack == 1 || ((enableInitBluAttack == 2) && (round (random 4))==0))) then
{
	diag_log "Init attack on blufor FOB";
	[AvalaibleInitAttackPositions,initBlueforLocation,[baseEnemyGroup,baseEnemyATGroup],baseEnemyVehicleGroup,difficultyParameter] execVM 'enemyManagement\doAmbush.sqf'; 
	isBluforAttacked = true;
	publicvariable "isBluforAttacked";
};

////////////////////////////
///// MissionInitSetup /////
////////////////////////////

//Case where blufor has objective on start

switch (missionInitSetup) do
{
	case 1:
		{
			//Setup init Civ city
			[[text initCityLocation,"ColorBlue","loc_help",getPos initCityLocation, "All"], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
		};
	case 2:
		{
			for [{_i = 0}, {_i <= lengthParameter}, {_i = _i + 1}] do //Peut être optimisé
			{
				[] execVM 'engine\revealObjective.sqf';
			};
		};
	default
		{
			//
		};
};

//Init garbage collector
[] execVM 'engine\garbageCollector.sqf'; 

//Disable respawn for IA Unit
{
	_x addMPEventHandler ["MPRespawn", {
		_unit = _this select 0;
		if (!isPlayer _unit) exitWith {
			deleteVehicle _unit;
		};
	}
];
} forEach playableUnits;


//Init checkdeath
[] execVM 'engine\checkdeath.sqf';

missionGenerated = true;
publicvariable "missionGenerated";