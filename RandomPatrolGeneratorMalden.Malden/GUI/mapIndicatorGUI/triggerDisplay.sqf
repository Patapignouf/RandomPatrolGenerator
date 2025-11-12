doRotate = {
	params ["_x", "_y", "_ang", "_pos"];
	private _xr = _x * cos _ang - _y * sin _ang;
	private _yr = _x * sin _ang + _y * cos _ang;
	[_pos select 0 + _xr, _pos select 1 + _yr]
};


displayTriggerOnMap = {
	params ["_trigger"];

	//params ["_trigger", ["_segments", 64]];

	if (isNull _trigger) exitWith {hint "Trigger invalide";};

	// Infos du trigger
	private _pos      = getPosATL _trigger;
	private _size     = triggerArea _trigger;  // [a, b, angle, isRect, isEllipse]
	private _a        = _size select 0;        // demi-axe X
	private _b        = _size select 1;        // demi-axe Y
	private _angle    = _size select 2;
	private _isRect   = _size select 3;

	// On ne gère que les ellipses
	if (_isRect) exitWith {hint "La fonction ne gère que les triggers elliptiques.";};

	// Rotation en radians
	private _angRad = _angle * (pi / 180);

	// Fonction de rotation locale -> monde

	// Ajouter handler pour dessiner l’ellipse
	// _drawHandler = findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
	// 	params ["_map"];
	// 	_pos    = _thisArgs select 0;
	// 	_a      = _thisArgs select 1;
	// 	_b      = _thisArgs select 2;

	// 	(_this select 0)  drawEllipse [
	// 		_pos, _a, _b, 0, [1, 0, 0, 1], ""
	// 	];

	// }, [_pos, _a, _b]];
	_uid = random [10000000000,
					55555555555,
					99999999999];	

	_bob = createMarker [str (_uid), _pos]; 
	_bob setMarkerShape "ELLIPSE"; 
	_bob setMarkerColor "ColorGrey"; 
	_bob setMarkerSize [_a, _b]; 
	_bob setMarkerBrush "SOLID";

	[_trigger, str _uid] spawn 
	{
		params ["_trigger", "_uid"];
		waitUntil {isNull _trigger};
		//findDisplay 12 displayCtrl 51 ctrlRemoveEventHandler ["Draw", _drawHandler];
		[_uid] remoteExec ["deleteMarker", 0, true];
	};
};

