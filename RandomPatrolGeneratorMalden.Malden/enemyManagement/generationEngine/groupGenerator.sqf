doGenerateEnemyGroup = 
{
	//Get parameters
	params ["_thisGroupToSpawn","_thisSpawnPosition","_thisFaction","_thisGroupType"];

	//Group spawn
	_currentGroupPatrol = [_thisSpawnPosition, _thisFaction, _thisGroupToSpawn,[],[],[],[],[], random 360] call BIS_fnc_spawnGroup;

	//Optimize IA 
	_currentGroupPatrol enableDynamicSimulation true;
	

	//Intel Synchronization
	if (_thisGroupType != "") then
	{
		_missionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];
		_missionEnemyInfo pushBack [_thisGroupType,_thisSpawnPosition, _currentGroupPatrol];
		missionNamespace setVariable ["MissionEnemyInfo", _missionEnemyInfo, true];
	};
	
	//Set IA Skills
	[_currentGroupPatrol, missionIASkill] call doSetGroupSkills;

	//Adjust ACE Medic items 
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
	{
		[_currentGroupPatrol] call doAdjustACEMedic;
	};

	//Opfor group
	if (_thisFaction == opfor) then 
	{
		{	
			//Case infantry
			//Add eventHandler suppress
			_x addEventHandler ["Suppressed", {
				params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];

				if (getSuppression _unit > 0.9 && _distance<3 && !(_unit getVariable ["isSuppressed", false])) then 
				{
					_unit setVariable ["isSuppressed", true, true];
					//hint format ["unit : %1 \ndistance : %2 \ninstigator : %3\n suppression level : %4",name _unit, _distance, name _instigator, getSuppression _unit];
					[[1, "RPG_ranking_suppress"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
					
					//Reset suppressed score on the unit after 60 sec
					[_unit] spawn {
						params ["_unit"];
						sleep 60;
						waitUntil {getSuppression _unit < 0.9};
						_unit setVariable ["isSuppressed", false, true];
					};	
				};
			}];

			//Add eventhandler killed
			_x addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];

				if (isPlayer _instigator) then 
				{
					[[1, "RPG_ranking_infantry_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
				} else {
					//Debug IA killed log
					diag_log format ["The IA %1 has been killed by %2", name _unit, name _instigator];
				}; 

				//Garbage collect unit  
				[_unit] spawn 
				{
					params ["_unit"];
					//Fix ACE locking place in vehicle when an IA dies
					sleep 20;
					moveOut _unit;

					//Free some memory usage by cleaning the corpse
					sleep 300;
					deleteVehicle _unit;
				};
			}];
			

		} foreach (units _currentGroupPatrol);
	};
	
	//Define specific vehicle trigger
	if (_thisGroupType == "Car" || _thisGroupType == "LightArmored" || _thisGroupType == "HeavyArmored") then 
	{
		_vehicleFromGroup = vehicle (leader _currentGroupPatrol);

		//Add eventhandler killed
		_vehicleFromGroup addEventHandler ["HandleDamage", {
			params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
			if ((_unit getHit "motor") > 0.7 && !(_unit getVariable ["isAlmostDead", false])) then 
			{
				_unit setVariable ["isAlmostDead", true, true];
				_unit setDamage 1;
				
				if (isPlayer _instigator) then 
				{
					[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
					_killedForExp = _unit getVariable ["EHKilledForXP", 0];
					[_unit, ["Killed", _killedForExp]] remoteExec ["removeEventHandler", 0, true];
				}; 
			};
		}];

		_killedForExp = _vehicleFromGroup addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			if ((_unit getHit "motor") > 0.7 && !(_unit getVariable ["isAlmostDead", false])) then 
			{	
				if (isPlayer _instigator) then 
				{
					[[5, "RPG_ranking_vehicle_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
					[_unit, "HandleDamage"] remoteExec ["removeAllEventHandlers", 0, true];
				}; 
			};
		}];

		_vehicleFromGroup setVariable ["EHKilledForXP", _killedForExp, true];

		
		//Add side quest
		if (_thisGroupType == "LightArmored" || _thisGroupType == "HeavyArmored") then 
		{
			//TEMP feature - In the future there will be a dynamic side quest assignement
			//50% chance to setup the side mission 
			if (random 100 < 50) then 
			{
				[[format ["%1%2","_sideQuestArmored", random 10000],"DestroyArmored", getPos _vehicleFromGroup, _vehicleFromGroup], "engine\objectiveManagement\doGenerateSideObjective.sqf"] remoteExec ['BIS_fnc_execVM', 2];
			};
		};
	};


	//Manage civilian specific feature
	if (_thisFaction == civilian) then 
	{
		{		
			//Manage hostile civilian
			// 20% chance not to be hostile at all
			if (random 100 < 20) then 
			{
				[_x, 30] execVM "enemyManagement\behaviorEngine\manageHostileCivilian.sqf";
			};

			//Add eventhandler civKilled
			_x addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				[_unit] remoteExec ["removeAllActions", 0, true];

				if (isPlayer _instigator) then 
				{
					//Add civ killed counter
					_tempCivKilled = missionNamespace getVariable "civKilled";
					_tempCivKilled = _tempCivKilled + 1;
					missionNamespace setVariable ["civKilled", _tempCivKilled, true];

					//If number of killed civ reach max civ killed number then end mission
					if (missionNamespace getVariable "civKilled" > missionNamespace getVariable "maxCivKilled") then 
					{
						diag_log "END MISSION";
						[['CIV_DEAD'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
					};

					diag_log format ["Civilian has been killed by : %1 on side %2", name _instigator, side _instigator];
					[[format ["Civilian has been killed by : %1", name _instigator], "civiliankilled"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', side _instigator]; 
					
					[[-50,5], 'engine\rankManagement\rankPenalty.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
				}; 
			}];
		} foreach (units _currentGroupPatrol);
	};

	//Return spawned group
	_currentGroupPatrol
};


doGenerateHostileCivilianGroup = 
{
	//Get parameters
	params ["_thisGroupToSpawn","_thisSpawnPosition", "_hostileProba"];
	_thisGroupType = "Civilian";
	//Group spawn
	_currentGroupPatrol = [_thisSpawnPosition, civilian, _thisGroupToSpawn,[],[],[],[],[], random 360] call BIS_fnc_spawnGroup;

	//Optimize IA 
	_currentGroupPatrol enableDynamicSimulation true;

	//Intel Synchronization
	if (_thisGroupType != "") then
	{
		_missionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];
		_missionEnemyInfo pushBack [_thisGroupType,_thisSpawnPosition, _currentGroupPatrol];
		missionNamespace setVariable ["MissionEnemyInfo", _missionEnemyInfo, true];
	};
	
	//Set IA Skills
	[_currentGroupPatrol, missionIASkill] call doSetGroupSkills;


	//Manage civilian specific feature
	{		
		//Manage hostile civilian
		if (random 100 < _hostileProba) then 
		{
			//50% chance to trigger hostile transformation
			[_x, 80] execVM "enemyManagement\behaviorEngine\manageHostileCivilian.sqf";
		};

		//Add eventhandler civKilled
		_x addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			[_unit] remoteExec ["removeAllActions", 0, true];

			if (isPlayer _instigator) then 
			{
				//Add civ killed counter
				_tempCivKilled = missionNamespace getVariable "civKilled";
				_tempCivKilled = _tempCivKilled + 1;
				missionNamespace setVariable ["civKilled", _tempCivKilled, true];

				//If number of killed civ reach max civ killed number then end mission
				if (missionNamespace getVariable "civKilled" > missionNamespace getVariable "maxCivKilled") then 
				{
					diag_log "END MISSION";
					[['CIV_DEAD'], 'engine\objectiveManagement\endMission.sqf'] remoteExec ['BIS_fnc_execVM', 2];
				};

				diag_log format ["Civilian has been killed by : %1 on side %2", name _instigator, side _instigator];
				[[format ["Civilian has been killed by : %1", name _instigator], "civiliankilled"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', side _instigator]; 
				
				[[-50,5], 'engine\rankManagement\rankPenalty.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
			}; 
		}];
	} foreach (units _currentGroupPatrol);

	//Return spawned group
	_currentGroupPatrol
};



doSetGroupSkills = 
{
	params ["_thisGroup", "_thisSkillLevel"];

	switch (_thisSkillLevel) do
	{
		case 0:
			{
				 {
					_unit = _x;
					_unit setSkill ["aimingAccuracy", random [0.25, 0.30, 0.35]];
					_unit setSkill ["aimingShake", random [0.06, 0.08, 0.1]];
					_unit setSkill ["aimingSpeed", random [0.1, 0.15, 0.20]];
					_unit setSkill ["spotDistance", random [0.5, 0.6, 0.7]];
					_unit setSkill ["spotTime", random [0.2, 0.3, 0.4]];
					_unit setSkill ["general", random [0.6, 0.65, 0.7]];	
					_unit setSkill ["courage", random [0.2, 0.25, 0.3]];
					_unit setSkill ["reloadSpeed", random [0.2, 0.3, 0.3]];
				 } forEach (units _thisGroup);
			};
		case 1:
			{
				 {
					_unit = _x;
					_unit setSkill ["aimingAccuracy", random [0.50, 0.55, 0.60]];
					_unit setSkill ["aimingShake", random [0.06, 0.08, 0.1]];
					_unit setSkill ["aimingSpeed", random [0.25, 0.30, 0.35]];
					_unit setSkill ["spotDistance", random [0.7, 0.75, 0.8]];
					_unit setSkill ["spotTime", random [0.3, 0.4, 0.5]];
					_unit setSkill ["general", random [0.7, 0.75, 0.8]];	
					_unit setSkill ["courage", random [0.3, 0.4, 0.5]];
					_unit setSkill ["reloadSpeed", random [0.2, 0.3, 0.3]];
				 } forEach (units _thisGroup);
			};
		case 2:
			{
				 {
					_unit = _x;
					_unit setSkill ["aimingAccuracy", random [0.55, 0.60, 0.70]];
					_unit setSkill ["aimingShake", random [0.10, 0.15, 0.2]];
					_unit setSkill ["aimingSpeed", random [0.40, 0.45, 0.50]];
					_unit setSkill ["spotDistance", random [0.75, 0.8, 0.85]];
					_unit setSkill ["spotTime", random [0.4, 0.45, 0.5]];
					_unit setSkill ["general", random [0.8, 0.85, 0.88]];	
					_unit setSkill ["courage", random [0.4, 0.5, 0.6]];
					_unit setSkill ["reloadSpeed", random [0.3, 0.4, 0.5]];
				 } forEach (units _thisGroup);
			};
		case 3:
			{
				 {
					_unit = _x;
					_unit setSkill ["aimingAccuracy", random [0.70, 0.80, 0.90]];
					_unit setSkill ["aimingShake", random [0.10, 0.15, 0.20]];
					_unit setSkill ["aimingSpeed", random [0.50, 0.60, 0.70]];
					_unit setSkill ["spotDistance", random [0.75, 0.8, 0.9]];
					_unit setSkill ["spotTime", random [0.4, 0.5, 0.55]];
					_unit setSkill ["general", random [0.75, 0.8, 0.85]];	
					_unit setSkill ["courage", random [0.4, 0.45, 0.5]];
					_unit setSkill ["reloadSpeed", random [0.3, 0.4, 0.5]];
				 } forEach (units _thisGroup);
			};
	};
};


doAdjustACEMedic = {
	params ["_thisGroup"];

	//Apply adjust on every group unit
	{
		_currentUnit = _x;
		if ((items _currentUnit)findIf { _x == "Medikit" } > -1) then 
		{
			//Remove Medikit
			_currentUnit removeItem "Medikit";

			//Add Medikit ACE equivalent
			_currentUnit addItem "ACE_surgicalKit";
			for "_i" from 0 to 11 do { _currentUnit addItem "ACE_suture" };
			for "_i" from 0 to 1 do { _currentUnit addItem "ACE_bloodIV_500" };
			for "_i" from 0 to 1 do { _currentUnit addItem "ACE_bloodIV" };
			for "_i" from 0 to 3 do { _currentUnit addItem "ACE_epinephrine" };
			for "_i" from 0 to 1 do { _currentUnit addItem "ACE_splint" };
			for "_i" from 0 to 11 do { _currentUnit addItem "ACE_elasticBandage" };
			for "_i" from 0 to 11 do { _currentUnit addItem "ACE_quikclot" };

			//for "_i" from 0 to 9 do { _currentUnit addItem "ACE_morphine" }; //Basic ACE conversion will give enough morphine
			//for "_i" from 0 to 5 do { _currentUnit addItem "ACE_tourniquet" };	//Basic ACE conversion will give enough tourniquet
		};
	}
	foreach (units _thisGroup);
};



