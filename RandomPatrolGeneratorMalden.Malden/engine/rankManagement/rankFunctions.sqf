rankList = [
	["PRIVATE",0],
	["CORPORAL",200],
	["SERGEANT",500],	
	["LIEUTENANT",1000],
	["CAPTAIN",2000],
	["MAJOR",4000],
	["COLONEL",8000]
];

saveRank = {
	params ["_experience"];

	//Save unit rank
	profileNamespace setVariable ["RPG_ranking", _experience];
	saveProfileNamespace;
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
	params ["_experience", "_experienceType"];

	//Unit current experience
	_unitExperience = profileNamespace getVariable ["RPG_ranking", 0];

	//Track custom experience type
	_currentXPtoTrack = player getVariable [_experienceType, 0];
	player setVariable [_experienceType, _currentXPtoTrack + _experience, true];

	//Save rank
	[_experience + _unitExperience] call saveRank;

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
	_unitFloorRank = (rankList select {_x#1 <= _unitExperience}) #-1;
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
					["RPG_ied_defuse","IED defuse"],
					["RPG_ranking_intel_collect","intel collect"],
					["RPG_ranking_objective_complete","objective complete"]
					];

	{
		_structuredStringXP = format ["%1<br/>%2 : %3",_structuredStringXP, _x#1, _unit getVariable [_x#0,0]];
	}	foreach _basicXPToGather;

	_structuredStringXP
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

		//Increase prestige
		_currentPrestige = profileNamespace getVariable ["RPG_prestige", 0];
		profileNamespace setVariable ["RPG_prestige", _currentPrestige+1];
		player setVariable ["RPG_prestige", _currentPrestige+1, true];

		//Display message to everyone 
		[[parseText format ["<img image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa' size='3'/><br/><br/><t size='1.2'>You have been promoted to prestige %1</t>", _currentPrestige+1], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', player]; 
		[[parseText format ["<img image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_requestleadership_ca.paa' size='3'/><br/><br/><t size='1.2'>%2 has been promoted to prestige %1</t>", _currentPrestige+1, name player], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', -clientOwner]; 
	};
};