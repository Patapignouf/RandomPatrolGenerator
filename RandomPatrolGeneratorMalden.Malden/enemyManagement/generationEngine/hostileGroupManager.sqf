generateOpforInBiggestBuildings = {
	params ["_center", "_maxRangeFromCenter", "_opforGroup"];
	_avalaibleFreePos = _center;
	_thisDifficulty = missionNamespace getVariable "missionDifficultyParam"; //Default medium


	//Find the biggest building
	_allBuildings = (nearestTerrainObjects [_center, ["house"], _maxRangeFromCenter, false, true]);

	if (count _allBuildings > 0) then 
	{
		_allPositionsAndBuilding = []; //[buildingID, numberOfAvalaiblePlaces]
		_alreadyHostileBuildings = missionNameSpace getVariable ["hostileBuildinds", []];
		_allBuildings = _allBuildings - _alreadyHostileBuildings;
		_allBuildings apply {_allPositionsAndBuilding append [[_x, count (_x buildingPos -1)]]};
		_sortedBuildingsByPos = [_allPositionsAndBuilding, [], {_x#1}, "DESCEND"] call BIS_fnc_sortBy;

		//Get maximum avalaible pos 
		diag_log format ["_sortedBuildingsByPos %1", _sortedBuildingsByPos];
		_maxPosKnown = _sortedBuildingsByPos#0#1;

		//Filter existing building to keep only the max 
		_allBuildingAtMax = _sortedBuildingsByPos select { _x#1 == _maxPosKnown};
		_buildingToKeep = selectRandom _allBuildingAtMax;
		_alreadyHostileBuildings append _buildingToKeep;
		missionNameSpace setVariable ["hostileBuildinds", _alreadyHostileBuildings];

		//Populate buildings
		_listOfAllavalaiblePos = _buildingToKeep#0 buildingPos -1;

		//Find hostage location
		_avalaibleFreePos = selectRandom _listOfAllavalaiblePos;
		_listOfAllavalaiblePos = _listOfAllavalaiblePos - [_avalaibleFreePos];

		//Find all other buildings arround 
		_allBuildingsAround = (nearestTerrainObjects [getPos (_buildingToKeep#0), ["house"], _maxRangeFromCenter, false, true]);
		_allBuildingsAround = [_allBuildingsAround, [], {(getPos _x) distance (getPos (_buildingToKeep#0))}, "ASCEND"] call BIS_fnc_sortBy;
		_allBuildingsAround = _allBuildingsAround - [_buildingToKeep#0];
		_allBuildingsAround apply {_listOfAllavalaiblePos append (_x buildingPos -1)};

		//Spawn enemies
		_group = [];
		for [{_i = 0}, {_i < ((_thisDifficulty)*2)+1}, {_i = _i + 1}] do 
		{
			_spawnedGroup = ([selectRandom _opforGroup, _center, opfor, "Infantry"] call doGenerateEnemyGroup);
			(units _spawnedGroup) apply {_group pushBack _x};
		};

		{
			_currentUnit = _x;
			//Disable LAMBS IA behaviour
			if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
			{
				_currentUnit setVariable ["lambs_danger_disableAI", true];
			};

			//Remove grenade that can kill hostage
			_throwableItems = (magazines _currentUnit) select {_x call BIS_fnc_isThrowable;};
			{
   				_currentUnit removeMagazines _x;
			} foreach _throwableItems;

			//If there is avalaible places
			if (count _listOfAllavalaiblePos >0) then 
			{	
				//teleport in building
				_x setPos _listOfAllavalaiblePos#0;
				_listOfAllavalaiblePos = _listOfAllavalaiblePos - [_listOfAllavalaiblePos#0];

				//Set defensive behaviour
				_x disableAI "PATH";
				_x setUnitPos selectRandom ["UP","UP","MIDDLE"];

				//50% to give an EH which enable movement for IA
				if (random 100 >50) then 
				{
					_x addEventHandler["Fired",
					{
						params ["_unit"];
						_unit enableAI "PATH";
						_unit dofollow leader _unit;
						_unit setUnitPos "AUTO";
						_unit removeEventHandler ["Fired",_thisEventHandler];
					}];
				};
			};

		} foreach _group;
	};

	diag_log format ["_avalaibleFreePos %1", _avalaibleFreePos];
	_avalaibleFreePos;
};


