//add respawn tent action
if (missionNameSpace getVariable ["enableAdvancedRespawn", 1] == 1) then 
{

	//Create action
	[
		player,
		localize "STR_ACTIONS_PLACE_TENT",
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep2_ca.paa",
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_sleep2_ca.paa",
		"
			(_this getVariable 'role' == 'leader')
			&&
			(vehicle _this == _this)
		    &&
			(lineIntersectsSurfaces [eyePos _this, (eyePos _this) vectorAdd (getCameraViewDirection _this vectorMultiply 2.5), _this, objNull, true, 1, 'GEOM']) isNotEqualTo [] 
			&& 
			{((lineIntersectsSurfaces [eyePos _this, (eyePos _this) vectorAdd (getCameraViewDirection _this vectorMultiply 2.5), _this, objNull, true, 1, 'GEOM'] select 0 select 0 select 2) < ((getPosASL _this select 2) + 0.5))}
		",
		
		"true",
		{	params ["_target", "_caller", "_actionId", "_arguments"];
			_caller playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
		},
		{},
		{ 
			params ["_object","_caller","_ID","_avalaibleVehicle"];

			if (count (allUnits select {side _x == opfor && ((getPos _caller) distance _x < 15 )})==0) then 
			{
				missionNameSpace setVariable [format ['bluforAdvancedRespawn%1', str (group _caller)], false, true];
				missionNameSpace setVariable [format ['bluforPositionAdvancedRespawn%1', str (group _caller)], getPosATL _object, true];

				//Create tent
				_createTent = createVehicle ["Land_TentDome_F", (_caller modelToWorld [0, 1, 0]), [], 0, "NONE"];
				_callerPos = getPosATL _caller;
				_tentPos = getPos _createTent;
				_createTent setPosATL [_tentPos#0, _tentPos#1, _callerPos#2];
				_createTent setVariable [str (group _caller), true, true];

				//Create opfor control trigger
				_triggerTent = createTrigger ["EmptyDetector", getPos _createTent];
				_triggerTent setTriggerArea [7, 7, 0, true];

				//Check if there are enemy nearby to delete tent
				[_triggerTent, _caller] spawn {
					params ["_triggerTent", "_caller"];

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

				//Create marker
				//Delete tent if respawn coordinates changed
				[_createTent, str (group _caller), _triggerTent, _caller] spawn 
				{
					params ["_createTent", "_groupCaller","_triggerTent" ,"_caller"];

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

					_variableToCheck = format ['bluforPositionAdvancedRespawn%1', _groupCaller];
					_lastTentPositionKnown = missionNameSpace getVariable _variableToCheck;
					waitUntil {([missionNameSpace getVariable _variableToCheck , [0,0,0]] call BIS_fnc_areEqual)};
					_createTent setDamage 1;
					[_createTent] remoteExec ["removeAllEventHandlers", 0, true];
					[_createTent] remoteExec ["removeAllActions", 0, true];

					_markerName = format ["tent%1", _groupCaller];
					deleteMarker _markerName;

					//Delete associated trigger
					deleteVehicle _triggerTent;	


					//Destroy tent 
					sleep 120;
					deleteVehicle _createTent;
				};

				//Disable tent if it dies
				_createTent setVariable ["tentGroupName", str (group _caller),true];
				_createTent addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					//get task associated to the object
					[_unit] remoteExec ["removeAllEventHandlers", 0, true];
					[_unit] remoteExec ["removeAllActions", 0, true];

					//Reset group tent
					_variableToCheck = format ['bluforPositionAdvancedRespawn%1', _unit getVariable ["tentGroupName", ""]];
					missionNameSpace setVariable [_variableToCheck , [0,0,0], true];
				}];

			} else 
			{
				hint "Enemy nearby cannot place the tent";
			};
		}, //Success
		{}, //Failed
		[],
		10,
		2,
		false,
		false
	] call BIS_fnc_holdActionAdd;

};