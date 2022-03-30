_centerAreaToClean = _this select 0;
_radiusAreaToClean = _this select 1;



_stuff = nearestTerrainObjects [_centerAreaToClean, [], _radiusAreaToClean];
{_x hideObjectGlobal true;} forEach _stuff;


