#include "rankFunctions.sqf"
params ["_unit","_isFirstStart"];

//initialize unit rank 
if (_isFirstStart) then 
{
	_unit setRank "PRIVATE";
	_unitRanking = [_unit] call getExperience; //Default armed aircraft are disabled
	[_unit, true] call adjustRank;
	[_unit] call displayCurrentRank;
	_unit setVariable ["startingXP",_unitRanking, true];
	_unit setVariable ["currentXP",_unitRanking, true];
	_currentPrestige = profileNamespace getVariable ["RPG_prestige", 0];
	_unit setVariable ["RPG_prestige", _currentPrestige, true];

	//Detect if there is a new player and show discord
	if (_unitRanking == 0) then 
	{
		_ctrl = findDisplay 46 createDisplay "RscDisplayEmpty" ctrlCreate ["RscStructuredText", -1];
		_ctrl ctrlSetPosition [0,0,1,1];
		_ctrl ctrlCommit 0;
		_ctrl ctrlSetStructuredText parseText "<a color='#ff0000' size='4' href='https://discord.gg/S6Y6YTjT'><t color='#ff0000'>Join the PataCompany !</t><br/><t color='#ff0000'>Join the Discord</t></a>";
	};
};

// //Kill ranking reward management
// // unit: Object - object the event handler is assigned to
// // object: Object - object for which score was awarded
// // score: Number - score to be added
// _unit addEventHandler ["HandleScore", { 
// 	params ["_unit", "_object", "_score"];

// 	_objectClass = typeOf _object;
// 	_objectSide = side _object;

// 	//hint format ["%1 %2 %3",_unit, _object, _score];
	
// 	//Check friendly attack
// 	if (_score < 0) then 
// 	{
// 		[] call addPenalty;
// 	} else 
// 	{
// 		//Increase player experience
// 		switch (true) do 
// 		{   
// 			case (_objectClass isKindOf "Man"):
// 				{
// 					[1] call addExperience;
// 				};
// 			case (_objectClass isKindOf "Tank"):
// 				{
// 					[10] call addExperience;
// 				};
// 			case (_objectClass isKindOf "Car"): 
// 				{
// 					[5] call addExperience;
// 				};   
// 			case (_objectClass isKindOf "Ship"): 
// 				{
// 					[5] call addExperience;
// 				};    
// 			case (_objectClass isKindOf "Helicopter"): 
// 				{
// 					[10] call addExperience;
// 				};   
// 			case (_objectClass isKindOf "Plane"): 
// 				{
// 					[10] call addExperience;
// 				};
// 			default 
// 				{
// 					//Do nothing
// 				};   
// 		};
// 	};

// 	[_unit, false] call adjustRank;

// 	true
// }];

//Add repair event (no direct event for repair found, this is based on animation, it can obviously be improved)
_unit addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];
	if (_anim == "acts_carfixingwheel" || _anim == "amovpknlmstpsnonwnondnon") then 
	{
		// diag_log _anim;
		// hint format ["P1 : %1\nP2 : %2",_unit,_anim];
		[[1, "RPG_ranking_repair"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _unit];
	};
}];




//Medical ranking reward management
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	//ACE medic reward
	//List of ace medic items which give basic experience points
	basicExpRewardMedicItems = [
		"ACE_fieldDressing",
		"ACE_packingBandage",
		"ACE_elasticBandage",
		"ACE_quikclot",
		"ACE_splint",
		"ACE_bloodIV_250",
		"ACE_tourniquet"
	];
	//List of ace medic items which give intermediate experience points
	intermediateExpRewardMedicItems = [
		"ACE_bloodIV_500",
		"ACE_epinephrine"
	];
	//List of ace medic items which give high experience points
	highExpRewardMedicItems = [
		"ACE_bloodIV"
	];

	["ace_treatmentSucceded", {
		params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

		//Display for debug
		//hint format ["Use item : %1 from %2 with classname : %3", _usedItem, name _caller, _className];

		//Only reward heal on others 
		if (_caller != _target) then 
		{
			// Check if medical item used is useless, and therefore should not be rewarded
			private _isItemUseless = false;
			//Note : ace_medical_bloodVolume gives blood in target in liters. 6 liters being the max (at spawn value).
			if (([_usedItem,"ACE_bloodIV_250"] call BIS_fnc_areEqual && (_target getVariable "ace_medical_bloodVolume" >= 5.75))
				|| ([_usedItem,"ACE_bloodIV_500"] call BIS_fnc_areEqual && (_target getVariable "ace_medical_bloodVolume" >= 5.5))
				|| ([_usedItem,"ACE_bloodIV"] call BIS_fnc_areEqual && (_target getVariable "ace_medical_bloodVolume" >= 5)))
			then {
				_isItemUseless = true;
			} else
			{ // Special check for tourniquets on undamaged body parts
				if ([_usedItem,"ACE_tourniquet"] call BIS_fnc_areEqual) then {
					// Check if target has a bleeding open wound on the concerned body part
					private _openWounds = _target getVariable ["ace_medical_openWounds", []];
					if (!(_selectionName in _openWounds)) then
					{
						_isItemUseless = true;
					} else
					{
						_isItemUseless = true;
						{
							private _amountOf = _x select 1;
							private _bleeding = _x select 2;
							if (_bleeding * _amountOf > 0) then
							{
								_isItemUseless = false;
								break;
							}

						} forEach (_openWounds get _selectionName);
					};
				};
			};

			// Check if target is currently unconscious, for different XP rewards
			// When unconscious, each medical action adds to a participation score used to determine a "shared-pot" reward for all participating players upon the target regaining consciousness
			if (_target getVariable ["isUnconscious", false]) then 
			{
				// // Special check for non-rewarded action: CPR is useless if target is not in cardiac arrest
				if ([_className,"CPR"] call BIS_fnc_areEqual && _target getVariable ["ace_medical_inCardiacArrest", false]) then
				{
					_isItemUseless = true;
				};

				if (!_isItemUseless) then {
					// Determine how much participation value the treatment is worth
					private _addedParticipationValue = 0;

					// basic medical items + CPR
					if (basicExpRewardMedicItems findIf { [_usedItem,_x] call BIS_fnc_areEqual} > -1 
						|| [_className,"CPR"] call BIS_fnc_areEqual)
					then {
						_addedParticipationValue = 1;
					};
					// intermediate medical items
					if (intermediateExpRewardMedicItems findIf { [_usedItem,_x] call BIS_fnc_areEqual} > -1) then 
					{
						_addedParticipationValue = 2;
					};
					// high value medical items
					if (highExpRewardMedicItems findIf { [_usedItem,_x] call BIS_fnc_areEqual} > -1) then 
					{
						_addedParticipationValue = 4;
					};

					// Update the participation score of the _caller
					_medicalParticipationHashMap = _target getVariable ["medicalParticipationHashMap", createHashMap];
					private _callerId = _caller call BIS_fnc_objectVar;

					if (_callerId in _medicalParticipationHashMap) then
					{
						private _newParticipationValue = ((_medicalParticipationHashMap get _callerId) select 1) + _addedParticipationValue;
						_medicalParticipationHashMap set [_callerId, [_caller, _newParticipationValue]];
					} else
					{
						_medicalParticipationHashMap set [_callerId, [_caller, _addedParticipationValue]];
					};
					_target setVariable ["medicalParticipationHashMap", _medicalParticipationHashMap, true];
				};
			} else
			// When target is not unconscious, rewards are straightforward "per action" rewards
			{ 
				// Special check for non-rewarded item: epinephrine is useless when conscious
				if ([_usedItem,"ACE_epinephrine"] call BIS_fnc_areEqual) then
				{
					_isItemUseless = true;
				};

				if (!_isItemUseless) then {
					// Keep track of the number (and value) of medical items used, 1 exp point = 4 basic / 2 intermediate / 1 high value item(s)
					private _valueOfMedicItemsUsed_tmp = _caller getVariable ["valueOfMedicItemsUsed", 0];

					// basic medical items + sutures (surgicalKit) & CPR
					if (basicExpRewardMedicItems findIf { [_usedItem,_x] call BIS_fnc_areEqual} > -1 
						|| [_className,"surgicalKit"] call BIS_fnc_areEqual
						|| [_className,"CPR"] call BIS_fnc_areEqual)
					then {
						_valueOfMedicItemsUsed_tmp = _valueOfMedicItemsUsed_tmp + 1;
					};
					// intermediate medical items
					if (intermediateExpRewardMedicItems findIf { [_usedItem,_x] call BIS_fnc_areEqual} > -1) then 
					{
						_valueOfMedicItemsUsed_tmp = _valueOfMedicItemsUsed_tmp + 2;
					};
					// high value medical items
					if (highExpRewardMedicItems findIf { [_usedItem,_x] call BIS_fnc_areEqual} > -1) then 
					{
						_valueOfMedicItemsUsed_tmp = _valueOfMedicItemsUsed_tmp + 4;
					};

					// Grant 1 XP reward for every 4 points of value of medical treatments
					if (_valueOfMedicItemsUsed_tmp >= 4) then 
					{
						[[(floor (_valueOfMedicItemsUsed_tmp / 4)), "RPG_ranking_heal"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
						_caller setVariable ["valueOfMedicItemsUsed", (_valueOfMedicItemsUsed_tmp % 4)];
					} else 
					{
						_caller setVariable ["valueOfMedicItemsUsed", _valueOfMedicItemsUsed_tmp];
					};
				};
			};
		};
	}] call CBA_fnc_addEventHandler;

	// Take note of units falling unconscious or regaining consciousness
	["ace_unconscious", {
		params ["_unit", "_state"];

		_unit setVariable ["isUnconscious", _state];
		// If unit is regaining consciousness, xp rewards are granted to people who participated to medical treatments during unconsciousness
		if (!_state) then 
		{
			private _medicalParticipationHashMap = _unit getVariable ["medicalParticipationHashMap", createHashMap];
			if (count _medicalParticipationHashMap > 0) then
			{
				// Determine total participation score
				private _totalParticipationScore = 0;
				{
					_totalParticipationScore = _totalParticipationScore + (_y select 1);
				} forEach _medicalParticipationHashMap;

				// Determine total shared xp reward
				private _totalXpReward = 4;
				if (_totalParticipationScore > 12) then
				{ _totalXpReward = 6; };
				if (_totalParticipationScore > 20) then
				{ _totalXpReward = 8; };

				{
					// Grant portion of the shared xp to players based on individual participation.
					[[round(_totalXpReward * ((_y select 1) / _totalParticipationScore)), "RPG_ranking_heal"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _y select 0];
				} forEach _medicalParticipationHashMap;
			};
		};
		_unit setVariable ["medicalParticipationHashMap", createHashMap, true];
	}] call CBA_fnc_addEventHandler;

	// Forget about any medical xp reward if the patient dies
	_unit addEventHandler ["Killed", {
		params ["_unit"];
		
		_unit setVariable ["medicalParticipationHashMap", nil, true];
	}];
} else 
{
	//Non ACE medic reward
	inGameUISetEventHandler ["Action", " 
	if (([_this#3, 'HealSoldier'] call BIS_fnc_areEqual) || ([_this#4, 'Revive        Space     '] call BIS_fnc_areEqual)) then  
	{ 
		_healer = _this#1;
		_injured = _this#0;
		[_injured, _healer] spawn {
			params ['_injured', '_healer'];
			private _damage = damage _injured;
			waitUntil { damage _injured != _damage };
			if (!([_healer,_injured] call BIS_fnc_areEqual)) then 
			{
				if (damage _injured < _damage) then {
					[[1, 'RPG_ranking_heal'], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _healer];
				};
			};
		};
	};
	"];


	//Explore actions
	// inGameUISetEventHandler ["Action", " 
	// 	hint format ['%1',_this];
	// };
	// "];
};
