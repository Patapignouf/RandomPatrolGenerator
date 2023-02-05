params ["_thisTrigger"];

//Count independent and blufor player
_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);


//Add more opfor to the area
_baseRadius = 100;
for [{_i = 0}, {_i < missionDifficultyParam+1}, {_i = _i + 1}] do 
{
	currentRandomGroup = selectRandom EnemyWaveLevel_1;
	currentGroup = [currentRandomGroup, getPos _thisTrigger, east, "DefenseInfantry"] call doGenerateEnemyGroup;
	
	//Spawn group
	[currentGroup, currentGroup, _baseRadius, [], true, (round random 3 == 0), -2, true] call lambs_wp_fnc_taskGarrison;
	_baseRadius = _baseRadius + 20;
};

//Add more opfor to the area
while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
};

//Check tasks
_thisObjectiveToComplete = _thisTrigger getVariable ["associatedTask","none"];
if (_thisObjectiveToComplete != "none") then 
{
	[_thisObjectiveToComplete] execVM 'engine\objectiveManagement\completeObjective.sqf'; 

	//Manage Completed Objective
	_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
	_completedObjectives pushBack _thisObjectiveToComplete;
	missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	
};

//Check FOB clear
_thisFOBCheck = _thisTrigger getVariable ["isFOBAssociated",false];
if (_thisFOBCheck) then 
{
	_OpforFOBCleared = missionNamespace getVariable ["OpforFOBCleared", 0];
	missionNamespace setVariable ["OpforFOBCleared", _OpforFOBCleared+1, true];	
};
