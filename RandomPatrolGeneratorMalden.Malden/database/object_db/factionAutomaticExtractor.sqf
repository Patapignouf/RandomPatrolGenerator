#include "factionsBaseFunctions.sqf";

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
_potentialCivFactions = [];

{
	if (isNumber (configFile >> "CfgVehicles" >> (configName _x) >> "scope")) then {
		if (((configFile >> "CfgVehicles" >> (configName _x) >> "scope") call BIS_fnc_GetCfgData) == 2) then {
			_factionClass = ((configFile >> "CfgVehicles" >> (configName _x) >> "faction") call BIS_fnc_GetCfgData);
			//_factionsWithUnits pushBackUnique _factionClass;		
			if ((configName _x) isKindOf "Man") then {
				_index = ([_factionsWithUnitsFiltered, _factionClass] call BIS_fnc_findInPairs);
				if (_index == -1) then {
					_factionsWithUnitsFiltered pushBack [_factionClass, 1, ((configFile >> "CfgVehicles" >> configName _x >> "side") call BIS_fnc_GetCfgData)];
				} else {
					_factionsWithUnitsFiltered set [_index, [((_factionsWithUnitsFiltered select _index) select 0), ((_factionsWithUnitsFiltered select _index) select 1)+1,((configFile >> "CfgVehicles" >> configName _x >> "side") call BIS_fnc_GetCfgData)]];
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
				} else 
				{
					if (_thisSideNum  == 3) then 
					{
						_potentialCivFactions pushBack _x;
					};
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
		_sideName = "";
		switch (_x#2) do {
			case 0:
			{
				_sideName = "OPFOR";
				[opfor, _factionTechName] call addRadioToFaction;
			};
			case 1:
			{
				_sideName = "BLUFOR";
				[blufor, _factionTechName] call addRadioToFaction;
			};
			case 2:
			{
				_sideName = "INDEPENDENT";
				[independent, _factionTechName] call addRadioToFaction;
			};
		};

		factionInfos pushBack [_factionTechName, _factionTechName, format ["%1 [AUTO %2]", ((configFile >> "CfgFactionClasses" >> _factionTechName >> "displayName") call BIS_fnc_GetCfgData), _sideName], true, true, false];
		_potentialOpfor pushBack _factionTechName;
	};
} foreach _potentialFactions;

{
	_factionTechName = _x#0;
	if (factionInfos findIf {_x#0 == _factionTechName}==-1) then 
	{
		factionInfos pushBack [_factionTechName, _factionTechName, format ["%1 [AUTO]", ((configFile >> "CfgFactionClasses" >> _factionTechName >> "displayName") call BIS_fnc_GetCfgData)], false, false, true];
	};
} foreach _potentialCivFactions;

publicVariable "factionInfos";

//Role filtered to not bo added in faction
_roleFilter = ["Unarmed"];

//Get All blufor stuff for every factions
{
	_cfgName = (configName _x);
	_cfgVehName = configFile >> "CfgVehicles" >> _cfgName;
	_thisFac = ((configFile >> "CfgVehicles" >> _cfgName >> "faction") call BIS_fnc_GetCfgData);

	if (_cfgName isKindOf 'Man') then {	

		//Check civilian mans
		if ((_cfgVehName >> "side") call BIS_fnc_GetCfgData == 3) then 
		{
			_currentFactionName = format ["potentialCivMan%1", _thisFac];
			_currentCivMans = 	missionNamespace getVariable [_currentFactionName, []];
			_currentCivMans pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentCivMans]; 
		} else 
		{
			if !(["story", _cfgName, false] call BIS_fnc_inString || ["story", ((_cfgVehName >> "editorSubcategory") call BIS_fnc_GetCfgData), false] call BIS_fnc_inString) then 
			{		
				_thisRole = ((_cfgVehName >> "role") call BIS_fnc_GetCfgData);
				if (_roleFilter findIf {_thisRole == _x} == -1) then {
					_currentFactionName = format ["loadout%1", _thisFac];
					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];

					_thisRole = [_thisRole, _cfgName] call adjustRole; 

					if (_thisRole != "empty" && _thisRole != "") then 
					{
						_indexFound = _currentStuffFaction findIf {_thisRole == (_x#0)};
						if (_indexFound == -1) then 
						{
							_currentStuffFaction pushBack [_thisRole, _cfgName];
							missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
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
							missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
						};

						//Add backpack
						_currentFactionName = format ["backPackList%1", _thisFac];
						_currentUnitStuff = getUnitLoadout _cfgName;
						_loadoutToCheck = [([_currentUnitStuff] call getAllStringInArray)] call filterString;
						_currentUnitStuff = [_loadoutToCheck] call getListOfBagsFromStuff;
						_backPackList = missionNamespace getVariable [_currentFactionName, []];
						_backPackList = _backPackList + _currentUnitStuff;
						missionNamespace setVariable [_currentFactionName, _backPackList]; 

						
						//Specifies accessories for the faction
						if (_thisRole == "leader" || _thisRole == "rifleman") then 
						{
							//Allow all accessories from the leader to other people

							_currentFactionName = format ["attachmentShortList%1", _thisFac];

							_currentUnitStuff = getUnitLoadout _cfgName;
							_loadoutToCheck = [([_currentUnitStuff] call getAllStringInArray)] call filterString;
							_currentUnitStuff = [_loadoutToCheck] call getListOfAccessoriesFromStuff;
							_accessoriesShort = missionNamespace getVariable [_currentFactionName, []];
							_accessoriesShort = _accessoriesShort + _currentUnitStuff;
							missionNamespace setVariable [_currentFactionName, _accessoriesShort]; 
						};

						//Specifies accessories for the faction
						if (_thisRole == "rifleman") then 
						{
							//Allow all weapons from the rifleman to other people
							_currentUnitStuff = getUnitLoadout _cfgName;
							_loadoutToCheck = [([_currentUnitStuff] call getAllStringInArray)] call filterString;
							_currentUnitStuff = [_loadoutToCheck] call getListOfWeaponsFromStuff;
							
							//Get weapons and accessories already attached
							_listOfWeaponsAndAccessoriesFromStuff = [_currentUnitStuff] call getAllAccessoriesAndWeaponsFromWeapons;

							//Whitelist complete weapons and weapons
							_currentFactionName = format ["rifleList%1", _thisFac];
							_rifleList = missionNamespace getVariable [_currentFactionName, []];
							_rifleList = _rifleList + _currentUnitStuff + _listOfWeaponsAndAccessoriesFromStuff#0;
							missionNamespace setVariable [_currentFactionName, _rifleList]; 

							//Whitelist accessories already attached
							_currentFactionName = format ["attachmentShortList%1", _thisFac];
							_accessoriesShort = missionNamespace getVariable [_currentFactionName, []];
							_accessoriesShort = _accessoriesShort + _listOfWeaponsAndAccessoriesFromStuff#1;
							missionNamespace setVariable [_currentFactionName, _accessoriesShort]; 
						};
					};
				};
			};
		};
	};

	//Check civilian vehicles
	if ((_cfgVehName >> "side") call BIS_fnc_GetCfgData == 3) then 
	{
		if (_cfgName isKindOf 'Car') then 
		{
			_currentFactionName = format ["civilianTruck%1", _thisFac];
			_currentCivMans = 	missionNamespace getVariable [_currentFactionName, []];
			_currentCivMans pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentCivMans]; 
		};
	} else 
	{
		//Detect UAV 
		_vehicleClass = (configFile >> "CfgVehicles" >> _cfgName >> "vehicleClass") call BIS_fnc_GetCfgData;
		if (_vehicleClass == "Autonomous") then 
		{
			_currentFactionName = format ["bluforDrone%1", _thisFac];

			_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
			_currentStuffFaction pushBack _cfgName;
			missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
		} else 
		{
			if (_cfgName isKindOf 'Car' && !(_cfgName isKindOf 'Tank' || _cfgName isKindOf 'Wheeled_APC_F' || _cfgName isKindOf 'APC_Tracked_02_base_F' || ((configFile >> "CfgVehicles" >> _cfgName >> "artilleryScanner") call BIS_fnc_GetCfgData) == 1 )) then {	
				if (count (_cfgName call BIS_fnc_allTurrets) == 0) then 
				{
					//Add unarmed vehicle to base vehicles
					_currentFactionName = format ["bluforUnarmedVehicle%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 

					//Add unarmed vehicles to HQ vehicles
					_currentFactionName = format ["bluforHQVehicle%1", _thisFac];
					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
				} else 
				{
					_currentFactionName = format ["bluforArmedVehicle%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;

					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
				};
			};
			if (_cfgName isKindOf 'Helicopter') then {	
				//if (count (((configFile >> "CfgVehicles" >> _cfgName >> "weapons") call BIS_fnc_GetCfgData) select {_x != "CMFlareLauncher"})== 0) then 
				if (count (((configFile >> "CfgVehicles" >> _cfgName >> "availableForSupportTypes") call BIS_fnc_GetCfgData) select {_x == "CAS_Heli"})== 1) then 
				{
					_currentFactionName = format ["bluforArmedChopper%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
				} else 
				{
					_currentFactionName = format ["bluforUnarmedVehicleChopper%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
				};
			};
			if ((_cfgName isKindOf 'Tank' || _cfgName isKindOf 'Wheeled_APC_F' || _cfgName isKindOf 'APC_Tracked_02_base_F') && ((configFile >> "CfgVehicles" >> _cfgName >> "artilleryScanner") call BIS_fnc_GetCfgData) == 0) then {	

					_currentFactionName = format ["bluforArmoredVehicle%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
			};
			if (_cfgName isKindOf 'Ship') then {	

					_currentFactionName = format ["bluforBoat%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
			};
			if (_cfgName isKindOf 'Plane') then {	

					_currentFactionName = format ["bluforFixedWing%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
			};
			if (_cfgName isKindOf 'StaticWeapon') then {	

				if (["82mm", _cfgName] call BIS_fnc_inString || ["Mortar", _cfgName] call BIS_fnc_inString) then 
				{
					_currentFactionName = format ["bluforMortar%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
				} else {
					_currentFactionName = format ["bluforStaticWeapon%1", _thisFac];

					_currentStuffFaction = 	missionNamespace getVariable [_currentFactionName, []];
					_currentStuffFaction pushBack _cfgName;
					missionNamespace setVariable [_currentFactionName, _currentStuffFaction]; 
				}
			};	
		};
	};

} foreach ("(getNumber (_x >> 'scope') == 2)" configClasses (configFile / "CfgVehicles"));


//Manage civilians men groups
{
	_thisFac = _x#0;

	//Get all civilians mens 
	_currentFactionName = format ["potentialCivMan%1", _thisFac];
	_currentCivMans = 	missionNamespace getVariable [_currentFactionName, []];

	if (count _currentCivMans != 0) then
	{
		//Build 5 men group 
		_currentGroup = [];
		_currentFactionName = format ["civilian_group%1", _thisFac];

		for [{_i = 0}, {_i < 5}, {_i = _i + 1}] do
		{
			_currentGroup pushBack (selectRandom _currentCivMans);
		};
		missionNamespace setVariable [_currentFactionName, _currentGroup]; 

		//Build 8 men group
		_currentGroup = [];
		_currentFactionName = format ["civilian_big_group%1", _thisFac];

		for [{_i = 0}, {_i < 8}, {_i = _i + 1}] do
		{
			_currentGroup pushBack (selectRandom _currentCivMans);
		};
		missionNamespace setVariable [_currentFactionName, _currentGroup]; 
	};
} foreach _potentialCivFactions;

//Manage specific faction merging 
if ("EnableRHSMerge" call BIS_fnc_getParamValue == 1) then 
{
	["rhs_faction_usmc_d", "rhs_faction_usaf"] call mergeFactions;
	["rhs_faction_usmc_d", "rhs_faction_usn"] call mergeFactions;
	["rhs_faction_usmc_w", "rhs_faction_usaf"] call mergeFactions;
	["rhs_faction_usmc_w", "rhs_faction_usn"] call mergeFactions;
	["rhs_faction_usarmy_d", "rhs_faction_usaf"] call mergeFactions;
	["rhs_faction_usarmy_w", "rhs_faction_usaf"] call mergeFactions;
	["rhsgref_faction_cdf_ground", "rhsgref_faction_cdf_air"] call mergeFactions;
	["rhs_faction_msv", "rhs_faction_vvs_c"] call mergeFactions;
	["rhsgref_faction_cdf_ground_b", "rhsgref_faction_cdf_air_b"] call mergeFactions;
};


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
	_currentFactionName = format ["bluforArmedVehicle%1", _thisFac];
	_currentStuffFaction = _currentStuffFaction + (missionNamespace getVariable [_currentFactionName, []]);
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