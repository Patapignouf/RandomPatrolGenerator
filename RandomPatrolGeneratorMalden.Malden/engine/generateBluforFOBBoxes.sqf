params ["_initBlueforLocation","_deployableFOBMounted","_deployableFOB"];
//Init publicvariables
VA2 = nil;
publicvariable "VA2";
deployableFOBItem = nil;
publicvariable "deployableFOBItem";
TPFlag1 = nil;
publicvariable "TPFlag1";


//Wait for Blufor FOB generation
sleep 5;

//Init VA
VA2 = createVehicle ["B_CargoNet_01_ammo_F", [_initBlueforLocation, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal VA2;
clearMagazineCargoGlobal VA2;
clearItemCargoGlobal VA2;
clearBackpackCargoGlobal VA2;
VA2 allowDamage false; 
VA2 enableSimulationGlobal false;
publicvariable "VA2";

[["STR_RPG_3D_LOADOUT", (getPos VA2) vectorAdd [0,0,2],"\a3\ui_f\data\igui\cfg\simpletasks\types\rifle_ca.paa" , [1,1,0,1]], 'GUI\3DNames\3DNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];

//Create portable FOB 
deployableFOBItem = createVehicle [deployableFOB, [_initBlueforLocation, 20, 50, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
clearWeaponCargoGlobal deployableFOBItem;
clearMagazineCargoGlobal deployableFOBItem;
clearItemCargoGlobal deployableFOBItem;
clearBackpackCargoGlobal deployableFOBItem;
deployableFOBItem allowDamage false; 
publicvariable "deployableFOBItem";

[["STR_RPG_3D_ADV_FOB", (getPos deployableFOBItem) vectorAdd [0,0,2],"\A3\ui_f\data\map\markers\military\flag_CA.paa" , [0,1,0,1]], 'GUI\3DNames\3DNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];

//Add action to deploy advanced outpost
[deployableFOBItem, _deployableFOBMounted] execVM 'objectGenerator\doAddActionForAdvFOB.sqf'; 

//Add airdrop on blufor FOB
[deployableFOBItem, [
	"<img size='2' image='\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa'/><t>Air drop the advanced FOB</t>",
	{
			params ["_object","_caller","_ID","_viewDistance"];

			//Open map 
			//Click on map to spawn
			selectedLoc = [0,0,0];
			openMap true;
			uiSleep 1;

			["<t color='#ffffff' size='.8'>Select the FOB crate airdrop position<br /></t>",0,0,2,0,0,789] spawn BIS_fnc_dynamicText;
			onMapSingleClick "selectedLoc = _pos; onMapSingleClick ''; openMap false; true;";
			waitUntil{!(visibleMap)};  
			if (!([selectedLoc, [0,0,0]] call BIS_fnc_areEqual)) then 
			{
				//Remove this action
				[_object, _ID] remoteExec ["removeAction", 0, true];

				//Call air drop 
				_positionLZ = selectedLoc findEmptyPosition [0, 200,"Land_HelipadCircle_F"];

				_parachute = createVehicle ["B_Parachute_02_F", [(_positionLZ select 0), (_positionLZ select 1), ((_positionLZ select 2)+500)], [], 0, 'FLY'];
				_object attachTo [_parachute, [0, 0, -1.3]];
				_object allowdamage false;

				
				//Wait for care almost hit ground
				//Fix bug where crate go under the ground
				waitUntil {((((position _object)#2) < 0.6) || (isNil "_parachute"))};
				detach _object;
				_object setVelocity [0,0,-5];
				sleep 0.3;
				
				//Place crate on the ground
				_object setPos [(position _object)#0, (position _object)#1, 1];
				_object setVelocity [0,0,0]; 

				//Setup a map marker
				[["Advanced FOB Drop", "ColorBlue", "hd_end", getPos _object, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0, true]; 

				//Add smoke to crate
				for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
				{
					_supplyLight = "Chemlight_green" createVehicle (position deployableFOBItem);
					_supplyLight attachTo [deployableFOBItem, [0,0,0]];
					_supplySmoke = "SmokeShellGreen" createVehicle (position deployableFOBItem);
					_supplySmoke attachTo [deployableFOBItem, [0,0,0]];
					sleep 30;
				};
			};

	},[],1.5,true,true,"","(_target distance _this <5) && (_this getVariable 'role' == 'leader' || _this getVariable 'role' == 'pilot')"
	]
] remoteExec ["addAction", 0, true];


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
	_tempBox addItemCargoGlobal ["ACE_Suture", 100];

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
TPFlag1 enableSimulationGlobal false;
[TPFlag1, false] remoteExec ["enableSimulationGlobal", 2];
TPFlag1 setVectorUp surfaceNormal position TPFlag1;
TPFlag1 setObjectTexture [0, _mapTexture];
publicvariable "TPFlag1";

[["STR_RPG_3D_SHOP", (getPos TPFlag1) vectorAdd [0,0,2.5],"\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa" , [1,0,0,1]], 'GUI\3DNames\3DNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];


//generate patrol and commandant
_botHQ = [blufor, bluFaction, "leader"] call doAddBotSimple;
_safeCommanderPos = [_initBlueforLocation, 1, 10, 1, 0, 20, 0] call BIS_fnc_findSafePos;
_botHQ setPos _safeCommanderPos;
_botHQ disableAI "ALL";
_botHQ enableAI "ANIM";
_botHQ allowDamage false;
[_botHQ, "BRIEFING", "NONE"] remoteExecCall ["BIS_fnc_ambientAnim"];
[["STR_RPG_HC_NAME", (getPos _botHQ) vectorAdd [0,0,2.5],"\a3\UI_F_Orange\Data\CfgMarkers\b_Ordnance_ca.paa" , [0,0,1,1]], 'GUI\3DNames\3DNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];

//Add teammember units
[_botHQ, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_RECRUIT_UNITS"],{
//Define parameters
	params ["_object","_caller","_ID","_avalaibleVehicle"];

	[[], 'GUI\botteamGUI\botteamGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
},[],3,true,false,"","(_target distance _this <7) && (_this getVariable 'role' == 'leader')"]] remoteExec [ "addAction", 0, true ];

//Add group manager
[_botHQ, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_TEAM_SETTINGS"],{
//Define parameters
	params ["_object","_caller","_ID","_avalaibleVehicle"];

	[[_caller], "GUI\teamManagementGUI\teamManagementGUI.sqf"] remoteExec ['BIS_fnc_execVM', _caller];

},[],3,true,false,"","(_target distance _this <7)"]] remoteExec [ "addAction", 0, true ];

if ((missionNameSpace getVariable "officialPataCompanyServer") == 1) then 
{
	[_botHQ, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_JOINPATACOMPANY"],{
	//Define parameters
	params ["_object","_caller","_ID","_avalaibleVehicle"];

	[] call displayPataCompanyAd;

	},[],3,true,false,"","(_target distance _this <7)"]] remoteExec [ "addAction", 0, true ];
};



HQCommander = _botHQ;
publicVariable "HQCommander";


//Manage carrier 
if (!isNil "USS_FREEDOM_CARRIER") then 
{
	//Spawn basic items on Carrier
	waitUntil{!isNil "VA2"};
	waitUntil{!isNil "TPFlag1"};
	waitUntil{!isNil "deployableFOBItem"};
	waitUntil{!isNil "HQCommander"};

	_warEra = missionNamespace getVariable "warEra";

	VA2 setPosASL [initBlueforLocation#0-105, initBlueforLocation#1-18, initBlueforLocation#2];
	TPFlag1 setPosASL [initBlueforLocation#0-115, initBlueforLocation#1-18, initBlueforLocation#2-0.5];
	deployableFOBItem setPosASL [initBlueforLocation#0-50, initBlueforLocation#1-15, initBlueforLocation#2];
	HQCommander setPosASL [initBlueforLocation#0-117, initBlueforLocation#1-18, initBlueforLocation#2-0.5];

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

	_baseSpawnShip = [initBlueforLocation#0-100, initBlueforLocation#1+70, 0];
	{
		_baseSpawnShip = [_baseSpawnShip#0+40, _baseSpawnShip#1, 0];
		_ship = createVehicle [_x,  _baseSpawnShip, [], 0, "NONE"];
		sleep 1;
		_ship setPos _baseSpawnShip;
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

			//Add custom plane catapult on WWII planes because of heavy bugs on USS Freedom
			if (_warEra == 0) then 
			{
				[_plane, [format ["<img size='2' image='\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa'/><t size='1'>Catapult the plane</t>"],{
					//Define parameters
					params ["_object","_caller","_ID","_avalaibleVehicle"];

					//Move caller in the player
    				_caller moveInAny _object;

					//Start the plane
    				_object engineOn true;
					_objectPos = getPos _object;
					_object setPosASL [_objectPos#0, _objectPos#1, _objectPos#2+300];
					_vel = velocity _object;
					_dir = getDir _object;
					_additionalSpeed = 150; // in m/s
					_object setVelocity [
						(_vel select 0) + (sin _dir * _additionalSpeed),
						(_vel select 1) + (cos _dir * _additionalSpeed),
						(_vel select 2) // horizontal only
					];

					//Delete the action 
					[_object, _ID] remoteExec ["removeAction", 0, true];
 
				},_x,3,true,false,"","(_target distance _this <3) && (_this getVariable 'role' == 'leader' || _this getVariable 'role' == 'pilot')"]] remoteExec ["addAction", 0, true];
			};

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
} else 
{
	//Create patrol
	_patrolGroup = createGroup blufor;
	_startPatrolPos = [_initBlueforLocation, 30, 60, 1, 0, 20, 0] call BIS_fnc_findSafePos;
	for [{_i = 0}, {_i < 6}, {_i = _i + 1}] do
	{
		_botPatrol = [blufor, bluFaction, "random"] call doAddBotSimple;
		_botPatrol setPos _startPatrolPos;
		[_botPatrol] joinSilent _patrolGroup;
	};
	_patrolGroup setBehaviour "SAFE";
	[_patrolGroup, _initBlueforLocation, 100] call doPatrol; 
};



_trgBluforGrassCutterFOB = createTrigger ["EmptyDetector", initBlueforLocation];
_trgBluforGrassCutterFOB setTriggerArea [15, 15, 0, true];

//Just cutting grass with a small trigger on Blufor FOB :p  
[_trgBluforGrassCutterFOB, 20, 20] execvm "engine\grassCutter.sqf";

bluforFOBBuild = true;
publicvariable "bluforFOBBuild";