params [
	["_center", [0,0,0], [[]]],
	["_radius", 50, [0]]
];

_center = getPos player;
_radius =100;

// Cherche tous les objets physiques dans le rayon (filtre selon besoin)
private _objects = nearestObjects [_center, [], _radius];

private _result = [];

{
	private _obj = _x;

	// Ne pas inclure le joueur, caméras, etc.
	if (isNull _obj || {_obj isKindOf "CAManBase"}) then { continue };
	private _class = typeOf _obj;
	
	
	private _absPos  = getPos _obj;
	private _relPos  = [
		(_absPos select 0) - (_center select 0),
		(_absPos select 1) - (_center select 1),
		((getPosATL _obj) select 2) 
	];
	
	
	
	
	private _pos = getPosATL _obj;			// ← inclut la hauteur exacte
	private _dir = getDir _obj;
	private _vUp = vectorUp _obj;
	private _sim = simulationEnabled _obj;
	private _damage = false;

	private _entry = [
		_class,
		_relPos,
		_dir,
		1,
		0,
		_vUp,
		"",
		"",
		_sim,
		_damage
	];

	_result pushBack _entry;

} forEach _objects;


{
	deleteVehicle _x;
} foreach (nearestObjects [getPos player, [], 100]);


[getPos player, 0, _result, 0] call BIS_fnc_objectsMapper;
_result

