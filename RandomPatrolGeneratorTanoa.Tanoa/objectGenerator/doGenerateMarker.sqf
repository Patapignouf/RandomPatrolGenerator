_thisTitle     = _this select 0;
_thisColor  = _this select 1;
_thisIcon = _this select 2;
_thisPosition   = _this select 3;
_thisSide       = _this select 4;

//define local variable


if (!isDedicated) then 
{
	_markerstr = objNull;
	if (format ["%1", _thisSide ] != "All") then 
	{
		
		if (side player == _thisSide) then
		{
			_markerstr = createMarkerLocal [format["%1 %2", _thisTitle, random 100], _thisPosition];
			_markerstr setMarkerShapeLocal "ICON";
			_markerstr setMarkerTextLocal _thisTitle;
			_markerstr setMarkerTypeLocal _thisIcon;
			_markerstr setMarkerColorLocal _thisColor;
		};
	} else
	{
		_markerstr = createMarkerLocal [format["%1 %2", _thisTitle, random 100], _thisPosition];
		_markerstr setMarkerShapeLocal "ICON";
		_markerstr setMarkerTextLocal _thisTitle;
		_markerstr setMarkerTypeLocal _thisIcon;
		_markerstr setMarkerColorLocal _thisColor;
	};
};

