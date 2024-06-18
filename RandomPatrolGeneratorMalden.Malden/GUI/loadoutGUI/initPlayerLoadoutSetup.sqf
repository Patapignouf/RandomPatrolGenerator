disableSerialization;
#include "..\..\database\factionParameters.sqf"
#include "..\..\database\missionParameters.sqf"
#include "..\..\database\arsenalLibrary.sqf"
#include "..\..\engine\rankManagement\rankFunctions.sqf"

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
private _button3DItems = _mainDisplay displayCtrl 7205;
private _buttonRank = _mainDisplay displayCtrl 7206;
private _buttonResetLoadout = _mainDisplay displayCtrl 7207;
private _nameTag = _mainDisplay displayCtrl 7002;


//Faction params
bluFaction = missionNamespace getVariable "bluforFaction";
indFaction = missionNamespace getVariable "independentFaction";

//Function params
firstOpen = true;

//Setup player's name
_nameTag ctrlSetText (name player);

refreshCustomLoadoutDisplay = {
		_buttonLoad = (findDisplay 7000) displayCtrl 7203;
		_button3DItems = (findDisplay 7000) displayCtrl 7205;
		_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, player call getPlayerFaction, player getVariable "role"], []];

		if (count _loadableLoadout == 0) then 
		{
			_buttonLoad ctrlShow false;
		} else 
		{
			_buttonLoad ctrlShow true;
		};

		if !(isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
		{
			_button3DItems ctrlShow false;
		}
};



//Load default loadout when player open loadout screen if there isn't ironMan mode enabled
if (!ironMan) then 
{
	//Loadout validated loadout (compared with spawn loadout)
	[player] call validateLoadout;
	[] call refreshCustomLoadoutDisplay;
};

//Specify button's names in ironMan mode 
if (ironMan) then 
{
	_buttonSave ctrlSetText "Place loadout in the box"; 
	_buttonLoad ctrlSetText "Get back loadout from the box";
};

//Remove custom voice 
player setSpeaker "noVoice";

//Specify all GUI content and button actions
_comboBoxClassSelection ctrlAddEventHandler[ "LBSelChanged", 
	{
		if (!firstOpen) then 
		{
			_mainDisplay = (findDisplay 7000);
			_comboBoxClassSelection = _mainDisplay displayCtrl 7100;

			//Setup arsenal loadout
			_listOfAvalaibleRole = [player call getPlayerFaction] call setupRoleSwitchToList;
			_role = (_listOfAvalaibleRole select parseNumber ((_comboBoxClassSelection lbData (lbCurSel _comboBoxClassSelection))));
			[player, player, player call getPlayerFaction , _role, false] call switchToRole;
			[player, player, player call getPlayerFaction] call setupArsenalToItem;

			//Refresh load button
			[] call refreshCustomLoadoutDisplay;

			//Hint switch role
			[[format ["%1 has switched to role %2", name player, player getVariable "role"], "arsenal"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', -clientOwner]; 
		}
		else 
		{
			//Allow player to change stuff
			firstOpen = false;
		};
	}];

//Reset loadout
if (ironMan) then 
{
	_buttonResetLoadout ctrlShow false;
};

_buttonResetLoadout ctrlAddEventHandler[ "ButtonClick", 
	{ 
		hint "Loadout reset";
		[player, player call getPlayerFaction, true] call doInitializeLoadout;
		player setVariable ["spawnLoadout", getUnitLoadout player];
	}];


//Open arsenal
_buttonArsenal ctrlAddEventHandler[ "ButtonClick", 
	{ 
		hint "Open arsenal";
		(findDisplay 7000) closeDisplay 1;
		[] execVM 'database\openArsenal.sqf';
	}];

//clear item 
_buttonClearItems ctrlAddEventHandler[ "ButtonClick", 
	{ 
		hint "Stuff cleared";
		removeAllItemsWithMagazines player;
	}];

//show rank
_buttonRank ctrlAddEventHandler[ "ButtonClick", 
	{ 
		[[], 'GUI\rankGUI\rankGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];
	}];

//Force 3D Optics
//Set button color
if (profileNamespace getVariable ["is3DOptics", false]) then 
{
	_button3DItems ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green seems enable
} else 
{
	_button3DItems ctrlSetTextColor [1, 1, 1, 1]; //White seems disable
};
_button3DItems ctrlAddEventHandler[ "ButtonClick", 
	{ 
		params ["_ctrl"];

		//Switch optic mode
		profileNamespace setVariable ["is3DOptics", !(profileNamespace getVariable ["is3DOptics", false])];
		saveProfileNamespace;

		//Set button color
		if (profileNamespace getVariable ["is3DOptics", false]) then 
		{
			_ctrl ctrlSetTextColor [0.5, 1, 0.5, 0.8]; //Green seems enable
		} else 
		{
			_ctrl ctrlSetTextColor [1, 1, 1, 1]; //White seems disable
		};
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
		hint "Loadout loaded";

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
		//Save personnal loadout
		_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, player call getPlayerFaction, player getVariable "role"], player getVariable "spawnLoadout"];
		player setUnitLoadout _loadableLoadout;

		//Fix TFAR link 
		if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then 
		{
			_currentRadios = player call TFAR_fnc_radiosList;

			if (count _currentRadios >= 1) then
			{
				//Remove previously added radio in case where there is already a member with the same radio ID
				_currentRadio = _currentRadios#0;
				player unassignItem _currentRadio;
				player removeItem _currentRadio;

				//Search default radio name (TFAR rename player's radio)
				_tempArray = (_currentRadio splitString "_");
				_tempArray resize (count _tempArray-1);
				_radioToAdd = (_tempArray joinString "_");

				//Add specific radio
				player addItem _radioToAdd;
				player assignItem _radioToAdd;
			};
		};
		
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
	_currentComboBox lbSetTooltip [(lbSize _currentComboBox)-1, [_x] call getClassInformation];
} foreach _listOfAvalaibleRole;

//Default value of role combo box 
_comboBoxClassSelection lbSetCurSel (_listOfAvalaibleRole find (player getVariable "role")); //Actual Warfare

//Disable space button in dialog
waituntil {!(IsNull (findDisplay 7000))};

//Add 3D Optics Switch
_currentOptics = (weaponsItems player)#0#3;	
if (["_PIP", _currentOptics] call BIS_fnc_inString && profileNamespace getVariable ["is3DOptics", false]) then 
{
	_opticsStringRework = _currentOptics regexReplace ["_PIP", "_3D"];
	if (getText (configFile >> "cfgWeapons" >> _opticsStringRework >> "displayName")!="") then 
	{
			player removePrimaryWeaponItem _currentOptics;
			player addPrimaryWeaponItem _opticsStringRework;
	};
} else 
{
	if (["_3D", _currentOptics] call BIS_fnc_inString && profileNamespace getVariable ["is3DOptics", false]) then 
	{
		_opticsStringRework = _currentOptics regexReplace ["_3D", "_PIP"];
		if (getText (configFile >> "cfgWeapons" >> _opticsStringRework >> "displayName")!="") then 
		{
				player removePrimaryWeaponItem _currentOptics;
				player addPrimaryWeaponItem _opticsStringRework;
		};
	};
};

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



