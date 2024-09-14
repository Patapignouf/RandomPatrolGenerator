/**
 *
 * Author : Erym
 *
 * Function to create an explosive object and optionally a crater at a specified position.
 *
 * This function creates an explosive object at a given position. If specified, it will also create 
 * a crater at the same position. The explosive object and crater are created using the `createVehicle` 
 * command.
 *
 * Parameters:
 * - _explosive: (STRING) The type of explosive object to create. Default is "M_Titan_AT".
 * - _position: (ARRAY) The position (x, y, z) where the explosive object (and optionally the crater) 
 *   will be created. Default is [0, 0, 0].
 * - _crater: (BOOL) A flag indicating whether a crater should be created at the position. 
 *   If true, a crater will be created; if false, only the explosive object will be created.
 *
 * Example Usage:
 * [] call explosions_fnc_doAnExplosion; 
 * - Creates a "M_Titan_AT" explosive at the default position with no crater.
 * 
 * ["M_Mo_82mm_Mine", [1000, 2000, 0], true] call explosions_fnc_doAnExplosion;
 * - Creates a "M_Mo_82mm_Mine" explosive at position [1000, 2000, 0] with a crater.
 *
 * @param STRING _explosive - Type of explosive to create.
 * @param ARRAY _position - Position (x, y, z) for the explosive and optional crater.
 * @param BOOL _crater - Whether to create a crater at the position.
 */

params [
    ["_explosive", "M_Titan_AT"],
    ["_position", [0, 0, 0]],
	["_crater", false]
];

if(_crater) then {
	"Land_ShellCrater_01_F" createVehicle _position;
};
_explosive createVehicle _position;