player hideObjectGlobal true;
player setPos [0,0,10000];

waitUntil {!isNull player};

player setUnitLoadout (player getVariable "spawnLoadout");
player allowdamage false;
player enableSimulationGlobal false;
setPlayerRespawnTime missionRespawnParam;

//Setup respawn GUI
[[], 'GUI\respawnGUI\initPlayerRespawnMenu.sqf'] remoteExec ['BIS_fnc_execVM', player];

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
