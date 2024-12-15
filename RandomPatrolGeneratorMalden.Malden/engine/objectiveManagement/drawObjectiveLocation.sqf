params ["_taskID", "_position"];


switch (missionNameSpace getVariable ["enableObjectiveExactLocation",0]) do 
{
	case 1:
	{
		_randomPos = [[[_position, 50]], []] call BIS_fnc_randomPos;
		[_taskID, _randomPos] call BIS_fnc_taskSetDestination;

		_bob = createMarker [_taskID, _randomPos]; 
		_bob setMarkerShape "ELLIPSE"; 
		_taskID setMarkerColor "ColorOrange"; 
		_taskID setMarkerSize [150, 150]; 
		_taskID setMarkerBrush "SOLID";
		_bob setMarkerPos _randomPos; //reajust after modify shape
	};
	case 2:
	{
		[_taskID, _position] call BIS_fnc_taskSetDestination;
	};
	default
	{
		//Do nothing
	};
};


//[["", getPos player], "engine\objectiveManagement\drawObjectiveLocation.sqf"] remoteExec ['BIS_fnc_execVM', 0, true];
