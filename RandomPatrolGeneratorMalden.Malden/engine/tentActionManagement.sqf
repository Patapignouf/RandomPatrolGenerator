//add respawn tent action
if (missionNameSpace getVariable ["enableAdvancedRespawn", 1] == 1) then 
{
	//Add tent action
    player addAction [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_PLACE_TENT"],{
		//Define parameters
		params ["_object","_caller","_ID","_avalaibleVehicle"];

		if (count (allUnits select {side _x == opfor && ((getPos _caller) distance _x < 15 )})==0) then 
		{
		
			missionNameSpace setVariable [format ['bluforAdvancedRespawn%1', str (group _caller)], false, true];
			missionNameSpace setVariable [format ['bluforPositionAdvancedRespawn%1', str (group _caller)], getPos _object, true];

			//Create tent
			_createTent = createVehicle ["Land_TentDome_F", [getPos _caller, 1, 5, 3, 0, 20, 0, [], [getPos _caller, getPos _caller]] call BIS_fnc_findSafePos, [], 0, "NONE"];
			_createTent setVariable [str (group _caller), true, true];
			_createTent allowDamage false;

			//Check if there are enemy nearby to delete tent
			[getPos _createTent, _caller] spawn {
				params ["_triggerPos", "_caller"];

				//Create opfor control trigger
				_triggerTent = createTrigger ["EmptyDetector", _triggerPos];
				_triggerTent setTriggerArea [7, 7, 0, true];
				_groupName = str (group (_caller));
				
				_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _triggerTent);

				while {sleep 15; _nbOpfor == 0} do 
				{
					_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _triggerTent);
				};

				//Reset group tent
				_variableToCheck = format ['bluforPositionAdvancedRespawn%1', _groupName];
				missionNameSpace setVariable [_variableToCheck , [0,0,0], true];

				//Tell all the group that the tent has been destroyed by opfor
				[{["STR_RPG_HC_NAME", "STR_RPG_HC_DESTROY_TENT"] call doDialog}] remoteExec ["call", units (group _caller)];
			};

			//Allow the leader to get back the tent after 5 minutes
			[_caller] spawn {
				params ["_caller"];
				sleep 600; //Not fully secured code due to the possibility from the leader to get back the tent by himself
				missionNameSpace setVariable [format ['bluforAdvancedRespawnGetBack%1', str (group _caller)], true, true];
			};

			[{["STR_RPG_HC_NAME", "STR_RPG_HC_RESPAWN_TENT"] call doDialog}] remoteExec ["call", units (group _caller)];

			[[str (group _caller), _createTent,"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa" , [0,0,1,1]], 'GUI\3DNames\3DObjectNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];

			//Add support action on tent
			[_createTent, [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_OPEN_SUPPORT_SHOP"],{
				params ["_object","_caller","_ID","_param"];

				[[false], 'GUI\supportGUI\supportGUI.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
			},[],3,true,false,"","(_target distance _this <5) && (_target getVariable [str (group _this), false])"]] remoteExec [ "addAction", 0, true ];

			_createTent addAction [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep2_ca.paa'/>%1</t>", localize "STR_ACTIONS_SLEEP"],{
				//Define parameters
				params ["_object","_caller","_ID","_avalaibleVehicle"];

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
			},_x,3,true,false,"","(_this getVariable 'role' == 'leader') && (_target distance _this <5) && (_target getVariable [str (group _this), false])"];

			if (side player == blufor) then 
			{
				//Add action to add arsenal to the tent
				_createTent addAction [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep2_ca.paa'/>%1</t>", "Add arsenal to the tent (1000 credits)"],{
					//Define parameters
					params ["_object","_caller","_ID","_avalaibleVehicle"];

					_vehiclePriceToSpawn = 1000;
					_bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";

					if (_bluforVehicleAvalaibleSpawnCounter>=_vehiclePriceToSpawn) then 
					{
						missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", _bluforVehicleAvalaibleSpawnCounter-_vehiclePriceToSpawn, true];
						if (ironMan) then 
						{
							[[_object], {params ["_object"]; [_object] call setupPlayerLoadout;	}] remoteExec ["spawn", blufor]; //Adapt for independent
						} else 
						{
							[[_object], {params ["_object"]; [_object] call setupPlayerLoadoutWithoutConditionRemake;	}] remoteExec ["spawn", blufor]; //Adapt for independent
						};
					} else 
					{
						hint "Not enough credits";
					};

				},_x,3,true,false,"","(_this getVariable 'role' == 'leader') && (_target distance _this <5) && (_target getVariable [str (group _this), false])"];
			};

			//Delete tent if respawn coordinates changed
			[_createTent, str (group _caller), _triggerTent] spawn 
			{
				params ["_createTent", "_groupCaller","_triggerTent"];

				_variableToCheck = format ['bluforPositionAdvancedRespawn%1', _groupCaller];
				waitUntil {[missionNameSpace getVariable _variableToCheck , [0,0,0]] call BIS_fnc_areEqual};
				deleteVehicle _createTent;

				_markerName = format ["tent%1", _groupCaller];
				deleteMarker _markerName;

				//Delete associated trigger
				deleteVehicle _triggerTent;	
			};

			//Create marker
			_markerName = format ["tent%1", str (group _caller)];
			if !(_markerName in allMapMarkers) then 
			{
				_marker = createMarker [_markerName, getPos _caller]; // Not visible yet.
				_marker setMarkerText (format ["Tent %1", str (group _caller)]);
				_marker setMarkerType "b_hq"; // Visible.
				_marker setMarkerSize [1, 1];
				_marker setMarkerColor "ColorBlue";
			};

			//Create action to authorize tent disassembly
			[
				_createTent, 
				"Disassemble tent", 
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", 
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa", 
				"(_this distance _target < 3) && (_this getVariable 'role' == 'leader') && (vehicle _this == _this)",
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

					//If the tent is on your squad
					if (_object getVariable [str (group _caller), false]) then 
					{
						//delete the tent and allow leader to place another one
						deleteVehicle _object;

						//Allow players to spawn on tent 10 until 10 secs after disassembly
						sleep 10;

						missionNameSpace setVariable [format ['bluforAdvancedRespawn%1', str (group _caller)], true, true];
						missionNameSpace setVariable [format ['bluforPositionAdvancedRespawn%1', str (group _caller)], [0,0,0], true];
					} else 
					{
						cutText ["This is not your tent", "PLAIN", 0.3];
					};
				}, 
				{
					// Action failed code
				}, 
				[],  
				2,
				1000, 
				false,
				false
			] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
		} else 
		{
			hint "Enemy nearby cannot place the tent";
		};

	},_x,3,true,false,"","(_this getVariable 'role' == 'leader') && (missionNameSpace getVariable [ format ['bluforAdvancedRespawn%1', str (group _this)], true]) && (vehicle _this == _this) && isTouchingGround _this"];


	//GetBack tent
    player addAction [format ["<img size='2' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa'/><t size='1'>%1</t>", localize "STR_ACTIONS_DELETE_TENT"],{
		//Define parameters
		params ["_object","_caller","_ID","_avalaibleVehicle"];

		//Set respawn pos to 0,0,0 to trigger tent auto clean
		_group = str (group _caller);
		_variable= format ['bluforPositionAdvancedRespawn%1', _group];
		missionNameSpace setVariable [_variable, [0,0,0], true];

		_variableRespawn= format ['bluforAdvancedRespawn%1', _group];
		missionNameSpace setVariable [_variableRespawn, true, true];

		//Not allow tent getBack action
		missionNameSpace setVariable [format ['bluforAdvancedRespawnGetBack%1', str (group _caller)], false, true];

	},_x,3,true,false,"","(_this getVariable 'role' == 'leader') && (missionNameSpace getVariable [ format ['bluforAdvancedRespawnGetBack%1', str (group _this)], false]) && (vehicle _this == _this) && isTouchingGround _this"];
};