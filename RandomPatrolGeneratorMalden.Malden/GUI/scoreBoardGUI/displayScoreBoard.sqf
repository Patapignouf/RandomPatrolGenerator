//How to use it :
//[[], 'GUI\scoreBoardGUI\displayScoreBoard.sqf'] remoteExec ['BIS_fnc_execVM', player];

params ["_categories", "_dataToDisplay"];


disableSerialization;
// Create the display
_thisDisplay = findDisplay 46 createDisplay "RscDisplayEmpty";

// Create the Background
_scoreboardBackground = _thisDisplay ctrlCreate ["RscText", -1];
_scoreboardBackground ctrlSetPosition [-0.5, -0.2, 2, 2];
_scoreboardBackground ctrlSetBackgroundColor [0.5, 0.5, 0.5, 1];
_scoreboardBackground ctrlCommit 0;


// Create the scoreboard
_scoreboardList = _thisDisplay ctrlCreate ["RscListNBox", -1];
_scoreboardList ctrlSetPosition [-0.5, -0.2, 2, 2];
_scoreboardList ctrlSetFont "RobotoCondensedLight";

//Clear table
{
	_scoreboardList lnbDeleteColumn 0;
} foreach (lnbGetColumnsPosition _scoreboardList);

//Populate table with columns
_minSpace = 0;
{
	_scoreboardList lnbAddColumn _minSpace;
			
	//Adjust column width with column title size
	if (_foreachIndex <3) then 
	{
		_minSpace = _minSpace + 0.08;
	} else 
	{
		_minSpace = _minSpace + (count _x)*0.006;
	};

} foreach _categories;

_title = [_categories];
_scoreboardData = _title;

// Example data (replace this with your actual data)
_scoreboardData = _scoreboardData + _dataToDisplay;

// Populate the list with example data
{
    _currentRow = _scoreboardList lnbAddRow _x;
	_currentScoreIndex = _foreachIndex;
	if (_foreachIndex == 0) then 
	{
		for "_col" from 0 to (count _categories - 1) do {
			_scoreboardList ctrlSetFont "RobotoCondensedBold";
		};
	};

	//Change style of player's row
	if (name player == _x#1) then 
	{
		for "_col" from 0 to (count _categories - 1) do {
			_scoreboardList lnbSetColor [[_currentRow, _col], [1, 0.8, 0, 1]]; 
		};
	};
} forEach _scoreboardData;

//color the title 
{
	//_scoreboardList lnbSetColor [[0, _foreachIndex],[0, 0, 0, 1]];
} foreach _categories;

//Select title row
_scoreboardList   lnbSetCurSelRow 0;

//add background
//[_scoreboardList] call doAddBackground;

_scoreboardList ctrlCommit 0;

player setVariable ["ScoreBoardDisplay", _thisDisplay];
//_thisDisplay closeDisplay 1;

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



doAddBackground = {
	/*
		Auteur : Gemini
		Description : Crée un fond noir dynamique derrière une ListNBox existante
	*/
	params ["_table"];

	private _display = ctrlParent _table; // Récupère le display parent du tableau
	private _pos = ctrlPosition _table;   // Récupère [x, y, w, h] du tableau

	// 1. Créer le background (RscText est idéal pour un aplat de couleur)
	private _background = _display ctrlCreate ["RscText", -1];

	// 2. Appliquer les mêmes coordonnées que le tableau
	_background ctrlSetPosition _pos;

	// 3. Définir la couleur en noir (RGBA : 0,0,0,1)
	_background ctrlSetBackgroundColor [0, 0, 0, 1];

	// 4. Envoyer le background en arrière-plan
	// Sans cela, il risquerait de cacher le texte du tableau
	_background ctrlCommit 0; 

	// On utilise l'ID du contrôle pour s'assurer que le tableau est dessiné après
	// (Dans Arma, le dernier contrôle créé ou modifié par ctrlCommit passe au-dessus)
	_table ctrlCommit 0; 

	// Retourne le contrôle du background au cas où tu voudrais le supprimer plus tard
	_background

};