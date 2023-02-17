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
		[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", player];

		//Counter to limit civilian not to give enough intel
		_counter = missionNamespace getVariable ["TAG_fnc_civsAsked",0];
		_counter = _counter + 1;
		missionNamespace setVariable ["TAG_fnc_civsAsked", _counter, true];

	} else {
		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", player];
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
			_revealedObjectives = missionNamespace getVariable ["revealedObjectives",[]];
			_tempMissionObjectives = missionNamespace getVariable ["MissionObjectives",[]];
			_revealedMissionEnemyInfo = missionNamespace getVariable ["revealedMissionEnemyInfo",[]];
			_MissionEnemyInfo = missionNamespace getVariable ["MissionEnemyInfo",[]];

			//Same code here, needs to be factorize
			_potentialMissionEnemyInfo = _MissionEnemyInfo - _revealedMissionEnemyInfo;
			_infoToReveal = selectRandom _potentialMissionEnemyInfo;
			_revealedMissionEnemyInfo pushBack _infoToReveal;
			missionNamespace setVariable ["revealedMissionEnemyInfo",_revealedMissionEnemyInfo,true];
			_infoName = _infoToReveal select 0;
			_infoPos = _infoToReveal select 1;
			_infoGroup = _infoToReveal select 2;
			_nearestCity = nearestLocations [_infoPos, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1500] select 0;
			_intelRevelated = "";
			switch (_infoName) do 
			{
				case "Mortar":
				{
					_intelRevelated = format ["This morning i saw a mortar position near %1. I don't know if they are there for you, be careful.",text _nearestCity];
				};
				case "Patrol":
				{
					_intelRevelated = format ["I've heard there's soldiers patrolling around %1. About %2 men.",text _nearestCity, count units _infoGroup];
				};
				case "Car":
				{
					_intelRevelated = format ["I saw an unknown car leaving here for %1 this morning...",text _nearestCity];
				};
				case "LightArmored";
				case "HeavyArmored":
				{
					_intelRevelated = format ["I've heard there's military vehicles next to %1. They seem to prepare an attack.",text _nearestCity];
				};
				case "DefenseFOBInfantry":
				{
					_intelRevelated = format ["I know there is an enemy base around %1, this location seems dangerous",text _nearestCity];
				};
				case "DefenseInfantry":
				{
					_intelRevelated = format ["I know there is a group of %2 soldiers defending %1, this location seems dangerous",text _nearestCity, count units _infoGroup];
				};
				case "Civilian":
				{
					_intelRevelated = format ["Be careful, there are civilian in %1. Watch your fire...",text _nearestCity];
				};
			};
				
				//Display dialog to the player
				cutText [_intelRevelated, "PLAIN", 0.5];

				//Create diary entry for the intel 
				_intelDiaryAlreadyRevealed = player getVariable "diaryIntel";
				_allDiaryIntel =  format ["%1 <br/> %2 <br/>", _intelDiaryAlreadyRevealed, _intelRevelated];
				player removeDiaryRecord  ["RPG", _intelDiaryAlreadyRevealed]; //Update diary doesn't work very well so delete/create is the only solution
				_newIntelDiaryAlreadyRevealed = player createDiaryRecord ["RPG", ["RPG intel", _allDiaryIntel]];
				player setVariable ["diaryIntel", _newIntelDiaryAlreadyRevealed];

			missionNamespace setVariable ["TAG_fnc_civsAsked",(round random 1),true];
		};

		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", player];

		//Counter to limit civilian not to give enough intel
		_counter = missionNamespace getVariable ["TAG_fnc_civsAsked",0];
		_counter = _counter + 1;
		missionNamespace setVariable ["TAG_fnc_civsAsked", _counter, true];

	} else {
		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", player];
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
			sleep 2;
			for "_i" from 0 to 3 do { _civ addItem (currentMagazine player); };	//Give civ some ammunitions

			sleep 5;
			reload _civ;
		} else 
		{
			_randomAnswers = ["Oh please leave me alone !","I don't trust you !"];
			[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", player];
		};

	} else {
		// hint format ["You have already talk to %1 ", name thisCivilian];
		_randomAnswers = ["No idea what you're talking about!","Go bother someone else?","Oh please leave me alone !","Get out of this area !"];
		[1,[selectRandom _randomAnswers, "PLAIN", 0.5]] remoteExec ["cutText", player];
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