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
	params ["_unit","_isInit"];

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

	//Unit has been promoted
	if (_newRankId>_currentRankId) then 
	{
		_rankTexture = [_unit, "texture"] call BIS_fnc_rankParams;
		_rankName = [_unit, "displayName"] call BIS_fnc_rankParams;
		[[parseText format ["<img image='%1'/><br/><br/><t size='1.2'>You have been promoted to %2</t>", _rankTexture, _rankName]], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _unit]; 
		if (!_isInit) then 
		{
			[[parseText format ["<img image='%1'/><br/><br/><t size='1.2'>%3 has been promoted to %2</t>", _rankTexture, _rankName, name _unit]], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', -clientOwner]; 
		};
	};

	//Unit has been demoted
	if (_newRankId<_currentRankId) then {
		_rankTexture = [_unit, "texture"] call BIS_fnc_rankParams;
		_rankName = [_unit, "displayName"] call BIS_fnc_rankParams;
		[[parseText format ["<img image='%1'/><br/><br/><t size='1.2'>You have been demoted to %2</t>", _rankTexture, _rankName]], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _unit]; 
		if (!_isInit) then 
		{
			[[parseText format ["<img image='%1'/><br/><br/><t size='1.2'>%3 has been demoted to %2</t>", _rankTexture, _rankName, name _unit]], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', -clientOwner]; 
		};
	};

	true
};

addExperience = {
	params ["_experience"];

	//Unit current experience
	_unitExperience = profileNamespace getVariable ["RPG_ranking", 0];

	[_experience + _unitExperience] call saveRank;

	true
};

addPenalty = {
	//Unit current experience
	_unitExperience = profileNamespace getVariable ["RPG_ranking", 0];

	[_unitExperience - 50] call saveRank;

	true
};