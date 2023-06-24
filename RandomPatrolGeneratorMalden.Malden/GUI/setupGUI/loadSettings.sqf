//Define global faction variable 
warEra_loaded = profileNamespace getVariable ["RPG_warEra", 3]; // GUI generation mission boolean flag
bluforFaction_loaded = profileNamespace getVariable ["RPG_bluforFaction", 14]; //Default faction 14 -> OTAN 2035
opforFaction_loaded = profileNamespace getVariable ["RPG_opforFaction", 21]; //Default faction 3 -> Syndikat
independentFaction_loaded = profileNamespace getVariable ["RPG_independentFaction", 21]; //Default faction 3 -> Syndikat
civilianFaction_loaded = profileNamespace getVariable ["RPG_civilianFaction", 21]; //Default faction 3 -> Syndikat


//Missions vehicle settings
enableArmedAicraft_loaded = profileNamespace getVariable ["RPG_enableArmedAicraft", false]; //Default armed aircraft are disabled
enableArmoredVehicle_loaded = profileNamespace getVariable ["RPG_enableArmoredVehicle", false]; //Default armored vehicle are disabled

//Mission configuration
enableCampaignMode_loaded = profileNamespace getVariable ["RPG_enableCampaignMode", false]; //Default armored vehicle are disabled
missionLength_loaded = profileNamespace getVariable ["RPG_missionLength", 2]; //Default armored vehicle are disabled
missionDifficultyParam_loaded = profileNamespace getVariable ["RPG_missionDifficultyParam", 1]; //Default armored vehicle are disabled
ironMan_loaded = profileNamespace getVariable ["RPG_ironMan", false]; //Default disable ironman mode
startIntel_loaded = profileNamespace getVariable ["RPG_startIntel", 1]; //Default disable ironman mode
missionIASkill_loaded = profileNamespace getVariable ["RPG_missionIASkill", 1]; //Default disable ironman mode
missionRespawnParam_loaded = profileNamespace getVariable ["RPG_missionRespawnParam", 99999999999999]; //Default disable ironman mode

//Mission objectives
avalaibleTypeOfObj_loaded = profileNamespace getVariable ["RPG_avalaibleTypeOfObj", []]; //Default disable ironman mode
