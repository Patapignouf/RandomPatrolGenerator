
disableSerialization;
#include "..\database\factionParameters.sqf"

//Create GUI
createDialog "DialogSetupParams";

//Specify all GUI items
//Define a comboBox foreach faction
private _comboBoxBlufor = (findDisplay 6000) displayCtrl 6100;
private _comboBoxOpfor = (findDisplay 6000) displayCtrl 6101;
private _comboBoxIndependent = (findDisplay 6000) displayCtrl 6102;
private _comboBoxCivilian = (findDisplay 6000) displayCtrl 6103;

//Specify all GUI content 
//Populate faction comboBox
{
	_currentComboBox = _x;
	{
		_currentComboBox lbAdd format ["%1", _x select 2];
		_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",_x select 1]];
	} foreach factionInfos;
} foreach [_comboBoxBlufor, _comboBoxOpfor, _comboBoxIndependent, _comboBoxCivilian];

//Default faction 
_comboBoxBlufor lbSetCurSel (14); //Otan 2035
_comboBoxOpfor lbSetCurSel (3); //Syndikat
_comboBoxIndependent lbSetCurSel (3); //Syndikat
_comboBoxCivilian lbSetCurSel (3); //Syndikat
