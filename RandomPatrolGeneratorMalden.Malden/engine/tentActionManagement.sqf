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

				//Create tent
				_createTent = createVehicle ["Land_TentDome_F", (_caller modelToWorld [0, 1, 0]), [], 0, "NONE"];
				_callerPos = getPosATL _caller;

				//setup tent pos
				missionNameSpace setVariable [format ['bluforPositionAdvancedRespawn%1', str (group _caller)], getPosATL _createTent, true];

				_tentPos = getPos _createTent;
				_createTent setPosATL [_tentPos#0, _tentPos#1, _callerPos#2];
				_createTent setVariable [str (group _caller), true, true];
				_createTent setVariable ["tentGroupName", str (group _caller),true];


				//Create opfor control trigger
				_triggerTent = createTrigger ["EmptyDetector", getPos _createTent];
				_triggerTent setTriggerArea [7, 7, 0, true];

				//Check if there are enemy nearby to delete tent
				[_triggerTent, _caller, _createTent] spawn {
					params ["_triggerTent", "_caller", "_createTent"];

					_groupName = str (group (_caller));
					_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _triggerTent);

					while {sleep 15; _nbOpfor == 0} do 
					{
						_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _triggerTent);
					};

					[_createTent] call destroyTent;

					[_createTent] call adjustRespawnPos;

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
				[_createTent, _triggerTent]  call invokeTentManager;

				//Disable tent if it dies
				_createTent addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];

					//Reset group tent
					_groupCaller = _unit getVariable ["tentGroupName", ""];
					_tentCompleteListName = format ['bluforPositionAdvancedRespawnHistory%1', _groupCaller];
					_tentCompleteList = missionNameSpace getVariable [_tentCompleteListName, []];
					_tentElement = _tentCompleteList select {_x#1 distance  (getPosATL _createTent)>3};
					if (count _tentElement != 0) then 
					{
						_lastTentPosition = _tentElement select -1;
						_variableToCheck = format ['bluforPositionAdvancedRespawn%1', _unit getVariable ["tentGroupName", ""]];
						missionNameSpace setVariable [_variableToCheck , _lastTentPosition, true];
					};

					[_unit] call destroyTent;

					[_unit] call adjustRespawnPos;
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


invokeTentManager = {
	params ["_createTent", "_triggerTent"];

	//Get tent name
	_groupCaller = _createTent getVariable ["tentGroupName", ""];

	//Store tent in history
	_tentCompleteListName = format ['bluforPositionAdvancedRespawnHistory%1', _groupCaller];
	_tentCompleteList = missionNameSpace getVariable [_tentCompleteListName, []];
	_tentCompleteList pushBackUnique [(count _tentCompleteList)+1, getPosATL _createTent, _createTent];
	missionNameSpace setVariable [_tentCompleteListName, _tentCompleteList, true];

	//Place marker
	[_createTent] call adjustRespawnPos;
};


destroyTent = {
	params ["_createTent", ["_triggerTent", objNull]];

	//Delete associated trigger
	if (!(isNull _triggerTent)) then 
	{
		deleteVehicle _triggerTent;	
	};

	//Destroy tent and remove EH
	_createTent setDamage 1;
	[_createTent] remoteExec ["removeAllEventHandlers", 0, true];
	[_createTent] remoteExec ["removeAllActions", 0, true];
	_groupCaller = _createTent getVariable ["tentGroupName", ""];

	//Clear history list
	_tentCompleteListName = format ['bluforPositionAdvancedRespawnHistory%1', _groupCaller];
	_tentCompleteList = missionNameSpace getVariable [_tentCompleteListName, []];
	_tentElement = _tentCompleteList select {_x#1 distance  (getPosATL _createTent)<5};
	//systemChat format ["_tentElement to destroy : %1", _tentElement];
	if (count _tentElement != 0) then 
	{
		_tentCompleteList = _tentCompleteList - _tentElement;
		missionNameSpace setVariable [_tentCompleteListName, _tentCompleteList, true];

		//Replicate
		{
			[_x#2] call destroyTent;
		}  foreach _tentElement;
	};

	//Destroy tent 
	[_createTent] spawn {
		params ["_createTent"];
		sleep 120;
		deleteVehicle _createTent;
	};
};


adjustRespawnPos = {
	params [["_createTent", objNull]];

	//Reset group tent
	_groupCaller = _createTent getVariable ["tentGroupName", ""]; 
	_tentCompleteListName = format ['bluforPositionAdvancedRespawnHistory%1', _groupCaller];
	_tentCompleteList = missionNameSpace getVariable [_tentCompleteListName, []];

	//Create marker
	_markerName = format ["tent%1", _groupCaller];

	_defaultTentLocation = getPosATL _createTent;

	//Remove old tent position if there is no available position to spawn
	if (count _tentCompleteList == 0) then 
	{
		//Reset TentPosition
		deleteMarker _markerName;
		missionNameSpace setVariable [format ['bluforPositionAdvancedRespawn%1', _groupCaller], [0,0,0], true];
	} else 
	{
		//Get last tent in history
		_lastTentPosition = _tentCompleteList select -1;
		_variableToCheck = format ['bluforPositionAdvancedRespawn%1', _createTent getVariable ["tentGroupName", ""]];
		missionNameSpace setVariable [_variableToCheck , _lastTentPosition#1, true];
		_defaultTentLocation = _lastTentPosition#1;

		if !(_markerName in allMapMarkers) then 
		{
			_marker = createMarker [_markerName, _defaultTentLocation]; // Not visible yet.
			_marker setMarkerText (format ["Tent %1", _groupCaller]);
			_marker setMarkerType "b_hq"; // Visible.
			_marker setMarkerSize [1, 1];
			_marker setMarkerColor "ColorBlue";
		} else 
		{
			_markerName setMarkerPos _defaultTentLocation;
		};
	};
};