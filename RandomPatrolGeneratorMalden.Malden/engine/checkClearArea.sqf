params ["_thisTrigger"];

//Count independent and blufor player
_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
while {sleep 15; _nbBluePlayer + _nbIndPlayer == 0 || _nbOpfor > 2} do 
{
	_nbBluePlayer = count ((allPlayers select {alive _x && side _x == blufor} ) inAreaArray _thisTrigger);
	_nbIndPlayer = count ((allPlayers select {alive _x && side _x == independent} ) inAreaArray _thisTrigger);
	_nbOpfor = count ((allUnits select {alive _x && side _x == opfor} ) inAreaArray _thisTrigger);
};
_thisObjectiveToComplete = _thisTrigger getVariable "associatedTask";
[_thisObjectiveToComplete] execVM 'engine\completeObjective.sqf'; 

//Manage Completed Objective
_completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
_completedObjectives pushBack _thisObjectiveToComplete;
missionNamespace setVariable ["completedObjectives",_completedObjectives,true];	