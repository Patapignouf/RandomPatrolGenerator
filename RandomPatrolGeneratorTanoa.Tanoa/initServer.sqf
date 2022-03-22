//Init Location functions
#include "engine\searchLocation.sqf"
#include "database\objectLibrary.sqf"

//Init checkdeath
[] execVM 'engine\checkdeath.sqf';

//Init base mission parameters 
difficultyParameter = "Difficulty" call BIS_fnc_getParamValue;
lengthParameter = "MissionLength" call BIS_fnc_getParamValue;
civFaction = "CivFaction" call BIS_fnc_getParamValue;
opFaction = "OpFaction" call BIS_fnc_getParamValue;
bluFaction = "BluFaction" call BIS_fnc_getParamValue;
indFaction = "IndFaction" call BIS_fnc_getParamValue;

/////////////////////////
//////Find Assets////////
/////////////////////////

//FriendlyGroupDefinition
bluforUnarmedVehicle = bluforUnarmedVehicle_db select {_x select 1  == bluFaction} select 0 select 0;

bluforArmedVehicle = bluforArmedVehicle_db select {_x select 1  == bluFaction} select 0 select 0;

//IndGroupDefinition

ind_group = ind_group_db select {_x select 1  == indFaction} select 0 select 0;

//CivilianGroupDefinition
civilian_group = civilian_group_db select {_x select 1  == civFaction} select 0 select 0;

civilian_big_group = civilian_big_group_db select {_x select 1  == civFaction} select 0 select 0;

civilianTruck = civilianTruck_db select {_x select 1  == civFaction} select 0 select 0;

//EnemyGroupDefinition
baseEnemyGroup = baseEnemyGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyATGroup = baseEnemyATGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyDemoGroup = baseEnemyDemoGroup_db select {_x select 1  == opFaction} select 0 select 0;

baseEnemyMortarGroup = baseEnemyMortarGroup_db select {_x select 1  == opFaction} select 0 select 0;

//avalaibleAmmoBox = [];

//avalaibleSupplyBox = [];

//avalaibleHVT = [];



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


//EnemyWaveGroups = [EnemyWaveLevel_1,EnemyWaveLevel_2,EnemyWaveLevel_3,EnemyWaveLevel_4,EnemyWaveLevel_5,EnemyWaveLevel_6,EnemyWaveLevel_7,EnemyWaveLevel_8,EnemyWaveLevel_9,EnemyWaveLevel_10];
EnemyWaveGroups = [EnemyWaveLevel_1,EnemyWaveLevel_6,EnemyWaveLevel_8];

publicVariable "EnemyWaveGroups";

/////////////////////////
/////Find locations//////
/////////////////////////

//InitLogicDefinition 
possibleInitLocation = [] call getRandomCenterLocations;
initCityLocation = selectRandom possibleInitLocation;
publicVariable "initCityLocation";
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

//Setup init Civ city
[[text initCityLocation,"ColorBlue","loc_help",getPos initCityLocation, "All"], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
currentTruck = selectRandom civilianTruck;
logiTruck = createVehicle [currentTruck, ((getPos initCityLocation) findEmptyPosition [5, 70, currentTruck]), [], 0, "NONE"];


/////////////////////////
///Generate Objectives///
/////////////////////////

//Define 3 objectives
SupplyPositions = [];
SelectedObjectivePosition = objNull;
//SupplyObjects = [[o1,"supply"],[o2,"ammo"],[o3,"ammo"],[o4,"vip"],[o5,"hvt"]];
SupplyObjects = [];
currentObjType = nil;
currentRandomPos = [];
currentObj = objNull;
currentRandObj = objNull;
for [{_i = 0}, {_i <= lengthParameter}, {_i = _i + 1}] do //Peut être optimisé
{
	currentObjType = selectRandom avalaibleTypeOfObj;
	currentRandomPos = [nil, ["ground"]] call BIS_fnc_randomPos;
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
				currentObj = leader ([currentRandomPos, east, [selectRandom avalaibleHVT],[],[],[],[],[],180] call BIS_fnc_spawnGroup);
			};
		case "vip":
			{
				currentObj = leader ([currentRandomPos, civilian, [selectRandom avalaibleVIP],[],[],[],[],[],180] call BIS_fnc_spawnGroup);
			};
		default { hint "default" };
	};
	SupplyObjects pushBack [currentObj,currentObjType];
};

publicVariable "SupplyObjects";
SelectedObjectives = [];
publicVariable "SelectedObjectives";
CompletedObjectives = [];
publicVariable "CompletedObjectives";

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
	EnemyWaveSpawnPositions pushBack (selectRandom possibleEnemyWaveSpawnPositions);
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
	
	currentCivGroup = [((getPos initCityLocation) findEmptyPosition [10, 60]), civilian, civilian_big_group,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	civsGroup pushBack currentCivGroup;
	diag_log format ["Generation of civilian group : %1 on position %2 has been completed", currentCivGroup, initCityLocation];
};

[civsGroup, false] execVM 'enemyManagement\doGarrison.sqf';

/////////////////////////
////Generate Ind/////////
/////////////////////////

//Define independent stuff
{
	if (side _x == independent) then 
	{
		_x setUnitLoadout (getUnitLoadout (configFile >> "CfgVehicles" >> (selectRandom ind_group)));
	};
} foreach allPlayers;


/////////////////////////
///////Generate AO///////
/////////////////////////
tempSupplyObjects = SelectedObjectives;
currentObject = objNull;
{
	currentObject = selectRandom tempSupplyObjects;
	tempSupplyObjects = tempSupplyObjects - [currentObject];
	diag_log format ["Objective generation started : %1 on position %2", currentObject, _x];
	[EnemyWaveLevel_1, civilian_group ,_x,difficultyParameter,currentObject] execVM 'enemyManagement\generatePOI.sqf'; 

} forEach SupplyPositions;


//IA taskPatrol with level 1 enemy
[EnemyWaveLevel_1,AmbushPositions,difficultyParameter] execVM 'enemyManagement\generatePatrol.sqf'; 

//Generate Wave
if (1 <= (count EnemyWaveSpawnPositions)) then 
{
	[EnemyWaveGroups,EnemyWaveSpawnPositions,initCityLocation,difficultyParameter] execVM 'enemyManagement\generateWave.sqf'; 
};



/////////////////////////
////Generate Blufor//////
/////////////////////////
selectedBluforVehicle =[];
aoSize = 1500;

// Get smallest distance to an AO
areaOfOperation = [possiblePOILocation] call getAreaOfMission;
initBlueforLocation = [getPos initCityLocation, (aoSize+500), (aoSize+1500), 8, 0, 0.25, 0, [areaOfOperation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
//Safe position
initBlueforLocation = [selectMax [selectMin [initBlueforLocation select 0, worldSize-50 ],50],selectMax [selectMin [initBlueforLocation select 1, worldSize-50],50]]; 

//Generate FOB
spawnFOBObjects = [([initBlueforLocation, 1, 25, 30, 0, 20, 0] call BIS_fnc_findSafePos), (random 360), selectRandom avalaibleFOB] call BIS_fnc_ObjectsMapper;					
initBlueforLocation = getPos (spawnFOBObjects select 0);
publicvariable "initBlueforLocation";

VA setPos ([initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);

	
//Generate vehicle
for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
{
	selectedBluforVehicle pushBack (selectRandom bluforUnarmedVehicle);
};

for [{_i = 0}, {_i < 1}, {_i = _i + 1}] do
{
	selectedBluforVehicle pushBack (selectRandom bluforArmedVehicle);
};

{
	createVehicle [_x, (initBlueforLocation findEmptyPosition [10, 60, _x]), [], 0, "NONE"];
}
foreach selectedBluforVehicle;

//Setup random attack on blufor at the beginning
if (round (random 4) == 0) then
{
	[EnemyWaveSpawnPositions,initBlueforLocation,EnemyWaveLevel_1,difficultyParameter] execVM 'enemyManagement\doAmbush.sqf'; 
	if (round (random 1) == 0) then
	{
		[["Le QG vous informe qu'une attaque est possiblement en cours sur vos positions dans une quizaine de minutes, quittez les lieux avant leur arrivée.",blufor], 'engine\doGenerateMessage.sqf'] remoteExec ['BIS_fnc_execVM', 0];
	};
};
