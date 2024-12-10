 booleanSelection = [false, true];

warEraSelection = [
	[0,"2nd War"],
	[1,"Cold War"],
	[2,"Modern Warfare"],
	[3,"Current Warfare"],
	[4,"Future Warfare"]
];

missionLengthSelection = [
	[1,"Short (1 objective)"], //Begin at 1
	[2,"Medium (2 objectives)"],
	[3,"Long (3 objectives)"],
	[4,"Very long (4 objectives)"]
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
	[60,"Respawn every minute"],
	[180,"Respawn every 3 minutes"],
	[300,"Respawn every 5 minutes"],
	[600,"Respawn every 10 minutes"],
	[1200,"Respawn every 20 minutes"],
	[1800,"Respawn every 30 minutes"],
	[99999999999999,"Respawn on objective completion only"]
];

missionAreaSizeParam = 
[
	[	
		[0, "Small"],
		[1, "Normal"],
		[2, "Huge"]
	],
	"Mission area size",
	0,
	"missionAreaSize"
];


civiliansOnObjectivesParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Enable civilian population on objectives",
	1,
	"enableCiviliansOnObjectives"
];

enableObjectiveExactLocationParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Objective exact location markers",
	0,
	"enableObjectiveExactLocation"
];

enableRegularIncomeParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Enable regular income (when credits under 500)",
	1,
	"enableRegularIncome"
];

sideRelationParam =
[
	[	
		[0, "Blufor friend with Independent against Opfor"],
		[1, "Blufor against Independent against Opfor"],
		[2, "Blufor against Independent and Opfor"]
	],
	"Determines side relations",
	0,
	"sideRelations"
];

enablePersistentParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Enable Persistent Mode (No fail on death)",
	0,
	"enablePersistent"
];


endlessMissionParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Restart after mission end",
	0,
	"endlessMission"
];


disableZoomParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Temp Zoom (hold right clic)",
	0,
	"disableZoom"
];




enableAutoDifficultyBalanceParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Enable Automatic difficulty balance",
	1,
	"enableAutoDifficultyBalance"
];


enableLoadoutRestrictionParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Enable loadout restriction",
	1,
	"enableLoadoutRestriction"
];

enableHaloParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Enable HALO JUMP",
	1,
	"enableHalo"
];

timeOfDayParam = 
[
	[	
		[0, "Random"],
		[1, "Morning"],
		[2, "Day"],
		[3, "Afternoon"],
		[4, "Night"]
	],
	"Choose time of day",
	2,
	"timeOfDay"
];


civJoinableFactionParam = 
[
	[	
		[0, "Nobody can recruit civilian"],
		[1, "Only indepedent can recruit civilian"],
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
		[1, "Active suicide bomber"]
		
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

enableOpforVehicleParam = 
[
	[	
		[0, "None"],
		[1, "Medium"],
		[2, "Too many"]
	],
	"Number Opfor vehicle",
	1,
	"enableOpforVehicle"
];

enableOpforMortarParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Opfor mortar",
	1,
	"enableOpforMortar"
];

enableReAirDropAdvFOBParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Aidrop Adv FOB after disassembly",
	0,
	"enableReAirDropAdvFOB"
];

randomizeObjectiveOrderParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Randomize objective order",
	1,
	"randomizeObjectiveOrder"
];

xpDisplayParam = 
[
	[	
		[0, "Disable"],
		[1, "Enable"]
	],
	"Experience real time display",
	0,
	"xpDisplay"
];

opforReinforcementParam = 
[
	[	
		[0, "Few"],
		[1, "Normal"],
		[2, "Often"]
	],
	"Opfor Reinforcement frequency",
	1,
	"opforReinforcement"
];


baseParamsToManage = [missionAreaSizeParam, civiliansOnObjectivesParam, sideRelationParam, enableObjectiveExactLocationParam, enablePersistentParam, enableRegularIncomeParam, disableZoomParam, enableAutoDifficultyBalanceParam, civJoinableFactionParam, enableLoadoutRestrictionParam, enableOpforVehicleParam, enableHaloParam, timeOfDayParam, civSuicideBomberParam, civSuicideBomberProbabilityParam, endlessMissionParam, enableOpforMortarParam, enableReAirDropAdvFOBParam, randomizeObjectiveOrderParam, xpDisplayParam, opforReinforcementParam];