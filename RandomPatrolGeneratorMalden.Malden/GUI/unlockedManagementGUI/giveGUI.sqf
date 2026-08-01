params ["_weapon", "_category"];

/*
    Author: Assistant Gemini and Patapignouf
    Description: Opens a dynamic GUI menu to select a player from all currently connected players.
    Usage: execVM "fn_selectPlayerMenu.sqf";
*/

// 1. Control ID Definitions
#define IDD_PLAYER_MENU   9900
#define IDC_COMBO_PLAYERS 9901
#define IDC_BTN_SELECT    9902
#define IDC_BTN_CANCEL    9903

// Close the menu if it is already open
if (!isNull (findDisplay IDD_PLAYER_MENU)) exitWith { closeDialog 0; };

// 2. Create the main dynamic Display (Parent container)
private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";
_display setVariable ["idd", IDD_PLAYER_MENU];

// 3. Dark Overlay Background
private _bg = _display ctrlCreate ["RscText", -1];
_bg ctrlSetPosition [0.35, 0.35, 0.30, 0.25];
_bg ctrlSetBackgroundColor [0, 0, 0, 0.8];
_bg ctrlCommit 0;

// 4. Menu Title Bar
private _title = _display ctrlCreate ["RscText", -1];
_title ctrlSetPosition [0.35, 0.35, 0.30, 0.04];
_title ctrlSetBackgroundColor [
    (profileNamespace getVariable ['GUI_BCG_RGB_R', 0.13]), 
    (profileNamespace getVariable ['GUI_BCG_RGB_G', 0.54]), 
    (profileNamespace getVariable ['GUI_BCG_RGB_B', 0.21]), 
    1
];
_title ctrlSetText "SELECT A PLAYER";
_title ctrlCommit 0;

// 5. Player Selection Dropdown (Combo Box)
private _combo = _display ctrlCreate ["RscCombo", IDC_COMBO_PLAYERS];
_combo ctrlSetPosition [0.37, 0.42, 0.26, 0.04];
_combo ctrlCommit 0;

_activePlayers = allPlayers select {side _x == side player && _x != player};

// Populate the combo box with all connected players
{
    private _index = _combo lbAdd (name _x);
    // Store the player's unique Steam UID in the list row data
    _combo lbSetData [_index, getPlayerUID _x]; 
} forEach _activePlayers;

// Select the first player in the list by default if any exist
if (count _activePlayers > 0) then {
    _combo lbSetCurSel 0;
};

// 6. SUBMIT Button
private _btnSelect = _display ctrlCreate ["RscButton", IDC_BTN_SELECT];
_btnSelect ctrlSetPosition [0.37, 0.52, 0.12, 0.04];
_btnSelect ctrlSetText "Confirm";
_btnSelect ctrlCommit 0;

_btnSelect setVariable ["weapon", _weapon];
_btnSelect setVariable ["category", _category];


// Click Event Handler for Submit
_btnSelect ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _display = ctrlParent _control;
    private _combo = _display displayCtrl IDC_COMBO_PLAYERS;

	private _supportClass = _control getVariable ["weapon", ""];
    private _supportType = _control getVariable ["category", ""];

    private _selectedIndex = lbCurSel _combo;
    if (_selectedIndex == -1) exitWith { hint "No player selected!"; };

    // Retrieve the UID stored in the selected dropdown entry
    private _playerUID = _combo lbData _selectedIndex;
    
    // Convert the player's UID back into an object reference
    private _selectedPlayer = _playerUID call BIS_fnc_getUnitByUID;

    // --- EXECUTE ACTIONS ON THE SELECTED PLAYER HERE ---
    if (!isNull _selectedPlayer) then {
        //hint format ["Selected Player: %1\n(UID: %2)", name _selectedPlayer, _playerUID];

		_currentFaction = indFaction;
		if (side player == blufor) then 
		{
			_currentFaction = bluFaction;
		};

		//get current player faction
		[_supportClass, _supportType, _currentFaction] call removeUnlockedWeapon;		

		[player, player, player call getPlayerFaction] call setupArsenalToItem;

		

		//Add weapon to current selected player
		[[_supportClass, _supportType, _currentFaction], 
			{
				params ["_supportClass", "_supportType", "_currentFaction"];

				[_supportClass, _supportType, _currentFaction] call addUnlockedWeapon;		

				[player, player, player call getPlayerFaction] call setupArsenalToItem;
				
				//Display reward hint
				[_supportClass, _currentFaction] call displayReward;

			}
		] remoteExec ["spawn", _selectedPlayer]; 

		//Tell everybody X gave item to Y
		(format [localize "STR_RPG_HC_GIVE_CALL", name player, name _selectedPlayer, getText (configFile >> "CfgWeapons" >> _supportClass >> "displayName")]) remoteExec ["systemChat", 0, true];

		//Reopen unlock menu
		[[], 'GUI\unlockedManagementGUI\unlockedManagementGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];

        // Example action: Teleport to the selected player (uncomment if needed)
        // player setPosATL (getPosATL _selectedPlayer);
    } else {
        hint "The selected player is no longer online or could not be found.";
    };
    // ---------------------------------------------------

    _display closeDisplay 1;
}];

// 7. CANCEL Button
private _btnCancel = _display ctrlCreate ["RscButton", IDC_BTN_CANCEL];
_btnCancel ctrlSetPosition [0.51, 0.52, 0.12, 0.04];
_btnCancel ctrlSetText "Cancel";
_btnCancel ctrlCommit 0;

// Click Event Handler for Cancel
_btnCancel ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    (ctrlParent _control) closeDisplay 2;
}];