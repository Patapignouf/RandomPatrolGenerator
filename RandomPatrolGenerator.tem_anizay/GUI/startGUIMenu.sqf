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

//Get all combo box value
bluforFactionSelected = _comboBoxBlufor lbData (lbCurSel _comboBoxBlufor);
opforFactionSelected = _comboBoxOpfor lbData (lbCurSel _comboBoxOpfor);
independentFactionSelected = _comboBoxIndependent lbData (lbCurSel _comboBoxIndependent);
civilianFactionSelected = _comboBoxCivilian lbData (lbCurSel _comboBoxCivilian);

warEraSelected = _comboBoxWarEra lbData (lbCurSel _comboBoxWarEra);
enableArmedAicraftSelected = _comboBoxEnableArmedAicraft lbData (lbCurSel _comboBoxEnableArmedAicraft);
enableArmoredVehicleSelected = _comboBoxEnableArmoredVehicle lbData (lbCurSel _comboBoxEnableArmoredVehicle);
enableCampaignModeSelected = _comboBoxEnableCampaignMode lbData (lbCurSel _comboBoxEnableCampaignMode);
missionLengthSelected = _comboBoxMissionLength lbData (lbCurSel _comboBoxMissionLength);
missionDifficultySelected = _comboBoxMissionDifficulty lbData (lbCurSel _comboBoxMissionDifficulty);

//Display combo box value for debug
diag_log format ["Blufor faction choose : %1\nOpfor faction choose : %2\nIndependent faction choose : %3\nCivilian faction choose : %4\n ", bluforFactionSelected, opforFactionSelected, independentFactionSelected, civilianFactionSelected];

//Define global faction variable 
missionNamespace setVariable ["warEra", parseNumber warEraSelected, true]; // GUI generation mission boolean flag
missionNamespace setVariable ["bluforFaction", parseNumber bluforFactionSelected, true]; //Default faction 14 -> OTAN 2035
missionNamespace setVariable ["opforFaction", parseNumber opforFactionSelected, true]; //Default faction 3 -> Syndikat
missionNamespace setVariable ["independentFaction", parseNumber independentFactionSelected, true]; //Default faction 3 -> Syndikat
missionNamespace setVariable ["civilianFaction", parseNumber civilianFactionSelected, true]; //Default faction 3 -> Syndikat


//Missions vehicle settings
missionNamespace setVariable ["enableArmedAicraft", [enableArmedAicraftSelected, "true"] call BIS_fnc_inString, true]; //Default armed aircraft are disabled
missionNamespace setVariable ["enableArmoredVehicle",[enableArmoredVehicleSelected, "true"] call BIS_fnc_inString, true]; //Default armored vehicle are disabled

//Mission configuration
missionNamespace setVariable ["enableCampaignMode", [enableCampaignModeSelected, "true"] call BIS_fnc_inString, true]; //Default armored vehicle are disabled
missionNamespace setVariable ["missionLength", parseNumber missionLengthSelected, true]; //Default armored vehicle are disabled
missionNamespace setVariable ["missionDifficultyParam", parseNumber missionDifficultySelected, true]; //Default armored vehicle are disabled

//Begin mission generation
missionNamespace setVariable ["generationSetup", true, true]; 

//Close setup menu
_mainDisplay closeDisplay 1;