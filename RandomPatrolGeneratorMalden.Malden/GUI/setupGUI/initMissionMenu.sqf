disableSerialization;
#include "..\..\database\factionParameters.sqf"
#include "..\..\database\missionParameters.sqf"
#include "loadSettings.sqf"

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
private _comboBoxIronman = _mainDisplay displayCtrl 6110;
private _comboBoxStartIntel = _mainDisplay displayCtrl 6112;
private _comboBoxIASkill = _mainDisplay displayCtrl 6113;
private _comboBoxRespawnParam = _mainDisplay displayCtrl 6114;


//Specify all GUI content 
//Populate faction comboBox

//Setup Blufor and independent Factions
{
	_currentComboBox = _x;
	{
		if (_x#3) then 
		{
			_currentComboBox lbAdd format ["%1", _x select 2];
			_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 1]];
		};
	} foreach factionInfos;
} foreach [_comboBoxBlufor, _comboBoxIndependent];

//Setup Opfor Factions
_currentComboBox = _comboBoxOpfor;
{
	if (_x#4) then 
	{
		_currentComboBox lbAdd format ["%1", _x select 2];
		_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 1]];
	};
} foreach factionInfos;

//Setup Civilian Factions
_currentComboBox = _comboBoxCivilian;
{
	if (_x#5) then 
	{
		_currentComboBox lbAdd format ["%1", _x select 2];
		_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 1]];
	};
} foreach factionInfos;

//War Era
_currentComboBox = _comboBoxWarEra;
{
	_currentComboBox lbAdd format ["%1", _x select 1];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 0]];
} foreach warEraSelection;

//Populate Missions vehicle settings
{
	_currentComboBox = _x;
	{
		_currentComboBox lbAdd format ["%1", _x];
		_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x]];
	} foreach booleanSelection;
} foreach [_comboBoxEnableArmedAicraft, _comboBoxEnableArmoredVehicle, _comboBoxIronman];

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

//Mission start intel
_currentComboBox = _comboBoxStartIntel;
{
	_currentComboBox lbAdd format ["%1", _x select 1];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 0]];
} foreach missionStartIntelSelection;

//Mission IA Skill
_currentComboBox = _comboBoxIASkill;
{
	_currentComboBox lbAdd format ["%1", _x select 1];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 0]];
} foreach missionIASkill;


_currentComboBox = _comboBoxRespawnParam;
{
	_currentComboBox lbAdd format ["%1", _x select 1];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 0]];
} foreach missionRespawnParamSettings;


//Default faction 
_comboBoxBlufor lbSetCurSel (factionInfos select {_x#3} apply {_x select 1} find (bluforFaction_loaded));
_comboBoxOpfor lbSetCurSel (factionInfos select {_x#4} apply {_x select 1} find (opforFaction_loaded));
_comboBoxIndependent lbSetCurSel (factionInfos select {_x#3} apply {_x select 1} find (independentFaction_loaded));
_comboBoxCivilian lbSetCurSel (factionInfos select {_x#5} apply {_x select 1} find (civilianFaction_loaded));
_comboBoxWarEra lbSetCurSel (warEraSelection apply {_x select 0} find (warEra_loaded));

//Default values
_comboBoxEnableArmedAicraft lbSetCurSel (booleanSelection find enableArmedAicraft_loaded); //Disable
_comboBoxEnableArmoredVehicle lbSetCurSel (booleanSelection find enableArmoredVehicle_loaded); //Disable
_comboBoxIronman lbSetCurSel (booleanSelection find ironMan_loaded); 

//Default values 
_comboBoxEnableCampaignMode lbSetCurSel (booleanSelection find enableCampaignMode_loaded); //Syndikat
_comboBoxMissionLength lbSetCurSel (missionLengthSelection apply {_x select 0} find (missionLength_loaded)); //Syndikat
_comboBoxMissionDifficulty lbSetCurSel (missionDifficultySelection apply {_x select 0} find (missionDifficultyParam_loaded)); //Syndikat
_comboBoxStartIntel lbSetCurSel (missionStartIntelSelection apply {_x select 0} find (startIntel_loaded)); //Blufor must take intel
_comboBoxIASkill lbSetCurSel (missionIASkill apply {_x select 0} find (missionIASkill_loaded)); //IA Skill default value : Balanced
_comboBoxRespawnParam lbSetCurSel (missionRespawnParamSettings apply {_x select 0} find (missionRespawnParam_loaded)); //IA Skill default value : Balanced
