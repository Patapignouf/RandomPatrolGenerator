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