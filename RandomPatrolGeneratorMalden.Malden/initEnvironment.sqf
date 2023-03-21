#include "database\factionParameters.sqf"

c_variableToInit = ["listOfRoles","loadout","rifleList","grenadeLauncherList","attachmentLongList","attachmentShortList","smgList","marksmanrifleList","autorifleList","launcherList","itemList","itemEngineerList","itemMedicList",'backPackList','uniformList', "bluforUnarmedVehicle","bluforArmedVehicle","bluforUnarmedVehicleChopper","bluforDrone","bluforBoat","civilian_group",
"civilian_big_group","civilianTruck","baseEnemyGroup","baseEnemyATGroup","baseEnemyDemoGroup","baseEnemyMortarGroup","baseEnemyVehicleGroup",
"baseEnemyLightArmoredVehicleGroup","baseEnemyHeavyArmoredVehicleGroup","bluforFixedWing","bluforArmedChopper", "bluforHQVehicle","magazineList"];


//////////
//InitDB function//
//////////
initFactionDb = {
	params ["_currentVariable"];
	_currentTempVariable = [];
	{
		_currentFactionName = _x select 0;
		_currentFactionParameters = _x select 1;
		_currentFactionBuild = format ["%1%2", _currentVariable, _currentFactionName];
		_currentTempVariable pushBack [missionNamespace getVariable [_currentFactionBuild,[]], _currentFactionParameters];
	} foreach factionInfos;
	_currentVariableName = format ["%1%2", _currentVariable, c_db];
	diag_log format ["Initialize : %1", _currentVariableName];
	missionNamespace setVariable [_currentVariableName, _currentTempVariable, true];
};

//////////
//InitDB//
//////////
diag_log "Begin Arsenal and Faction Library initialization";
{
	[_x] call initFactionDb;
}
foreach c_variableToInit;
diag_log "End Arsenal and Faction Library initialization";


