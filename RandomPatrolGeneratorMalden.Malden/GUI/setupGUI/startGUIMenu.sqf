disableSerialization;
params ["_thisButtonValidate"];

//Get All Combo box
private _mainDisplay = (findDisplay 6000);
private _comboBoxBlufor = _mainDisplay displayCtrl 6100;
private _comboBoxOpfor = _mainDisplay displayCtrl 6101;
private _comboBoxIndependent = _mainDisplay displayCtrl 6102;
private _comboBoxCivilian = _mainDisplay displayCtrl 6103;
private _comboBoxWarEra = _mainDisplay displayCtrl 6104;
private _comboBoxEnableArmedAicraft = _mainDisplay displayCtrl 6105;
private _comboBoxEnableArmoredVehicle = _mainDisplay displayCtrl 6106;
private _comboBoxEnableCampaignMode = _mainDisplay displayCtrl 6107;
private _comboBoxMissionLength = _mainDisplay displayCtrl 6108;
private _comboBoxMissionDifficulty = _mainDisplay displayCtrl 6109;
private _comboBoxIronman = _mainDisplay displayCtrl 6110;
private _comboBoxStartIntel = _mainDisplay displayCtrl 6112;
private _comboBoxIASkill = _mainDisplay displayCtrl 6113;
private _comboBoxRespawnParam = _mainDisplay displayCtrl 6114;

//Get all combo box value
bluforFactionSelected = _comboBoxBlufor lbData (lbCurSel _comboBoxBlufor);
opforFactionSelected = _comboBoxOpfor lbData (lbCurSel _comboBoxOpfor);
independentFactionSelected = _comboBoxIndependent lbData (lbCurSel _comboBoxIndependent);
civilianFactionSelected = _comboBoxCivilian lbData (lbCurSel _comboBoxCivilian);
ironManSelected = _comboBoxIronman lbData (lbCurSel _comboBoxIronman);

warEraSelected = _comboBoxWarEra lbData (lbCurSel _comboBoxWarEra);
enableArmedAicraftSelected = _comboBoxEnableArmedAicraft lbData (lbCurSel _comboBoxEnableArmedAicraft);
enableArmoredVehicleSelected = _comboBoxEnableArmoredVehicle lbData (lbCurSel _comboBoxEnableArmoredVehicle);
enableCampaignModeSelected = _comboBoxEnableCampaignMode lbData (lbCurSel _comboBoxEnableCampaignMode);
missionLengthSelected = _comboBoxMissionLength lbData (lbCurSel _comboBoxMissionLength);
missionDifficultySelected = _comboBoxMissionDifficulty lbData (lbCurSel _comboBoxMissionDifficulty);
missionStartIntel = _comboBoxStartIntel lbData (lbCurSel _comboBoxStartIntel);
missionIASkillParam = _comboBoxIASkill lbData (lbCurSel _comboBoxIASkill);
missionRespawnParam = _comboBoxRespawnParam lbData (lbCurSel _comboBoxRespawnParam);

//Display combo box value for debug
//Manage random blufor faction
if (bluforFactionSelected == "RANDOM") then 
{
	bluforFactionSelected = selectRandom (factionInfos select {_x#3})#1;
};

//Manage random blufor faction
if (opforFactionSelected == "RANDOM") then 
{
	opforFactionSelected = selectRandom (factionInfos select {_x#4})#1;
};

//Manage random independent faction
if (independentFactionSelected == "RANDOM") then 
{
	independentFactionSelected = selectRandom (factionInfos select {_x#3})#1;
};

diag_log format ["Blufor faction choose : %1\nOpfor faction choose : %2\nIndependent faction choose : %3\nCivilian faction choose : %4\n ", bluforFactionSelected, opforFactionSelected, independentFactionSelected, civilianFactionSelected];

//Define global faction variable 
missionNamespace setVariable ["warEra", parseNumber warEraSelected, true]; // GUI generation mission boolean flag
missionNamespace setVariable ["bluforFaction", bluforFactionSelected, true]; //Default faction 14 -> OTAN 2035
missionNamespace setVariable ["opforFaction", opforFactionSelected, true]; //Default faction 3 -> Syndikat
missionNamespace setVariable ["independentFaction", independentFactionSelected, true]; //Default faction 3 -> Syndikat
missionNamespace setVariable ["civilianFaction", civilianFactionSelected, true]; //Default faction 3 -> Syndikat


//Missions vehicle settings
missionNamespace setVariable ["enableArmedAicraft", [enableArmedAicraftSelected, "true"] call BIS_fnc_inString, true]; //Default armed aircraft are disabled
missionNamespace setVariable ["enableArmoredVehicle",[enableArmoredVehicleSelected, "true"] call BIS_fnc_inString, true]; //Default armored vehicle are disabled

//Mission configuration
missionNamespace setVariable ["enableCampaignMode", [enableCampaignModeSelected, "true"] call BIS_fnc_inString, true]; //Default armored vehicle are disabled
missionNamespace setVariable ["missionLength", parseNumber missionLengthSelected, true]; //Default armored vehicle are disabled
missionNamespace setVariable ["missionDifficultyParam", parseNumber missionDifficultySelected, true]; //Default armored vehicle are disabled
missionNamespace setVariable ["ironMan", [ironManSelected, "true"] call BIS_fnc_inString, true]; //Default disable ironman mode
missionNamespace setVariable ["startIntel", parseNumber missionStartIntel, true]; //Default disable ironman mode
missionNamespace setVariable ["missionIASkillParam", parseNumber missionIASkillParam, true]; //Default medium difficulty
missionNamespace setVariable ["missionRespawnParam", parseNumber missionRespawnParam, true]; //Default disable ironman mode

//Fix type of obj not saved
missionNameSpace setVariable ["avalaibleTypeOfObj", profileNamespace getVariable ["RPG_avalaibleTypeOfObj", []], true];

//Go to objective selection
if (_thisButtonValidate) then 
{
	[[], 'GUI\setupGUI\startGUIMenuLocation.sqf'] remoteExec ['BIS_fnc_execVM', player];

} else 
{
	_execSave = [] execVM 'GUI\setupGUI\saveSettings.sqf';
	waitUntil { isNull _execSave};
	[[], 'GUI\setupGUI\advancedSetup.sqf'] remoteExec ['BIS_fnc_execVM', player];
};

//Close setup menu
_mainDisplay closeDisplay 1;
