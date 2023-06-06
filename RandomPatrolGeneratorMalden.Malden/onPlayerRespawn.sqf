player hideObjectGlobal true;
player setPos [0,0,10000];

diag_log format ["Player %1 is dead", name player];

waitUntil {!isNull player};

player setUnitLoadout (player getVariable "spawnLoadout");
player allowdamage false;
player enableSimulationGlobal false;

//Respawn on side spawn position location
// player setPos (((side player) call BIS_fnc_getRespawnPositions) select 0);

// Fix player damaged on respawn 
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
  [objNull, player] call ace_medical_treatment_fnc_fullHeal;
} else 
{
  player setDamage 0;
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

// if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
// 	[player, false] call TFAR_fnc_forceSpectator;
// };
