// ask civilian for intel
_civs = allUnits select {alive _x AND side _x isEqualTo civilian};

{
	_x linkItem "ItemRadio"; //so they can "talk" if they're editor placed civilian units

	//Add action to ask civilian for intel
	_ID = 	[
				_x, 
				"Talk to civilian", 
				"\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa", 
				"\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa", 
				"_this distance _target < 3",						// Condition for the action to be shown
				"_caller distance _target < 3",						// Condition for the action to progress
				{
					// Action start code
				}, 
				{
					// Action on going code
				},  
				{
					// Action successfull code
					params ["_object","_caller","_ID","_civ","_progress","_maxProgress"];

					//Open civilian dialog GUI
					[[_object], 'GUI\dialogGUI\initDialogCivilian.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
				}, 
				{
					// Action failed code
				}, 
				[_x],  
				1,
				0, 
				false, 
				false
			] call BIS_fnc_holdActionAdd;
	_x setVariable ["TAG_fnc_revealActionID",_ID]; //Can be used to remove all talk actions

} forEach _civs;