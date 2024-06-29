params ["_isHaloJumpAuthorized"];
disableSerialization;

//Create GUI
createDialog "supportGUI";
["onLoad",(findDisplay 60000), _isHaloJumpAuthorized] execVM 'GUI\supportGUI\loadSupportGUI.sqf';