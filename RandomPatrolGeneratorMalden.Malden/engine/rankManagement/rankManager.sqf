#include "rankFunctions.sqf"
params ["_unit"];

//initialize unit rank
_unit setRank "PRIVATE";
_unitRanking = profileNamespace getVariable ["RPG_ranking", 0]; //Default armed aircraft are disabled
[_unit, true] call adjustRank;

//Kill ranking reward management
// unit: Object - object the event handler is assigned to
// object: Object - object for which score was awarded
// score: Number - score to be added
_unit addEventHandler ["HandleScore", { 
	params ["_unit", "_object", "_score"];

	_objectClass = typeOf _object;
	_objectSide = side _object;
	
	//Check friendly attack
	if (_score < 0) then 
	{
		[] call addPenalty;
	} else 
	{
		//Increase player experience
		switch (true) do {   
			case (_objectClass isKindOf "Man"):
				{
					[1] call addExperience;
				};
			case (_objectClass isKindOf "Tank"):
				{
					[3] call addExperience;
				};
			case (_objectClass isKindOf "Car"): 
				{
					[2] call addExperience;
				};   
			case (_objectClass isKindOf "Ship"): 
				{
					[2] call addExperience;
				};    
			case (_objectClass isKindOf "Helicopter"): 
				{
					[3] call addExperience;
				};   
			case (_objectClass isKindOf "Plane"): 
				{
					[3] call addExperience;
				};
			default 
				{
					//Do nothing
				};   
		};
	};

	[_unit, false] call adjustRank;

	true
}];


//Medical ranking reward management
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	//ACE medic reward
	["ace_treatmentSucceded", {
		params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

		//hint format ["Use item : %1 from %2 with classname : %3",_usedItem, name _caller, _className];
		if ([_usedItem,"ACE_epinephrine"] call BIS_fnc_areEqual) then 
		{
			[[1], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
		};
		if ([_className,"surgicalKit"] call BIS_fnc_areEqual) then 
		{
			[[1], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
		};
	}] call CBA_fnc_addEventHandler;
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
					[[1], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _healer];
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

