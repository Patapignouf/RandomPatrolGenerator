params [["_baseParam", []]];
disableSerialization;

//Create GUI
createDialog "unlockedManagementGUI";
//_baseParam is unused
["onLoad",(findDisplay 60000), _baseParam] execVM 'GUI\unlockedManagementGUI\loadunlockedManagementGUI.sqf';