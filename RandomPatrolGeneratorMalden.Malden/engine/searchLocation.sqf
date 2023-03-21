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
	
	_LocList = nearestLocations [[(getPos _thisLocation) select 0, (getPos _thisLocation) select 1], ["NameLocal","NameVillage","NameCity","NameCityCapital"], _thisRadius];
	
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
	
	_leftmostPoints = [_listOfPOI, [], {(getPos _x) select 0}, "ASCEND"] call BIS_fnc_sortBy;
	_leftmostPoint = _leftmostPoints select 0;
	_rightmostPoint = _leftmostPoints select ((count _leftmostPoints)-1);
	_topmostPoints = [_listOfPOI, [], {(getPos _x) select 1}, "DESCEND"] call BIS_fnc_sortBy;
	_topmostPoint = _topmostPoints select 0;
	_bottommostPoint = _topmostPoints select ((count _topmostPoints)-1);
	_xDist =  (getPos _rightmostPoint select 0) - (getPos _leftmostPoint select 0);
	_yDist = (getPos _topmostPoint select 1) - (getPos _bottommostPoint select 1);
	_centerTrue = [(getPos _rightmostPoint select 0)- (_xDist/2), (getPos _topmostPoint select 1) - (_yDist/2)];

	trgAOC = createTrigger ["EmptyDetector", _centerTrue];
	trgAOC setTriggerArea [_xDist/1.5, _yDist/1.5, 0, true];
	trgAOC
};


getListOfPositionsAroundTarget = 
{
	//Define parameters
	_targetPosition = _this select 0;
	_minDistance = _this select 1;
	_maxDistance = _this select 2;
	_numberOfPosition = _this select 3;
	
	AvalaiblePositions = [];
	
	for [{_i = 0}, {_i <= _numberOfPosition}, {_i = _i + 1}] do
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