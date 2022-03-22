_thisGlobalObject     = _this select 0;
_thisPosition   = _this select 1;
_thisSide       = _this select 2;

//define local variable
_thisObject = _thisGlobalObject select 0;


if (!isDedicated) then 
{
	if (format ["%1", _thisSide ] != "All") then 
	{
		if (side player == _thisSide) then
		{
			diag_log format ["Create marker : %1 at position %2 %3 with name %4 for player %5 in side %6", _thisObject, _thisPosition, getPos _thisPosition, getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), name player, _thisSide];
			_markerstr = createMarkerLocal [format["%1 %2", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName"), random 100], getPos _thisPosition];
			_markerstr setMarkerShapeLocal "ICON";
			_markerstr setMarkerTextLocal getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName");
			_markerstr setMarkerTypeLocal "hd_objective";
			switch (_thisGlobalObject select 1) do
			{
				case "supply":
					{
					_markerstr setMarkerColorLocal "ColorBrown";
					};
				case "ammo":
					{
					_markerstr setMarkerColorLocal "ColorGreen";
					};
				case "hvt":
					{
					_markerstr setMarkerColorLocal "ColorRed";
					};
				case "vip":
					{
					_markerstr setMarkerColorLocal "ColorBlue";
					};
				default { hint "default" };
			};
			
		};
	};
};

