//How to use it :
//[[], 'GUI\scoreBoardGUI\displayScoreBoard.sqf'] remoteExec ['BIS_fnc_execVM', player];

params ["_categories", "_dataToDisplay"];


disableSerialization;
// Create the display
_thisDisplay = findDisplay 46 createDisplay "RscDisplayEmpty";

// Create the Background
_scoreboardBackground = _thisDisplay ctrlCreate ["RscText", -1];
_scoreboardBackground ctrlSetPosition [-0.5, -0.2, 2, 2];
_scoreboardBackground ctrlSetBackgroundColor [0, 0, 0, 1];
_scoreboardBackground ctrlCommit 0;


// Create the scoreboard
_scoreboardList = _thisDisplay ctrlCreate ["RscListNBox", -1];
_scoreboardList ctrlSetPosition [-0.5, -0.2, 2, 2];
_scoreboardList ctrlSetFont "RobotoCondensedLight";
_scoreboardList ctrlCommit 0;

//Clear table
{
	_scoreboardList lnbDeleteColumn 0;
} foreach (lnbGetColumnsPosition _scoreboardList);

//Populate table with columns
_minSpace = 0;
{
	_scoreboardList lnbAddColumn _minSpace;
	_minSpace = _minSpace + 0.08;
} foreach _categories;

_title = [_categories];
_scoreboardData = _title;

// Example data (replace this with your actual data)
_scoreboardData = _scoreboardData + _dataToDisplay;

// Populate the list with example data
{
    _currentRow = _scoreboardList lnbAddRow _x;
	_currentScoreIndex = _foreachIndex;
} forEach _scoreboardData;

//color the title 
{
	//_scoreboardList lnbSetColor [[0, _foreachIndex],[0, 0, 0, 1]];
} foreach _categories;

//Select title row
_scoreboardList   lnbSetCurSelRow 0;

_scoreboardList ctrlCommit 0;

/////////////////////////WIP////////////////
// Function to update the scoreboard
// scoreboardUpdate = {
// 	params ["_scoreboardList","_scoreboardData"];
//     lnbClear _scoreboardList;
//     {
//         _scoreboardList lnbAddRow _x;
//     } forEach _scoreboardData;
// };

// // Call the scoreboard update function periodically
// scoreboardUpdater = {
// 	params ["_scoreboardList","_scoreboardData"];
//     // while {true} do {
//     //     sleep 1; // Update interval in seconds
//     //     [_scoreboardList,_scoreboardData] call scoreboardUpdate;
//     // };
// };

// // Start the scoreboard updater
// _spawn = [_scoreboardList,_scoreboardData] spawn scoreboardUpdater;
