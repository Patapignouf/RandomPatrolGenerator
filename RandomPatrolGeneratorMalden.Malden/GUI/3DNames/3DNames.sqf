params ["_name", "_position", "_icon", "_colorArray"];


addMissionEventHandler ["draw3D",
{
	//Params getter
	_name = _thisArgs#0;
	_position = _thisArgs#1;
	_icon = _thisArgs#2;
	_colorArray = _thisArgs#3;

	_localizedName = localize _name;

	if (_localizedName != "") then 
	{
		_name = _localizedName;
	};

	//Distance filter 15m
	_k = 1;
	if (player distance _position < 15) then 
	{
		_k = 10 / (player distance _position);
	} else 
	{
		_k = 0;
	};

	//Drawing engine
	drawIcon3D
	[
		_icon,
		_colorArray,
		_position,
		1 * _k,
		1 * _k,
		0,
		_name,
		0,
		0.04 * _k,
		"RobotoCondensed",
		"right",
		true,
		0.005 * _k,
		-0.035 * _k
	];
},
[_name, _position, _icon, _colorArray] //Params
];

//To test 
//[["HQ Vehicle", (getPos bluforMobileHQ) vectorAdd [0,0,5],"\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa" , [0,0,1,1]], 'GUI\3DNames\3DNames.sqf'] remoteExec ['BIS_fnc_execVM', blufor, true];
