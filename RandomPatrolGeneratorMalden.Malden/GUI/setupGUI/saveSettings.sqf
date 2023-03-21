//Define global faction variable 
profileNamespace setVariable ["RPG_warEra", warEra]; // GUI generation mission boolean flag
profileNamespace setVariable ["RPG_bluforFaction", bluforFaction]; //Default faction 14 -> OTAN 2035
profileNamespace setVariable ["RPG_opforFaction", opforFaction]; //Default faction 3 -> Syndikat
profileNamespace setVariable ["RPG_independentFaction", independentFaction]; //Default faction 3 -> Syndikat
profileNamespace setVariable ["RPG_civilianFaction", civilianFaction]; //Default faction 3 -> Syndikat


//Missions vehicle settings
profileNamespace setVariable ["RPG_enableArmedAicraft", enableArmedAicraft]; //Default armed aircraft are disabled
profileNamespace setVariable ["RPG_enableArmoredVehicle", enableArmoredVehicle]; //Default armored vehicle are disabled

//Mission configuration
profileNamespace setVariable ["RPG_enableCampaignMode", enableCampaignMode]; //Default armored vehicle are disabled
profileNamespace setVariable ["RPG_missionLength", missionLength]; //Default armored vehicle are disabled
profileNamespace setVariable ["RPG_missionDifficultyParam", missionDifficultyParam]; //Default armored vehicle are disabled
profileNamespace setVariable ["RPG_ironMan", ironMan]; //Default disable ironman mode
profileNamespace setVariable ["RPG_startIntel", startIntel]; //Default disable ironman mode
profileNamespace setVariable ["RPG_missionIASkill", missionIASkill]; //Default disable ironman mode

//Mission objectives
profileNamespace setVariable ["RPG_avalaibleTypeOfObj", avalaibleTypeOfObj]; //Default disable ironman mode
saveProfileNamespace;