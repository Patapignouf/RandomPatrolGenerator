//Start the mission
missionNamespace setVariable ["revealedObjectives", [], true];
missionNamespace setVariable ["MissionObjectives", [], true];
missionNamespace setVariable ["maxCivKilled", 10, true];
missionNamespace setVariable ["civKilled", 0, true];

//Blufor vehcile spawn counter
missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", 2, true];
missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", 10, true];

//Dead player base
missionNamespace setVariable ["deadPlayer", [], true];

//Factions
missionNamespace setVariable ["generationSetup", false, true]; // GUI generation mission boolean flag
missionNamespace setVariable ["bluforFaction", 14, true]; //Default faction 14 -> OTAN 2035
missionNamespace setVariable ["opforFaction", 2, true]; //Default faction 2 -> Syndikat
missionNamespace setVariable ["independentFaction", 2, true]; //Default faction 2 -> Syndikat
missionNamespace setVariable ["civilianFaction", 2, true]; //Default faction 2 -> Syndikat


//Init scenario scripts
[] execVM 'start.sqf'; 