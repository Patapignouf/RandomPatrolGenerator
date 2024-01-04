getRandomLocation = 
{
	randomLocation = [];

	randomLocation
};


getRandomCenterLocations = 
{
	_size = worldSize;
	_worldCenter = (_size/2);
	_LocList = nearestLocations [[_worldCenter, _worldCenter], ["NameLocal","NameVillage","NameCity","NameCityCapital"], _size];
	_LocList
};

getLocationsAround = 
{
	_thisLocation = _this select 0;
	_thisRadius = _this select 1;	
	
	_LocList = nearestLocations [[(getPos _thisLocation) select 0, (getPos _thisLocation) select 1], ["NameLocal","NameVillage","NameCity","NameCityCapital"], _thisRadius];
	_LocList
};

getLocationsAroundWithBuilding = 
{
	_thisLocation = _this select 0;
	_thisRadius = _this select 1;	
	
	_LocList = nearestLocations [[(_thisLocation) select 0, (_thisLocation) select 1], ["NameLocal","NameVillage","NameCity","NameCityCapital"], _thisRadius];
	
	//Clear location without building
	{
		//Select smallest location (mountain, forest, plains)
		if (type _x == "NameLocal") then 
		{
			//Check if there is building near the location
			if (count ((locationPosition _x) nearObjects ["House", 150]) == 0) then 
			{
				//Remove the location
				_LocList = _LocList - [_x];
			};
		};
	} foreach _LocList;
	_LocList
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
	
	AvalaiblePositions = [];
	
	for [{_i = 0}, {_i < _numberOfPosition}, {_i = _i + 1}] do
	{ 
		AvalaiblePositions pushBack ([_targetPosition, (_minDistance), (_maxDistance), 8, 0, 0.25, 0, [], [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos);
	};
	AvalaiblePositions
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
	{deletemarker _x} foreach allMapMarkers;

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