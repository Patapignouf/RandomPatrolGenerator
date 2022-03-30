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
enableInitAttack = "EnableInitAttack" call BIS_fnc_getParamValue;
enableInitBluAttack = "EnableInitBluAttack" call BIS_fnc_getParamValue;
initBluforBase = "InitBluforBase" call BIS_fnc_getParamValue;

/////////////////////////
//////Find Assets////////
/////////////////////////

//FriendlyGroupDefinition
bluforUnarmedVehicle = bluforUnarmedVehicle_db select {_x select 1  == bluFaction} select 0 select 0;

bluforArmedVehicle = bluforArmedVehicle_db select {_x select 1  == bluFaction} select 0 select 0;

bluforUnarmedVehicleChopper = bluforUnarmedVehicleChopper_db select {_x select 1  == bluFaction} select 0 select 0;

bluforDrone = bluforDrone_db select {_x select 1  == bluFaction} select 0 select 0;


//IndGroupDefinition

ind_group = ind_group_db select {_x select 1  == indFaction} select 0 select 0;
publicvariable "ind_group";

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

publicvariable "SupplyObjects";
SelectedObjectives = [];
publicvariable "SelectedObjectives";
CompletedObjectives = [];
publicvariable "CompletedObjectives";

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
	[AvalaibleInitAttackPositions,getPos initCityLocation,[baseEnemyGroup,baseEnemyATGroup,[selectRandom baseEnemyVehicleGroup]],difficultyParameter] execVM 'enemyManagement\doAmbush.sqf'; 
	isIndAttacked = true;
	publicvariable "isIndAttacked";
};

//Init prema harass on player
[[baseEnemyGroup,baseEnemyATGroup,[selectRandom baseEnemyVehicleGroup]],difficultyParameter] execVM 'enemyManagement\generateHarass.sqf'; 

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

//Generate blufor FOB Location


//Init
selectedBluforVehicle =[];
selectedBluforAirVehicle = [];
selectedBluforAirDroneVehicle = [];
vehicleGoodPosition = [];
spawnAttempts = 0;
// Get smallest distance to an AO
areaOfOperation = [possiblePOILocation] call getAreaOfMission;
initBlueforLocation = [];
aoSize = 1500;

//TODO create the random option
if (initBluforBase == 0 || (initBluforBase == 2 && (round random 1 == 0))) then
{
	initBlueforLocation = [getPos initCityLocation, (aoSize+500), (aoSize+1500), 50, 0, 0.25, 0, [areaOfOperation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	//Safe position
	initBlueforLocation = [selectMax [selectMin [initBlueforLocation select 0, worldSize-50 ],50],selectMax [selectMin [initBlueforLocation select 1, worldSize-50],50]]; 
	
	//Clean area WIP
	waitUntil {count allPlayers != 0};
	[initBlueforLocation,50] execVM 'objectGenerator\doCleanArea.sqf'; 
	
	//Generate FOB
	spawnFOBObjects = [initBlueforLocation, (random 360), selectRandom avalaibleFOB] call BIS_fnc_ObjectsMapper;	
	initBlueforLocation = getPos (spawnFOBObjects select 0);	
	publicvariable "initBlueforLocation";
} else 
{
	initBlueforLocation = [getPos initCityLocation, (aoSize+1500), (aoSize+3500), 50, 0, 0.25, 0, [areaOfOperation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	//Safe position
	initBlueforLocation = [selectMax [selectMin [initBlueforLocation select 0, worldSize-50 ],50],selectMax [selectMin [initBlueforLocation select 1, worldSize-50],50]]; 
	
	//Clean area WIP
	[initBlueforLocation,50] execVM 'objectGenerator\doCleanArea.sqf'; 
	
	//Generate FOB
	spawnFOBObjects = [initBlueforLocation, (random 360), selectRandom avalaibleFOB] call BIS_fnc_ObjectsMapper;	
	initBlueforLocation = getPos (spawnFOBObjects select 0);
	publicvariable "initBlueforLocation";
	waitUntil {!isNil "spawnFOBObjects"};
	
	//Generate air vehicle
	for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
	{
		selectedBluforAirVehicle pushBack (selectRandom bluforUnarmedVehicleChopper);
	};
	
	{	
		spawnAttempts = 0;
		//vehicleGoodPosition = (initBlueforLocation findEmptyPosition [10, 60, "Land_HelipadCircle_F"]);
		//vehicleGoodPosition = initBlueforLocation isFlatEmpty [10,-1,10,50];
		vehicleGoodPosition = [initBlueforLocation, 15, 150, 25, 0, 0.25, 0] call BIS_fnc_findSafePos;
		while {(isNil "vehicleGoodPosition" || count vehicleGoodPosition==0) && spawnAttempts <10} do 
		{
			//vehicleGoodPosition = (initBlueforLocation findEmptyPosition [10, 60, "Land_HelipadCircle_F"]);
			//vehicleGoodPosition = initBlueforLocation isFlatEmpty [10,-1,10,50];
			vehicleGoodPosition = [initBlueforLocation, 15, 150, 25, 0, 0.25, 0] call BIS_fnc_findSafePos;
			spawnAttempts = spawnAttempts +1;
		};
		if (!isNil "vehicleGoodPosition"&& count vehicleGoodPosition>0) then 
		{
			diag_log format ["Position to spawn chopper is not Nil %1",vehicleGoodPosition];
			createVehicle ["Land_HelipadCircle_F", vehicleGoodPosition , [], 0, "NONE"];
			createVehicle [_x, [vehicleGoodPosition select 0,vehicleGoodPosition select 1]  , [], 0, "NONE"];
		};
	}
	foreach selectedBluforAirVehicle;
	
    //Generate air drone vehicle
	selectedBluforAirDroneVehicle pushBack (selectRandom bluforDrone);
	{
		//createVehicle [_x, (initBlueforLocation findEmptyPosition [40, 150, _x]), [], 10, "FLY"];
		currentGroup = [([[initBlueforLocation select 0, initBlueforLocation select 1, (initBlueforLocation select 2)+400],1,60,10,0] call BIS_fnc_findSafePos), blufor, [_x],[],[],[],[],[],0] call BIS_fnc_spawnGroup;
	}
	foreach selectedBluforAirDroneVehicle;
	
	
};
[["FOB","ColorBlue","loc_Fortress",initBlueforLocation, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];				


//Init VA
//VA setPos ([initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos);
VA2 = createVehicle ["B_supplyCrate_F", [initBlueforLocation, 1, 5, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal VA2;
clearMagazineCargoGlobal VA2;
clearItemCargoGlobal VA2;

// ["AmmoboxExit", VA2] call BIS_fnc_arsenal;
// [VA2,((weaponCargo VA2) + weaponList )] call BIS_fnc_addVirtualWeaponCargo;
// [VA2,((backpackCargo VA2) + backpacksList)] call BIS_fnc_addVirtualBackpackCargo;
// //[VA2,((itemCargo VA2) + _availableHeadgear + _availableUniforms + _availableVests)] call BIS_fnc_addVirtualItemCargo;
// //[VA2,((magazineCargo VA2) + _availablemagazinecargoindependent )] call BIS_fnc_addVirtualMagazineCargo;
// [VA2,((weaponCargo VA2) + attachmentList )] call BIS_fnc_addVirtualItemCargo;



// //["AmmoboxInit",[VA2,false,{(_target getVariable "role" == "leader")||true}]] call BIS_fnc_arsenal;
// ["AmmoboxInit",[VA2,false,{true}]] call BIS_fnc_arsenal;
publicvariable "VA2";
	
//Generate vehicle
vehicleGoodPosition = [];
for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
{
	selectedBluforVehicle pushBack (selectRandom bluforUnarmedVehicle);
};

for [{_i = 0}, {_i < 1}, {_i = _i + 1}] do
{
	selectedBluforVehicle pushBack (selectRandom bluforArmedVehicle);
};

{
		spawnAttempts = 0;
		vehicleGoodPosition = (initBlueforLocation findEmptyPosition [10, 60, _x]);
		while {(isNil "vehicleGoodPosition" || count vehicleGoodPosition==0) && spawnAttempts <10} do 
		{
			vehicleGoodPosition = (initBlueforLocation findEmptyPosition [10, 60, _x]);
			spawnAttempts = spawnAttempts +1;
		};
		if (!isNil "vehicleGoodPosition" && count vehicleGoodPosition>0) then 
		{
			diag_log format ["Position to spawn vehicle is not Nil %1",vehicleGoodPosition];
			createVehicle [_x, vehicleGoodPosition , [], 0, "NONE"];
		};
}
foreach selectedBluforVehicle;





//Setup random attack on blufor at the beginning
isBluforAttacked = false;
publicvariable "isBluforAttacked";

AvalaibleInitAttackPositions = [];
AvalaibleInitAttackPositions = [initBlueforLocation, 800,1000,difficultyParameter] call getListOfPositionsAroundTarget;
if ( count AvalaibleInitAttackPositions != 0 && (enableInitBluAttack == 1 || ((enableInitBluAttack == 2) && (round (random 4))==0))) then
{
	diag_log "Init attack on blufor FOB";
	[AvalaibleInitAttackPositions,initBlueforLocation,[baseEnemyGroup,baseEnemyATGroup,[selectRandom baseEnemyVehicleGroup]],difficultyParameter] execVM 'enemyManagement\doAmbush.sqf'; 
	isBluforAttacked = true;
	publicvariable "isBluforAttacked";
};

//Init garbage collector
[] execVM 'engine\garbageCollector.sqf'; 


missionGenerated = true;
publicvariable "missionGenerated";