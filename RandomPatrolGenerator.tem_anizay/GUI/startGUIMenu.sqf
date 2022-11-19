disableSerialization;
params ["_thisButtonValidate"];

//Get All Combo box
private _mainDisplay = (findDisplay 6000);
private _comboBoxBlufor = _mainDisplay displayCtrl 6100;
private _comboBoxOpfor = _mainDisplay displayCtrl 6101;
private _comboBoxIndependent = _mainDisplay displayCtrl 6102;
private _comboBoxCivilian = _mainDisplay displayCtrl 6103;

//Get all combo box value
bluforFactionSelected = _comboBoxBlufor lbData (lbCurSel _comboBoxBlufor);
opforFactionSelected = _comboBoxBlufor lbData (lbCurSel _comboBoxOpfor);
independentFactionSelected = _comboBoxBlufor lbData (lbCurSel _comboBoxIndependent);
civilianFactionSelected = _comboBoxBlufor lbData (lbCurSel _comboBoxCivilian);

//Display combo box value for debug
diag_log format ["Blufor faction choose : %1\nOpfor faction choose : %2\nIndependent faction choose : %3\nCivilian faction choose : %4\n ", bluforFactionSelected, opforFactionSelected, independentFactionSelected, civilianFactionSelected];

//Define global faction variable 
missionNamespace setVariable ["bluforFaction", parseNumber bluforFactionSelected, true]; //Default faction 14 -> OTAN 2035
missionNamespace setVariable ["opforFaction", parseNumber opforFactionSelected, true]; //Default faction 3 -> Syndikat
missionNamespace setVariable ["independentFaction", parseNumber independentFactionSelected, true]; //Default faction 3 -> Syndikat
missionNamespace setVariable ["civilianFaction", parseNumber civilianFactionSelected, true]; //Default faction 3 -> Syndikat

//Begin mission generation
missionNamespace setVariable ["generationSetup", true, true]; 

//Close setup menu
_mainDisplay closeDisplay 1;
