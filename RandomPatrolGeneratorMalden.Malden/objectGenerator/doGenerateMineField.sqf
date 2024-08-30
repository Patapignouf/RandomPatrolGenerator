params ["_position"];

//Generate FOB
_spawnedMineField = [_position, (random 360), selectRandom avalaibleMineFields] call BIS_fnc_ObjectsMapper;
	
//Snap FOB object to ground
{
	_x setVectorUp surfaceNormal position _x;
} foreach _spawnedMineField;