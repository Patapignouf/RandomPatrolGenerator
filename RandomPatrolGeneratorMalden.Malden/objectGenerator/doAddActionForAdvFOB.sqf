params ["_deployableFOBItem", "_deployableFOBMounted"];

[
	_deployableFOBItem, 
	"Deploy advanced FOB", 
	"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", 
	"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", 
	"true",
	"true", 
	{
		// Action start code
	}, 
	{
		// Action on going code
	},  
	{
		// Action successfull code
		params ["_object","_caller","_ID","_param"];
		_avalaibleOutpost = _param select 0;

		//[TODO] Check distance from blufor spawn
		if (_caller distance initBlueforLocation > 100) then 
		{
			//Spawn outpost
			_spawnFOBObjects = [getPos _object, (random 360), _avalaibleOutpost] call BIS_fnc_ObjectsMapper;
			
			//diag_log format ["FOB object : %1", _spawnFOBObjects];
			{
				_x setVariable ["isAdvancedFOB", true, true];
			} foreach _spawnFOBObjects;

			
			TPFlag2 = createVehicle ["Flag_Blue_F", [getPos _object, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
			TPFlag2 setVariable ["isAdvancedFOB", true, true];
			missionNamespace setVariable ["advancedBlueforLocation", getPos TPFlag2, true];

			//Add action to rest and skip 6 hours
			[TPFlag2, ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep2_ca.paa'/>Take a nap</t>",{
				params ["_object","_caller","_ID","_param"];
				
				if (!(missionNamespace getVariable ["usedFewTimeAgo",false])) then 
				{
					//Skip 6 hour
					6 remoteExec ["skipTime", 2, false]; 
					[format ["%1 needs to rest", name _caller]] remoteExec ["hint",0,true];
					missionNamespace setVariable ["usedFewTimeAgo",true,true];
					sleep 300;
					missionNamespace setVariable ["usedFewTimeAgo",false,true];
				} else {
					hint "No need to rest";
				};
			},objNull,1.5,true,false,"","_target distance _this <7"]] remoteExec [ "addAction", 0, true ];

			//Add action to rest until morning
			[TPFlag2, ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep2_ca.paa'/>Sleep until next morning</t>",{
				params ["_object","_caller","_ID","_param"];
				
				if (!(missionNamespace getVariable ["usedFewTimeAgo",false])) then 
				{
					//set morning
					skipTime ((06 - dayTime + 24) % 24);
					[format ["%1 needs to rest", name _caller]] remoteExec ["hint",0,true];
					missionNamespace setVariable ["usedFewTimeAgo",true,true];
					sleep 300;
					missionNamespace setVariable ["usedFewTimeAgo",false,true];
				} else {
					hint "No need to rest";
				};
			},objNull,1.5,true,false,"","_target distance _this <7"]] remoteExec [ "addAction", 0, true ];

			//Add support shop
			[TPFlag2, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>Open support shop</t>"],{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];
					[[false], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
				}
			]] remoteExec [ "addAction", 0, true ];


			//Add action vehicle shop
			[TPFlag2, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>Open vehicle shop</t>"],{
					//Define parameters
					params ["_object","_caller","_ID","_avalaibleVehicle"];

					[["bluforVehicleAvalaibleSpawn", bluforUnarmedVehicle, bluforArmedVehicle, bluforArmoredVehicle, bluforUnarmedVehicleChopper, bluforArmedChopper, bluforDrone, bluforFixedWing, bluforBoat], 'GUI\vehicleSpawnerGUI\vehicleSpawner.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			},_x,3,true,false,"","(_target distance _this <7) && (_this getVariable 'role' == 'leader' || _this getVariable 'role' == 'pilot')"]] remoteExec [ "addAction", 0, true ];


			//Add action open team member shop
			[TPFlag2, ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>Open team member shop</t>",{
			//Define parameters
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			[[], 'GUI\botteamGUI\botteamGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			},_x,3,true,false,"","(_target distance _this <7) && (_this getVariable 'role' == 'leader')"]] remoteExec [ "addAction", 0, true ];



			//Add action to redeploy FOB
			[TPFlag2, ["<img size='2' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa'/>Advanced FOB disassembly</t>",{
				params ["_object","_caller","_ID","_param"];
				_avalaibleOutpost = _param select 0;
				_respawnSetting = _param select 1;
				
				_currentTempPos = getPos _object;

				//Get all items related to FOB 
				{
					//Check if item is related to FOB
					if (_x getVariable ["isAdvancedFOB", false]) then 
					{
						deleteVehicle _x;
					};
				} foreach (nearestObjects [getPos _object, [], 50]);

				//Create FOB box
				_deployableFOBItem = createVehicle ["B_supplyCrate_F", _currentTempPos, [], 0, "NONE"];
				clearWeaponCargoGlobal _deployableFOBItem;
				clearMagazineCargoGlobal _deployableFOBItem;
				clearItemCargoGlobal _deployableFOBItem;
				clearBackpackCargoGlobal _deployableFOBItem;
				_deployableFOBItem allowDamage false; 
				[_deployableFOBItem, _avalaibleOutpost] execVM 'objectGenerator\doAddActionForAdvFOB.sqf'; 

				missionNamespace setVariable ["advancedBlueforLocation", [0,0,0], true];

			},[_avalaibleOutpost],0.5,true,false,"","_target distance _this <7"]] remoteExec [ "addAction", 0, true ];

			//Remove Box
			deleteVehicle _object;
		} else {
			hint "Too close from base";
		};
	}, 
	{
		// Action failed code
	}, 
	[_deployableFOBMounted],  
	10,
	3, 
	true,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];