c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";

//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack ["_Taki",0,"Takistani [CUP]", true, true, true];
};

///////////////////////////
/////Civilian Management///
///////////////////////////

//Taki
civilian_group_taki = [
	"CUP_C_TK_Man_06_Coat", 
	"CUP_C_TK_Man_05_Coat", 
	"CUP_C_TK_Man_08",
	"CUP_C_TK_Man_03_Jack"
];

civilian_big_group_taki = [
	"CUP_C_TK_Man_06_Coat", 
	"CUP_C_TK_Man_05_Coat", 
	"CUP_C_TK_Man_08", 
	"CUP_C_TK_Man_04", 
	"CUP_C_TK_Man_03_Jack", 
	"CUP_C_TK_Man_02"
];

civilianTruck_taki = [
	"CUP_C_Lada_TK_CIV", 
	"CUP_C_V3S_Open_TKC", 
	"CUP_C_LR_Transport_CTK", 
	"CUP_C_S1203_CIV", 
	"CUP_C_Volha_Limo_TKCIV", 
	"CUP_C_Ural_Civ_01"
];



//////////////////////////////
///Define enemy group data////
//////////////////////////////
//Taki
baseEnemyGroup_taki = ["CUP_O_TK_INS_Soldier_TL", 
"CUP_O_TK_INS_Soldier_MG", 
"CUP_O_TK_INS_Soldier_GL", 
"CUP_O_TK_INS_Soldier_AT",  
"CUP_O_TK_INS_Soldier", 
"CUP_O_TK_INS_Soldier_AR", 
"CUP_O_TK_INS_Sniper", 
"CUP_O_TK_INS_Soldier_Enfield", 
"CUP_O_TK_INS_Soldier_FNFAL"];

baseEnemyATGroup_taki = ["CUP_O_TK_INS_Soldier_TL", 
"CUP_O_TK_INS_Soldier_AT", 
"CUP_O_TK_INS_Soldier_AT",
"CUP_O_TK_INS_Soldier_AT",
"CUP_O_TK_INS_Soldier"];

baseEnemyDemoGroup_taki = ["CUP_O_TK_INS_Mechanic", 
"CUP_O_TK_INS_Mechanic",
"CUP_O_TK_INS_Bomber",
"CUP_O_TK_INS_Bomber"];

baseEnemyMortarGroup_taki = ["CUP_O_TK_INS_Mechanic", 
"CUP_O_2b14_82mm_TK_INS",
"CUP_O_TK_INS_Bomber"];

baseEnemyVehicleGroup_taki = ["CUP_O_LR_Transport_TKM", 
"CUP_O_Hilux_zu23_TK_INS", 
"CUP_O_Hilux_AGS30_TK_INS", 
"CUP_O_LR_SPG9_TKM", 
"CUP_O_LR_MG_TKM", 
"CUP_O_Hilux_podnos_TK_INS", 
"CUP_O_Hilux_MLRS_TK_INS", 
"CUP_O_Hilux_igla_TK_INS", 
"CUP_O_Hilux_DSHKM_TK_INS"];

baseEnemyLightArmoredVehicleGroup_taki = ["CUP_O_Ural_ZU23_TKM", 
"CUP_O_BTR40_MG_TKM","CUP_O_Hilux_armored_DSHKM_TK_INS"];

baseEnemyHeavyArmoredVehicleGroup_taki = ["CUP_O_MTLB_pk_TK_MILITIA"];

////////////////////////
//Vehicle management////
////////////////////////
//Takistani
bluforUnarmedVehicle_Taki = [
	"CUP_O_LR_Transport_TKM",
	"CUP_O_Hilux_unarmed_TK_INS"
];

bluforArmedVehicle_Taki = [
	"CUP_O_LR_MG_TKM"
];

bluforArmoredVehicle_Taki = [
	"CUP_O_MTLB_pk_TK_MILITIA",
	"CUP_O_BTR40_MG_TKM"
];

bluforUnarmedVehicleChopper_Taki = [];

bluforDrone_Taki = [];

bluforBoat_Taki = [];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_Taki = [
	"CUP_O_BTR40_TKM"
];
////////////////////////
//Loadout management////
////////////////////////


//Takistani
loadout_Taki = [		
	[c_leader,"CUP_O_TK_INS_Soldier_TL"],
	[c_at,"CUP_O_TK_INS_Soldier_AT"],
	[c_rifleman,"CUP_O_TK_INS_Soldier"],//Default stuff
	[c_engineer,"CUP_O_TK_INS_Mechanic"],
	[c_autorifleman,"CUP_O_TK_INS_Soldier_MG"],
	[c_marksman,"CUP_O_TK_INS_Sniper"],
	[c_medic,"CUP_O_TK_INS_Guerilla_Medic"],
	[c_grenadier,"CUP_O_TK_INS_Soldier_GL"]
];


//Sample loadout

////////////////////////
///Weapon management////
////////////////////////
//Takistani
rifleList_Taki = [		
	"CUP_arifle_AK74",
	"CUP_arifle_AKM",
	"CUP_arifle_FNFAL",
	"CUP_arifle_AKM_Early",
	"CUP_arifle_AKMS",
	"CUP_arifle_AKMS_Early",
	"CUP_arifle_AKS74U",
	"CUP_arifle_AK47",
	"CUP_arifle_AK47_Early",
	"CUP_arifle_AKS",
	"CUP_arifle_AK74_Early",
	"CUP_arifle_AKS74",
	"CUP_srifle_LeeEnfield"
];	


grenadeLauncherList_Taki = [
	"CUP_arifle_AKM_GL",
	"CUP_arifle_AKM_GL_Early",
	"CUP_arifle_AKMS_GL",
	"CUP_arifle_AKMS_GL_Early",
	"CUP_arifle_AK47_GL",
	"CUP_arifle_AK47_GL_Early",
	"CUP_arifle_AK74_GL",
	"CUP_arifle_AK74_GL_Early",
	"CUP_arifle_AKS74_GL"
];


launcherList_Taki = [		
	"CUP_launch_RPG7V",
	"CUP_launch_RPG7V_PGO7V"
];	

autorifleList_Taki = [			
	"CUP_lmg_PKM"
];	


marksmanrifleList_Taki = [		
	"CUP_arifle_AKS74_pso",
	"CUP_srifle_SVD_pso",
	"CUP_srifle_SVD"
];

smgList_Taki = [		
	"CUP_hgun_Makarov"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_Taki	= [

];

attachmentLongList_Taki	= [
	"CUP_optic_PSO_1"
];


////////////////////////
////Items management////
////////////////////////
itemList_Taki = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"Binocular",
	"Rangefinder",
	"ACE_MapTools",
	"ACE_CableTie",
	"ACE_DAGR",
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
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed"
	];

itemEngineerList_Taki = [
	"ToolKit",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch",
	"ACE_DefusalKit",
	"ACE_Clacker",
	"ACE_M26_Clacker",
	"ace_marker_flags_white",
	"ace_marker_flags_yellow",
	"ace_marker_flags_purple",
	"ace_marker_flags_orange",
	"ace_marker_flags_red"
	];
	
itemMedicList_Taki = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_morphine",
	"ACE_splint",
	"ACE_tourniquet",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture",
	"ACE_bodyBag"
	];



//Uniform, vest, headgear, avalaible for all unit
uniformList_Taki = [
	"CUP_O_TKI_Khet_Partug_01",
	"CUP_H_TKI_Lungee_01",
	"CUP_V_OI_TKI_Jacket2_03",
	"CUP_FR_NeckScarf",
	"CUP_O_TKI_Khet_Partug_02",
	"CUP_V_OI_TKI_Jacket2_02",
	"CUP_V_OI_TKI_Jacket2_01",
	"CUP_O_TKI_Khet_Partug_06",
	"CUP_FR_NeckScarf4",
	"CUP_O_TKI_Khet_Partug_08",
	"CUP_FR_NeckScarf3",
	"CUP_FR_NeckScarf5",
	"CUP_O_TKI_Khet_Partug_05"
];




backPackList_Taki = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"CUP_B_TK_AssaultPack_Medic",
	"CUP_B_AlicePack_Khaki",
	"CUP_B_AlicePack_Bedroll"
];


//Magazine avalaible for all unit
magazineList_Taki = [
	"CUP_HandGrenade_M67",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"CUP_8Rnd_9x18_Makarov_M",
	"CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M",
	"CUP_30Rnd_762x39_AK47_M",
	"CUP_1Rnd_HE_GP25_M",
	"CUP_FlareWhite_GP25_M",
	"CUP_1Rnd_SMOKE_GP25_M",
	"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Red_M",
	"CUP_30Rnd_TE1_Red_Tracer_545x39_AK74_plum_M",
	"CUP_10x_303_M",
	"CUP_PG7V_M",
	"CUP_PG7VM_M",
	"CUP_PG7VL_M",
	"CUP_TBG7V_M",
	"CUP_OG7_M",
	"CUP_20Rnd_762x51_FNFAL_M",
	"CUP_10Rnd_762x54_SVD_M"
];
