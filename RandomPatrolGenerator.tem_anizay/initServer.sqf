//Start the mission
missionNamespace setVariable ["revealedObjectives", [], true];
missionNamespace setVariable ["MissionObjectives", [], true];
missionNamespace setVariable ["maxCivKilled", 10, true];
missionNamespace setVariable ["civKilled", 0, true];

//Blufor vehcile spawn counter
missionNamespace setVariable ["bluforAdvancedVehicleAvalaibleSpawn", 2, true];
missionNamespace setVariable ["bluforVehicleAvalaibleSpawn", 10, true];

[] execVM 'start.sqf'; 
