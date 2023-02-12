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

//GUI init setup
missionNamespace setVariable ["generationSetup", false, true]; // GUI generation mission boolean flag

//Factions
missionNamespace setVariable ["warEra", 3, true]; // GUI generation mission boolean flag
missionNamespace setVariable ["bluforFaction", 14, true]; //Default faction 14 -> OTAN 2035
missionNamespace setVariable ["opforFaction", 2, true]; //Default faction 2 -> Syndikat
missionNamespace setVariable ["independentFaction", 2, true]; //Default faction 2 -> Syndikat
missionNamespace setVariable ["civilianFaction", 2, true]; //Default faction 2 -> Syndikat

//Missions vehicle settings
missionNamespace setVariable ["enableArmedAicraft", false, true]; //Default armed aircraft are disabled
missionNamespace setVariable ["enableArmoredVehicle", false, true]; //Default armored vehicle are disabled
missionNamespace setVariable ["ironMan", false, true]; //Default disable ironman mode

//Mission configuration
missionNamespace setVariable ["enableCampaignMode", false, true]; //Default armored vehicle are disabled
missionNamespace setVariable ["missionLength", 2, true]; //Default armored vehicle are disabled
missionNamespace setVariable ["missionDifficultyParam", 1, true]; //Default armored vehicle are disabled

//Blufor Initilization 
missionNamespace setVariable ["advancedBlueforLocation", [0,0], true]; //Default armored vehicle are disabled

//Init scenario scripts
[] execVM 'start.sqf'; 