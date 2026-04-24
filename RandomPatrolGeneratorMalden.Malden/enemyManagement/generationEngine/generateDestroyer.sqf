//[_pos] execVM 'enemyManagement\generationEngine\generateDestroyer.sqf';
params ["_pos"];

//If there is no water then don't spawn destroyer
if ([_pos, [0,0]] call BIS_fnc_areEqual) exitWith {};

//_pos = [0,0,0]; //Debug only
_side = east;		 // Camp des soldats (east = OPFOR)
_ship = createVehicle ["Land_Destroyer_01_base_F", [_pos#0,_pos#1,0], [], 0, "NONE"];
_ship setPosASL [_pos select 0, _pos select 1, 0]; // On s'assure qu'il est au niveau de la mer
_ship setDir 0; // Orientation
[_ship] call BIS_fnc_Carrier01PosUpdate;

// Wait spawn 
sleep 1;

// --- Create garrison---
_groupAssociatedToDestroyer = createGroup _side;


//List of infantry spawn on boat
_positionsRelatives = [
	[0,-28,11],       //Front catwalk 1
	[0,-37,11],       //Front catwalk 2
	[6.8,-40,11],       //Front catwalk 3
	[-8.6,-41,11],       //Front catwalk 4
	[-5.52085,-38.7103,11],  //Front catwalk 4
	[1, 17, 8],      //Main Corridor Down 
	[-1.5, 10, 8],   //Main Corridor Down 2
    [-4, 15, 8],     // Platform right middle 1
	[-9, 10, 8],     // Platform right middle 2
	[-10.9754,15.9895,8], //Platform right middle 3
	[-14.1224,18.1668,8], //Platform right middle 4
	[3.44091,14.5404,12], //Platform right up
    [5, 13, 8],      // Platform left middle 1
	[11, 15, 8],     // Platform left middle 2
	[11, 7, 8],      // Platform left middle 3
	[1, 2.5, 8],      //Main Corridor Down 3
	[-1, -4, 8],      //Main Corridor Down 4
	[1, -12, 8],      //Main Corridor Down 5
	[-0.967709,-15.3545,8],  //Main Corridor Down 6
	[1, -15, 8],      //Main Corridor Down 6 stairs
	[1, -21, 12],      //Main Corridor Down 7 up stairs
	[5.5, -27, 11],      //Main Corridor Down 8 up stairs
	[5.5, -30, 14],      //Main Corridor Down 9 up up stairs
	[4, -28, 17],      //Main Corridor Down 10 up up up stairs
	[4.5, -32, 19.5],      //Main Corridor Down 11 up up up stairs
	[0, 15, 12],     // Main corridor between plateform
	[8, 10.9, 12],   // left corridor between plateform
	[-8, 10.9, 12],  // right corridor between plateform
    //[0, 35, 12],     // Couloir avant près de la tourelle
    [4, -36, 19.5],    // Command post (left)
    [-4, -36, 19.5],   // Command post (right)
	[0.03186,-37.0375,19.5], //Command post (middle)
	[0, -43, 19.5],   // Command post (center)
	[-5.05721,-41.5423,19.5], //Command post (corner)
	[10, -37, 19.5],   // Command post (left) outside
	[-10, -37, 19.5],   // Command post (right) outside
    [0, -58, 11],    //Front middle
	[0, -93, 13],    //Front front middle
	[-8.30324,-49.9275,11], //Front right
	[7.59745,-52.7687,11], //Front left
	[0.152797,-47.3984,16], //front up
	[8, 40, 9],      //Back left
	[-1, 48, 9],      //Back center
	[-1, 30, 9],      //Back center 2
	[-8, 30, 9],      //Back center 3
	[-4, 55, 9],      //Back center 4
	[0, 23, 9],      //Back center down
    [-8, 40, 11],    //Back right
	[-13.8, 53, 9], //Back Corridor right
	[-10, 69, 9],   //Back platform right
	[-10, 81, 9],   //Back platform right
	[11, 78, 9],    //Back platform left
	[9, 63, 9],    //Back platform left
	[7.12695,53.3584,9], //Back platform left
	[-5.20397,28.0927,9], //Back platform
	[8.08264,33.1443,9], //Back platform
	[-8, 34, 15.5],  //Back roof right
	[8, 34, 15.5],  //Back roof left
	[0, 44, 15.5],   //Back roof middle
	[0, 55, 15.5]   //Back roof middle 2

];

//Add chopper on back 
if (random 100 < 50) then 
{
	_baseEnemyChopper = baseEnemyUnarmedChopperGroup;
	_chopperBackPos = [0,75.2479,12];
	if (count _baseEnemyChopper != 0) then 
	{
		_chopperToSpawn = createVehicle [selectRandom _baseEnemyChopper, [0,0,0], [], 0, "CAN_COLLIDE"];
		_chopperToSpawn attachTo [_ship, _chopperBackPos];
		detach _chopperToSpawn;
		_chopperToSpawn setDir 0;
	};
};


//Box spawn 
_boxPossibleSpawn = [
	[0.222828,53.1161,9.5],
	[5.06257,37.4685,9.5],
	[-5.33996,32.698,9.5]
];

{
	//50% chance to spawn box
	if (random 100 < 50) then 
	{
		_boxSpawnObject = createVehicle [selectRandom ["Land_PaperBox_closed_F"], [0,0,0], [], 0, "CAN_COLLIDE"];
		_boxSpawnObject attachTo [_ship, _x];
		_boxSpawnObject setDir 0;
	};
} foreach _boxPossibleSpawn;


//Ammo cache 
_AmmoCachePos = [-0.926269,41.6359,10];
_AmmoCacheObject = createVehicle [selectRandom ["Box_FIA_Wps_F"], [0,0,0], [], 0, "CAN_COLLIDE"];
_AmmoCacheObject attachTo [_ship, _AmmoCachePos];
_AmmoCacheObject setDir 0;
_mustGenerateShop = (missionNameSpace getVariable ["enableOpforWeaponShop",1] == 2);

clearWeaponCargoGlobal _AmmoCacheObject;
clearMagazineCargoGlobal _AmmoCacheObject;
clearItemCargoGlobal _AmmoCacheObject;
clearBackpackCargoGlobal _AmmoCacheObject;

if (_mustGenerateShop) then 
{
	//Add shop to the box
	[_AmmoCacheObject, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa'/><t size='1'>%1</t>", localize "RPG_GUI_GENERAL_WEAPON_SHOP"],{
			params ["_object","_caller","_ID","_thisObjective"];
			[[[false, "OPFOR"]], "GUI\weaponShopGUI\weaponShopGUI.sqf"] remoteExec ['BIS_fnc_execVM', _caller];
		},[],10,true,false,"","_target distance _this <4"]] remoteExec ["addAction", 0, true];

	//Remove weapon shop if the box has been destroyed
	_AmmoCacheObject addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		//Remove all actions
		[_unit] remoteExec ["removeAllEventHandlers", 0, true];
		[_unit] remoteExec ["removeAllActions", 0, true];
	}];
};


//Reward 
_rewardPos = [0.0968822,-35.206, 19.3];

_rewardObject = createVehicle [selectRandom ["Land_File_research_F"], [0,0,0], [], 0, "CAN_COLLIDE"];
_rewardObject attachTo [_ship, _rewardPos];
_rewardObject setDir 0;

[_rewardObject, ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa'/><t size='1'>Collect intel (Win 1 token)</t>",{
			params ["_object","_caller","_ID","_thisObjective"];

			//Give token to players
			[[], 
			{
				params ["_unit", "_instigator"];
				_unblockCredit = profileNameSpace getVariable ["RPG_UnlockCredit",0];
				profileNameSpace setVariable ["RPG_UnlockCredit",_unblockCredit+1];
			}
			] remoteExec ["spawn", 0]; 

			//Manage respawn and delete object
			deleteVehicle _object;
			if (["Respawn",1] call BIS_fnc_getParamValue == 1) then 
			{
				[[], "engine\respawnManagement\respawnManager.sqf"] remoteExec ['BIS_fnc_execVM', 0];
			};
		},[],10,true,true,"","_target distance _this <4"]] remoteExec ["addAction", 0, true];





//Add turret 
_turretPos = [0,-80,16];
_turret = createVehicle [selectRandom ["B_AAA_System_01_F", "B_SAM_System_02_F", "B_SAM_System_01_F"], [0,0,0], [], 0, "CAN_COLLIDE"];
_turret attachTo [_ship, _turretPos];
detach _turret;
//_turret setPosASL _turretPos;
//_turret setPos _turretPos;

_turret setDir 0;

// Create AI crew and force them to OPFOR side
createVehicleCrew _turret;
_crew = crew _turret;
_turretGroup = createGroup opfor; //Create opfor group
_crew joinSilent _turretGroup;

_turretPos2 = [0, 50, 19];
_turret2 = createVehicle [selectRandom ["B_AAA_System_01_F", "B_SAM_System_02_F", "B_SAM_System_01_F"], [0,0,0], [], 0, "CAN_COLLIDE"];
_turret2 attachTo [_ship, _turretPos2];
detach _turret2;
_turret2 setDir 0;
createVehicleCrew _turret2;
_crew2 = crew _turret2;
_crew2 joinSilent _turretGroup;


//Add sabotage action
[
	_turret, 
	"Sabotage the turret", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
	"(_this distance _target < 100) && (_this getVariable 'role' == 'engineer') ",		// Condition for the action to be shown
	"_caller distance _target < 100",		// Condition for the action to progress
	{
		// Action start code
	}, 
	{
		// Action on going code
	},  
	{
		// Action successfull code
		params ["_object","_caller","_ID","_objectParams","_progress","_maxProgress"];
		
		[format ["The turret will be destroyed in 60 secs", name _caller]] remoteExec ["hint", _caller,true];
		sleep 60;
		_object setDamage 1;
		[{[5, "RPG_ranking_repair"] call doUpdateRank}] remoteExec ["call", _caller];
	}, 
	{
		// Action failed code
	}, 
	[],  
	5,
	5, 
	true, 
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

//Add sabotage action
[
	_turret2, 
	"Sabotage the turret", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
	"(_this distance _target < 100) && (_this getVariable 'role' == 'engineer') ",		// Condition for the action to be shown
	"_caller distance _target < 100",		// Condition for the action to progress
	{
		// Action start code
	}, 
	{
		// Action on going code
	},  
	{
		// Action successfull code
		params ["_object","_caller","_ID","_objectParams","_progress","_maxProgress"];
		
		[format ["The turret will be destroyed in 60 secs", name _caller]] remoteExec ["hint", _caller,true];
		sleep 60;
		_object setDamage 1;
		[{[5, "RPG_ranking_repair"] call doUpdateRank}] remoteExec ["call", _caller];
	}, 
	{
		// Action failed code
	}, 
	[],  
	5,
	5, 
	true, 
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];



//Spawn enemies
_groupAssociatedToDestroyer = [];
_opforGroup1 = [opFaction, "BASIC"] call getBasicUnitsGroup;
_opforGroup2 = [opFaction, "AT"] call getBasicUnitsGroup;
_opforGroup = [_opforGroup1, _opforGroup2];
_thisDifficulty = missionNamespace getVariable "missionDifficultyParam"; //get difficulty
for [{_i = 0}, {_i < ((_thisDifficulty)*2)+1}, {_i = _i + 1}] do 
{
	_spawnedGroupDestroyer = ([selectRandom _opforGroup, [0,0,0], opfor, "Infantry"] call doGenerateEnemyGroup);
	(units _spawnedGroupDestroyer) apply {_groupAssociatedToDestroyer pushBack _x};

};

//Count number of AI to manage
//systemChat format ["number of Opfor %1",count _groupAssociatedToDestroyer];

//Disable specific opfor unit behaviour
{
	_currentUnit = _x;

	//Debug opfor unit
	(group _currentUnit) enableDynamicSimulation false;

	//Disable LAMBS IA behaviour
	if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
	{
		_currentUnit setVariable ["lambs_danger_disableAI", true];
	};

	//Remove grenade that can kill hostage
	_throwableItems = (magazines _currentUnit) select {_x call BIS_fnc_isThrowable;};
	{
		_currentUnit removeMagazines _x;
	} foreach _throwableItems;

	//Move soldier to boat
	// Calcul de la position mondiale par rapport au navire
	if (count _positionsRelatives == 0) then 
	{
		deleteVehicle _currentUnit;

	} else 
	{
		_randomBoatPos = selectRandom _positionsRelatives;
		_worldPos = _ship modelToWorld (_randomBoatPos);
		_positionsRelatives = _positionsRelatives - [_randomBoatPos];
		//systemChat format ["remaining Post %1 current Pos %2", count _positionsRelatives, _randomBoatPos];
		
		// Placement du soldat
		_currentUnit setPosASL _worldPos;

		//_currentUnit setPosASL (AGLToASL (_currentUnit modelToWorldVisual [0,0,0]));
		_currentUnit setDir (random 360);
		
		// On force l'IA à rester sur place pour éviter qu'elle ne tombe à l'eau
		//Set defensive behaviour
		_currentUnit disableAI "PATH";
		_currentUnit setUnitPos selectRandom ["UP","UP","MIDDLE"];
	};
} foreach _groupAssociatedToDestroyer;





//Count number of AI to manage
//systemChat format ["number of Opfor post filter %1",count _groupAssociatedToDestroyer];

//Add side objective 50%
if (random 100 < 50) then 
{
	[[format ["%1%2","_sideQuestFOB", random 10000],"AttackDestroyer", _pos, objNull], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 2];

	//Locate on map
	if (missionNameSpace getVariable ["enableObjectiveExactLocation", 0] != 0) then 
	{
		[["Destroyer", "ColorRed", "loc_boat", _pos, blufor], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
	};
};