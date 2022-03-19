//Init Location functions
#include "engine\searchLocation.sqf"

//Add flag interactions
//[[flag1]] execVM 'ctf.sqf';

//Init checkdeath
[] execVM 'engine\checkdeath.sqf';

//Init base mission parameters 
difficultyParameter = "Difficulty" call BIS_fnc_getParamValue;
lengthParameter = "MissionLength" call BIS_fnc_getParamValue;

//Init GroupDefinition
testGroupCivGarrison = ["c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13"];

civilianTruck = ["CUP_I_V3S_Open_TKG"];

bluforUnarmedVehicle = ["CUP_B_M1151_USA"];

bluforArmedVehicle = ["CUP_B_M1151_Deploy_USA"];

//CivilianGroupDefinition
civilian_group = ["CUP_C_TK_Man_06_Coat", 
"CUP_C_TK_Man_05_Coat", 
"CUP_C_TK_Man_08"];

civilian_big_group = ["CUP_C_TK_Man_06_Coat", 
"CUP_C_TK_Man_05_Coat", 
"CUP_C_TK_Man_08", 
"CUP_C_TK_Man_04", 
"CUP_C_TK_Man_03_Jack", 
"CUP_C_TK_Man_02"
];

//EnemyGroupDefinition
baseEnemyGroup = ["CUP_O_TK_INS_Soldier_TL", 
"CUP_O_TK_INS_Soldier_MG", 
"CUP_O_TK_INS_Soldier_GL", 
"CUP_O_TK_INS_Soldier_AT",  
"CUP_O_TK_INS_Soldier", 
"CUP_O_TK_INS_Soldier_AR", 
"CUP_O_TK_INS_Sniper", 
"CUP_O_TK_INS_Soldier_Enfield", 
"CUP_O_TK_INS_Soldier_FNFAL"];

baseEnemyATGroup = ["CUP_O_TK_INS_Soldier_TL", 
"CUP_O_TK_INS_Soldier_AT", 
"CUP_O_TK_INS_Soldier_AT",
"CUP_O_TK_INS_Soldier_AT",
"CUP_O_TK_INS_Soldier"];

baseEnemyDemoGroup = ["CUP_O_TK_INS_Mechanic", 
"CUP_O_TK_INS_Mechanic",
"CUP_O_TK_INS_Bomber",
"CUP_O_TK_INS_Bomber"];

baseEnemyMortarGroup = ["CUP_O_TK_INS_Mechanic", 
"CUP_O_2b14_82mm_TK_INS",
"CUP_O_TK_INS_Bomber"];

avalaibleAmmoBox = ["CUP_BOX_TK_MILITIA_Wps_F", 
"CUP_BOX_TK_MILITIA_Ammo_F"
];

avalaibleSupplyBox = ["ACE_medicalSupplyCrate_advanced", 
"ACE_medicalSupplyCrate"
];

avalaibleHVT = ["CUP_O_TK_Officer"
];

avalaibleVIP = ["CUP_C_TK_Man_03_Waist"
];

avalaibleTypeOfObj = ["supply","ammo","vip","hvt"];

//FOB description from DRO
//Waiting for a PANY FOB
fob1 = [
["Land_HBarrier_5_F",[-7.33789,7.19934,0],270.094,1,0,[0,0],"","",true,false], 
	["Land_Pallets_F",[-9.05835,12.902,0],264.398,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[17.9697,-0.935638,0],90.2135,1,0,[0,-0],"","",true,false], 
	["Land_HBarrierBig_F",[-7.67224,16.7066,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[-14.4656,-12.1106,0],184.122,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[4.32324,-18.77,0],270.353,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-14.2883,-10.0949,0],179.713,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[17.7296,7.38129,0],269.965,1,0,[0,0],"","",true,false], 
	["Land_WaterTank_F",[7.76477,-18.7261,-5.72205e-006],268.373,1,0,[0.000581058,1.90213e-005],"","",true,false], 
	["Land_Pallets_stack_F",[-16.3892,-12.2328,0],270.353,1,0,[-2.43987e-005,-1.25789e-006],"","",true,false], 
	["Land_ToiletBox_F",[-11.4088,17.4513,5.24521e-006],359.815,1,0,[-0.000641798,-0.000366751],"","",true,false], 
	["Land_Tyres_F",[-11.0228,-18.2807,0.00659704],162.138,1,0,[0,-0],"","",true,false], 
	["Land_WaterTank_F",[10.9957,-18.7661,5.24521e-006],268.373,1,0,[0.00207411,-0.00155132],"","",true,false], 
	["Land_Cargo20_military_green_F",[13.434,17.4225,4.76837e-007],106.796,1,0,[-3.53963e-005,4.12904e-006],"","",true,false], 
	["Land_ToiletBox_F",[-13.5955,17.3864,4.76837e-006],359.815,1,0,[-0.000176553,0.000250982],"","",true,false], 
	["Land_HBarrier_5_F",[23.7905,-5.4263,0],181.584,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_open_empty_F",[-9.6665,-20.1551,0],76.4729,1,0,[0,0],"","",true,false], 
	["Land_Cargo20_military_green_F",[7.94397,20.9161,0],96.2963,1,0,[-4.60749e-005,5.49738e-006],"","",true,false], 
	["Land_PaperBox_closed_F",[-17.4805,-14.2681,0],35.8529,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[16.6414,-15.8525,0],150.973,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-20.0004,-14.385,0],270.529,1,0,[0,0],"","",true,false], 
	["Land_Cargo20_military_green_F",[10.7101,20.8058,4.76837e-007],278.791,1,0,[1.26151e-005,2.08784e-006],"","",true,false], 
	["Land_PaperBox_closed_F",[-11.6792,-20.4561,0],3.4345,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[3.71948,25.879,0],90.9567,1,0,[0,-0],"","",true,false], 
	["Land_HBarrierBig_F",[17.6447,16.5574,0],270.353,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-11.0516,21.7983,0],359.745,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-26.6294,2.63609,0],359.441,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[7.50696,-23.9942,0],181.888,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[14.7341,-20.4855,0],127.108,1,0,[0,-0],"","",true,false], 
	["Land_HBarrierBig_F",[-18.1364,18.019,0],304.968,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[25.1033,-9.72986,0],270.353,1,0,[0,0],"","",true,false], 
	["Land_Cargo_Patrol_V3_F",[24.8461,-10.9578,0],269.639,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-19.6694,-19.1063,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[21.6969,-16.8302,0],181.888,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[-26.5153,7.80341,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[14.5088,24.3171,0],228.036,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[25.0844,-15.2732,0],270.353,1,0,[0,0],"","",true,false], 
	["Land_Cargo_Patrol_V3_F",[-27.9869,8.15738,0],88.4909,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-28.1226,6.88979,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[6.9021,27.7117,0],182.276,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-24.9733,14.1209,0],359.745,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[-14.6956,-25.3488,0],224.401,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[0.325562,-29.9501,0],182.48,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[10.9374,-25.7316,0],93.3079,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-28.2957,12.4295,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[5.98071,-30.0578,0],180.916,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-9.01318,-29.685,0],0.132941,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-16.2528,-26.7327,0],45.8939,1,0,[0,0],"","",true,false]
];

avalaibleFOB = [ fob1
];


//Enemy Wave Composition
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



//InitLogicDefinition 
possibleInitLocation = [] call getRandomCenterLocations;
initCityLocation = selectRandom possibleInitLocation;
publicVariable "initCityLocation";
possiblePOILocation = ([initCityLocation, 2500] call getLocationsAround) - [initCityLocation];
dangerAreaList = [];


if ( count possiblePOILocation < lengthParameter + 1) then 
{
	possiblePOILocation = ([initCityLocation, 3500] call getLocationsAround) - [initCityLocation];
	
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


publicVariable "EnemyWaveSpawnPositions";

//Setup init Civ city
[[text initCityLocation,"ColorBlue","loc_help",getPos initCityLocation, "All"], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0];
currentTruck = selectRandom civilianTruck;
logiTruck = createVehicle [currentTruck, ((getPos initCityLocation) findEmptyPosition [10, 60, currentTruck]), [], 0, "NONE"];


///SETUP OBJECTIVES///

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
possibleEnemyWaveSpawnPositions = ([initCityLocation, 1500] call getLocationsAround) - ([initCityLocation]+[SelectedObjectivePosition]);

for [{_i = 0}, {_i < numberOfSpawnWave}, {_i = _i + 1}] do
{
	EnemyWaveSpawnPositions pushBack (selectRandom possibleEnemyWaveSpawnPositions);
};




//Init checkobjective
[SelectedObjectives,initCityLocation] execVM 'engine\checkobjective.sqf';


///SETUP IA INIT BEHAVIOR///

//IA civilian taskGarrison
currentCivGroup = objNull;
civsGroup = [];
for [{_i = 0}, {_i <= 2}, {_i = _i + 1}] do
{ 

	currentCivGroup = [getPos initCityLocation, civilian, civilian_big_group,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	civsGroup pushBack currentCivGroup;
	
};
[civsGroup, false] execVM 'enemyGenerator\doGarrison.sqf';


//Generate AO
tempSupplyObjects = SelectedObjectives;
currentObject = objNull;
{
	currentObject = selectRandom tempSupplyObjects;
	tempSupplyObjects = tempSupplyObjects - [currentObject];
	diag_log format ["Objective generation started : %1 on position %2", currentObject, _x];
	[EnemyWaveLevel_1, civilian_group ,_x,difficultyParameter,currentObject] execVM 'enemyGenerator\generatePOI.sqf'; 

} forEach SupplyPositions;


//IA taskPatrol with level 1 enemy
[EnemyWaveLevel_1,AmbushPositions,difficultyParameter] execVM 'enemyGenerator\generatePatrol.sqf'; 

//Generate Wave
if (1 <= (count EnemyWaveSpawnPositions)) then 
{
	[EnemyWaveGroups,EnemyWaveSpawnPositions,initCityLocation,difficultyParameter] execVM 'enemyGenerator\generateWave.sqf'; 
};



//Setup Blufor location
selectedBluforVehicle =[];
aoSize = 1500;


// Get smallest distance to an AO
initBlueforLocation = [getPos initCityLocation, (aoSize+500), (aoSize+1500), 8, 0, 0.25, 0, [possiblePOILocation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;

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