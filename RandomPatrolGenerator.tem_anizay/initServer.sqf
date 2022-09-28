//Start the mission
missionNamespace setVariable ["revealedObjectives", [], true];
missionNamespace setVariable ["MissionObjectives", [], true];
missionNamespace setVariable ["maxCivKilled", 10, true];
missionNamespace setVariable ["civKilled", 0, true];

[] execVM 'start.sqf'; 
