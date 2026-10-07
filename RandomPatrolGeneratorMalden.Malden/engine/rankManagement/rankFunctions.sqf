rankList = [
	["PRIVATE",0],
	["CORPORAL",200],
	["SERGEANT",500],	
	["LIEUTENANT",1000],
	["CAPTAIN",2000],
	["MAJOR",4000],
	["COLONEL",8000]
];

displayPataCompanyAd = {
	_tempDisplay = findDisplay 46 createDisplay "RscDisplayEmpty";

	_backGround = _tempDisplay ctrlCreate[ "ctrlStaticPicture", -1 ];
	_backGround ctrlSetPosition[ -0.1, -0.1, 1.2, 1.2 ];
	_backGround ctrlSetText "#(argb,8,8,3)color(0.35,0.35,0.35,1)";
	_backGround ctrlCommit 0;

	//Discord link
	_ctrl = _tempDisplay ctrlCreate ["RscStructuredText", -1];
	_ctrl ctrlSetPosition [0,0,1,0.5];
	_ctrl ctrlCommit 0;
	_ctrl ctrlSetStructuredText parseText "<t size='4' color='#f0ffff'>Join the </t><t size='4' color='#0048BA'>Pata</t><t size='4' color='#f0ffff'>Comp</t><t size='4' color='#E32636'>any</t><t size='4' color='#f0ffff'> !</t><br/><a color='#ff0000' size='3' href='https://discord.gg/medsxC5rGJ'><br/><t color='#ff0000'>Join the Discord</t></a>";

	//TS3 link
	_ctrl2 = _tempDisplay ctrlCreate ["RscStructuredText", -1];
	_ctrl2 ctrlSetPosition [0,0.5,1,0.3];
	_ctrl2 ctrlCommit 0;
	_ctrl2 ctrlSetStructuredText parseText "<a color='#ff0000' size='3' href='https://tinyurl.com/47r9ur8z'><t color='#ff0000'>Join the TeamSpeak !</t></a>";

	_ButtonRight = _tempDisplay ctrlCreate ["RscButton", -1];
	_ButtonRight ctrlSetPosition [(0.45 * safezoneW + safezoneX),(0.75 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
	_ButtonRight ctrlSetBackgroundColor [0,0,0,0.7];
	_ButtonRight ctrlCommit 0;
	ctrlSetFocus _ButtonRight;
	_ButtonRight ctrlEnable true;
	_ButtonRight ctrlSetText localize "RPG_GUI_GENERAL_CLOSE";
	_ButtonRight ctrlAddEventHandler ["ButtonClick",{
			params ["_ctrl"];
			_display = ctrlParent _ctrl;
			_display closeDisplay 1;
	}];	
};

saveRank = {
	params ["_experience"];

	//Save unit rank
	if (missionNameSpace getVariable ["enableExperienceSave", 0] == 1) then 
	{
		profileNamespace setVariable ["RPG_ranking", _experience];
	};
	true
};

adjustRank = {
	params ["_unit", "_isInit"];

	//Unit current experience
	_unitExperience = profileNamespace getVariable ["RPG_ranking", 0];

	//Get future unit rank
	_unitFloorRank = "";
	if (_unitExperience<0) then 
	{
		//A negative experience give the first rank
		_unitFloorRank = rankList#0;
	} else 
	{
		_unitFloorRank = (rankList select {_x#1 <= _unitExperience}) #-1;
	};
	_currentRankId = rankId _unit;


	//update rank
	_unit setRank _unitFloorRank#0;
	_newRankId = rankId _unit;

	//Update experience analytics
	_unit setVariable ["currentXP", _unitExperience, true];

	if (!_isInit) then 
	{
		//Unit has been promoted
		if (_newRankId>_currentRankId) then 
		{
			_rankTexture = [_unit, "texture"] call BIS_fnc_rankParams;
			_rankName = [_unit, "displayName"] call BIS_fnc_rankParams;
			[[parseText format ["<img image='%1'/><br/><br/><t size='1.2'>You have been promoted to %2</t>", _rankTexture, _rankName], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _unit]; 
			[[parseText format ["<img image='%1'/><br/><br/><t size='1.2'>%3 has been promoted to %2</t>", _rankTexture, _rankName, name _unit], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', -clientOwner]; 
		};

		//Unit has been demoted
		if (_newRankId<_currentRankId) then {
			_rankTexture = [_unit, "texture"] call BIS_fnc_rankParams;
			_rankName = [_unit, "displayName"] call BIS_fnc_rankParams;
			[[parseText format ["<img image='%1'/><br/><br/><t size='1.2'>You have been demoted to %2</t>", _rankTexture, _rankName], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _unit]; 
			[[parseText format ["<img image='%1'/><br/><br/><t size='1.2'>%3 has been demoted to %2</t>", _rankTexture, _rankName, name _unit], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', -clientOwner]; 
		};
	};
	true
};


addExperience = {
	params ["_experience", "_experienceToRegister", "_experienceType", ["_experienceCustomParam", ""]];

	//Unit current experience
	_unitExperience = profileNamespace getVariable ["RPG_ranking", 0];

	//Track custom experience type
	_currentXPtoTrack = player getVariable [_experienceType, 0];
	player setVariable [_experienceType, _currentXPtoTrack + _experienceToRegister, true];

	//Save rank
	[_experience + _unitExperience] call saveRank;

	//Display score and display mod allow xp display
	if (missionNameSpace getVariable ["xpDisplay", 0] == 1 && profileNameSpace getVariable ["RPG_xpDisplayMode", "R"] != "N") then 
	{
		[_experience, _experienceType, _experienceCustomParam] call doDisplayScore;
	};

	//Add equivalent amount in token
	if (missionNameSpace getVariable ["linkXPWithToken", 1] == 1) then 
	{
		[_experience] call earnToken;
	};
	
	true
};

getExperience = {
	//Unit current experience
	_unitExperience = profileNamespace getVariable ["RPG_ranking", 0];
	_unitExperience
};

addPenalty = {
	//Unit current experience
	_unitExperience = profileNamespace getVariable ["RPG_ranking", 0];

	[_unitExperience - 50] call saveRank;

	true
};

displayCurrentRank = {
	params ["_unit"];

	//Text to display 
	_textToDisplay = [_unit] call getDisplayableCurrentRank;
	
	//Display current rank 
	[[parseText _textToDisplay, "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _unit]; 
};

getDisplayableCurrentRank = {
	params ["_unit"];

	//Unit current experience
	_unitExperience = profileNamespace getVariable ["RPG_ranking", 0];

	//init rank next objective
	_unitFloorRank = [];
	if (_unitExperience <0) then 
	{
		_unitFloorRank = rankList#0;
	} else 
	{
		_unitFloorRank = (rankList select {_x#1 <= _unitExperience}) #-1;
	};
	
	_unitNextRankList = (rankList select {_x#1 > _unitExperience});
	
	if (count _unitNextRankList == 0) then 
	{
		_unitNextRankList = [rankList#-1];
	};

	//Get next rank informations
	_unitNextRank = _unitNextRankList#0;
	_unitExperienceNextFloor = _unitNextRank#1;

	//Get rank informations
	_rankTexture = [_unit, "texture"] call BIS_fnc_rankParams;
	_rankName = [_unit] call getPlayerRankCompleteName;
	format ["<img image='%1' size='3'/><br/><br/><t size='1.5'>Your current rank is %2</t><br/><br/><t size='1.2'>Experience to the next rank  %3/%4</t>", _rankTexture, _rankName, _unitExperience, _unitExperienceNextFloor];
};

getDisplayableCurrentXPPerCat = {
	params ["_unit"];

	_structuredStringXP = "Experience for the current OP<br/>";

	//Add progression 
	_structuredStringXP = format ["%1<br/>Progression : %2",_structuredStringXP, (_unit getVariable ["currentXP",0])-(_unit getVariable ["startingXP",0])];

	//Unit current experience
	_basicXPToGather = [["RPG_ranking_infantry_kill","infantry kill"],
						["RPG_ranking_vehicle_kill","vehicle kill"],
						["deathNumber","death"],
						["RPG_ranking_suppress","suppress"],
						["RPG_ranking_heal","heal"],
						["RPG_ranking_repair","repair"],
						["RPG_ranking_intel_collect","intel collect"],
						["RPG_ranking_objective_complete","objective complete"]
					];

	{
		_structuredStringXP = format ["%1<br/>%2 : %3",_structuredStringXP, _x#1, _unit getVariable [_x#0,0]];
	}	foreach _basicXPToGather;

	_structuredStringXP
};

quickDisplayCompleteScore = {
	params ["_objective"];
	
	_structuredXP = [];
	
	//Basic xp keys/values
	_basicXPToGather = 
	[
		["RPG_ranking_infantry_kill","infantry kill"],
		["RPG_ranking_vehicle_kill","vehicle kill"],
		["deathNumber","death"],
		["RPG_ranking_suppress","suppress"],
		["RPG_ranking_heal","heal"],
		["RPG_ranking_repair","repair"],
		["RPG_ranking_intel_collect","intel collect"],
		["RPG_ranking_objective_complete","objective complete"]
	];
	
	{
		//Get old XP from previous mission and calculate the difference
		_oldXPName = format ["%1_Old", _x#0];
		_oldXP = player getVariable [_oldXPName, 0];
		_newXP = player getVariable [_x#0, 0];
		_deltaXP = _newXP - _oldXP;
		
		//Store difference
		_structuredXP pushBackUnique [_x#1, _deltaXP];

		//Save new XP 
		player setVariable [_oldXPName, _newXP];
	}	foreach _basicXPToGather;
	
	reverse _structuredXP;

	[_structuredXP, 5, format ["%1", _objective#1 ], count _structuredXP] call quickDisplayScore;
};

quickDisplayScore = {
	params [
        ["_scores", [], [[]]],
        ["_duration", 8, [0]],
        ["_title", "SCOREBOARD", [""]],
        ["_maxEntries", 8, [0]]
    ];

    // Nothing to display on a dedicated server / headless client
    if (!hasInterface) exitWith { false };

    // Main game display, needed to create the controls dynamically
    private _display = findDisplay 46;
    if (isNull _display) exitWith { false };

    // Keep only well-formed entries: ["string", number]
    private _entries = _scores select {
        _x isEqualType []
        && { count _x >= 2 }
        && { (_x select 0) isEqualType "" }
        && { (_x select 1) isEqualType 0 }
    };
    if (_entries isEqualTo []) exitWith { false };

    // Sort by score (highest first) and limit the number of rows
    _entries = [_entries, [], { _x select 1 }, "DESCEND"] call BIS_fnc_sortBy;
    if (count _entries > _maxEntries) then { _entries resize _maxEntries };

    // Remove any panel that is still on screen
    {
        ctrlDelete _x;
    } forEach (uiNamespace getVariable ["SCR_scoreRecap_ctrls", []]);

    // Unique id so an older timer never deletes a newer panel
    private _id = (uiNamespace getVariable ["SCR_scoreRecap_id", 0]) + 1;
    uiNamespace setVariable ["SCR_scoreRecap_id", _id];

    // ------------------------------------------------------------------
    // Layout (tweak these values to change the look)
    // ------------------------------------------------------------------
    private _width   = 0.20 * safeZoneW;   // Panel width
    private _rowH    = 0.035 * safeZoneH;  // Height of one score row
    private _titleH  = 0.05 * safeZoneH;   // Height of the title area
    private _padding = 0.008;              // Inner padding
    private _margin  = 0.015;              // Distance from the right screen edge
    private _nameW   = _width * 0.65;      // Width of the name column

    private _rows   = count _entries;
    private _height = _titleH + (_rowH * _rows) + (_padding * 2);

    private _posX = safeZoneX + safeZoneW - _width - _margin;
    private _posY = safeZoneY + (safeZoneH - _height) / 2;

    // Horizontal distance used for the slide in / slide out animation
    private _slide = _width + _margin + 0.02;

    // ------------------------------------------------------------------
    // Build structured texts
    // ------------------------------------------------------------------
    private _playerName = name player;
    private _namesParts  = [];
    private _scoresParts = [];

    {
        _x params ["_scoreName", "_scoreValue"];

        // Highlight the local player's line
        private _color = ["#FFFFFF", "#FFD966"] select (_scoreName isEqualTo _playerName);

        _namesParts append [
            (text format ["%1. %2", _forEachIndex + 1, _scoreName]) setAttributes ["color", _color, "size", "0.9"],
            lineBreak
        ];
        _scoresParts append [
            (text str _scoreValue) setAttributes ["color", _color, "size", "0.9", "align", "right"],
            lineBreak
        ];
    } forEach _entries;

    private _titleText = (text _title) setAttributes ["color", "#FFD966", "size", "1.1", "align", "center", "font", "PuristaBold"];

    // ------------------------------------------------------------------
    // Create controls: [class, [x, y, w, h]]
    // ------------------------------------------------------------------
    private _targets = [
        [_posX,                    _posY,                              _width,                  _height],  // Background
        [_posX,                    _posY + _padding,                   _width,                  _titleH],  // Title
        [_posX + _padding,         _posY + _padding + _titleH,         _nameW,                  _rowH * _rows],  // Names
        [_posX + _nameW,           _posY + _padding + _titleH,         _width - _nameW - _padding, _rowH * _rows]   // Scores
    ];
    private _classes = ["RscText", "RscStructuredText", "RscStructuredText", "RscStructuredText"];

    private _ctrls = [];
    {
        private _ctrl = _display ctrlCreate [_classes select _forEachIndex, -1];

        // Start hidden, off-screen on the right
        private _start = +_x;
        _start set [0, (_start select 0) + _slide];
        _ctrl ctrlSetPosition _start;
        _ctrl ctrlSetFade 1;
        _ctrl ctrlCommit 0;

        _ctrls pushBack _ctrl;
    } forEach _targets;

    (_ctrls select 0) ctrlSetBackgroundColor [0, 0, 0, 0.6];
    (_ctrls select 1) ctrlSetStructuredText composeText [_titleText];
    (_ctrls select 2) ctrlSetStructuredText composeText _namesParts;
    (_ctrls select 3) ctrlSetStructuredText composeText _scoresParts;

    uiNamespace setVariable ["SCR_scoreRecap_ctrls", _ctrls];

    // Slide in + fade in
    {
        _x ctrlSetPosition (_targets select _forEachIndex);
        _x ctrlSetFade 0;
        _x ctrlCommit 0.35;
    } forEach _ctrls;

    // ------------------------------------------------------------------
    // Auto-hide after the given duration
    // ------------------------------------------------------------------
    [_ctrls, _targets, _id, _duration, _slide] spawn {
        params ["_ctrls", "_targets", "_id", "_duration", "_slide"];

        uiSleep _duration;

        // A newer panel replaced this one: do nothing
        if ((uiNamespace getVariable ["SCR_scoreRecap_id", 0]) != _id) exitWith {};

        // Slide out + fade out
        {
            private _end = +(_targets select _forEachIndex);
            _end set [0, (_end select 0) + _slide];
            _x ctrlSetPosition _end;
            _x ctrlSetFade 1;
            _x ctrlCommit 0.35;
        } forEach _ctrls;

        uiSleep 0.4;

        // Delete controls only if no newer panel appeared meanwhile
        if ((uiNamespace getVariable ["SCR_scoreRecap_id", 0]) == _id) then {
            { ctrlDelete _x } forEach _ctrls;
            uiNamespace setVariable ["SCR_scoreRecap_ctrls", []];
        };
    };

    true
};

getPlayerRankCompleteName = {
	params ["_player"];
	_currentPlayerCompleteRankName = ([_player] call getPlayerRank);
	_currentPrestige = _player getVariable ["RPG_prestige", 0];
	if (_currentPrestige != 0) then 
	{
		_currentPlayerCompleteRankName = format ["%1 P%2", _currentPlayerCompleteRankName, _currentPrestige];
	};
	_currentPlayerCompleteRankName
};

getPlayerRank = {
	params ["_player"];
	[_player, "displayName"] call BIS_fnc_rankParams
};


increasePrestige = {
	//Test if player has enough XP
	if (([player] call getPlayerRank) == "Colonel") then 
	{
		//Reset experience
		[0] call saveRank;
		[player, true] call adjustRank;

		//Reset tokens
		[0] call saveUnlockCredit;

		//Reset weapons
		[[]] call saveAllUnlockedWeapons;

		//Increase prestige
		_currentPrestige = profileNamespace getVariable ["RPG_prestige", 0];
		profileNamespace setVariable ["RPG_prestige", _currentPrestige+1];
		player setVariable ["RPG_prestige", _currentPrestige+1, true];

		//Display message to everyone 
		[[parseText format ["<img image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa' size='3'/><br/><br/><t size='1.2'>You have been promoted to prestige %1</t>", _currentPrestige+1], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', player]; 
		[[parseText format ["<img image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa' size='3'/><br/><br/><t size='1.2'>%2 has been promoted to prestige %1</t>", _currentPrestige+1, name player], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', -clientOwner]; 
	};
};

doUpdateRank = {
	params ["_experienceBonus", "_experienceType", ["_experienceCustomParam", ""]];

	//Save experience before XP multiplier
	_baseExperience = _experienceBonus;

	//Check if player has accepted a challenge
	if (player getVariable ["RPG_hasClickChallengeWeapon", false]) then 
	{
		//Check if player has the challegend weapon
		if ((player getVariable ["RPG_ChallengeWeapon", ""]) == (primaryWeapon player)) then 
		{
			_expMultiplier = 2;
			if (player getVariable ["RPG_hasClickChallengeOptics", false]) then 
			{
				if (([player, player getVariable ["RPG_ChallengeOptics", ""]] call hasOpticEquipped)) then 
				{
					_expMultiplier = 3;
				} else 
				{
					_expMultiplier = 1/3;
				};
			} else 
			{
				_expMultiplier = 2;
			};

			//If experience is positive and is not related to objective apply bonus 2x
			if ((0<_experienceBonus) && (_experienceType != "RPG_ranking_objective_complete")) then 
			{
				_experienceBonus = round (_expMultiplier*_experienceBonus);
			};
			
		} else 
		{
			if ((0<_experienceBonus) && (_experienceType != "RPG_ranking_objective_complete")) then 
			{
				_experienceBonus = round (_experienceBonus/2);
			};
		};
	};


	if (typeName _experienceBonus == "SCALAR") then 
	{
		//add experience
		[_experienceBonus, _baseExperience, _experienceType, _experienceCustomParam] call addExperience;

		//adjustrank
		[player, false] call adjustRank;
	} else 
	{
		diag_log format ["RPG_XP_Reward : %1 %2 %3", name player, _experienceBonus, _experienceType]; 
	};
	//diag_log format ["RPG_XP_Reward : %1 %2 %3", name player, _experienceBonus, _experienceType, _experienceCustomParam];
};

doUpdateRankWithPenalty = {
	params ["_experienceMalus", "_losePercentage"];

	_currentUnitExperience = [] call getExperience;

	//Determine potential lose
	_potentialExperienceLose = floor (-_currentUnitExperience*_losePercentage/100);

	//add experience
	_XPToSave = _potentialExperienceLose min _experienceMalus;
	[_XPToSave, _XPToSave, "RPG_ranking_player_death"] call addExperience;

	//adjustrank
	[player, false] call adjustRank;

	diag_log format ["RPG_XP_Reward : %1 %2 %3", name player, _potentialExperienceLose min _experienceMalus, "RPG_ranking_player_death"];
};


doGetScoreName = {
	params ["_type"];
	_scoreName = "";

	switch (_type) do
	{
		case "RPG_ranking_infantry_kill":
		{
			_scoreName = localize "STR_RPG_SCORE_INFANTRY_KILL";
		};
		case "RPG_ranking_infantry_killRange":
		{
			_scoreName = localize "STR_RPG_SCORE_INFANTRY_MAX_RANGE";
		};
		case "RPG_ranking_vehicle_kill":
		{
			_scoreName = localize "STR_RPG_SCORE_VEHICLE_KILL";
		};
		case "RPG_ranking_suppress":
		{
			_scoreName = localize "STR_RPG_SCORE_SUPPRESS";
		};
		case "RPG_ranking_heal":
		{
			_scoreName = localize "STR_RPG_SCORE_HEAL";
		};
		case "RPG_ranking_repair":
		{
			_scoreName = localize "STR_RPG_SCORE_REPAIR";
		};
		//Obsolete, it is now grouped with repair and named SUPPORT
		case "RPG_ied_defuse": 
		{
			_scoreName = localize "STR_RPG_SCORE_IED_DEFUSE";
		};
		case "RPG_ranking_intel_collect":
		{
			_scoreName = localize "STR_RPG_SCORE_INTEL";
		};
		case "RPG_ranking_objective_complete":
		{
			_scoreName = localize "STR_RPG_SCORE_OBJECTIVE";
		};
		case "RPG_ranking_player_death":
		{
			_scoreName = localize "STR_RPG_SCORE_PENALTY";
		};
		case "deathNumber" :
		{
			_scoreName = localize "STR_RPG_SCORE_DEATH";
		};
		default
		{
			
		};
	};

	//hint format ["type %1 and scoreText %2", _type, _scoreName];

	_scoreName;
};