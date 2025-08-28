params ["_baseParam"];
disableSerialization;

//Create GUI
createDialog "weaponShopGUI";
//_baseParam is unused
["onLoad",(findDisplay 60000), _baseParam] execVM 'GUI\weaponShopGUI\loadWeaponsShopGUI.sqf';