/**
 *
 * Author: Erym
 *
 * Function to determine if a random number is within a specified percentage range.
 *
 * This function generates a random number between 0 and a maximum value, and then checks if this 
 * random number is less than or equal to a specified percentage of the maximum value. It returns true 
 * if the random number is within the percentage range, and false otherwise.
 *
 * Parameters:
 * - _percent: (NUMBER) The percentage threshold (0-100) for the random number comparison. Default is 50.
 * - _max: (NUMBER) The maximum value for generating the random number. Default is 100.
 *
 * Returns:
 * - BOOL: Returns true if the generated random number is less than or equal to the percentage threshold 
 *   of the maximum value; otherwise, returns false.
 *
 * Example Usage:
 * // Check if a random number between 0 and 100 is within 50% range of the maximum value
 * result = [] call utils_fnc_doAProbability;
 * 
 * // Check if a random number between 0 and 200 is within 25% range of the maximum value
 * result = [25, 200] call utils_fnc_doAProbability;
 * 
 * @param NUMBER _percent - The percentage threshold (0-100) for the random number comparison.
 * @param NUMBER _max - The maximum value for generating the random number.
 * @return BOOL - Whether the generated random number is within the percentage range.
 */


params [
    ["_percent", 50],
    ["_max", 100]
];

_randomNumber = random _max;

if (_randomNumber <= _percent) then {
	true
} else {
	false
};