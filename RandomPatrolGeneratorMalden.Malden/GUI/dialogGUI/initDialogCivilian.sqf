disableSerialization;
#include "..\..\database\objectLibrary.sqf"

//Create GUI
createDialog "DialogCivilian";

//Specify all GUI items
//Define a comboBox foreach faction

params ["_thisCivilian"];
thisCivilian = _thisCivilian;

private _mainDisplay = (findDisplay 10000);
private _buttonClose = _mainDisplay displayCtrl 10200;


////////////////////////////////////////////////////////////
//Give a title to the dialog with the civilian name ////////
////////////////////////////////////////////////////////////
_RcsTitleDialog = _mainDisplay ctrlCreate ["RscText", -1];
_RcsTitleDialog ctrlSetText (format ["You are talking to %1 ", name thisCivilian]);
_RcsTitleDialog ctrlSetTextColor [0, 0, 0, 1];

//Position and size
_coordinateX = 0.44 * safezoneW + safezoneX;
_coordinateY = (0.65) * safezoneH + safezoneY;
_weight = 1;
_height = 0.05;

_RcsTitleDialog ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
_RcsTitleDialog ctrlCommit 0;


//////////////////////////////////
//Create objective dialog button//
//////////////////////////////////
_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", -1];
_RcsButtonObjective ctrlSetText "Ask for a task";

//Position and size
_coordinateX = 0.30 * safezoneW + safezoneX;
_coordinateY = (0.7) * safezoneH + safezoneY;
_weight = 1;
_height = 0.05;

_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
_RcsButtonObjective ctrlCommit 0;

//Add control logic (enable or disable objective)
_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;
	if (!(thisCivilian getVariable ["hasAlreadyGiveTask", false])) then 
	{
		//Disable task gift from this unit
		thisCivilian setVariable ["hasAlreadyGiveTask", true, true];

		//Wait 5 minutes before asking a new task
		[] spawn 
		{
			sleep 300;
			thisCivilian setVariable ["hasAlreadyGiveTask", false, true];
		};

		//Check if this unit can give intel
		_reveal = (missionNamespace getVariable ["TAG_fnc_civsAsked",0]) >= 1;//will return true on the third unit
		if (_reveal) exitWith {
			//Reveal objective to the player
			_mainPlayerSide = blufor;
			if ({isPlayer _x && side _x == independent} count allUnits != 0) then 
			{
				_mainPlayerSide = independent;
			};
			[player, [], _mainPlayerSide] execVM 'engine\objectiveManagement\revealObjective.sqf';

			missionNamespace setVariable ["TAG_fnc_civsAsked",(round random 1),true];
		};

		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[[format ["<t align = 'center' shadow = '2' color='#00ff00' size='1.5' font='PuristaMedium' >Civilian</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", selectRandom _randomAnswers], "PLAIN", -1, true, true]] remoteExec ["titleText", player];

		//Counter to limit civilian not to give enough intel
		_counter = missionNamespace getVariable ["TAG_fnc_civsAsked",0];
		_counter = _counter + 1;
		missionNamespace setVariable ["TAG_fnc_civsAsked", _counter, true];

	} else {
		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[[format ["<t align = 'center' shadow = '2' color='#00ff00' size='1.5' font='PuristaMedium' >Civilian</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", selectRandom _randomAnswers], "PLAIN", -1, true, true]] remoteExec ["titleText", player];
	};
}];


//////////////////////////////////
//Create intel dialog button//////
//////////////////////////////////
_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", -1];
_RcsButtonObjective ctrlSetText "Ask for intel";

//Position and size
_coordinateX = 0.30 * safezoneW + safezoneX;
_coordinateY = (0.75) * safezoneH + safezoneY;
_weight = 1;
_height = 0.05;

_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
_RcsButtonObjective ctrlCommit 0;

//Add control logic (enable or disable objective)
_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;
	if (!(thisCivilian getVariable ["hasAlreadyGiveTask", false])) then 
	{
		//Disable task gift from this unit
		thisCivilian setVariable ["hasAlreadyGiveTask", true, true];

		//Wait 5 minutes before asking a new task
		[] spawn 
		{
			sleep 300;
			thisCivilian setVariable ["hasAlreadyGiveTask", false, true];
		};

		//Check if this unit can give intel
		_reveal = (missionNamespace getVariable ["TAG_fnc_civsAsked",0]) >= 1;//will return true on the third unit
		if (_reveal) exitWith 
		{
			//Get mission context
			//Reveal minor intel for the caller
			[[player, "civilianAsking"], 'engine\objectiveManagement\revealMinorIntel.sqf'] remoteExec ['BIS_fnc_execVM', player];

			[[1, "RPG_ranking_intel_collect"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', player];
			missionNamespace setVariable ["TAG_fnc_civsAsked",(round random 1),true];
		};

		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[[format ["<t align = 'center' shadow = '2' color='#00ff00' size='1.5' font='PuristaMedium' >Civilian</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", selectRandom _randomAnswers], "PLAIN", -1, true, true]] remoteExec ["titleText", player];

		//Counter to limit civilian not to give enough intel
		_counter = missionNamespace getVariable ["TAG_fnc_civsAsked",0];
		_counter = _counter + 1;
		missionNamespace setVariable ["TAG_fnc_civsAsked", _counter, true];

	} else {
		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[[format ["<t align = 'center' shadow = '2' color='#00ff00' size='1.5' font='PuristaMedium' >Civilian</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", selectRandom _randomAnswers], "PLAIN", -1, true, true]] remoteExec ["titleText", player];
	};
}];

//////////////////////////////////
//Create jointeam dialog button///
//////////////////////////////////
_RcsButtonObjective = _mainDisplay ctrlCreate ["RscButton", -1];
_RcsButtonObjective ctrlSetText "Ask civilian to join your team";

//Position and size
_coordinateX = 0.30 * safezoneW + safezoneX;
_coordinateY = (0.80) * safezoneH + safezoneY;
_weight = 1;
_height = 0.05;

_RcsButtonObjective ctrlSetPosition [_coordinateX, _coordinateY, _weight, _height];
_RcsButtonObjective ctrlCommit 0;

//Add control logic (enable or disable objective)
_RcsButtonObjective ctrlAddEventHandler[ "ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;
	if (!(thisCivilian getVariable ["hasAlreadyAnswerJoinTeam", false])) then 
	{
		//Disable task gift from this unit
		thisCivilian setVariable ["hasAlreadyAnswerJoinTeam", true, true];

		//Wait 5 minutes before asking a new task
		[] spawn 
		{
			sleep 1200;
			thisCivilian setVariable ["hasAlreadyAnswerJoinTeam", false, true];
		};

		_civ = thisCivilian;
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
			[1,["Ok let's go !", "PLAIN", 0.5]] remoteExec ["cutText", player];
			[_civ] remoteExec ["removeAllEventHandlers", 0, true];
			[_civ] remoteExec ["removeAllActions", 0, true];
			_civ removeAllMPEventHandlers "mpkilled"; 
			_civ switchMove "";

			//Civ join player squad
			_tempGroup = createGroup (side player); //Specific line to debug unit which doesn't change side
			[_civ] joinSilent _tempGroup;
			[_civ] joinSilent (group player); //join player group

			
			//Manage loadout
			_civLoadout = getUnitLoadout _civ;
			_weapon = [((getUnitLoadout player) select 0) select 0];	
			_weaponArray = ["","","","",[],[],""];
			_vestArray = ["V_BandollierB_rgr",[]];
			_weaponArray set [0, _weapon select  0];
			
			_civLoadout set [0, _weaponArray];
			_civLoadout set [4, _vestArray];

			_civ setUnitLoadout _civLoadout;
			// sleep 2;
			for "_i" from 0 to 3 do { _civ addItem (currentMagazine player); };	//Give civ some ammunitions

			// sleep 5;
			reload _civ;
		} else 
		{
			_randomAnswers = ["Oh please leave me alone !","I don't trust you !"];
			[[format ["<t align = 'center' shadow = '2' color='#00ff00' size='1.5' font='PuristaMedium' >Civilian</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", selectRandom _randomAnswers], "PLAIN", -1, true, true]] remoteExec ["titleText", player];
		};

	} else {
		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[[format ["<t align = 'center' shadow = '2' color='#00ff00' size='1.5' font='PuristaMedium' >Civilian</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", selectRandom _randomAnswers], "PLAIN", -1, true, true]] remoteExec ["titleText", player];
	};
}];

//Close display
_buttonClose ctrlAddEventHandler[ "ButtonClick", 
	{ 
		//Close civilian dialog setup
		params ["_ctrl"];
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;
	}
];

//Disable space button in dialog
waituntil {!(IsNull _mainDisplay)};
_keyDown = (_mainDisplay) displayAddEventHandler ["KeyDown", {
	params ["_control", "_dikCode", "_shift", "_ctrl", "_alt"];

	private _handled = false;

	switch (_dikCode) do {
		case 57: {
			// case 1 for ESC -> https://community.bistudio.com/wiki/DIK_KeyCodes
			// open your dialog
			_control closeDisplay 1;
			[[thisCivilian], 'GUI\dialogGUI\initDialogCivilian.sqf'] remoteExec ['BIS_fnc_execVM', player];
		};
	};

	_handled
}];