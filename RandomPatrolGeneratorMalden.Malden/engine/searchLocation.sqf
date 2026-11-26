getRandomLocation = 
{
	randomLocation = [];

	randomLocation
};


getRandomCenterLocations = 
{
	_size = worldSize;
	_worldCenter = (_size/2);
	_locationType = ["NameLocal","NameVillage","NameCity","NameCityCapital","CityCenter", "Airport", "Name", "SafetyZone", "StrongpointArea"];
	_smallType = ["Hill", "Area"];

	if (missionNameSpace getVariable ["allowSmallLocations", 0] == 1) then 
	{
		_locationType = _locationType + _smallType;
	};

	_LocList = nearestLocations [[_worldCenter, _worldCenter], _locationType, _size];

	//Purge noname locations
	{
		if (text _x == "") then 
		{
			_LocList = _LocList-[_x];
		};
	} foreach _LocList;

	_LocList
};

searchNearestPlayer = {
	params ["_searchPos"];

	private _players = allPlayers select { alive _x };
	if (_players isEqualTo []) exitWith { objNull };

	private _nearestPlayer = _players#0;
	private _minDist = _searchPos distance _nearestPlayer;

	{
		private _dist = _searchPos distance _x;
		if (_dist < _minDist) then {
			_minDist = _dist;
			_nearestPlayer = _x;
		};
	} forEach _players;

	_nearestPlayer
};


/*
    Function: fnc_findClosestPlayerPoint
    Description: Finds the closest (point, player) pair from a given list of points
                 and all currently alive players.

    Parameters:
        0: ARRAY - List of points (positions [x, y, z] or objects)

    Return Value:
        ARRAY - [closestPoint, closestPlayer, distanceInMeters]
                Returns [[], objNull, -1] if there are no points or no valid players.
*/

fnc_findClosestPlayerPoint = {
    params [["_points", [], [[]]]];

    // Filter valid players (alive)
    private _players = allPlayers select { alive _x };

    if (_points isEqualTo [] || { _players isEqualTo [] }) exitWith {
        [[], objNull, -1]
    };

    private _bestPoint = [];
    private _bestPlayer = objNull;
    private _bestDistSqr = 1e39; // Large initial value

    {
        private _point = _x;
        // Support both position arrays and objects (e.g., GameLogic, vehicles)
        private _pointPos = if (_point isEqualType objNull) then { getPosATL _point } else { _point };

        {
            private _player = _x;
            private _playerPos = getPosATL _player;
            private _distSqr = _pointPos distanceSqr _playerPos;

            if (_distSqr < _bestDistSqr) then {
                _bestDistSqr = _distSqr;
                _bestPoint = _point;
                _bestPlayer = _player;
            };
        } forEach _players;
    } forEach _points;

    private _distance = sqrt _bestDistSqr;

    [_bestPoint, _bestPlayer, _distance]
};

getAllBigLocationsWithBuildings = {
	_tempAllLocations = [] call getRandomCenterLocations;

	//Clear location without building
	{
		//Select smallest location (mountain, forest, plains)
		if (type _x == "NameLocal" || type _x == "Hill" ) then 
		{
			//Check if there is building near the location
			if (count ((nearestTerrainObjects [locationPosition _x, ["house", "FORTRESS", "BUNKER", "BUILDING"], 150, false, true])) == 0) then 
			{
				//Remove the location
				_tempAllLocations = _tempAllLocations - [_x];
			} else 
			{
				//Debug mode to view found location
				// _name = text _x;
				// _pos = getPos _x;
				// createMarkerLocal [_name, _pos];
				// _name setMarkerTypeLocal  "selector_selectedMission";
				// _name setMarkerTextLocal  _name;
				// //_name setMarkerColorLocal _color;
			};
		};
	} foreach _tempAllLocations;
	_tempAllLocations
};



getLocationsAround = 
{
	params ["_thisLocation", "_thisRadius"];
	
	_LocList = nearestLocations [[(getPos _thisLocation) select 0, (getPos _thisLocation) select 1], ["NameLocal","NameVillage","NameCity","NameCityCapital","CityCenter","Area", "Airport", "Name", "SafetyZone", "StrongpointArea", "Hill"], _thisRadius];
	
	//Purge noname locations
	{
		if (text _x == "") then 
		{
			_LocList = _LocList-[_x];
		};
	} foreach _LocList;
	
	_LocList
};

getLocationsAroundWithBuilding = 
{
	params ["_thisLocation", "_thisRadius"];
	
	_LocList = nearestLocations [[(_thisLocation) select 0, (_thisLocation) select 1], ["NameLocal","NameVillage","NameCity","NameCityCapital","CityCenter","Area", "Airport", "Name", "SafetyZone", "StrongpointArea", "Hill"], _thisRadius];
	
	//Purge noname locations
	{
		if (text _x == "") then 
		{
			_LocList = _LocList-[_x];
		};
	} foreach _LocList;

	//Clear location without building
	{
		//Select smallest location (mountain, forest, plains)
		if (type _x == "NameLocal" || type _x == "Hill" ) then 
		{
			//Check if there is building near the location
			if (count ((nearestTerrainObjects [locationPosition _x, ["house", "FORTRESS", "BUNKER"], 150, false, true])) == 0) then 
			{
				//Remove the location
				_LocList = _LocList - [_x];
			};
		};
	} foreach _LocList;
	_LocList
};


isAroundWithBuilding = 
{
	params ["_thisPosition"];
	_locationPresence = true;

	//Check if there is building near the location
	if (count ((nearestTerrainObjects [_thisPosition, ["house", "FORTRESS", "BUNKER"], 150, false, true])) == 0) then 
	{
		//Remove the location
		_locationPresence = false;
	};

	_locationPresence
};

getAreaOfMission = 
{
	_listOfPOI = _this select 0;
	
	_leftmostPoints = [_listOfPOI, [], {(_x) select 0}, "ASCEND"] call BIS_fnc_sortBy;
	_leftmostPoint = _leftmostPoints select 0;
	_rightmostPoint = _leftmostPoints select ((count _leftmostPoints)-1);
	_topmostPoints = [_listOfPOI, [], {(_x) select 1}, "DESCEND"] call BIS_fnc_sortBy;
	_topmostPoint = _topmostPoints select 0;
	_bottommostPoint = _topmostPoints select ((count _topmostPoints)-1);
	_xDist =  (_rightmostPoint select 0) - (_leftmostPoint select 0);
	_yDist = (_topmostPoint select 1) - (_bottommostPoint select 1);
	_centerTrue = [(_rightmostPoint select 0)- (_xDist/2), (_topmostPoint select 1) - (_yDist/2)];

	_trgAOC = createTrigger ["EmptyDetector", _centerTrue];
	_trgAOC setTriggerArea [_xDist/1.5, _yDist/1.5, 0, true];
	_trgAOC
};


getListOfPositionsAroundTarget = 
{
	//Define parameters
	_targetPosition = _this select 0;
	_minDistance = _this select 1;
	_maxDistance = _this select 2;
	_numberOfPosition = _this select 3;
	
	private _AvalaiblePositions = [];
	
	for [{_i = 0}, {_i < _numberOfPosition}, {_i = _i + 1}] do
	{ 
		private _tempPos = [_targetPosition, (_minDistance), (_maxDistance), 8, 0, 0.30, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		_tempPos pushBack 0;
		_AvalaiblePositions pushBack (_tempPos);
	};
	_AvalaiblePositions
};

getPositionAroundTargetNoSafeZone = 
{
	//Define parameters
	_targetPosition = _this select 0;
	_minDistance = _this select 1;
	_maxDistance = _this select 2;
	_numberOfPosition = _this select 3;
	
	AvalaiblePositions = [];
	

	AvalaiblePositions pushBack ([_targetPosition, (_minDistance), (_maxDistance), 3, 0, 0.25, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos);
	
	AvalaiblePositions#0
};

isLocationOnMap = {
	params ["_testedLocation"];
	_isLocationOnMap = false;

	//Test default location
	if (!([_testedLocation , [0,0,0]] call BIS_fnc_areEqual)) then 
	{

		//Test out of bound location
		if (_testedLocation select 0 > worldSize || _testedLocation select 1 > worldSize || _testedLocation select 1 < 0 || _testedLocation select 1 < 0) then 
		{
			_isLocationOnMap = true;
		};
	} else 
	{
		_isLocationOnMap = true;
	};

	_isLocationOnMap
};

//Find good positions roads near positions
findPositionsNearRoads = {
	params ["_position", "_distance", "_numberOfPositions"];

	//Result positions 
	_candidateResultPositions = [];
	
	_IEDs = [];
	_roads = _position nearroads _distance; //grabbing all roads within _distance
	//systemchat str count _roads;

	while {count _roads > 0} do {
		_rndRoad = selectRandom _roads; //picking a random road segment
		_roads = _roads select {_x distance2d _rndRoad >= 1000}; //removing any roads closer than 1km to that random segment
		//_IEDs pushback _rndroad; //store the random segment in an array for later usage

		//some markers to visualize the entire thing
		//Uncomment for debug
		// _marker = createmarker [str _rndRoad,getposatl _rndRoad];
		// _marker setmarkertype "hd_dot";
		// _marker setmarkercolor "ColorRed";
		// _marker setmarkertext format ["IED %1",_IEDs find _rndRoad];
		_candidateResultPositions pushBack (getposatl _rndRoad);
	};

	_resultPositions = [];
	if (count _candidateResultPositions > _numberOfPositions) then 
	{
		for [{_i = 0}, {_i < _numberOfPositions}, {_i = _i + 1}] do 
		{
			_resultPositions pushBack (selectRandom _candidateResultPositions); //Can be optimize, it can return same position twice
		};
	} else 
	{
		_resultPositions = _candidateResultPositions;
	};

	//that's it
	_resultPositions
};

//Search a road for a RoadBlock
findRoadBlockPosition = 
{
	params ["_startingPosition", "_maxRadius"];

	_roads = _startingPosition nearRoads _maxRadius;

	_roadsSorted = [_roads,[],{_startingPosition distance _x},"ASCEND"] call BIS_fnc_sortBy;

	_nearestRoad = _roadsSorted select 0;

	_roadConnectedTo = roadsConnectedTo _nearestRoad;

	_connectedRoad = _roadConnectedTo select 0;

	_roadCenter = getPos _nearestRoad;

	_roadDir = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;

	[_roadCenter, _roadDir]
};


//Find closest locationPosition 
getClosest = {
	params ["_position", "_allPositions"];
	_allPositions = [_allPositions, [], {_position distance _x}, "ASCEND"] call BIS_fnc_sortBy;
	_allPositions#0;
};


getDepthAtLocation = {
	params ["_position"];
	private _depth = 0;
	private _terrainHeight = getTerrainHeightASL _position;

	if (_terrainHeight < 0) then {
		_depth = abs _terrainHeight; // On transforme la valeur négative en profondeur positive
	} else {
		_depth = 0; // On est sur la terre ferme
	};

	_depth
};

searchLocationWithWaterDepth = {
	params [["_numberOfAttempts", 3]];

	private _searchResult = [[], false];

	_positionCandidate = [nil, ["ground"]] call BIS_fnc_randomPos; // Ou une position fixe ex: [1200, 4500, 0]

	//Search max 4 times water at 20 meters deep
	for [{_i = 0}, {_i < _numberOfAttempts}, {_i = _i + 1}] do
	{ 
		_depthAtLoc = [_positionCandidate] call getDepthAtLocation;
		if (20 < _depthAtLoc) then 
		{
			_searchResult set [0, _positionCandidate];
			_searchResult set [1, true];
		} else 
		{
			_positionCandidate = [nil, ["ground"]] call BIS_fnc_randomPos;
		};
	};
	_searchResult
};


getEdgePoints = {
    params [
        ["_destination", [0,0,0], [[]], [2,3]],   // accepte [x,y] et [x,y,z]
        ["_minLength", 500, [0]]                  // longueur mini du segment (m)
    ];

    private _mapSize = worldSize;

    // Ramener la destination dans la carte
    private _destX = ((_destination select 0) max 0) min _mapSize;
    private _destY = ((_destination select 1) max 0) min _mapSize;

    private _result = [];

    for "_i" from 1 to 20 do {
        private _angle = random 360;
        private _minLen = _minLength;

        // Dernier essai : direction vers le centre de la carte, sans longueur mini
        if (_i == 20) then {
            _angle = 90 - ([_destX, _destY] getDir [_mapSize / 2, _mapSize / 2]);
            _minLen = 0;
        };

        private _dx = cos _angle;
        private _dy = sin _angle;

        // Éviter la division par zéro
        if (abs _dx < 1e-6) then { _dx = 1e-6 };
        if (abs _dy < 1e-6) then { _dy = 1e-6 };

        // Intersections de la droite avec les bandes x∈[0,size] et y∈[0,size]
        private _tx1 = (0 - _destX) / _dx;
        private _tx2 = (_mapSize - _destX) / _dx;
        private _ty1 = (0 - _destY) / _dy;
        private _ty2 = (_mapSize - _destY) / _dy;

        private _tMin = ((_tx1 min _tx2) max (_ty1 min _ty2));
        private _tMax = ((_tx1 max _tx2) min (_ty1 max _ty2));

        if ((_tMax - _tMin) >= _minLen) exitWith {
            _result = [
                [
                    ((_destX + _tMin * _dx) max 0) min _mapSize,
                    ((_destY + _tMin * _dy) max 0) min _mapSize,
                    0
                ],
                [
                    ((_destX + _tMax * _dx) max 0) min _mapSize,
                    ((_destY + _tMax * _dy) max 0) min _mapSize,
                    0
                ]
            ];
        };
    };

    _result
};