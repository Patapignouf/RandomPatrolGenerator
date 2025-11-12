#include "itemdb.sqf"

params ["_warEra"];

selectNumberAndRemove = {
	params ["_workingArray", "_number"];
	_result = [];
	
	//Loop until the good amount has been reached
	for [{_indexWeapon = 0}, {_indexWeapon < _number}, {_indexWeapon = _indexWeapon + 1}] do
	{	
		//Select a random item
		if (count _workingArray != 0) then 
		{
			_randomItem = selectRandom _workingArray;
			_result pushBackUnique _randomItem;
			_workingArray = _workingArray - [_randomItem];
		};
	};

	_result;
};

//Define black market content
{
	_workingBMItems = _x#0; //Select all list
	_workingBMName = _x#1;

	//Filter items or weapons with avalaible content only
	// if (_workingBMName == "BMshortAccessoriesList" || _workingBMName == "BMlongAccessoriesList") then 
	// {
	// 	{
	// 		if (!isClass (configFile >> "CfgWeapons" >> _x)) then 
	// 		{
	// 			_workingBMItems = _workingBMItems - [_x];
	// 		};
	// 	}	foreach _workingBMItems;
	// } else 
	// {
	// 	{
	// 		if (!isClass (configFile >> "CfgWeapons" >> _x)) then 
	// 		{
	// 			_workingBMItems = _workingBMItems - [_x];
	// 		};
	// 	}	foreach _workingBMItems;
	// };

	_workingBMItemsByEraAll = ((_workingBMItems select {_x#0 <= _warEra})); //Select only item on the same era

	_workingBMItemsByEra = [];
	{
		//Add every item
		{
			_workingBMItemsByEra pushBack _x;
		}	foreach (_x#1);
	}
	foreach _workingBMItemsByEraAll;
	
	{
		if (!(isClass (configFile >> "CfgWeapons" >> _x))) then 
		{
			_workingBMItemsByEra = _workingBMItemsByEra - [_x];
		};
	}	foreach _workingBMItemsByEra;



	//Select only 3 items 
	_selectingItems = [_workingBMItemsByEra, 3] call selectNumberAndRemove;
	missionNameSpace setVariable [_workingBMName, _selectingItems, true];
} foreach [[BMrifleList_db, "BMrifleList"], [BMsmgList_db, "BMsmgList"], [BMsniperRifleList_db, "BMsniperRifleList"], [BMautoRifleList_db, "BMautoRifleList"], [BMlauncherList_db, "BMlauncherList"], [BMgrenadeLauncherList_db, "BMgrenadeLauncherList"], [BMshortAccessoriesList_db, 'BMshortAccessoriesList'], [BMlongAccessoriesList_db, "BMlongAccessoriesList"]];


