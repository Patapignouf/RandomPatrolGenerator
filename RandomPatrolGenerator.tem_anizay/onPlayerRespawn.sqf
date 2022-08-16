waitUntil {!isNull player};
player setUnitLoadout (player getVariable "spawnLoadout");

if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
  [false] call ace_spectator_fnc_setSpectator;
} else 
{
  ["Terminate"] call BIS_fnc_EGSpectator;
};


//Respawn on side spawn position location
player setPos (((side player) call BIS_fnc_getRespawnPositions) select 0);

// Fix player damaged on respawn 
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
  [objNull, player] call ace_medical_treatment_fnc_fullHeal;
};


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