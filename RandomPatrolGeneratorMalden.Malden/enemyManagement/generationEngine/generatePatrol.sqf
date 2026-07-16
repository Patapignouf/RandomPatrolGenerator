params ["_thisAvailableGroup", "_possiblePOILocation", "_thisDifficulty"];

//Search road around AO
possibleAmbushPosition = [];
tempPossibleAmbush = [];
currentAO = objNull;

_distance = 0;
{
	currentAO = _x;
	tempPossibleAmbush = (getPos _x) nearRoads 2000;
	{
		_distance = (getPos _x) distance (getPos currentAO);
		if (350<_distance && _distance<1000) then	//Il faudrait tester si ce n'est pas trop près des villes adjacentes
		{
			possibleAmbushPosition pushBack _x;
		};		
	}
	foreach tempPossibleAmbush;
} foreach _possiblePOILocation;

numberOfAmbush = (missionLength+1)*4;
AmbushPositions = [];
for [{_i = 0}, {_i < numberOfAmbush}, {_i = _i + 1}] do
{
	AmbushPositions pushBack (selectRandom possibleAmbushPosition);
	possibleAmbushPosition = possibleAmbushPosition - [AmbushPositions select ((count AmbushPositions)-1)];
};

currentGroupPatrol = objNull;
{
	if (round (random _thisDifficulty+1)!= _thisDifficulty) then
	{
		//Patrol generation
		_currentRandomPatrol = selectRandom _thisAvailableGroup;
		currentGroupPatrol = [_currentRandomPatrol, getPos _x, east, "Patrol"] call doGenerateEnemyGroup;
		[currentGroupPatrol, getPos (leader currentGroupPatrol), 250 + random 300] call doPatrol;
	};
} foreach AmbushPositions;