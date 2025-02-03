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

			
			TPFlag2 = createVehicle ["Land_MapBoard_Enoch_F", [getPos _object, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos, [], 0, "NONE"];
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
			[TPFlag2, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep2_ca.paa'/>%1</t>", localize "STR_ACTIONS_SLEEP"],{
				params ["_object","_caller","_ID","_param"];
				
				if (!(missionNamespace getVariable ["usedFewTimeAgo",false])) then 
				{
					//set morning
					((08 - dayTime + 24) % 24) remoteExec ["skipTime", 2, false]; 
					[format ["%1 needs to rest", name _caller]] remoteExec ["hint",0,true];
					missionNamespace setVariable ["usedFewTimeAgo",true,true];
					sleep 300;
					missionNamespace setVariable ["usedFewTimeAgo",false,true];
				} else {
					hint "No need to rest";
				};
			},objNull,1.5,true,false,"","_target distance _this <7"]] remoteExec [ "addAction", 0, true ];

			//Add support shop
			[TPFlag2, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_OPEN_SUPPORT_SHOP"],{

				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];
					[[false], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
				}
			]] remoteExec [ "addAction", 0, true ];


			//Add action vehicle shop
			[TPFlag2, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_OPEN_VEHICLE_SHOP"],{
					//Define parameters
					params ["_object","_caller","_ID","_avalaibleVehicle"];

					[["bluforVehicleAvalaibleSpawn", bluforUnarmedVehicle, bluforArmedVehicle, bluforArmoredVehicle, bluforUnarmedVehicleChopper, bluforArmedChopper, bluforDrone, bluforFixedWing, bluforBoat], 'GUI\vehicleSpawnerGUI\vehicleSpawner.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			},[],3,true,false,"","(_target distance _this <7) && (_this getVariable 'role' == 'leader' || _this getVariable 'role' == 'pilot')"]] remoteExec [ "addAction", 0, true];


			//Add action open team member shop
			[TPFlag2, ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>Open team member shop</t>",{
			//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];

				[[], 'GUI\botteamGUI\botteamGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			},[],3,true,false,"","(_target distance _this <7) && (_this getVariable 'role' == 'leader')"]] remoteExec [ "addAction", 0, true ];



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

				//Allow players to air drop AdvFOB again after disassembly
				if (missionNameSpace getVariable ["enableReAirDropAdvFOB", 0] == 1) then 
				{
					//Add airdrop on blufor FOB
					[_deployableFOBItem, [
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
				};

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