//Init Location functions
#include "engine\searchLocation.sqf"
#include "engine\objectiveManagement\doGenerateObjective.sqf"
#include "database\objectLibrary.sqf"
#include "objectGenerator\vehicleManagement.sqf"
#include "enemyManagement\generationEngine\groupGenerator.sqf"
#include "engine\modManager.sqf"
#include "GUI\botteamGUI\botteamFunctions.sqf"
#include "enemyManagement\behaviorEngine\unitsBehaviorFunctions.sqf"
#include "engine\hintManagement\customDialog.sqf"
#include "GUI\scoreBoardGUI\scoreFunctions.sqf"
#include "database\factionParameters.sqf"


//Init base mission parameters 
enableInitAttack = "EnableInitAttack" call BIS_fnc_getParamValue;
enableInitBluAttack = "EnableInitBluAttack" call BIS_fnc_getParamValue;

//Init all environement database variable
_handleEnvironmentInitialization = [] execVM 'initEnvironment.sqf'; 
private _generateHarass = compile preprocessFileLineNumbers "enemyManagement\generationEngine\generateHarass.sqf";

waitUntil {isNull _handleEnvironmentInitialization};

//Wait players to connect
waitUntil {count allPlayers != 0};
waitUntil {  {getPlayerUID _x != ""} count allPlayers == count allPlayers};

//Check server mods
[] call doCheckRunningModsOnServer;

adminExist = false;
//Check if there is an admin to setup the mission
if (isMultiplayer) then 
{
	{
		if (admin (owner _x) != 0) then 
		{
			adminExist = true;
		};
	} foreach (call BIS_fnc_listPlayers);
};
publicVariable "adminExist";

//Setup endmission
missionNamespace setVariable ["isEndMissionRunning", false, true];
missionNamespace setVariable ["generationSetup", false, true];
missionGenerated = nil;
publicvariable "missionGenerated";
bluforFOBBuild = nil;
publicvariable "bluforFOBBuild";
PossibleObjectivePosition = nil;
publicvariable "PossibleObjectivePosition";
AllPossibleObjectivePosition = nil;
publicvariable "AllPossibleObjectivePosition";

//Mission settings waiting
waitUntil {missionNamespace getVariable "generationSetup" == true};

missionNameSpace setVariable ["missionSetupMessage", "STR_RPG_SETUP_FACTIONS", true];

//faction definition
warEra = missionNamespace getVariable "warEra"; // Default actual warfare
bluFaction = missionNamespace getVariable "bluforFaction"; //Default faction 14 -> OTAN 2035
opFaction = missionNamespace getVariable "opforFaction"; //Default faction 3 -> Syndikat
indFaction = missionNamespace getVariable "independentFaction"; //Default faction 3 -> Syndikat
civFaction = missionNamespace getVariable "civilianFaction"; //Default faction 3 -> Syndikat

//Missions vehicle settings
enableArmedAicraft = missionNamespace getVariable "enableArmedAicraft"; //Default armed aircraft are disabled
enableArmoredVehicle = missionNamespace getVariable "enableArmoredVehicle"; //Default armored vehicle are disabled

//Mission configuration
enableCampaignMode = missionNamespace getVariable "enableCampaignMode"; //Default disable
missionLength = missionNamespace getVariable "missionLength"; //Default 2 missions + 1 optional
missionDifficultyParam = missionNamespace getVariable "missionDifficultyParam"; //Default medium
startIntel = missionNamespace getVariable "startIntel"; //Default medium

enableAutoDifficultyBalance = missionNamespace getVariable "enableAutoDifficultyBalance";
timeOfDay = missionNamespace getVariable "timeOfDay";
disableZoom = missionNamespace getVariable "disableZoom";

//Wait auto faction builder
waitUntil {!isNil "missionFactionSetup"};
waitUntil {!isNil "missionInitFactionSetup"};


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
publicVariable "bluforUnarmedVehicle";

bluforArmedVehicle = bluforArmedVehicle_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforArmedVehicle";

bluforArmoredVehicle = bluforArmoredVehicle_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforArmoredVehicle";

bluforUnarmedVehicleChopper = bluforUnarmedVehicleChopper_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforUnarmedVehicleChopper";

bluforExtractVehicleChopper = bluforExtractVehicleChopper_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforExtractVehicleChopper";

bluforFixedWing = bluforFixedWing_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforFixedWing";

bluforArmedChopper = bluforArmedChopper_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforArmedChopper";

bluforDrone = bluforDrone_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforDrone";

bluforHQVehicle = bluforHQVehicle_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforHQVehicle";

bluforBoat = bluforBoat_db select {_x select 1  == bluFaction} select 0 select 0;
publicVariable "bluforBoat";


bluforMagazineList = magazineList_db select {_x select 1  == bluFaction} select 0 select 0;

//CivilianGroupDefinition
civilian_group = civilian_group_db select {_x select 1  == civFaction} select 0 select 0;
civilian_big_group = civilian_big_group_db select {_x select 1  == civFaction} select 0 select 0;
civilianTruck = civilianTruck_db select {_x select 1  == civFaction} select 0 select 0;

//EnemyGroupDefinition
baseEnemyGroup = [opFaction, "BASIC"] call getBasicUnitsGroup;
baseEnemyATGroup = [opFaction, "AT"] call getBasicUnitsGroup;
baseEnemyDemoGroup = [opFaction, "DEMO"] call getBasicUnitsGroup;
baseEnemyMortarGroup = baseEnemyMortarGroup_db select {_x select 1  == opFaction} select 0 select 0;
baseEnemyVehicleGroup = baseEnemyVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;
baseEnemyTurretGroup = ((baseEnemyTurretGroup_db select {_x#1  == opFaction})#0)#0;
baseEnemyLightArmoredVehicleGroup = baseEnemyLightArmoredVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;
baseEnemyHeavyArmoredVehicleGroup = baseEnemyHeavyArmoredVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;
baseEnemyUnarmedChopperGroup = baseEnemyUnarmedChopperGroup_db select {_x select 1  == opFaction} select 0 select 0;
baseEnemyArmedChopperGroup = baseEnemyArmedChopperGroup_db select {_x select 1  == opFaction} select 0 select 0;
baseFixedWingGroup = baseFixedWingGroup_db select {_x select 1  == opFaction} select 0 select 0;



//Enemy Wave Composition, needs to be completely rework
EnemyWaveLevel_1 = [baseEnemyGroup, baseEnemyATGroup];
EnemyWaveLevel_6 = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup];
EnemyWaveLevel_8 = [baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup,baseEnemyMortarGroup];


///////////////////////////
///Define player settings//
///////////////////////////

//Determine main player side
_mainPlayerSide = blufor;
if ({isPlayer _x && side _x == independent} count allPlayers != 0) then 
{
	_mainPlayerSide = independent;
};

//Determine side relation 
switch (missionNameSpace getVariable "sideRelations") do
{
	case 0:
	{
		west setFriend [resistance, 1];
		resistance setFriend [west, 1];

		west setFriend [east, 0];
		east setFriend [west, 0];

		east setFriend [resistance, 0];
		resistance setFriend [east, 0];
	};
	case 1:
	{
		west setFriend [resistance, 0];
		resistance setFriend [west, 0];

		west setFriend [east, 0];
		east setFriend [west, 0];

		east setFriend [resistance, 0];
		resistance setFriend [east, 0];
	};
	case 2:
	{
		west setFriend [resistance, 0];
		resistance setFriend [west, 0];

		west setFriend [east, 0];
		east setFriend [west, 0];

		east setFriend [resistance, 1];
		resistance setFriend [east, 1];
	};
	default
	{
		//Never happened
	};
};

//Init bunker FOB depending of war era and mod
if (isClass (configFile >> "CfgPatches" >> "fow_main")) then 
{
	if (warEra == 0) then 
	{
		avalaibleEnemyFOB = avalaibleEnemyFOB_FOW;
	};
};

/////////////////////////
/////Find locations//////
/////////////////////////

missionNameSpace setVariable ["missionSetupMessage", "STR_RPG_SETUP_AREA", true];

//Initilize independent starting position 
if (initCityLocationPosition isEqualType []) then 
{

	if (!([initCityLocationPosition, [0,0,0]] call BIS_fnc_areEqual)) then 
	{
		initCityLocation = initCityLocationPosition;
	};
}  else 
{
	//Select a random position
	possibleInitLocation = [] call getRandomCenterLocations;
	initCityLocation = getPos (selectRandom possibleInitLocation);
};

initCityLocationLocs = nearestLocations [initCityLocation, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 300];
initCityLocationLoc = objNull;
initCityLocationName = mapGridPosition initCityLocation;
if (count initCityLocationLocs >=1) then 
{
	initCityLocationLoc = initCityLocationLocs#0;
	initCityLocationName = text initCityLocationLoc;
};


publicvariable "initCityLocation";

_searchRadius = 3000; //Default

//Define search area for objective
switch (missionNameSpace getVariable ["missionAreaSize", 0]) do
{
	case 0:
	{
		_searchRadius = 3000;
	};
	case 1:
	{
		_searchRadius = 6000;
	};
	case 2:
	{
		_searchRadius = worldSize;
	};
};

possiblePOILocation = ([initCityLocation, _searchRadius] call getLocationsAroundWithBuilding) - [initCityLocationLoc];
dangerAreaList = [];

if ( count possiblePOILocation < missionLength) then 
{
	possiblePOILocation = ([initCityLocation, _searchRadius+2000] call getLocationsAroundWithBuilding) - [initCityLocationLoc];
};

//Search road around AO
possibleAmbushPosition = [];
tempPossibleAmbush = [];
currentAO = objNull;
_distance = 0;
{
	currentAO = _x;
	tempPossibleAmbush = (getPos _x) nearRoads 1500;
	{
		_distance = (getPos _x) distance (getPos currentAO);
		if (350<_distance && _distance<1000) then	//Il faudrait tester si ce n'est pas trop près des villes adjacentes
		{
			possibleAmbushPosition pushBack _x;
		};		
	}
	foreach tempPossibleAmbush;
} foreach possiblePOILocation;


numberOfAmbush = (missionLength+1)*4;
AmbushPositions = [];
for [{_i = 0}, {_i < numberOfAmbush}, {_i = _i + 1}] do
{
	AmbushPositions pushBack (selectRandom possibleAmbushPosition);
	possibleAmbushPosition = possibleAmbushPosition - [AmbushPositions select ((count AmbushPositions)-1)];
};

//Manually Determine objective location will not be randomize
NeedToRandomizePOI = missionNameSpace getVariable ["randomizeObjectiveOrder", 1];

if (typeName PossibleObjectivePosition != "ARRAY") then 
{
 	PossibleObjectivePosition = [];
	{
		PossibleObjectivePosition pushBack (getPos (_x));
	}	foreach possiblePOILocation;
};

AllPossibleObjectivePosition = PossibleObjectivePosition;
publicVariable "AllPossibleObjectivePosition";

for [{_i = 0}, {_i <= 2}, {_i = _i + 1}] do //Peut être optimisé
{
	_currentTruckType = selectRandom civilianTruck;
	[initCityLocation, [[_currentTruckType, false]], 30, 100] call doGenerateVehicleForFOB;	
};

//Init enemy forces in the main civilian city if there's no independent player
if (random 100 < 20 && (count (allPlayers select {side _x == independent})== 0)) then 
{
	//Generate enemy forces on main civilian city environement
	_handlePOIGeneration = [baseEnemyVehicleGroup, [], [], [], [], initCityLocation, objNull] execVM 'enemyManagement\generationEngine\generatePOI.sqf'; 
	waitUntil {isNull _handlePOIGeneration};
};

/////////////////////////
///Generate Objectives///
/////////////////////////

missionNameSpace setVariable ["missionSetupMessage", "STR_RPG_SETUP_OBJ", true];

//Define 3 objectives
SupplyPositions = [];
SelectedObjectivePosition = objNull;
SupplyObjects = [];
currentObjType = nil;
currentRandomPos = [];
currentObj = objNull;
currentRandObj = objNull;


//Generate objectives according to the mission's length parameter
_minNumberOfMission = missionLength min(count AllPossibleObjectivePosition);

for [{_counterOfMission = 0}, {_counterOfMission < _minNumberOfMission}, {_counterOfMission = _counterOfMission + 1}] do //Peut être optimisé
{
	//Randomize objective locations or not
	if (NeedToRandomizePOI == 1) then 
	{
		PossibleObjectivePosition = [avalaibleTypeOfObj, PossibleObjectivePosition] call generateObjective;
	} else 
	{
		[avalaibleTypeOfObj, [PossibleObjectivePosition#0]] call generateObjective;
		PossibleObjectivePosition = PossibleObjectivePosition - [PossibleObjectivePosition#0];
	};
};

//check wave spawn 
EnemyWaveSpawnPositions = [];
numberOfSpawnWave = 4;
possibleEnemyWaveSpawnPositions = (([initCityLocation, 2000] call getLocationsAroundWithBuilding) - [initCityLocationLoc]) - SupplyPositions;

for [{_i = 0}, {_i < numberOfSpawnWave}, {_i = _i + 1}] do
{
	EnemyWaveSpawnPositions pushBack (getPos (selectRandom possibleEnemyWaveSpawnPositions));
};

//Init checkobjective
[initCityLocation] execVM 'engine\objectiveManagement\checkobjective.sqf';

/////////////////////////
////Generate Civ/////////
/////////////////////////

missionNameSpace setVariable ["missionSetupMessage", "STR_RPG_SETUP_CIV", true];

//IA civilian taskGarrison
diag_log format ["Begin generation of civilian AO : %1 on position %2", civilian_big_group, initCityLocation];
currentCivGroup = objNull;
civsGroup = [];
for [{_i = 0}, {_i <= 2}, {_i = _i + 1}] do
{ 
	currentCivGroup = [civilian_big_group, ((initCityLocation) findEmptyPosition [5, 60]), civilian, "Civilian"] call doGenerateEnemyGroup;
	civsGroup pushBack currentCivGroup;
	diag_log format ["Generation of civilian group : %1 on position %2 has been completed", currentCivGroup, initCityLocation];
};

//Garrison or camp every civ group
{
	[_x, getPos (leader _x), 80, true] call doGarrison;
} foreach civsGroup;


//Init VA
VA1 = createVehicle ["CargoNet_01_box_F", [initCityLocation, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal VA1;
clearMagazineCargoGlobal VA1;
clearItemCargoGlobal VA1;
clearBackpackCargoGlobal VA1;
VA1 allowDamage false; 
publicvariable "VA1";

/////////////////////////
////Generate Ind/////////
/////////////////////////

missionNameSpace setVariable ["missionSetupMessage", "STR_RPG_SETUP_IND", true];

//Init attack management on ind
isIndAttacked = false;
publicvariable "isIndAttacked";
AvalaibleInitAttackPositions = [];
AvalaibleInitAttackPositions = [initCityLocation, 1200,1400, missionDifficultyParam] call getListOfPositionsAroundTarget;
if ( count AvalaibleInitAttackPositions != 0 && (enableInitAttack == 1 || ((enableInitAttack == 2) && (round (random 1))==0))) then
{
	diag_log "Init attack on independent city";
	_handleCivGeneration = [AvalaibleInitAttackPositions, initCityLocation,[baseEnemyGroup,baseEnemyATGroup],baseEnemyVehicleGroup, missionDifficultyParam] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
	isIndAttacked = true;
	publicvariable "isIndAttacked";
	waitUntil {isNull _handleCivGeneration};
};

//Add reinforcement action on independent box
[VA1, ["Call Reinforcements",{
	params ["_object","_caller","_ID","_param"];
	
	if (!(missionNamespace getVariable ["usedRespawnFewTimeAgo",false])) then 
	{
		//set morning
		skipTime 24;
		[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
		[format ["%1 needs reinforcement", name _caller]] remoteExec ["hint",0,true];
		missionNamespace setVariable ["usedRespawnFewTimeAgo",true,true];
		_respawnTimer = missionNamespace getVariable "missionRespawnParam";
		sleep _respawnTimer;
		missionNamespace setVariable ["usedRespawnFewTimeAgo",false,true];
	} else {
		hint "You must wait before call reinforcements";
	};
},[],1.5,true,false,"","_target distance _this <5 && side _this == independent"]] remoteExec [ "addAction", 0, true ];

//Init perma harass on player
[[baseEnemyGroup,baseEnemyATGroup,baseEnemyDemoGroup],baseEnemyVehicleGroup, baseEnemyLightArmoredVehicleGroup, baseEnemyHeavyArmoredVehicleGroup, baseEnemyUnarmedChopperGroup, baseFixedWingGroup, baseEnemyArmedChopperGroup] spawn _generateHarass; 

//Init ambiant war 
if (missionNameSpace getVariable ["enableAmbiantWar", 0] == 1) then 
{
	[] execVM 'engine\doAmbiantWar.sqf';
};

// Get smallest distance to an AO
areaOfOperation = [AllPossibleObjectivePosition] call getAreaOfMission;
aoSize = 1500;
publicVariable "areaOfOperation";
areaOfOperationPosition = getPos areaOfOperation;
publicVariable "areaOfOperationPosition";

//Define extended operation Of area
extendedTriggerArea = [(triggerArea areaOfOperation #0), (triggerArea areaOfOperation #1)];
publicVariable "extendedTriggerArea";

/////////////////////////
////Generate Blufor//////
/////////////////////////

missionNameSpace setVariable ["missionSetupMessage", "STR_RPG_SETUP_BLU", true];

//Init
selectedBluforVehicle =[];
selectedBluforAirDroneVehicle = [];
vehicleGoodPosition = [];
initBlueforLocation = [0,0,0];
bluforShortFrequencyTFAR = (((round random 400)+400)/10);
publicvariable "bluforShortFrequencyTFAR";

//Initilize blufor starting position 
//Generate blufor FOB Location
_isOnWater = false;
if (initBlueforLocationPosition isEqualType []) then 
{
	if (!([initBlueforLocationPosition, [0,0,0]] call BIS_fnc_areEqual)) then 
	{
		initBlueforLocation = initBlueforLocationPosition;
		_isOnWater = surfaceIsWater initBlueforLocationPosition
	};
};

//Check if base is on water
if !(_isOnWater) then 
	{
		//TODO create the random option
		_minBluforCityRadius = aoSize+300;
		_maxBluforCityRadius = aoSize+2000;
		//Check if position is already determine by player
		if ([initBlueforLocation, [0,0,0]] call BIS_fnc_areEqual) then 
		{
			initBlueforLocation = [initCityLocation,_minBluforCityRadius, _maxBluforCityRadius, 3, 0, 0.25, 0, [areaOfOperation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			//Test avalaible position (not in water and not default)
			_spawnAttempts = 0;
			while {(([initBlueforLocation , [0,0,0]] call BIS_fnc_areEqual) || surfaceIsWater initBlueforLocation) && _spawnAttempts <10} do 
			{
				_maxBluforCityRadius = _maxBluforCityRadius +200;
				initBlueforLocation = [initCityLocation, _minBluforCityRadius, _maxBluforCityRadius, 3, 0, 0.25, 0, [areaOfOperation], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				_spawnAttempts = _spawnAttempts +1;
			};

			//Last chance to find a good position
			//It will ignore the area of operation
			if ([initBlueforLocation, [0,0,0]] call BIS_fnc_areEqual) then {
				initBlueforLocation = [initCityLocation, _minBluforCityRadius, _maxBluforCityRadius+3000, 3, 0, 0.25, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			};

			
			//Safe position
			initBlueforLocation = [selectMax [selectMin [initBlueforLocation select 0, worldSize-75 ],75],selectMax [selectMin [initBlueforLocation select 1, worldSize-75],75]]; 
		};

		//Generate FOB
		spawnFOBObjects = [initBlueforLocation, (random 360), selectRandom avalaibleFOB] call BIS_fnc_ObjectsMapper;
			
		//Snap FOB object to ground
		{
			_x setVectorUp surfaceNormal position _x;
		} foreach spawnFOBObjects;

		initBlueforLocation = getPos (spawnFOBObjects select 0);	
		publicvariable "initBlueforLocation";
		waitUntil {!isNil "spawnFOBObjects"};
} else 
{
	//Spawn carrier on water 
	_spawnPos = initBlueforLocation;
	_object = createVehicle ["Land_Carrier_01_base_F",[_spawnPos#0,_spawnPos#1,0],[],0,"NONE"];
	//_object setPosATL _spawnPos;
	//_object setPosWorld ASLToATL  [_spawnPos#0,_spawnPos#1,0];
	_object setPosWorld _spawnPos;
	_object setDir 270;
	[_object] call BIS_fnc_Carrier01PosUpdate;

	// Broadcast Carrier ID over network
	missionNamespace setVariable ["USS_FREEDOM_CARRIER",_object]; publicVariable "USS_FREEDOM_CARRIER";

	// Broadcast carrier position as blufor init base
	initBlueforLocation = [_spawnPos#0, _spawnPos#1, 24];
	publicVariable "initBlueforLocation";
};

[["FOB", "ColorBlue", "loc_Fortress", initBlueforLocation, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];

//Trigger message when blufor FOB is attackEnabled
[] spawn {
	_trgBluforFOB = createTrigger ["EmptyDetector", initBlueforLocation];
	_trgBluforFOB setTriggerArea [200, 200, 0, true];

	while {sleep 60; true;} do 
	{
		if ((count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _trgBluforFOB))>0) then 
		{
			[{["STR_RPG_HC_NAME", "STR_RPG_HC_ENEMY_TAKE_FOB", mapGridPosition initBlueforLocation] call doDialog}] remoteExec ["call", blufor];
			sleep 1000;
		} else 
		{
			{
				//Clear wreck
				if (!alive _x) then 
				{
					deleteVehicle _x;
				};
			} foreach (nearestObjects [initBlueforLocation, [], 100]);
		};
	};
};
	
//Clean area WIP
[initBlueforLocation, 150] execVM 'objectGenerator\doCleanArea.sqf'; 				

//Generate ground vehicle
vehicleGoodPosition = [];
if (0 < count bluforUnarmedVehicle ) then 
{
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{
		selectedBluforVehicle pushBack [(selectRandom bluforUnarmedVehicle), false];
	};
};



if (0 < count bluforArmedVehicle ) then 
{
	for [{_i = 0}, {_i < 1}, {_i = _i + 1}] do
	{
		selectedBluforVehicle pushBack [(selectRandom bluforArmedVehicle), false];
	};
};


//Generate Boat
if (0 < count bluforBoat ) then 
{
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{
		selectedBluforVehicle pushBack [(selectRandom bluforBoat), false];
	};
};

//Generate all vehicles
diag_log format ["Generating blufor vehicle : %1",selectedBluforVehicle];
[initBlueforLocation, selectedBluforVehicle, bluforHQVehicle] spawn {
	params ["_initBlueforLocation", "_selectedBluforVehicle" ,"_bluforHQVehicle"];

	sleep 15;
	_spawnedVehicle = [_initBlueforLocation, _selectedBluforVehicle, 30, 100] call doGenerateVehicleForFOB;
	diag_log format ["Generating blufor vehicle spawned : %1", _spawnedVehicle];
	//TODO: get each vehicule and set the lock parameter to LOCKED;

	//HQ Vehicle spawn
	if (count _bluforHQVehicle >0) then 
	{
		//Spawn one HQ vehicle at bluforFOB
		_bluforHQVehicleSpawned = ([initBlueforLocation, [[selectRandom _bluforHQVehicle, false]], 30, 100] call doGenerateVehicleForFOB);	
		diag_log format ["Generating blufor HQ vehicle spawned : %1", _bluforHQVehicleSpawned];
		if (count _bluforHQVehicleSpawned >0) then 
		{
			// //Change vehicle name
			// createVehicle ["Flag_Blue_F", getPos (_bluforHQVehicleSpawned select 0) , [], 0, "NONE"];
			bluforMobileHQ = _bluforHQVehicleSpawned select 0;
			publicVariable "bluforMobileHQ";

			//Add support action 
			[bluforMobileHQ, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_OPEN_SUPPORT_SHOP"],{
				params ["_object","_caller","_ID","_param"];
				[[false], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			},[],1.5,true,false,"","_target distance _this <10 && side _this == blufor"]] remoteExec [ "addAction", blufor, true ];
			
			//add drones backpack to the HQ Vehicles
			_virtualDroneBackpackList = [];
			_virtualDroneBackpackList = (droneBackPack_db select {_x select 1  == bluFaction} select 0 select 0);
			{
				bluforMobileHQ addBackpackCargoGlobal  [_x, 2];
			} foreach _virtualDroneBackpackList;
			
			//3D Display
			[["STR_RPG_3D_HQ", (getPos bluforMobileHQ) vectorAdd [0,0,6],"\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa" , [0,0,1,1]], 'GUI\3DNames\3DNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];
		};
	};
};

//Add rappeling with Advanced rappeling on chopper
AR_SUPPORTED_VEHICLES_OVERRIDE = bluforUnarmedVehicleChopper + bluforArmedChopper;


//Setup random attack on blufor at the beginning
isBluforAttacked = false;
publicvariable "isBluforAttacked";

AvalaibleInitAttackPositions = [];
AvalaibleInitAttackPositions = [initBlueforLocation, 800,1000, missionDifficultyParam] call getListOfPositionsAroundTarget;
if ( count AvalaibleInitAttackPositions != 0 && (enableInitBluAttack == 1 || ((enableInitBluAttack == 2) && (round (random 4))==0))) then
{
	diag_log "Init attack on blufor FOB";
	[AvalaibleInitAttackPositions,initBlueforLocation,[baseEnemyGroup,baseEnemyATGroup],baseEnemyVehicleGroup, missionDifficultyParam] execVM 'enemyManagement\behaviorEngine\doAmbush.sqf'; 
	isBluforAttacked = true;
	publicvariable "isBluforAttacked";
};

[initBlueforLocation, deployableFOBMounted, deployableFOB] execVM 'engine\generateBluforFOBBoxes.sqf'; 



/////////////////////////
///////Generate Opfor///////
/////////////////////////
//IA taskPatrol with level 1 enemy

missionNameSpace setVariable ["missionSetupMessage", "STR_RPG_SETUP_OPF", true];

[EnemyWaveLevel_1,AmbushPositions, missionDifficultyParam] execVM 'enemyManagement\generationEngine\generatePatrol.sqf'; 

//Generate Wave
if (1 <= (count EnemyWaveSpawnPositions)) then 
{
	//[EnemyWaveGroups,EnemyWaveSpawnPositions,initCityLocation, missionDifficultyParam] execVM 'enemyManagement\generationEngine\generateWave.sqf'; 
};

//Generate mortar | 25% chance to spawn 
if (count baseEnemyMortarGroup > 0 && (missionNameSpace getVariable ["enableOpforMortar", 0]==1)) then 
{
	if (random 100 < 25) then 
	{ 
		for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
		{ 
			_mortarSpawnPosition = [initCityLocation, (800), (aoSize+700), 3, 10, 0.25, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if !([_mortarSpawnPosition , [0,0,0]] call BIS_fnc_areEqual) then 
			{
				_mortarGroup = [baseEnemyMortarGroup, _mortarSpawnPosition, east, "Mortar"] call doGenerateEnemyGroup;
				[_mortarGroup, getPos (leader _mortarGroup), 200 + random 250] call doPatrol;
				//TEMP feature - In the future there will be a dynamic side quest assignement
				//75% chance to setup the side mission 
				if (random 100 < 75) then 
				{
					[[format ["%1%2","_sideQuestMortar", random 10000],"DestroyMortar", getPos leader (_mortarGroup), vehicle leader _mortarGroup], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 2];
				};
			};
		};
	}; 
};


for [{_i = 0}, {_i < missionLength}, {_i = _i + 1}] do //Peut être optimisé
{
	[] execVM 'enemyManagement\generationEngine\generateOpforFOB.sqf';
};

////////////////////////////
///// MissionInitSetup /////
////////////////////////////

//Case where blufor has objective on start

switch (startIntel) do
{
	case 1:
		{
			//Setup init Civ city
			//Init task for blufor to get informations
			[blufor, "taskContactCiv", [["STR_RPG_OBJ_CONTACT_CIV_TEXT", initCityLocationName], ["STR_RPG_OBJ_CONTACT_CIV"], ""], objNull, 1, 3, true] call BIS_fnc_taskCreate;
			initCityLocationTrigger = createTrigger ["EmptyDetector", initCityLocation]; //create a trigger area created at object with variable name my_object
			initCityLocationTrigger setTriggerArea [100, 100, 0, false]; // trigger area with a radius of 100m.
			
			//Set task exact location 
			[["taskContactCiv", initCityLocation], "engine\objectiveManagement\drawObjectiveLocation.sqf"] remoteExec ['BIS_fnc_execVM', 0, true];


			//Setup task completion
			[] spawn {
				_hasContactCivilian = false;
				while {sleep 10; !_hasContactCivilian} do 
				{
					if (count((allPlayers select {alive _x && side _x == blufor} ) inAreaArray initCityLocationTrigger) >0) then 
					{
						_hasContactCivilian = true;
						[{[10, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", blufor];
						["taskContactCiv","SUCCEEDED"] call BIS_fnc_taskSetState;
					};
				};
			};

			//reveal objective for ind
			if (_mainPlayerSide == independent) then 
			{
					for [{_i = 0}, {_i <= missionLength}, {_i = _i + 1}] do //Peut être optimisé
				{
					[objNull, [], _mainPlayerSide] execVM 'engine\objectiveManagement\revealObjective.sqf';
				};
			};
		};
	case 2:
		{
			//Give task to blufor
			for [{_i = 0}, {_i <= missionLength}, {_i = _i + 1}] do //Peut être optimisé
			{
				[objNull, [], _mainPlayerSide] execVM 'engine\objectiveManagement\revealObjective.sqf';
			};

			//Add blufor task to encounter independent
			if (_mainPlayerSide == independent && (missionNameSpace getVariable "sideRelations") == 0) then 
			{
				//Setup init Civ city
				//Init task for blufor to get informations
				[blufor, "taskContactCiv", [format ["Contact independent at %1 to get tasks", initCityLocationName], "Contact independent", ""], objNull, 1, 3, true] call BIS_fnc_taskCreate;
				initCityLocationTrigger = createTrigger ["EmptyDetector", initCityLocation]; //create a trigger area created at object with variable name my_object
				initCityLocationTrigger setTriggerArea [100, 100, 0, false]; // trigger area with a radius of 100m.
				
				//Set task exact location 
				[["taskContactCiv", initCityLocation], "engine\objectiveManagement\drawObjectiveLocation.sqf"] remoteExec ['BIS_fnc_execVM', 0, true];


				//Setup task completion
				[] spawn {
					_hasContactCivilian = false;
					while {sleep 10; !_hasContactCivilian} do 
					{
						if (count((allPlayers select {alive _x && side _x == blufor} ) inAreaArray initCityLocationTrigger) >0) then 
						{
							_hasContactCivilian = true;
							["taskContactCiv","SUCCEEDED"] call BIS_fnc_taskSetState;
							[{[10, "RPG_ranking_objective_complete"] call doUpdateRank}] remoteExec ["call", blufor];
						};
					};
				};
			};
		};
	default
		{
			//
		};
};

missionNameSpace setVariable ["missionSetupMessage", "STR_RPG_SETUP_LAST", true];

//Adjust some ACE parameters 
if (isClass (configFile >> "CfgPatches" >> "ace_common")) then 
{
	_ace_settings = [
	
		//ACE setting
		["ACE_maxWeightDrag", 8000, true], 
		["ACE_maxWeightCarry", 4000, true]
	];
	
	//Do all settings
	{
		missionNamespace setVariable _x;
	} forEach _ace_settings;
};


//Init garbage collector
//[] execVM 'engine\garbageCollector.sqf'; 

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

//Setup date
switch (warEra) do
{
	//2nd War
	case 0:
	{
		setDate [1944, 2, 25, 16, 0];
	};
	//Cold War
	case 1:
	{
		setDate [1970, 2, 25, 16, 0];
	};
	//Modern Warfare
	case 2:
	{
		setDate [2000, 2, 25, 16, 0];
	};
	//Actual Warfare
	case 3:
	{
		waitUntil { time > 0 };
		if (isMultiplayer) then 
		{
			setDate (missionStart select [0,5]);
		} else 
		{
			setDate [2020, 2, 25, 16, 0];
		};
	};
	//Future Warfare
	case 4:
	{
		setDate [2035, 2, 25, 16, 0];
	};
	default
	{
		
	};
};

//Setup time 
switch (timeOfDay) do
{
	case 1:
		{
			//set morning
			skipTime ((06 - dayTime + 24) % 24);
		};
	case 2:
		{
			//set day
			skipTime ((12 - dayTime + 24) % 24);
		};
	case 3:
		{
			//set afternoon
			skipTime ((18 - dayTime + 24) % 24);
		};
	case 4:
		{
			//set night
			skipTime ((00 - dayTime + 24) % 24);
		};
	default
		{
			//set random time
			skipTime ((round (random (24)) - dayTime + 24) % 24);
		};
};

//Setup weather
86400 setOvercast (random 1);
forceWeatherChange;

//Setup difficulty management
if (enableAutoDifficultyBalance==1) then 
{
	[] execVM 'engine\difficultyManagement.sqf'; 
};

if (enableRegularIncome == 1) then 
{
	[] execVM 'engine\regularIncomeManagement.sqf'; 
};

if (disableZoom == 1) then 
{
	[[], 'engine\disableZoom.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
};


//Init checkdeath
[] execVM 'engine\checkdeath.sqf';



missionGenerated = true;
publicvariable "missionGenerated";

/////////////////////////
///Init Campaign mode////
/////////////////////////

if (enableCampaignMode) then 
{
	//Init mission objective status
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_objectiveCompletedCounter = count _completedObjectives;
	_maxObjectivesGenerated = false;

	//Add this action on campaign mode blufor side
	waitUntil{!isNil "TPFlag1"};
	[TPFlag1, ["<t color='#0a5e00'>Complete campaign</t>",{
			//Param initialization
			params ["_object","_caller","_ID","_missionLength"];
			_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];

			//End mission
			if (_missionLength <= (count _completedObjectives)) then 
			{
				[['OBJ_OK'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
			} else 
			{
				hint "Not enough mission completed";
			};
		},missionLength,1.5,true,true,"","_target distance _this <5 && side _this == blufor && _this getVariable 'role' == 'leader'"]] remoteExec ["addAction", 0, true];

	//Add this action on campaign mode independent side
	[VA1, ["<t color='#0a5e00'>Complete campaign</t>",{
			//Param initialization
			params ["_object","_caller","_ID","_missionLength"];
			_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];

			//End mission
			if (_missionLength <= (count _completedObjectives)) then 
			{
				[['OBJ_OK'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
			} else 
			{
				hint "Not enough mission completed";
			};
		},missionLength,1.5,true,true,"","_target distance _this <5 && side _this == independent && _this getVariable 'role' == 'leader'"]] remoteExec ["addAction", 0, true];


	//Loop until maximum number of possible objective are generated
	while {sleep 10; (!_maxObjectivesGenerated)} do 
	{
		//Is an objective been completed ?
		if (_objectiveCompletedCounter == (count ((missionNamespace getVariable ["completedObjectives",[]]) + (missionNamespace getVariable ["missionFailedObjectives",[]])))) then 
		{
			//Do nothing
			sleep 30;

		} else 
		{
			//Randomize opforFaction if needed
			if (missionNameSpace getVariable "opforFactionRandomizer" == 1) then 
			{
				opFaction = selectRandom (factionInfos select {_x#4 && !(["air", _x#1] call BIS_fnc_inString) && !(["usaf", _x#1] call BIS_fnc_inString) && !(["_usn", _x#1] call BIS_fnc_inString) && !(["_AA", _x#1] call BIS_fnc_inString)})#1;
				missionNamespace setVariable ["opforFaction", opFaction, true];
				checkFinishOpforFaction = false;

				_execFaction = [] execVM 'database\object_db\factionAutomaticExtractor.sqf';
				waitUntil {isNull _execFaction};
				waitUntil {checkFinishFaction};

				[opFaction] call parseOpforFaction;
				waitUntil {checkFinishOpforFaction};

				//Wait initEnvironnement
				_handleEnvironmentInitialization2 = [] execVM 'initEnvironment.sqf'; 
				waitUntil {isNull _handleEnvironmentInitialization2};
				waitUntil {checkfinish};

				baseEnemyMortarGroup = baseEnemyMortarGroup_db select {_x select 1  == opFaction} select 0 select 0;
				baseEnemyVehicleGroup = baseEnemyVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;
				baseEnemyTurretGroup = ((baseEnemyTurretGroup_db select {_x#1  == opFaction})#0)#0;
				baseEnemyLightArmoredVehicleGroup = baseEnemyLightArmoredVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;
				baseEnemyHeavyArmoredVehicleGroup = baseEnemyHeavyArmoredVehicleGroup_db select {_x select 1  == opFaction} select 0 select 0;
				baseEnemyUnarmedChopperGroup = baseEnemyUnarmedChopperGroup_db select {_x select 1  == opFaction} select 0 select 0;
				baseEnemyArmedChopperGroup = baseEnemyArmedChopperGroup_db select {_x select 1  == opFaction} select 0 select 0;
				baseFixedWingGroup = baseFixedWingGroup_db select {_x select 1  == opFaction} select 0 select 0;
			};

			//Randomize objective locations or not
			if (NeedToRandomizePOI == 1) then 
			{
				PossibleObjectivePosition = [avalaibleTypeOfObj, PossibleObjectivePosition] call generateObjective;
			} else 
			{
				[avalaibleTypeOfObj, [PossibleObjectivePosition#0]] call generateObjective;
				PossibleObjectivePosition = PossibleObjectivePosition - [PossibleObjectivePosition#0];
			};

			//Generate opfor FOB in campaign mode
			if (random 100<25) then {
				[] execVM 'enemyManagement\generationEngine\generateOpforFOB.sqf';
			};

			//Reveal objective to the player
			if (startIntel == 2) then 
			{
				[objNull, [], _mainPlayerSide] execVM 'engine\objectiveManagement\revealObjective.sqf';
			};

			//Update objective complete counter
			_objectiveCompletedCounter = count ((missionNamespace getVariable ["completedObjectives",[]]) + (missionNamespace getVariable ["missionFailedObjectives",[]]));
		};


		//Check if there is always avalaible position for new objective
		_maxObjectivesGenerated = (count PossibleObjectivePosition) == 0;
	};
};