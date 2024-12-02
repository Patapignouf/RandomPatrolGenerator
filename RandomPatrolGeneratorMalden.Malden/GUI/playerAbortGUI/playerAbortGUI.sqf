
private _result = ["Your team seems wiped out, abort mission ?", "Confirm", true, true] call BIS_fnc_guiMessage;

if (_result) then {
	//systemChat "The player is sure.";
	player setDamage 1;
} else {
	//systemChat "The player is not sure.";
};