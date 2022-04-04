waitUntil {!isNull player};
player setUnitLoadout (player getVariable "spawnLoadout");
["Terminate"] call BIS_fnc_EGSpectator;
//#####