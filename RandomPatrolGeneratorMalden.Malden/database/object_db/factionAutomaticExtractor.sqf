
adjustRole = {
	params ["_cfgRole", "_cfgName"];

	_iconToTest = (configFile >> "CfgVehicles" >> _cfgName >> "icon") call BIS_fnc_GetCfgData;

	//Bind role with icon
	switch (_iconToTest) do {
		case "iconManLeader";
		case "iconManOfficer":
		{
			_cfgRole = "leader";
		};
		case "iconManAT":
		{
			_cfgRole = "at";
		};
		case "iconManMedic":
		{
			_cfgRole = "medic";
		};
		case "iconManExplosive";
		case "iconManEngineer":
		{
			_cfgRole = "engineer";
		};		
		case "iconManMG":
		{
			_cfgRole = "autorifleman";
		};
		default
		{
			//Just _cfgRole
		};
	};

	//Bind role with wrole
	switch (_cfgRole) do {
		case "CombatLifeSaver": {_cfgRole = "medic"};
		case "Grenadier": {_cfgRole = "grenadier"};
		case "MachineGunner": {_cfgRole = "autorifleman"};
		case "Marksman": {_cfgRole = "marksman"};
		case "MissileSpecialist": {_cfgRole = "at"};
		case "Rifleman": {_cfgRole = "rifleman"};
		case "Sapper": {_cfgRole = "engineer"};
		case "SpecialOperative": {_cfgRole = "rifleman"};
	};

	//Check if name contains specifics strings
	if (["pilot", _cfgName] call BIS_fnc_inString) then 
	{
		_cfgRole = "pilot";
	};

	if (["marksman", _cfgName] call BIS_fnc_inString) then 
	{
		_cfgRole = "marksman";
	};
	if (["sniper", _cfgName] call BIS_fnc_inString) then 
	{
		_cfgRole = "sniper";
	};
	if (["grenadier", _cfgName] call BIS_fnc_inString) then 
	{
		_cfgRole = "grenadier";
	};

	_cfgRole
};

doSetOpfor = {
	params ["_currentFactionName","_opforNameClass", "_existingValues"];
	//diag_log format ["%1%2 : %3",_opforNameClass,_currentFactionName, _existingValues];
	missionNamespace setVariable [format ["%1%2",_opforNameClass,_currentFactionName], _existingValues, true]; 
};

doDefineOpforFactionInfantry = {
	params ["_opforFaction", "_currentStuffFaction"];

	_coreEnemyGroup = [];

	//Setup core group
	_coreEnemyGroup pushBack ([_currentStuffFaction, "leader"] call getUnitByRole);
	for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do
	{ 
		_coreEnemyGroup pushBack ([_currentStuffFaction, "rifleman"] call getUnitByRole);
	};

	//setup core on every group
	_baseEnemyGroup = +_coreEnemyGroup;
	_baseEnemyATGroup = +_coreEnemyGroup;
	_baseEnemyDemoGroup = +_coreEnemyGroup;

	//Setup specific group design 
	//Base grouo
	_baseEnemyGroup pushBack ([_currentStuffFaction, "medic"] call getUnitByRole);
	_baseEnemyGroup pushBack ([_currentStuffFaction, "rifleman"] call getUnitByRole);
	for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
	{ 
		_baseEnemyGroup pushBack ([_currentStuffFaction, "autorifleman"] call getUnitByRole);
	};
	//diag_log format ["_baseEnemyGroup %1 ",_baseEnemyGroup];

	//AT group
	_baseEnemyATGroup pushBack ([_currentStuffFaction, "at"] call getUnitByRole);
	_baseEnemyATGroup pushBack ([_currentStuffFaction, "grenadier"] call getUnitByRole);
	//diag_log format ["_baseEnemyATGroup %1 ",_baseEnemyATGroup];

	//Demo group
	_baseEnemyDemoGroup pushBack ([_currentStuffFaction, "engineer"] call getUnitByRole);
	_baseEnemyDemoGroup pushBack ([_currentStuffFaction, "medic"] call getUnitByRole);
	//diag_log format ["_baseEnemyDemoGroup %1 ",_baseEnemyDemoGroup];

	//Fill with rifleman
	_baseEnemyGroup = [_baseEnemyGroup, _currentStuffFaction, 8] call doFillWithRifleman;
	_baseEnemyATGroup = [_baseEnemyATGroup, _currentStuffFaction, 6] call doFillWithRifleman;
	_baseEnemyDemoGroup = [_baseEnemyDemoGroup, _currentStuffFaction, 6] call doFillWithRifleman;

	[_opforFaction, "baseEnemyGroup", _baseEnemyGroup] call doSetOpfor;
	[_opforFaction, "baseEnemyATGroup", _baseEnemyATGroup] call doSetOpfor;
	[_opforFaction, "baseEnemyDemoGroup", _baseEnemyDemoGroup] call doSetOpfor;
};

getUnitByRole = {
	params ["_loadout", "_role"];

	_unit = "";
	_unitIndex = _loadout findIf {_x#0 == _role};

	if (_unitIndex != -1) then 
	{
		_unit = (_loadout#_unitIndex)#1;
	};
	_unit
};

doFillWithRifleman = {
	params ["_groupToEvaluate", "_currentStuffFaction", "_desiredNumber"];

	//diag_log format ["_groupToEvaluate %1 %3 desiredNumber %2",_groupToEvaluate, _desiredNumber, count _groupToEvaluate];

	if ((count _groupToEvaluate) < _desiredNumber) then 
	{
		_neededUnits = _desiredNumber-(count _groupToEvaluate);
		for [{_i = 0}, {_i < (_neededUnits)}, {_i = _i + 1}] do
		{ 
			_groupToEvaluate pushBack ([_currentStuffFaction, "rifleman"] call getUnitByRole);
		};
	};
	//diag_log format ["_groupToEvaluate after %1 %3 desiredNumber %2",_groupToEvaluate, _desiredNumber, count _groupToEvaluate];
	_groupToEvaluate
};

//Convert all faction number to faction string
for "_i" from 0 to count factionInfos -1 do
{
	private _element = factionInfos select _i;
	_element set [1, str (_element#1)];
	factionInfos set [_i, _element];
};

//This part was taken from DRO but highy modified 
_factionsWithUnitsFiltered = [];
_potentialFactions = [];

{
	if (isNumber (configFile >> "CfgVehicles" >> (configName _x) >> "scope")) then {
		if (((configFile >> "CfgVehicles" >> (configName _x) >> "scope") call BIS_fnc_GetCfgData) == 2) then {
			_factionClass = ((configFile >> "CfgVehicles" >> (configName _x) >> "faction") call BIS_fnc_GetCfgData);
			//_factionsWithUnits pushBackUnique _factionClass;		
			if ((configName _x) isKindOf "Man") then {
				_index = ([_factionsWithUnitsFiltered, _factionClass] call BIS_fnc_findInPairs);
				if (_index == -1) then {
					_factionsWithUnitsFiltered pushBack [_factionClass, 1];
				} else {
					_factionsWithUnitsFiltered set [_index, [((_factionsWithUnitsFiltered select _index) select 0), ((_factionsWithUnitsFiltered select _index) select 1)+1]];
				}; 
			};		
		};
	};
} forEach ("(configName _x) isKindOf 'AllVehicles'" configClasses (configFile / "CfgVehicles"));

//filter factions to select only blufor/east/independent
{
	//Filter strange factions
	if (count _x >1) then 
	{
		_thisSideNum = ((configFile >> "CfgFactionClasses" >> _x#0 >> "side") call BIS_fnc_GetCfgData);
		//systemChat ((configFile >> "CfgFactionClasses" >>_x#0 >> "displayName") call BIS_fnc_GetCfgData);

		//Check if sidenum is under 3
		if (!isNil "_thisSideNum") then 
		{
			if (typeName _thisSideNum == "SCALAR") then 
			{
				if (_thisSideNum <3) then 
				{
					_potentialFactions pushBack _x;
				};
			};
		};
	};
} foreach _factionsWithUnitsFiltered;


//Search in everyFaction the basic info
_potentialOpfor = [];
{
	_factionTechName = _x#0;
	if (factionInfos findIf {_x#0 == _factionTechName}==-1) then 
	{
		factionInfos pushBack [_factionTechName, _factionTechName, format ["%1 [AUTO]", ((configFile >> "CfgFactionClasses" >> _factionTechName >> "displayName") call BIS_fnc_GetCfgData)], true, true, false];
		_potentialOpfor pushBack _factionTechName;
	};
} foreach _potentialFactions;

publicVariable "factionInfos";

//Role filtered to not bo added in faction
_roleFilter = ["Unarmed", "Crewman"];

//Get All blufor stuff for every factions
{
	_cfgName = (configName _x);
	_cfgVehName = configFile >> "CfgVehicles" >> _cfgName;
	_thisFac = ((configFile >> "CfgVehicles" >> _cfgName >> "faction") call BIS_fnc_GetCfgData);

	if (_cfgName isKindOf 'Man') then {	

		// loadout_CHDSK_2020 = [		
		// 	[c_leader, "rhsgref_ins_g_squadleader", [], false],

		// ];
		_thisRole = ((_cfgVehName >> "role") call BIS_fnc_GetCfgData);
		if (_roleFilter findIf {_thisRole == _x} == -1) then {
			_currentFactionName = format ["loadout%1", _thisFac];
			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];

			_thisRole = [_thisRole, _cfgName] call adjustRole; 

			_indexFound = _currentStuffFaction findIf {_thisRole == (_x#0)};

			if (_indexFound == -1) then 
			{
				_currentStuffFaction pushBack [_thisRole, _cfgName];
				missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
			} else 
			{
				_currentStuffFactionCurrentRole = _currentStuffFaction#_indexFound;
				if (count _currentStuffFactionCurrentRole == 2) then 
				{
					_currentStuffFactionCurrentRole pushBack [_cfgName];
					_currentStuffFactionCurrentRole pushBack false;

				} else 
				{
					_currentStuffFactionCurrentRole#2 pushBack _cfgName;
				};
				_currentStuffFaction set [_indexFound, _currentStuffFactionCurrentRole];
				missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
			};
		};
	};

	if (_cfgName isKindOf 'Car' && !(_cfgName isKindOf 'Tank' || _cfgName isKindOf 'Wheeled_APC_F' || _cfgName isKindOf 'APC_Tracked_02_base_F')) then {	

			_currentFactionName = format ["bluforUnarmedVehicle%1", _thisFac];

			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentStuffFaction pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
	};
	if (_cfgName isKindOf 'Helicopter') then {	

			_currentFactionName = format ["bluforUnarmedVehicleChopper%1", _thisFac];

			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentStuffFaction pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
	};
	if (_cfgName isKindOf 'Tank' || _cfgName isKindOf 'Wheeled_APC_F' || _cfgName isKindOf 'APC_Tracked_02_base_F') then {	

			_currentFactionName = format ["bluforArmoredVehicle%1", _thisFac];

			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentStuffFaction pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
	};
	if (_cfgName isKindOf 'Ship') then {	

			_currentFactionName = format ["bluforBoat%1", _thisFac];

			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentStuffFaction pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
	};
	if (_cfgName isKindOf 'Plane') then {	

			_currentFactionName = format ["bluforFixedWing%1", _thisFac];

			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentStuffFaction pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
	};
	if (_cfgName isKindOf 'StaticWeapon') then {	

		if (["82mm", _cfgName] call BIS_fnc_inString || ["Mortar", _cfgName] call BIS_fnc_inString) then 
		{
			_currentFactionName = format ["bluforMortar%1", _thisFac];

			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentStuffFaction pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
		} else {
			_currentFactionName = format ["bluforStaticWeapon%1", _thisFac];

			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentStuffFaction pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
		}
	};	

} foreach ("(getNumber (_x >> 'scope') == 2)" configClasses (configFile / "CfgVehicles"));

//Adjust basic role 
{
	_thisFac = _x;

	_currentFactionName = format ["loadout%1", _thisFac];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];

	_riflemanRoleIndex = (_currentStuffFaction findIf {"rifleman" == _x#0});

	//If there is a rifleman role
	if (_riflemanRoleIndex != -1) then {
		_riflemanRoleConfig = _currentStuffFaction#_riflemanRoleIndex;
		_riflemanRoles = [];

		//Populate faction loadout with basic rifleman everywhere
		if (count _riflemanRoleConfig == 2) then 
		{
			_riflemanRoles pushBack _riflemanRoleConfig#1;
		} else 
		{
			
			//Add all rifleman roles
			{
				_riflemanRoles pushBack _x;
			} foreach _riflemanRoleConfig#2;
		};

		//Add rifleman role to every other role 
		//The goal is to authorize rifleman stuff for every role
		{
			_currentRole = _x#0;
			_currentStuffFactionCurrentRole = _x;

			if (_currentRole != "rifleman") then 
			{
				_indexFound = _currentStuffFaction findIf {_currentRole == (_x#0)};
				if (count _currentStuffFactionCurrentRole == 2) then 
				{
					_currentStuffFactionCurrentRole pushBack _riflemanRoles;
					_currentStuffFactionCurrentRole pushBack false;
				} else 
				{
					_currentStuffFactionCurrentRole#2 append _riflemanRoles;
				};
				_currentStuffFaction set [_indexFound, _currentStuffFactionCurrentRole];
			};
		}	foreach _currentStuffFaction;

		//write new loadout
		missionNamespace setVariable [_currentFactionName, _currentStuffFaction, true]; 
	};
} foreach _potentialOpfor;


//Define Opfor factions 
{
	_thisFac = _x;

	//Define infantry
	_currentFactionName = format ["loadout%1", _thisFac];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
	[_thisFac, _currentStuffFaction] call doDefineOpforFactionInfantry;

	//Define mortar 
	_currentFactionName = format ["bluforMortar%1", _thisFac];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
	if (count _currentStuffFaction > 0) then 
	{
		[_thisFac, "baseEnemyMortarGroup", [_currentStuffFaction#0]] call doSetOpfor;
	};

	//Define vehicle
	_currentFactionName = format ["bluforUnarmedVehicle%1", _thisFac];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
	[_thisFac, "baseEnemyVehicleGroup", _currentStuffFaction] call doSetOpfor;

	_currentFactionName = format ["bluforArmoredVehicle%1", _thisFac];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
	_heavy = [];
	_light = [];
	{
		switch true do {
			case (_x isKindOf 'Tank'):
			{
				_heavy pushBack _x;
			};
			case (_x isKindOf 'Wheeled_APC_F');
			case (_x isKindOf 'APC_Tracked_02_base_F'):
			{
				_light pushBack _x;
			};
		};
	} foreach _currentStuffFaction;
	[_thisFac, "baseEnemyLightArmoredVehicleGroup", _light] call doSetOpfor;
	[_thisFac, "baseEnemyHeavyArmoredVehicleGroup", _heavy] call doSetOpfor;

	_currentFactionName = format ["bluforUnarmedVehicleChopper%1", _thisFac];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
	[_thisFac, "baseEnemyUnarmedChopperGroup", _currentStuffFaction] call doSetOpfor;

	_currentFactionName = format ["bluforFixedWing%1", _thisFac];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
	[_thisFac, "baseFixedWingGroup", _currentStuffFaction] call doSetOpfor;

	//Define static
	_currentFactionName = format ["bluforStaticWeapon%1", _thisFac];
	_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
	_static = [];
	{
		_static pushBack [_x, selectRandom ["SMALLBUNKER", "NOTHING"]];
	} foreach _currentStuffFaction;

	[_thisFac, "baseEnemyTurretGroup", _static] call doSetOpfor;

} foreach _potentialOpfor;




// ARTILLERY VEHICLE FILTER 
// _Fnc_Is_Vehicle_Arty =

// {

// _Veh = _this select 0;

// _result = 0;

// if (isNumber (configFile >> "CfgVehicles" >> _Veh >> "artilleryScanner")) then

// {

// 	_result = getNumber (configFile >> "CfgVehicles" >> _Veh >> "artilleryScanner");

// };

// _result

// };