//basic items that will be included with all factions
//Include ACE items
basicItemsList = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"Binocular"
];

//ACE basic item
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	basicItemsList = basicItemsList +
	["ACE_MapTools",
	"ACE_SpraypaintRed",
	"ACE_CableTie",
	"ACE_WaterBottle",
	"ACE_EarPlugs",
	"ACE_fieldDressing",
	"ACE_packingBandage",
	"ACE_elasticBandage",
	"ACE_tourniquet",
	"ACE_splint",
	"ACE_morphine",
	"ACE_quikclot",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_painkillers",
	"ACE_PlottingBoard",
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_SpareBarrel",
	"ACE_Flashlight_MX991",
	"ACE_Flashlight_KSF1",
	"ACE_Flashlight_XL50"];
};


//basic medic items that will be included with all factions
//Include ACE items
basicMedicItems = [
	"Medikit"
];

//ACE Medic items
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	basicMedicItems = basicMedicItems +
	["ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture",
	"ACE_salineIV",
	"ACE_salineIV_500",
	"ACE_salineIV_250",
	"ACE_plasmaIV",
	"ACE_plasmaIV_500",
	"ACE_plasmaIV_250",
	"ACE_atropine",
	"ACE_adenosine",
	"ACE_bodyBag_blue",
	"ACE_bodyBag",
	"ACE_bodyBag_white"];
};


//basic engineer items that will be included with all factions
//Include ACE items
basicEngineerItems = [
	"ToolKit",
	"MineDetector"
];

//ACE engineering items
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	basicEngineerItems = basicEngineerItems +
	["ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_Clacker",
	"ACE_M26_Clacker",
	"ace_marker_flags_white",
	"ace_marker_flags_yellow",
	"ace_marker_flags_purple",
	"ace_marker_flags_orange",
	"ace_marker_flags_red",
	"ACE_VMH3",
	"ACE_VMM3"];

};

//Radio basic items
basicDefaultRadio = [
	"itemRadio"
];

//Add TFAR Radio
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then 
{
	basicDefaultRadio = ["TFAR_anprc152"];
};

basicAmmunitions = [
	"HandGrenade",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellRed",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellYellow",
	"O_IR_Grenade",
	"Laserbatteries"
];