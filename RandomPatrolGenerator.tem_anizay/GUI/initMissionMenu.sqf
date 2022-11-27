
disableSerialization;
#include "..\database\factionParameters.sqf"
#include "..\database\missionParameters.sqf"

//Create GUI
createDialog "DialogSetupParams";

//Specify all GUI items
//Define a comboBox foreach faction
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

//Specify all GUI content 
//Populate faction comboBox
{
	_currentComboBox = _x;
	{
		_currentComboBox lbAdd format ["%1", _x select 2];
		_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 1]];
	} foreach factionInfos;
} foreach [_comboBoxBlufor, _comboBoxOpfor, _comboBoxIndependent, _comboBoxCivilian];

//War Era
_currentComboBox = _comboBoxWarEra;
{
	_currentComboBox lbAdd format ["%1", _x select 1];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 0]];
} foreach warEraSelection;


//Default faction 
_comboBoxBlufor lbSetCurSel (14); //Otan 2035
_comboBoxOpfor lbSetCurSel (3); //Syndikat
_comboBoxIndependent lbSetCurSel (3); //Syndikat
_comboBoxCivilian lbSetCurSel (3); //Syndikat
_comboBoxWarEra lbSetCurSel (3); //Actual Warfare

//Populate Missions vehicle settings
{
	_currentComboBox = _x;
	{
		_currentComboBox lbAdd format ["%1", _x];
		_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x]];
	} foreach booleanSelection;
} foreach [_comboBoxEnableArmedAicraft, _comboBoxEnableArmoredVehicle];


//Default values
_comboBoxEnableArmedAicraft lbSetCurSel (1); //Disable
_comboBoxEnableArmoredVehicle lbSetCurSel (1); //Disable


//Populate mission configuration

//Campaign
_currentComboBox = _comboBoxEnableCampaignMode;
{
	_currentComboBox lbAdd format ["%1", _x];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x]];
} foreach booleanSelection;

//Mission length
_currentComboBox = _comboBoxMissionLength;
{
	_currentComboBox lbAdd format ["%1", _x select 1];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 0]];
} foreach missionLengthSelection;

//Mission difficulty
_currentComboBox = _comboBoxMissionDifficulty;
{
	_currentComboBox lbAdd format ["%1", _x select 1];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 0]];
} foreach missionDifficultySelection;

//Default values 
_comboBoxEnableCampaignMode lbSetCurSel (1); //Syndikat
_comboBoxMissionLength lbSetCurSel (1); //Syndikat
_comboBoxMissionDifficulty lbSetCurSel (1); //Syndikat
