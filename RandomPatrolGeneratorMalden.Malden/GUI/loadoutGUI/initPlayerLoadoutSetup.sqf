disableSerialization;
#include "..\..\database\factionParameters.sqf"
#include "..\..\database\missionParameters.sqf"
#include "..\..\database\arsenalLibrary.sqf"

//Create GUI
createDialog "PlayerLoadoutSetup";

//Specify all GUI items
//Define a comboBox foreach faction
private _mainDisplay = (findDisplay 7000);
private _comboBoxClassSelection = _mainDisplay displayCtrl 7100;
private _buttonClose = _mainDisplay displayCtrl 7200;
private _buttonArsenal = _mainDisplay displayCtrl 7201;
private _buttonSave = _mainDisplay displayCtrl 7202;
private _buttonLoad = _mainDisplay displayCtrl 7203;
private _buttonClearItems = _mainDisplay displayCtrl 7204;


//Faction params
bluFaction = missionNamespace getVariable "bluforFaction";
indFaction = missionNamespace getVariable "independentFaction";

//Function params
firstOpen = true;

//Load default loadout when player open loadout screen if there isn't ironMan mode enabled
if (!ironMan) then 
{
	//Loadout validated loadout (compared with spawn loadout)
	player setUnitLoadout ([getUnitLoadout player, player getVariable ["spawnLoadout", []]] call validateLoadout);
	[] call refreshCustomLoadoutDisplay;
};

//Specify button's names in ironMan mode 
if (ironMan) then 
{
	_buttonSave ctrlSetText "Place loadout in the box"; 
	_buttonLoad ctrlSetText "Get back loadout from the box";
};


//Specify all GUI content and button actions
_comboBoxClassSelection ctrlAddEventHandler[ "LBSelChanged", 
	{
		if (!firstOpen) then 
		{
			_mainDisplay = (findDisplay 7000);
			_comboBoxClassSelection = _mainDisplay displayCtrl 7100;

			_listOfAvalaibleRole =[];

			if (player getVariable "sideBeforeDeath" == "independent") then 
			{
				//Independent
				_listOfAvalaibleRole = [indFaction] call setupRoleSwitchToList;
				_role = (_listOfAvalaibleRole select parseNumber ((_comboBoxClassSelection lbData (lbCurSel _comboBoxClassSelection))));
				[VA1, player, indFaction , _role, false] call switchToRole;
			} else 
			{
				//Blufor
				_listOfAvalaibleRole = [bluFaction] call setupRoleSwitchToList;
				_role = (_listOfAvalaibleRole select parseNumber ((_comboBoxClassSelection lbData (lbCurSel _comboBoxClassSelection))));
				[VA2, player, bluFaction , _role, false] call switchToRole;
			};

			//Refresh load button
			[] call refreshCustomLoadoutDisplay;
		}
		else 
		{
			//Allow player to change stuff
			firstOpen = false;
		};
	}];

//Open arsenal
_buttonArsenal ctrlAddEventHandler[ "ButtonClick", 
	{ 
		hint "Open arsenal";
		(findDisplay 7000) closeDisplay 1;
		[] execVM 'database\openArsenal.sqf';
	}];

//Open arsenal
_buttonClearItems ctrlAddEventHandler[ "ButtonClick", 
	{ 
			hint "Stuff cleared";
			removeAllItemsWithMagazines player;
	}];

//Save loadout
_buttonSave ctrlAddEventHandler[ "ButtonClick", 
	{ 
		//Save default stuff when ironMan mode is disable
		if (!ironMan) then 
		{
			player setVariable ["spawnLoadout", getUnitLoadout player];
		};

		//Save current loadout
		[player, "personal"] call saveCustomLoadout;

		//Load default faction stuff in ironMan mode
		if (ironMan) then 
		{
			player setUnitLoadout (player getVariable ["spawnLoadout", []]);
			cutText ["Loadout saved\nLoading default loadout", "PLAIN", 0.3];
		} else 
		{
			//Refresh load button
			[] call refreshCustomLoadoutDisplay;
			cutText ["Loadout saved", "PLAIN", 0.3];
		};
	}];

//Load loadout
_buttonLoad ctrlAddEventHandler[ "ButtonClick", 
	{ 
		_loadableLoadout = [];
		//Save personnal loadout
		if (player getVariable "sideBeforeDeath" == "independent") then 
		{
			//Independent
			_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, indFaction, player getVariable "role"], player getVariable "spawnLoadout"];
		} else 
		{
			//Blufor
			_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, bluFaction, player getVariable "role"], player getVariable "spawnLoadout"];
		};
		
		player setUnitLoadout _loadableLoadout;
		

		//Wipe saved loadout in Ironman mode
		if (ironMan) then 
		{
			//Wipe loadout according to player faction
			[player, "empty"] call saveCustomLoadout;
			cutText ["Loadout loaded\nWipe custom loadout", "PLAIN", 0.3];
		} else 
		{
			cutText ["Loadout loaded", "PLAIN", 0.3];
		};
	}];

//Close display
_buttonClose ctrlAddEventHandler[ "ButtonClick", 
	{ 
		//Close mission setup
		params ["_ctrl"];
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;

		//Save default stuff on close when ironMan mode is disable
		if (!ironMan) then 
		{
			player setVariable ["spawnLoadout", getUnitLoadout player];
		};
	}
];

//get list of avalaible role for player's faction
_listOfAvalaibleRole =[];
if (player getVariable "sideBeforeDeath" == "independent") then 
{
	//Independent
	_listOfAvalaibleRole = [indFaction] call setupRoleSwitchToList;

} else 
{
	//Blufor
	_listOfAvalaibleRole = [bluFaction] call setupRoleSwitchToList;
};


//Define list of role in the combo box
_currentComboBox = _comboBoxClassSelection;
{
	_currentComboBox lbAdd format ["%1", _x];
	_currentComboBox lbSetData [(lbSize _currentComboBox)-1, format ["%1",(lbSize _currentComboBox)-1]];
} foreach _listOfAvalaibleRole;

//Default value of role combo box 
_comboBoxClassSelection lbSetCurSel (_listOfAvalaibleRole find (player getVariable "role")); //Actual Warfare

//Disable space button in dialog
waituntil {!(IsNull (findDisplay 7000))};
_keyDown = (findDisplay 7000) displayAddEventHandler ["KeyDown", {
	params ["_control", "_dikCode", "_shift", "_ctrl", "_alt"];

	private _handled = false;

	switch (_dikCode) do {
		case 1: 
		{
			//Save default stuff on close when ironMan mode is disable
			if (!ironMan) then 
			{
				player setVariable ["spawnLoadout", getUnitLoadout player];
			};
		};
		case 57: {
			// case 1 for ESC -> https://community.bistudio.com/wiki/DIK_KeyCodes
			// open your dialog
			_control closeDisplay 1;
			[[], 'GUI\loadoutGUI\initPlayerLoadoutSetup.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	};
	_handled
}];



refreshCustomLoadoutDisplay = {
		_buttonLoad = (findDisplay 7000) displayCtrl 7203;
		_loadableLoadout = [];

		//Save personnal loadout
		if (player getVariable "sideBeforeDeath" == "independent") then 
		{
			//Independent
			_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, indFaction, player getVariable "role"], []];
		} else 
		{
			//Blufor
			_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, bluFaction, player getVariable "role"], []];
		};


		if (count _loadableLoadout == 0) then 
		{
			_buttonLoad ctrlShow false;
		} else 
		{
			_buttonLoad ctrlShow true;
		};
};