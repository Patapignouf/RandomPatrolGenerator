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
				"true", 
				"true", 
				{
					// Action start code
				}, 
				{
					// Action on going code
				},  
				{
					// Action successfull code
					params ["_object","_caller","_ID","_civ","_progress","_maxProgress"];
					_reveal = (missionNamespace getVariable ["TAG_fnc_civsAsked",0]) >= 1;//will return true on the third unit
					if (_reveal) exitWith {
						[_caller,"engine\askCivilianIntel.sqf"] remoteExec ["BIS_fnc_execVM", _caller];
						missionNamespace setVariable ["TAG_fnc_civsAsked",(round random 1),true];
						[_object,_ID] remoteExec [ "removeAction", 0, true ];
					};
					
					//Case no intel given
					_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
					[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
					_counter = missionNamespace getVariable ["TAG_fnc_civsAsked",0];
					_counter = _counter + 1;
					missionNamespace setVariable ["TAG_fnc_civsAsked",_counter,true];
					[_object,_ID] remoteExec [ "removeAction", 0, true ];
				}, 
				{
					// Action failed code
				}, 
				[_x],  
				2,
				0, 
				true, 
				false
			] call BIS_fnc_holdActionAdd;
	_x setVariable ["TAG_fnc_revealActionID",_ID]; //Can be used to remove all talk actions


	//Add action to ask civilian to join player team
	_ID = 	[
				_x, 
				"Ask civilian to join your team", 
				"\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa", 
				"\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa", 
				"true", 
				"true", 
				{
					// Action start code
				}, 
				{
					// Action on going code
				},  
				{
					// Action successfull code
					params ["_object","_caller","_ID","_civParam","_progress","_maxProgress"];
					_civ = _civParam select 0;
					_civJoinableFaction = "CivJoinableFaction" call BIS_fnc_getParamValue;
					_hasToJoin = false;
					switch (_civJoinableFaction) do
					{
						case 1:
							{
								_hasToJoin = (side player == independent);
							};
						case 2:
							{
								_hasToJoin = (side player == blufor);
							};
						case 3:
							{
								_hasToJoin = true;
							};
						default
							{
								//
							};
					};
					if (_hasToJoin && (round (random 1))==0) then //50% chance to join
					{
						[1,["Ok let's go !", "PLAIN", 0.5]] remoteExec ["cutText", _caller];
						[_civ] remoteExec ["removeAllEventHandlers", 0, true];
						[_civ] remoteExec ["removeAllActions", 0, true];
						_thisUnit removeAllMPEventHandlers "mpkilled"; 
						_civ switchMove "";

						//Civ join player squad
						_tempGroup = createGroup (side _caller); //Specific line to debug unit which doesn't change side
						[_civ] joinSilent _tempGroup;
						[_civ] joinSilent (group _caller); //join player group

						
						//Manage loadout
						_civLoadout = getUnitLoadout _civ;
						_weapon = [((getUnitLoadout _caller) select 0) select 0];	
						_weaponArray = ["","","","",[],[],""];
						_vestArray = ["V_BandollierB_rgr",[]];
						_weaponArray set [0, _weapon select  0];
						
						_civLoadout set [0, _weaponArray];
						_civLoadout set [4, _vestArray];

						_civ setUnitLoadout _civLoadout;
						sleep 2;
						for "_i" from 0 to 3 do { _civ addItem (currentMagazine _caller); };	//Give civ some ammunitions

						sleep 5;
						reload _civ;
					} else 
					{
						_randomAnswers = ["Oh please leave me alone !","I don't trust you !"];
						[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", _caller];
					};

					[_object,_ID] remoteExec [ "removeAction", 0, true ];
				}, 
				{
					// Action failed code
				}, 
				[_x],  
				2,
				0, 
				true,
				false
			] call BIS_fnc_holdActionAdd;
	_x setVariable ["TAG_fnc_joinActionID",_ID]; //Can be used to remove all talk actions

} forEach _civs;