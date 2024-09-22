params ["_target"];

[(typeOf _target), 1, ["ACE_SelfActions"], 
    [
        "Admin Menu",  // Action name
        "Admin Menu",  // Tooltip/Description
        "",           // Icon path (empty for none)
        {
			[[], 'GUI\adminGUI\adminGUI.sqf'] remoteExec ['BIS_fnc_execVM', _target];
		},  // Code to execute when action is selected
        { true }      // Condition to show the action
    ] call ace_interact_menu_fnc_createAction
] call ace_interact_menu_fnc_addActionToClass;