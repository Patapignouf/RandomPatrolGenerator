//[_caller] execVM 'GUI\teamManagementGUI\teamManagementGUI.sqf';

getGroupByName = {
	params ["_groupName", "_caller"];
	_group = objNull;

	_groups = allGroups select {side _x == side _caller && str _x == _groupName};

	if (count _groups != 0) then 
	{
		_group = _groups#0;
	};

	_group;
};

populateTable = {
	params ["_display"];
	_lnbEntries = _display displayCtrl 70002;
	lnbClear _lnbEntries;
	{
		if (count (units _x select {isPlayer _x}) !=0) then 
		{
			_groupName = str _x;
			_groupPicture = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
			_ind = _lnbEntries lnbAddRow ["", _groupName, [_x] call getAllMembersOfGroup];
			_lnbEntries lnbSetPicture [[_ind, 0], _groupPicture];
			_lnbEntries lnbSetData [[_ind, 0], _x];
			_lnbEntries lnbSetData [[_ind, 1], str _x];
		};
	} foreach (allGroups select {side _x == side player});
};


getAllMembersOfGroup = {
	params ["_group"];
	_allMembers = "";
	{
		_allMembers = _allMembers + name _x + ", ";
	} foreach (units _group);

	_allMembers;
};

refreshTitle = {
	params ["_display"];
	_vehicleShopTitle = _display displayCtrl 69999;

	_vehicleShopTitle ctrlSetText (format ["Group manager | you are currently in %1", str (group player)]);
};


//Based on the work of 7erra
//Github : https://github.com/7erra/LNBSort
params ["_mode", "_this", "_caller"];
private _mainDisplay = (findDisplay 70000);
private _buttonJoin = _mainDisplay displayCtrl 70001;
private _buttonCreate = _mainDisplay displayCtrl 70003;
private _vehicleShopTitle = _mainDisplay displayCtrl 69999;

_vehicleShopTitle ctrlSetText (format ["Group manager | you are currently in %1", str (group _caller)]);


switch (_mode) do
{
	case "onLoad":
	{
		[_this] call populateTable;
	};
	case "sortCol":{
		params ["_display","_ctrl"];
		_lnbEntries = _display displayCtrl 1500;
		_column = [2400,2401,2402] find ctrlIDC _ctrl;
		_reverse = _ctrl getVariable "reverseSort";
		if (_column == 2) then {
			_lnbEntries lnbSortByValue [_column,_reverse];
		} else {
			_lnbEntries lnbSort [_column,_reverse];
		};
		_ctrl setVariable ["reverseSort",!_reverse];
	};
};


_buttonJoin ctrlAddEventHandler[ "ButtonClick", 
	{ 
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		//join group
		_lnbEntries = _display displayCtrl 70002;
		_group = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 0]);
		_groupName = (_lnbEntries lnbData [lnbCurSelRow _lnbEntries, 1]);

		//hint str ([_groupName, player] call getGroupByName);

		[player] joinSilent ([_groupName, player] call getGroupByName);

		//Refresh display
		[_display] spawn {
			params ["_display"];
			sleep 0.5;
			[_display] call populateTable;
			[_display] call refreshTitle;
		};
	}
];


_buttonCreate ctrlAddEventHandler[ "ButtonClick", 
	{ 
		params ["_ctrl"];
		_display = ctrlParent _ctrl;

		//Create group
		_newGroup = createGroup (side player);
		[player] joinSilent _newGroup;

		//Refresh display
		[_display] call populateTable;
		[_display] call refreshTitle;
	}];