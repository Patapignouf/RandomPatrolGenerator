waitUntil {!isNull player};
player setUnitLoadout (player getVariable "spawnLoadout");
["Terminate"] call BIS_fnc_EGSpectator;

//Hide HUD group to debug the UI after death
showHUD [
  true, // scriptedHUD
  true, // info
  true, // radar
  true, // compass
  true, // direction
  true, // menu
  false, // group
  true, // cursors
  true, // panels
  false, // kills
  false  // showIcon3D
];
//#####