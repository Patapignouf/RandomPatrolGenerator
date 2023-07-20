bluforRespawn = "respawn_west" setMarkerPos initBlueforLocation;
independentRespawn = "respawn_guerrila" setMarkerPos (initCityLocation);


//Setup basic respawn marker
[missionNamespace, [0,0,0],"respawn"] call BIS_fnc_addRespawnPosition;
_marker = createMarker ["respawn", [0,0,0]]; // Not visible yet.