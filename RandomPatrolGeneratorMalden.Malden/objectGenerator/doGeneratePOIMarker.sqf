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
			//TEMP HOTFIX : specific case of Steal vehicle
			//diag_log format ["Create marker : %1 at position %2 with name %3 for player %4 in side %5", _thisObject, _thisPosition, getText (configFile >> "cfgVehicles" >> typeOf  (vehicle leader _thisObject) >> "displayName"), name player, _thisSide];
			_markerstr = createMarkerLocal [format ["%1%2","Marker",_thisGlobalObject select 2], _thisPosition];
			_markerstr setMarkerShapeLocal "ICON";
			_markerstr setMarkerTypeLocal "hd_objective";
			switch (_thisGlobalObject select 1) do
			{
				case "supply":
					{
					_markerstr setMarkerColorLocal "ColorBrown";
					_markerstr setMarkerTextLocal format ["Ramenez en ville l'objet %1", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "ammo":
					{
					_markerstr setMarkerColorLocal "ColorGreen";
					_markerstr setMarkerTextLocal format ["Ramenez en ville ou détruisez l'objet %1", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "hvt":
					{
					_markerstr setMarkerColorLocal "ColorRed";
					_markerstr setMarkerTextLocal  format ["Eliminez la cible %1", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "vip":
					{
					_markerstr setMarkerColorLocal "ColorBlue";
					_markerstr setMarkerTextLocal format ["Ramenez en ville le VIP %1", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "steal":
					{
					_markerstr setMarkerColorLocal "ColorYellow";
					_markerstr setMarkerTextLocal format ["Ramenez en ville le véhicule %1 intact", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "clearArea":
					{
					_markerstr setMarkerColorLocal "ColorEAST";
					_markerstr setMarkerTextLocal format ["Pacifiez %1 en nous débarassant des ennemis", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "defendArea":
					{
					_markerstr setMarkerColorLocal "ColorEAST";
					_markerstr setMarkerTextLocal format ["Défendez %1 en nous débarassant des ennemis qui veulent s'emparer de la ville", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "takeAndHold":
					{
					_markerstr setMarkerColorLocal "ColorEAST";
					_markerstr setMarkerTextLocal format ["Défendez %1 en nous débarassant des ennemis qui veulent s'emparer de la ville", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "collectIntel":
					{
					_markerstr setMarkerColorLocal "ColorWhite";
					_markerstr setMarkerTextLocal format ["Récupérez l'intel à %1", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				case "informant":
					{
					_markerstr setMarkerColorLocal "ColorPink";
					_markerstr setMarkerTextLocal format ["Récupérez l'information cruciale auprès de %1", getText (configFile >> "cfgVehicles" >> typeOf _thisObject >> "displayName")];
					};
				default { 
					//hint "default" 
					};
			};
			
		};
	};
};

