/**
 *
 * Author: Erym
 *
 * Function to handle a civilian unit equipped with a mine that can be defused or explode based on certain conditions.
 *
 * This function initializes a civilian unit by assigning it a vest, changing its side, and equipping it with a mine.
 * The mine is attached to the civilian and hidden. The function sets up event handlers for when the civilian is killed,
 * which includes handling the mine's explosion or defuse actions, and creating a holder object for the mine with a defuse action.
 * 
 * The function also includes logic for updating the mine's behavior based on the distance from players, 
 * and determines whether the mine should explode based on player proximity.
 *
 * Parameters:
 * - _civilian: (OBJECT) The civilian unit to be processed. It must be of type "Man" and belong to the specified side.
 *
 * Returns:
 * - None
 *
 * Example Usage:
 * // Initialize a civilian unit with the mine setup and handling
 * [myCivilian] spawn civils_fnc_suicidebomber;
 * 
 * @param OBJECT _civilian - The civilian unit to be processed.
 */

params ["_civilian"];

// Exit if the civilian is not defined, not of type "Man", or not on the expected side
if(isNil "_civilian" || !(_civilian isKindOf "Man") || side _civilian != civilian) exitWith {};

// Equip the civilian with a vest
removeVest _civilian;
_civilian addVest "V_TacChestrig_grn_F";

// Change the side of the civilian to east and set its behavior
private _eastGroup = createGroup east;
[_civilian] joinSilent _eastGroup;
_eastGroup setBehaviour "CARELESS";

// Create and attach a mine to the civilian
_mine = createMine ["APERSMine", _civilian, [], 0];
_mine attachTo [_civilian, [0, 0, 1]];
_mine hideObjectGlobal true;
_civilian setVariable ["mine", _mine];


// Event handler for when the civilian is killed
_civilian addEventHandler ["Killed", {
	params ["_unit", "_killer"];

	_mine = _unit getVariable "mine";

	// Reward the kill
	[[1, "RPG_ranking_suppress"], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', _killer];

	// Check if the civilian has already exploded
	_exploded = _unit getVariable "exploded";
	if (_exploded) exitWith {
		deleteVehicle _mine;
	};

	// There is a 5% chance of exploding when the unit is killed
	_explode = [5] call utils_fnc_doAProbability;
	if (_explode) exitWith {
		["", civil_1, false] call explosions_fnc_doAnExplosion;
		deleteVehicle _mine;
	};
  
	// Remove the vest and create a holder for the mine
	_vestClass = vest _unit;
	removeVest _unit;

	_holder = createvehicle [ "weaponholdersimulated", position _unit, [], 0, "can_Collide"];
	
	_mine attachTo [_holder, [0, 0, 0]];
	_holder addweaponcargo ["V_TacChestrig_grn_F", 1];
	_holder setVariable ["mine", _mine];
	_holder enableSimulation false;

	// Add a hold action to defuse the mine
	[
		_holder,
		"Defuse the vest",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
		"_this distance _target < 3", //  Condition for the action to be shown
		"_caller distance _target < 3", //  Condition for the action to progress
		{
			// action start code
		},
		{
			// action on going code
		},
		{
			// action successfull code
			params ["_object", "_caller", "_ID", "_objectParams", "_progress", "_maxProgress"];

			_mine = _object getVariable "mine";
			_isACE = (isClass (configFile >> "CfgPatches" >> "ace_medical"));

			// Test if the player has engineer skill
			if ((_caller getUnitTrait "Engineer") && ((!_isACE) || (_isACE && ("ACE_DefusalKit" in (items _caller))))) then {
				// Tell the player that the vest has been defused
				[1, ["The vest has been defused", "PLAIN", 0.5]] remoteExec ["cutText", _caller];

				// Reward the defuse
				[[5, "RPG_ied_defuse"], "engine\rankManagement\rankUpdater.sqf"] remoteExec ['BIS_fnc_execVM', _caller];
			} else {
				// Explode the vest
				["", civil_1, false] call explosions_fnc_doAnExplosion;
				deleteVehicle _mine;
				deleteVehicle _object;

				// Explain to the player why he failed to defuse
				if (_isACE) then {
					[[format ["You need to be engineer and have a defusal kit to defuse the vest"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
				} else {
					[[format ["You need to be engineer to defuse the vest"], "intel"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', _caller];
				};
			};

			// Remove the vest
			deleteVehicle _mine;
			deleteVehicle _object;
		},
		{
			// action failed code
		},
		[_mine],
		2,
		0,
		true,
		false
	] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

	// Monitor nearby players and handle proximity-based events
	[_holder, _mine] spawn {
		params ["_holder", "_mine"];
		while { !isNil "_holder" } do {
			_PlayerInArea = (_holder nearEntities ["Man", 10]) select {
				isPlayer _x
			};

			_count = count _PlayerInArea;

			if (_count > 0) then {
				{
					_player = _x;
					_distance = _holder distance _player;

					// Trigger explosion if player is within proximity
					if (_distance <= 3) exitWith {
						if (stance _player != "PRONE") exitWith {
							["", civil_1, false] call explosions_fnc_doAnExplosion;
							deleteVehicle _mine;
							deleteVehicle _holder;
						};
					};

					if (_distance < 1.4) exitWith {
						["", civil_1, false] call explosions_fnc_doAnExplosion;
						deleteVehicle _mine;
						deleteVehicle _holder;
					};
				} forEach _PlayerInArea;
			};
			sleep 1;
		};
	};
}];


// Main loop to update the civilian's behavior and waypoints
while { alive _civilian } do {
	_PlayerInArea = (_civilian nearEntities ["Man", 30]) select {
		isPlayer _x
	};
	_count = count _PlayerInArea;

	if (_count > 0) then {
		// set Variables
		_unit = _PlayerInArea select 0;
		_distance = _unit distance _civilian;

		// Remove existing waypoints
		{
			deleteWaypoint _x
		} forEachReversed waypoints _eastGroup;

		// Add new waypoint towards the player
		_GroupWayPoint = _eastGroup addWaypoint [(position _unit), 0];
		_GroupWayPoint setWaypointType "MOVE";

		// Check distance and trigger actions
		if (_distance <= 15) then {
			[_civilian, "suicideBomber"] remoteExec ["say3D", 0];
		};

		// Trigger explosion if within 5 meters
		if (_distance <= 5) exitWith {
			["", civil_1, false] call explosions_fnc_doAnExplosion;
			deleteVehicle _mine;
			_civilian setVariable ["exploded", true];
		};
	};

	sleep 1;
};