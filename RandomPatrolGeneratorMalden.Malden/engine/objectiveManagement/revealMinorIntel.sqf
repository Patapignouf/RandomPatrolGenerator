params ["_caller","_revealedMode"];

//Get current avalaible info
_revealedMissionEnemyInfo = missionNamespace getVariable ["revealedMissionEnemyInfo",[]];
_MissionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];

//Select an avalaible info to reveal
_potentialMissionEnemyInfo = _MissionEnemyInfo - _revealedMissionEnemyInfo;

if (count _potentialMissionEnemyInfo >0) then 
{
	_infoToReveal = selectRandom _potentialMissionEnemyInfo;
	_revealedMissionEnemyInfo pushBack _infoToReveal;
	missionNamespace setVariable ["revealedMissionEnemyInfo",_revealedMissionEnemyInfo,true];

	//Search info description
	_infoName = _infoToReveal select 0;
	_infoPos = _infoToReveal select 1;
	_infoGroup = _infoToReveal select 2;
	_nearestCity = nearestLocations [_infoPos, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
	_intelCivilianRevelated = ""; //Description when player is talking to a civilian
	_intelDocumentRevelated = ""; //Description when player is looting corpse or document
	_mapMarkerName = "";
	_mapMarkerIcon = "";
	_color = "ColorRed";

	switch (_infoName) do 
	{
		case "Mortar":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_MORTAR_CIV", text _nearestCity];
			_intelDocumentRevelated = ["STR_RPG_INTEL_MORTAR_DOC", mapGridPosition _infoPos];
			_mapMarkerName = "Mortar";
			_mapMarkerIcon = "b_mortar";
		};
		case "Turret":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_TURRET_CIV",text _nearestCity];
			_intelDocumentRevelated = ["STR_RPG_INTEL_TURRET_DOC", mapGridPosition _infoPos];
			_mapMarkerName = "Bunker";
			_mapMarkerIcon = "b_installation";
		};
		case "Patrol":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_PATROL_CIV", text _nearestCity, count units _infoGroup];
			_intelDocumentRevelated = ["STR_RPG_INTEL_PATROL_DOC", mapGridPosition _infoPos, count units _infoGroup];
			_mapMarkerName = format ["patrol %1 men", count units _infoGroup];
			_mapMarkerIcon = "b_inf";
		};
		case "Car":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_CAR_CIV",text _nearestCity, getText (configFile >> "cfgVehicles" >> typeOf (vehicle leader (_infoGroup)) >> "displayName")];
			_intelDocumentRevelated = ["STR_RPG_INTEL_CAR_DOC", mapGridPosition _infoPos, getText (configFile >> "cfgVehicles" >> typeOf (vehicle leader (_infoGroup)) >> "displayName")];
			_mapMarkerName = getText (configFile >> "cfgVehicles" >> typeOf (vehicle leader (_infoGroup)) >> "displayName");
			_mapMarkerIcon = "b_motor_inf";
		};
		case "LightArmored";
		case "HeavyArmored":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_ARMORED_CIV",text _nearestCity];
			_intelDocumentRevelated = ["STR_RPG_INTEL_ARMORED_DOC", mapGridPosition _infoPos, getText (configFile >> "cfgVehicles" >> typeOf (vehicle leader (_infoGroup)) >> "displayName")];
			_mapMarkerName = getText (configFile >> "cfgVehicles" >> typeOf (vehicle leader (_infoGroup)) >> "displayName");
			_mapMarkerIcon = "b_armor";
		};
		case "DefenseFOBInfantry":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_FOB_INF_CIV", mapGridPosition _infoPos];
			_intelDocumentRevelated = ["STR_RPG_INTEL_FOB_INF_DOC", mapGridPosition _infoPos];
			_mapMarkerName = "FOB";
			_mapMarkerIcon = "o_hq";
		};
		case "RoadblockInfantry":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_FOB_INF_CIV", mapGridPosition _infoPos];
			_intelDocumentRevelated = ["STR_RPG_INTEL_FOB_INF_DOC", mapGridPosition _infoPos];
			_mapMarkerName = "Roadblock";
			_mapMarkerIcon = "o_inf";
		};
		case "DefenseInfantry":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_DEFENSE_INF_CIV",text _nearestCity, count units _infoGroup];
			_intelDocumentRevelated = ["STR_RPG_INTEL_DEFENSE_INF_DOC", mapGridPosition _infoPos, count units _infoGroup];
			_mapMarkerName = format ["squad %1 men", count units _infoGroup];
			_mapMarkerIcon = "b_inf";
		};
		case "Civilian":
		{
			_intelCivilianRevelated = ["STR_RPG_INTEL_CIV_PRESENCE_CIV", text _nearestCity];
			_intelDocumentRevelated = ["STR_RPG_INTEL_CIV_PRESENCE_DOC", mapGridPosition _infoPos];
			_mapMarkerName = "Civilians";
			_mapMarkerIcon = "loc_CivilDefense";
			_color = "ColorCIV";
		};
	};

	//Locate on map
	if (missionNameSpace getVariable ["enableObjectiveExactLocation", 0] != 0) then 
	{ 
		_randomPos = [[[_infoPos, 15]], []] call BIS_fnc_randomPos; 
		[[_mapMarkerName, _color, _mapMarkerIcon, _randomPos, "All"], 'objectGenerator\doGenerateMarker.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
	};

	_intelToReveal = "";

	switch (_revealedMode) do 
	{
		case "civilianAsking":
		{
			_intelToReveal = _intelCivilianRevelated;
			//Display dialog to the player
			[[_intelToReveal], {params ["_intelToReveal"]; ["STR_RPG_CIVILIAN_NAME", _intelToReveal] call doDialogWithCustomParam}] remoteExec ["spawn", _caller]; 
		};
		case "corpseLooting":
		{
			_intelToReveal = _intelDocumentRevelated;
			//Display dialog to the player
			[[_intelToReveal], {params ["_intelToReveal"]; ["STR_RPG_CORPSE_NAME", _intelToReveal] call doDialogWithCustomParam}] remoteExec ["spawn", _caller]; 
		};
		case "HQ":
		{
			_intelToReveal = _intelDocumentRevelated;
			//Display dialog to the player
			[[_intelToReveal], {params ["_intelToReveal"]; ["STR_RPG_HC_NAME", _intelToReveal] call doDialogWithCustomParam}] remoteExec ["spawn", _caller]; 
		};
		default
		{
			//Do nothing
		};
	};

	//Create diary entry for the intel 
	_intelDiaryAlreadyRevealed = _caller getVariable "diaryIntel";
	_allDiaryIntel =  format ["%1 <br/> %2 <br/>", _intelDiaryAlreadyRevealed, localize _intelToReveal];
	_caller removeDiaryRecord  ["RPG", _intelDiaryAlreadyRevealed]; //Update diary doesn't work very well so delete/create is the only solution
	_newIntelDiaryAlreadyRevealed = _caller createDiaryRecord ["RPG", ["RPG intel", _allDiaryIntel]];
	_caller setVariable ["diaryIntel", _newIntelDiaryAlreadyRevealed];
};
