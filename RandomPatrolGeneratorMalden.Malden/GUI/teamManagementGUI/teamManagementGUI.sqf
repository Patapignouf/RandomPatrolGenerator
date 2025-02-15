params ["_caller"];
disableSerialization;

//Create GUI
createDialog "teamManagement";
["onLoad", (findDisplay 70000), _caller] execVM 'GUI\teamManagementGUI\teamManagement.sqf';