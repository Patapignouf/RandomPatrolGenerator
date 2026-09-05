 booleanSelection = [false, true];

warEraSelection = [
	[0,"2nd War (1944)"],
	[1,"Cold War (1970's)"],
	[2,"Modern Warfare (2000's)"],
	[3,"Current Warfare (2020's)"],
	[4,"Future Warfare (2035)"]
];

missionLengthSelection = [
	[1,"Short (1 area of operation)"], //Begin at 1
	[2,"Medium (2 areas of operation)"],
	[3,"Long (3 areas of operation)"],
	[4,"Very long (4 areas of operation)"]
];

missionDifficultySelection = [
	[1,"A few (2 players)"],
	[2,"Normal (4 players)"],
	[3,"Many (8 players)"],
	[4,"Too many (16 players)"],
	[5,"Overrun (32 players)"]
];

missionStartIntelSelection = [
	[1,"Blufor must contact civilian to take objectives"],
	[2,"Blufor has objective on spawn"]
];

missionIASkill = [
	[0,"Easy"],
	[1,"Medium"],
	[2,"Hard"],
	[3,"Very Hard"]
];

missionRespawnParamSettings = [
	[30,"Respawn every 30 seconds"],
	[60,"Respawn every minute"],
	[180,"Respawn every 3 minutes"],
	[300,"Respawn every 5 minutes"],
	[600,"Respawn every 10 minutes"],
	[1200,"Respawn every 20 minutes"],
	[1800,"Respawn every 30 minutes"],
	[99999999999999,"Respawn on objective completion only"]
];




enableModCheckerParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable mod checker",
	1,
	"enableModChecker"
];

officialPataCompanyServerParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Official PataCompany server (enable Discord and TS)",
	0,
	"officialPataCompanyServer",
	"Only for official server"
];


enableExperienceSaveParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable experience (save on profile)",
	1,
	"enableExperienceSave",
	"Disable for debug only"
];

enableSurrenderUnitParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Opfor units can surrender",
	1,
	"enableSurrenderUnit",
	"Recommended enabled"
];

enableAdvancedRespawnParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Leader can place respawn point",
	1,
	"enableAdvancedRespawn",
	"Recommended enabled"
];

enableSelfRespawnTimerParam = 
[
	[	
		[0, "Global timer (default)"],
		[1, "Self timer"]
	],
	"Respawn timer is global or by player",
	0,
	"enableSelfRespawnTimer",
	"Recommended global timer"
];



enableRTBMissionParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable RTB mission after objectives",
	1,
	"enableRTBMission"
];


typeRTBMissionParam = 
[
	[	
		[0, "Random"],
		[1, "Extract in specific area (green smoke)"],
		[2, "Leave the area (blue square)"]
	],
	"Enable RTB mission after objectives",
	0,
	"typeRTBMission",
	"Recommended random"
];


enableOverHeatParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (ACE Only) (default)"]
	],
	"Enable overheat on enemy weapon",
	1,
	"enableOverHeat"
];

missionAreaSizeParam = 
[
	[	
		[0, "Small (default)"],
		[1, "Normal"],
		[2, "Huge"]
	],
	"Mission area size",
	0,
	"missionAreaSize",
	"Recommended normal or huge"
];

enableAmbiantWarParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Ambiant War (friendly squad)",
	0,
	"enableAmbiantWar",
	"Better on war operation"
];

enableAmbiantArtilleryParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Ambiant artillery",
	0,
	"enableAmbiantArtillery",
	"Better on war operation"
];

civiliansOnObjectivesParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable civilian population on objectives",
	1,
	"enableCiviliansOnObjectives",
	"Recommended for challenge"
];

respawnOnOtherPlayersParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Enable respawn on other players",
	0,
	"respawnOnOtherPlayers",
	"Recommended disabled"
];

respawnCheatParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Enable death cheat protection",
	0,
	"respawnCheat",
	"(prevent player from respawn deco/reco)"
];

enableObjectiveExactLocationParam = 
[
	[	
		[0, "None (default)"],
		[1, "Near (WIP)"],
		[2, "Exact"]
	],
	"Objective location markers",
	0,
	"enableObjectiveExactLocation",
	"None for immersion"
];

enableRegularIncomeParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Enable regular income (when credits under 500)",
	0,
	"enableRegularIncome",
	"Recommended disabled"
];

sideRelationParam =
[
	[	
		[0, "Blufor friend with Independent against Opfor (default)"],
		[1, "Blufor against Independent against Opfor (PvP)"],
		[2, "Blufor against Independent and Opfor (PvP)"]
	],
	"Determines side relations",
	0,
	"sideRelations"
];

enablePersistentParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Enable Persistent Mode (No fail on death)",
	0,
	"enablePersistent"
];


endlessMissionParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable (WIP)"]
	],
	"Restart after mission end",
	0,
	"endlessMission",
	"Experimental"
];


disableZoomParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable (WIP)"]
	],
	"Temp Zoom (hold right clic)",
	0,
	"disableZoom",
	"Experimental"
];




enableAutoDifficultyBalanceParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable (WIP)"]
	],
	"Enable Automatic difficulty balance",
	0,
	"enableAutoDifficultyBalance",
	"Enable this option for public server"
];


enableLoadoutRestrictionParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable loadout restriction",
	1,
	"enableLoadoutRestriction",
	"Recommended enabled"
];

enableAccessoriesRestrictionParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable accessories restriction",
	1,
	"enableAccessoriesRestriction",
	"Recommended enabled"
];

enableHaloParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Enable HALO JUMP",
	0,
	"enableHalo",
	"Recommended disabled"
];

enableMassiveHaloParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable HALO JUMP with all team",
	1,
	"enableMassiveHalo",
	"Recommended enabled"
];

timeOfDayParam = 
[
	[	
		[0, "00:00"],
		[1, "01:00"],
		[2, "02:00"],
		[3, "03:00"],
		[4, "04:00"],
		[5, "05:00"],
		[6, "06:00"],
		[7, "07:00"],
		[8, "08:00"],
		[9, "09:00"],
		[10, "10:00"],
		[11, "11:00"],
		[12, "12:00 (default)"],
		[13, "13:00"],
		[14, "14:00"],
		[15, "15:00"],
		[16, "16:00"],
		[17, "17:00"],
		[18, "18:00"],
		[19, "19:00"],
		[20, "20:00"],
		[21, "21:00"],
		[22, "22:00"],
		[23, "23:00"],
		[24, "Random"]
	],
	"Choose time of day",
	12,
	"timeOfDay"
];


civJoinableFactionParam = 
[
	[	
		[0, "Nobody can recruit civilian"],
		[1, "Only indepedent can recruit civilian (default)"],
		[2, "Only blufor can recruit civilian"],
		[3, "Both independent and blufor can recruit civilian"]
	],
	"Allow player to recruit civilian",
	1,
	"civJoinableFaction"
];

civSuicideBomberParam = 
[
	[	
		[0, "Disable suicide bomber"],
		[1, "Active suicide bomber (default)"]
		
	],
	"Allowing a suicide bomber",
	1,
	"civSuicideBomber"
];


_percentages = [];
for "_i" from 1 to 100 do {
    _percentages pushBack [_i - 1, format ["%1%%", _i]];
};

civSuicideBomberProbabilityParam = 
[
	_percentages,
	"Probability of suicide bomber",
	0,
	"civSuicideBomberProbability"
];

_percentages = [];
for "_i" from 1 to 100 do {
    _percentages pushBack [_i, format ["%1 objectives needed", _i]];
};

maxObjectivesGeneratedSettingParam = 
[
	_percentages,
	"Max number of objectives generated",
	100,
	"maxObjectivesGeneratedSetting",
	"Works only on campaign mode"
];

enableOpforVehicleParam = 
[
	[	
		[0, "None"],
		[1, "Few (default)"],
		[2, "Medium"],
		[3, "Crazy"],
		[4, "Insane"]
	],
	"Number Opfor vehicle",
	1,
	"enableOpforVehicle",
	"Recommended few or medium"
];

enableOpforMortarParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Opfor mortar",
	1,
	"enableOpforMortar",
	"Disable if it's too hard"
];

enableReAirDropAdvFOBParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Aidrop Adv FOB after disassembly",
	0,
	"enableReAirDropAdvFOB"
];

randomizeObjectiveOrderParam = 
[
	[	
		[0, "Default order"],
		[1, "Random (default)"],
		[2, "Closest"]
	],
	"Randomize objective order",
	1,
	"randomizeObjectiveOrder",
	"Closest for short missions"
];

objectivePerLocationParam = 
[
	[	
		[1, "1 objective per location (default)"],
		[2, "2 objectives per location"],
		[3, "3 objectives per location"],
		[4, "4 objectives per location"],
		[5, "5 objectives per location"]
	],
	"Number Of Objective per location",
	1,
	"objectivePerLocation"
];

xpDisplayParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable (Arcade)"]
	],
	"Experience real time display",
	0,
	"xpDisplay"
];

opforReinforcementParam = 
[
	[	
		[0, "Few"],
		[1, "Normal (default)"],
		[2, "Often"]
	],
	"Opfor Reinforcement frequency",
	1,
	"opforReinforcement"
];

opforFactionRandomizerParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Change opfor faction after each mission completion",
	0,
	"opforFactionRandomizer",
	"Not recommended"
];

playerMarkerAllowedParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "BLUFOR Accurate"],
		[2, "Colored grid area"],
		[3, "BLUFOR area"]

	],
	"Players position on map",
	0,
	"playerMarkerAllowed",
	"Recommended disable"
];

playerCounterSectorControlParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Players counter on sector control",
	1,
	"playerCounterSectorControl",
	"Recommended enabled"
];

addFOBOnObjectiveParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Add enemy FOB when AO doesn't have building",
	0,
	"addFOBOnObjective",
	"Only for empty maps"
];

enableDynamicSimulationParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable dynamic simulation",
	1,
	"enableDynamicSimulationSetting",
	"Recommended enabled for perf"
];

enableBluforFOBParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable blufor FOB spawn",
	1,
	"enableBluforFOB",
	"Recommended enabled"
];

enableSoloCrewTankParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Enable solo crew tank",
	0,
	"enableSoloCrewTank",
	"Recommended for small team"
];

enableOpforWeaponShopParam = 
[
	[	
		[0, "Disable"],
		[1, "Shop always available"],
		[2, "Shop on POI (default)"]
	],
	"Enable opfor weapon shop",
	2,
	"enableOpforWeaponShop",
	"Recommended Shop On POI"
];

rewardModeParam = 
[
	[	
		[0, "Force Token"],
		[1, "Force Items"],
		[2, "Player can choose (default)"]
	],
	"Reward with token or items",
	2,
	"rewardMode"
];

enableOpforBMShopParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable black market shop",
	1,
	"enableOpforBMShop"
];

enableChallengeModParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable challenge on HQ",
	1,
	"enableChallengeMod",
	"Arcade only"
];

vehicleLockedDefaultParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"[ACE] Lock vehicle on spawn",
	0,
	"vehicleLockedDefault",
	"ACE Only"
];

enableGPSJammerOnMapParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"[ACE] GPS and Radio jammer",
	1,
	"enableGPSJammerOnMap",
	"ACE and TFAR compatibility"
];

displayGPSJammerOnMapParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Display GPS Jammer area on map",
	1,
	"displayGPSJammerOnMap",
	"ACE and TFAR compatibility"
];

fastTravelParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Fast travel",
	1,
	"fastTravel"
];

ACETryFixUnconsciousParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"[ACE] Try fix player not really unconscious",
	0,
	"ACETryFixUnconscious",
	"Not Recommended debug only"
];

allowSmallLocationsParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Allow AO on small locations (ex : hill)",
	0,
	"allowSmallLocations",
	"Not Recommended on vanilla maps"
];

addAmbientOpforLocParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Populate cities with opfor",
	1,
	"addAmbientOpforLoc"
];

WeatherSettingParam = 
[
	[	
		[0, "Clear"],
		[1, "Cloudy (no rain)"],
		[2, "Random (default)"]
	],
	"Setup mission weather",
	2,
	"WeatherSetting"
];

_numberOfCivilian = [];
for "_i" from 1 to 100 do {
    _numberOfCivilian pushBack [_i, format ["%1 civilian killed", _i]];
};

maxCivKilledParam = 
[

	_numberOfCivilian
	,
	"Maximum killed civilian before mission failed",
	5,
	"maxCivKilled"
];


warReporterOnHQParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Ability to become war reporter (VIP)",
	0,
	"warReporterOnHQ",
	"Only for event"
];

gunsOnlyParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Allow only guns (no rifle)",
	0,
	"gunsOnly",
	"Only for event"
];

hostileCivCanCallReinforcementParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Hostile civilian can call enemy reinforcement",
	1,
	"hostileCivCanCallReinforcement"
];

talkToCivParam = 
[
	[	
		[0, "Only reporter"],
		[1, "Everyone (default)"]
	],
	"People who can talk to civilians",
	1,
	"talkToCiv"
];

enableDestroyerFOBParam = 
[
	[	
		[0, "Only FOB"],
		[1, "FOB or Destroyer (default)"],
		[2, "Only Destroyer"]
	],
	"Opfor Destroyers or FOB",
	1,
	"enableDestroyerFOB",
	"Recommended FOB or Destroyer"
];

enableBotRadioParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Enable friendly radio com",
	0,
	"enableBotRadio",
	"Recommended disable on MP"
];

enableFlatBluforBaseParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Make blufor base flat",
	0,
	"enableFlatBluforBase",
	"Recommended on mountain map"
];

defenseNumberWavesParam = 
[
	[	
		[1, "1 wave"],
		[3, "3 waves (default)"],
		[5, "5 waves"],
		[7, "7 waves"],
		[10, "10 waves"],
		[20, "20 waves"],
		[50, "50 waves"]
	],
	"Defense obj nb waves",
	3,
	"defenseNumberWaves"
];

defenseTimeWavesParam = 
[
	[	
		[60, "1 minute"],
		[120, "2 minutes"],
		[180, "3 minutes"],
		[300, "5 minutes (default)"],
		[420, "7 minutes"],
		[600, "10 minutes"],
		[900, "15 minutes"],
		[1200, "20 minutes"]
	],
	"Defense obj time waves",
	300,
	"defenseTimeWaves"
];

defenseIncreaseDifficultyParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Defense obj progressive difficulty",
	0,
	"defenseIncreaseDifficulty",
	"Difficulty double every 2 waves"
];


defenseAnnounceWavesParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Defense obj announce waves",
	0,
	"defenseAnnounceWaves"
];

defenseRespawnBetweenWaveParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Defense respawn between waves",
	0,
	"defenseRespawnBetweenWave"
];

defenseRewardBetweenWaveParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Defense reward between waves",
	0,
	"defenseRewardBetweenWave"
];

forceTentFOBParam = 
[
	[	
		[0, "Disable (default)"],
		[1, "Enable"]
	],
	"Force tent as blufor FOB",
	0,
	"forceTentFOB",
	"Recommended disabled"
];

bluforVehicleAvalaibleSpawnInitParam = 
[
	[	
		[0, "0 credit"],
		[500, "500 credits (default)"],
		[1000, "1000 credits"],
		[2000, "2000 credits"],
		[5000, "5000 credits"]
	],
	"Starting credits",
	1000,
	"bluforVehicleAvalaibleSpawnInit",
	"Useful to buy support and vehicle"
];


enableCivilianOnCityParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable civilian on civ city",
	1,
	"enableCivilianOnCity",
	"Recommended enabled"
];


enableFurnitureParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Enable Phronk's Furniture",
	1,
	"enableFurniture",
	"Recommended on vanilla maps"
];

linkXPWithTokenParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable (default)"]
	],
	"Link token reward and XP",
	1,
	"linkXPWithToken",
	"Recommended enabled"
];

//Full param list (obsolete)
baseParamsToManage = [enableExperienceSaveParam, enableRTBMissionParam, typeRTBMissionParam, missionAreaSizeParam, civiliansOnObjectivesParam, sideRelationParam, enableAmbiantWarParam, enableAmbiantArtilleryParam, enableObjectiveExactLocationParam, enablePersistentParam, enableRegularIncomeParam, disableZoomParam, enableAutoDifficultyBalanceParam, civJoinableFactionParam, enableLoadoutRestrictionParam, enableAccessoriesRestrictionParam, enableOpforVehicleParam, enableSurrenderUnitParam, enableHaloParam, enableMassiveHaloParam, timeOfDayParam, civSuicideBomberParam, civSuicideBomberProbabilityParam, endlessMissionParam, enableOpforMortarParam, enableReAirDropAdvFOBParam, randomizeObjectiveOrderParam, xpDisplayParam, opforReinforcementParam, enableOverHeatParam, enableAdvancedRespawnParam, respawnOnOtherPlayersParam, enableSelfRespawnTimerParam, enableModCheckerParam, officialPataCompanyServerParam, respawnCheatParam, opforFactionRandomizerParam, playerMarkerAllowedParam, addFOBOnObjectiveParam, enableDynamicSimulationParam, maxObjectivesGeneratedSettingParam, enableBluforFOBParam, enableSoloCrewTankParam, enableOpforWeaponShopParam, enableOpforBMShopParam, enableChallengeModParam, vehicleLockedDefaultParam, enableGPSJammerOnMapParam, displayGPSJammerOnMapParam, fastTravelParam, ACETryFixUnconsciousParam, maxCivKilledParam, WeatherSettingParam, warReporterOnHQParam, gunsOnlyParam, hostileCivCanCallReinforcementParam, talkToCivParam, objectivePerLocationParam, enableDestroyerFOBParam, enableBotRadioParam, enableFlatBluforBaseParam, defenseAnnounceWavesParam, defenseIncreaseDifficultyParam, defenseNumberWavesParam, defenseTimeWavesParam, rewardModeParam, bluforVehicleAvalaibleSpawnInitParam, forceTentFOBParam, enableCivilianOnCityParam, defenseRespawnBetweenWaveParam, defenseRewardBetweenWaveParam, allowSmallLocationsParam, addAmbientOpforLocParam, enableFurnitureParam, linkXPWithTokenParam, playerCounterSectorControlParam];

//Make one list by dedicated menu
baseGameParamToManage = [enableExperienceSaveParam, linkXPWithTokenParam, sideRelationParam, enableAmbiantWarParam, enableAmbiantArtilleryParam, enablePersistentParam, enableRegularIncomeParam, disableZoomParam, enableLoadoutRestrictionParam, enableAccessoriesRestrictionParam, enableOpforWeaponShopParam, enableOpforBMShopParam, enableChallengeModParam, rewardModeParam, enableReAirDropAdvFOBParam, xpDisplayParam, enableOverHeatParam, enableAdvancedRespawnParam, enableDynamicSimulationParam, enableSelfRespawnTimerParam, officialPataCompanyServerParam, respawnOnOtherPlayersParam, enableModCheckerParam, respawnCheatParam, playerMarkerAllowedParam, playerCounterSectorControlParam, enableSoloCrewTankParam, vehicleLockedDefaultParam, enableGPSJammerOnMapParam, displayGPSJammerOnMapParam, fastTravelParam, ACETryFixUnconsciousParam, gunsOnlyParam, enableBotRadioParam];

baseOpforParamToManage = [civiliansOnObjectivesParam, enableFurnitureParam, enableAutoDifficultyBalanceParam, enableOpforVehicleParam, addAmbientOpforLocParam, enableSurrenderUnitParam, civSuicideBomberParam, civSuicideBomberProbabilityParam, enableOpforMortarParam, opforReinforcementParam, addFOBOnObjectiveParam, opforFactionRandomizerParam, hostileCivCanCallReinforcementParam, enableDestroyerFOBParam];

baseMissionParamToManage = [WeatherSettingParam, enableHaloParam, enableMassiveHaloParam, enableBluforFOBParam, enableFlatBluforBaseParam, timeOfDayParam, allowSmallLocationsParam, randomizeObjectiveOrderParam, objectivePerLocationParam, maxObjectivesGeneratedSettingParam, bluforVehicleAvalaibleSpawnInitParam, enableRTBMissionParam, typeRTBMissionParam, missionAreaSizeParam, enableObjectiveExactLocationParam, civJoinableFactionParam, endlessMissionParam, maxCivKilledParam, warReporterOnHQParam, talkToCivParam, defenseNumberWavesParam, defenseIncreaseDifficultyParam, defenseAnnounceWavesParam, defenseTimeWavesParam, defenseRespawnBetweenWaveParam, defenseRewardBetweenWaveParam, forceTentFOBParam, enableCivilianOnCityParam];