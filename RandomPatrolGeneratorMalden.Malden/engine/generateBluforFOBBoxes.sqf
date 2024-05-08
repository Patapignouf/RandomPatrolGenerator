params ["_initBlueforLocation","_deployableFOBMounted","_deployableFOB"];

//Wait for Blufor FOB generation
sleep 5;

//Init VA
VA2 = createVehicle ["B_CargoNet_01_ammo_F", [_initBlueforLocation, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal VA2;
clearMagazineCargoGlobal VA2;
clearItemCargoGlobal VA2;
clearBackpackCargoGlobal VA2;
VA2 allowDamage false; 
publicvariable "VA2";

//Create portable FOB 
deployableFOBItem = createVehicle [deployableFOB, [_initBlueforLocation, 20, 50, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal deployableFOBItem;
clearMagazineCargoGlobal deployableFOBItem;
clearItemCargoGlobal deployableFOBItem;
clearBackpackCargoGlobal deployableFOBItem;
deployableFOBItem allowDamage false; 
publicvariable "deployableFOBItem";

//Add action to deploy advanced outpost
[deployableFOBItem, _deployableFOBMounted] execVM 'objectGenerator\doAddActionForAdvFOB.sqf'; 

BluforAmmoBox = [];

//Place empty box to blufor camp
{
	_tempBox = createVehicle [_x, [ _initBlueforLocation, 1, 15, 2, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
	clearWeaponCargoGlobal _tempBox;
	clearMagazineCargoGlobal _tempBox;
	clearItemCargoGlobal _tempBox;
	clearBackpackCargoGlobal _tempBox;
	BluforAmmoBox pushBack _tempBox;
} foreach ["Box_NATO_Grenades_F"];

//Place a box with ammo to blufor camp
{
	_tempBox = createVehicle [_x, [ _initBlueforLocation, 1, 15, 2, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
	clearWeaponCargoGlobal _tempBox;
	clearMagazineCargoGlobal _tempBox;
	clearItemCargoGlobal _tempBox;
	clearBackpackCargoGlobal _tempBox;

	//Add magazines according to avalaible magazine in the faction
	for [{_i = 0}, {_i < 10}, {_i = _i + 1}] do
	{
		{
			if (load _tempBox < 1) then 
			{
				_tempBox addItemCargoGlobal [_x, 2];
			};
		}	foreach bluforMagazineList;
	};
	BluforAmmoBox pushBack _tempBox;
} foreach ["Box_NATO_Uniforms_F","Box_NATO_Wps_F"];

//Spawn vehicle ammobox and refuel box ACE needed for interaction
BluforVehicleAmmoBox = createVehicle ["Box_NATO_AmmoVeh_F", [ _initBlueforLocation, 20, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal BluforVehicleAmmoBox;
clearMagazineCargoGlobal BluforVehicleAmmoBox;
clearItemCargoGlobal BluforVehicleAmmoBox;
clearBackpackCargoGlobal BluforVehicleAmmoBox;

_vehicleRefuelBox = createVehicle ["B_Slingload_01_Fuel_F", [ _initBlueforLocation, 20, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal _vehicleRefuelBox;
clearMagazineCargoGlobal _vehicleRefuelBox;
clearItemCargoGlobal _vehicleRefuelBox;
clearBackpackCargoGlobal _vehicleRefuelBox;


//Set the AmmoBox and make it draggable box with ACE
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	[BluforVehicleAmmoBox, 1200] call ace_rearm_fnc_makeSource;
	[BluforVehicleAmmoBox, true, [0, 2, 0], 45] call ace_dragging_fnc_setDraggable;
};
publicVariable "BluforVehicleAmmoBox";
 

//Place empty box with ACE medical stuff
_tempBox = createVehicle ["Box_NATO_Equip_F", [ _initBlueforLocation, 1, 15, 2, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal _tempBox;
clearMagazineCargoGlobal _tempBox;
clearItemCargoGlobal _tempBox;
clearBackpackCargoGlobal _tempBox;
BluforAmmoBox pushBack _tempBox;

//Check if ACE is enable on the server
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	//Setup medic ACE box 
	_tempBox addItemCargoGlobal ["ACE_surgicalKit", 1];
	_tempBox addItemCargoGlobal ["ACE_epinephrine", 10];
	_tempBox addItemCargoGlobal ["ACE_splint", 10];
	_tempBox addItemCargoGlobal ["ACE_elasticBandage", 50];
	_tempBox addItemCargoGlobal ["ACE_quikclot", 50];
	_tempBox addItemCargoGlobal ["ACE_morphine", 10];
	_tempBox addItemCargoGlobal ["ACE_bloodIV_500", 10];
	_tempBox addItemCargoGlobal ["ACE_bloodIV", 5];
	_tempBox addItemCargoGlobal ["ACE_tourniquet", 5];
	_tempBox addItemCargoGlobal ["ACE_Suture", 20];

	//Setup fortification ACE mod
	[blufor, 100, [["Land_BagFence_Long_F", 10], ["Land_BagFence_Round_F", 10], ["Land_SandbagBarricade_01_hole_F", 15], ["Land_BagBunker_Small_F", 20]]] call ace_fortify_fnc_registerObjects;
} else 
{
	_tempBox addItemCargoGlobal ["FirstAidKit", 20];
};

//Create a box with vehicle spare part for ACE engineer
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	_tempBoxSpare = createVehicle ["Land_CargoBox_V1_F", [ _initBlueforLocation, 30, 70, 2, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
	clearWeaponCargoGlobal _tempBoxSpare;
	clearMagazineCargoGlobal _tempBoxSpare;
	clearItemCargoGlobal _tempBoxSpare;
	clearBackpackCargoGlobal _tempBoxSpare;
	[_tempBoxSpare, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
	[_tempBoxSpare, 8, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
};

//Setup view distance changer
SettingsComputer =  createVehicle ["Land_MultiScreenComputer_01_olive_F", [_initBlueforLocation, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
{
	[SettingsComputer, [format ["Set view distance to %1",_x],{
				params ["_object","_caller","_ID","_viewDistance"];
				//Select ViewDistance
				setViewDistance _viewDistance;
			},_x,1.5,true,true,"","_target distance _this <5"]] remoteExec ["addAction", 0, true];
} foreach [-1,300,500,1000,1500,2000,2500];


_mapTexture = ((configFile >> "CfgWorlds" >> worldName >> "pictureMap") call BIS_fnc_GetCfgData);
TPFlag1 = createVehicle ["Land_MapBoard_Enoch_F", [_initBlueforLocation, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
[TPFlag1, false] remoteExec ["enableSimulationGlobal", 2];
TPFlag1 setVectorUp surfaceNormal position TPFlag1;
TPFlag1 setObjectTexture [0, _mapTexture];
publicvariable "TPFlag1";

//Manage carrier 
if (!isNil "USS_FREEDOM_CARRIER") then 
{
	//Spawn basic items on Carrier
	waitUntil{!isNil "VA2"};
	waitUntil{!isNil "TPFlag1"};
	waitUntil{!isNil "deployableFOBItem"};
	VA2 setPosASL [initBlueforLocation#0-105, initBlueforLocation#1-18, initBlueforLocation#2];
	TPFlag1 setPosASL [initBlueforLocation#0-115, initBlueforLocation#1-18, initBlueforLocation#2-1];
	deployableFOBItem setPosASL [initBlueforLocation#0-50, initBlueforLocation#1-15, initBlueforLocation#2];

	//Move basic ammo box
	waitUntil{!isNil "BluforAmmoBox"};
	_baseAmmoBoxSpawn = [initBlueforLocation#0-113, initBlueforLocation#1-25, initBlueforLocation#2];
	{
		_baseAmmoBoxSpawn = [_baseAmmoBoxSpawn#0+1, _baseAmmoBoxSpawn#1, _baseAmmoBoxSpawn#2];
		_x setPosASL [_baseAmmoBoxSpawn#0, _baseAmmoBoxSpawn#1, _baseAmmoBoxSpawn#2];
		
	} foreach BluforAmmoBox;

	//Spawn vehicle ammo box ACE Only
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		waitUntil{!isNil "BluforVehicleAmmoBox"};
		BluforVehicleAmmoBox setPosASL [initBlueforLocation#0-95, initBlueforLocation#1+40, initBlueforLocation#2+2];
	};


	//Try to spawn chopper on carrier (WIP)
	_baseSpawnChopper = [initBlueforLocation#0-100, initBlueforLocation#1-30, initBlueforLocation#2+1];
	{
		_baseSpawnChopper = [_baseSpawnChopper#0+25, _baseSpawnChopper#1, _baseSpawnChopper#2];
		_chopper = createVehicle [_x,  [_baseSpawnChopper#0, _baseSpawnChopper#1, _baseSpawnChopper#2+100], [], 0, "NONE"];
		_chopper enableSimulationGlobal false;
		_chopper setPosASL _baseSpawnChopper;

		//Repair vehicle
		[_chopper] spawn {
			params ["_vehicle"];
			sleep 1;
			_vehicle setfuel 1;
			_vehicle setVelocity [0, 0, 0];
			_vehicle setdamage 0;
			_vehicle enableSimulationGlobal true;
			if (!(alive _vehicle)) then 
			{
				deleteVehicle _vehicle;
			}; 

			//Add ACE keys
			if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
			{
				[_vehicle] call doAddKeys;
			};
		};
	} foreach bluforUnarmedVehicleChopper;



	//Try to spawn armed chopper on carrier (WIP)
	_baseSpawnChopper = [initBlueforLocation#0-110, initBlueforLocation#1-30, initBlueforLocation#2+1];
	{
		_baseSpawnChopper = [_baseSpawnChopper#0-20, _baseSpawnChopper#1, _baseSpawnChopper#2];
		_chopper = createVehicle [_x,  [_baseSpawnChopper#0, _baseSpawnChopper#1, _baseSpawnChopper#2+100], [], 0, "NONE"];
		_chopper enableSimulationGlobal false;
		_chopper setPosASL _baseSpawnChopper;

		//Repair vehicle
		[_chopper] spawn {
			params ["_vehicle"];
			sleep 1;
			_vehicle setfuel 1;
			_vehicle setVelocity [0, 0, 0];
			_vehicle setdamage 0;
			_vehicle enableSimulationGlobal true;
			if (!(alive _vehicle)) then 
			{
				deleteVehicle _vehicle;
			}; 

			//Add ACE keys
			if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
			{
				[_vehicle] call doAddKeys;
			};
		};
	} foreach bluforArmedChopper;


	_baseSpawnVehicle = [initBlueforLocation#0-100, initBlueforLocation#1+30, initBlueforLocation#2];
	{
		_baseSpawnVehicle = [_baseSpawnVehicle#0-5, _baseSpawnVehicle#1, _baseSpawnVehicle#2];
		_vehicle = createVehicle [_x,  [_baseSpawnVehicle#0, _baseSpawnVehicle#1, _baseSpawnVehicle#2+100], [], 180, "NONE"];
		_vehicle enableSimulationGlobal false;
		_vehicle setPosASL _baseSpawnVehicle;
		_vehicle setDir 180;

		//Repair vehicle
		[_vehicle] spawn {
			params ["_vehicle"];
			sleep 1;
			_vehicle setfuel 1;
			_vehicle setdamage 0;
			_vehicle setVelocity [0, 0, 0];
			_vehicle enableSimulationGlobal true;

			if (!(alive _vehicle)) then 
			{
				deleteVehicle _vehicle;
			};

			//Add ACE keys
			if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
			{
				[_vehicle] call doAddKeys;
			};

		};
	} foreach bluforUnarmedVehicle;

	_baseSpawnShip = [initBlueforLocation#0-40, initBlueforLocation#1+70, initBlueforLocation#2];
	{
		_baseSpawnShip = [_baseSpawnShip#0+30, _baseSpawnShip#1, 0];
		_ship = createVehicle [_x,  _baseSpawnShip, [], 0, "NONE"];
		sleep 1;
		_ship setfuel 1;
		_ship setdamage 0;
		if (!(alive _ship)) then 
		{
			deleteVehicle _ship;
		}; 
	} foreach bluforBoat;

	_baseSpawnPlane = [initBlueforLocation#0-78, initBlueforLocation#1+70, initBlueforLocation#2+2];
	_planeNumber = 0;
	{
		//Manage case where there are more than 2 planes
		if (_planeNumber==2) then 
		{
			_baseSpawnPlane = [initBlueforLocation#0+37, initBlueforLocation#1+40, initBlueforLocation#2+2];
		};

		if (_planeNumber<=3) then
		{
			_baseSpawnPlane = [_baseSpawnPlane#0, _baseSpawnPlane#1-30, _baseSpawnPlane#2];
			_plane = createVehicle [_x,  [_baseSpawnPlane#0, _baseSpawnPlane#1, _baseSpawnPlane#2+100], [], 0, "NONE"];
			_plane enableSimulationGlobal false;
			_plane allowDamage false;

			_bbr = boundingBoxReal vehicle _plane;
			_p1 = _bbr select 0;
			_p2 = _bbr select 1;
			_maxHeight = abs ((_p2 select 2) - (_p1 select 2));

			_plane setPosASL [_baseSpawnPlane#0, _baseSpawnPlane#1, _baseSpawnPlane#2];
			_plane setDir 90;
			_planeNumber = _planeNumber+1;

			//Repair vehicle
			[_plane] spawn {
				params ["_vehicle"];
				_vehicle enableSimulationGlobal true;
				waitUntil {(getPos _vehicle)#2<1};
				_vehicle setfuel 1;
				_vehicle setVelocity [0, 0, 0];
				_vehicle setdamage 0;
				_vehicle setDir 90;
				_vehicle allowDamage true;
				if (!(alive _vehicle)) then 
				{
					deleteVehicle _vehicle;
				}; 

				//Add ACE keys
				if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
				{
					[_vehicle] call doAddKeys;
				};
			};
		};
	} foreach bluforFixedWing;
};


_trgBluforGrassCutterFOB = createTrigger ["EmptyDetector", initBlueforLocation];
_trgBluforGrassCutterFOB setTriggerArea [15, 15, 0, true];

//Just cutting grass with a small trigger on Blufor FOB :p  
[_trgBluforGrassCutterFOB, 20, 20] execvm "engine\grassCutter.sqf";