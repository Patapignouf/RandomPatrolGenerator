c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";
c_drone = "UAV opérator";
c_pilot = "pilot";

//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack ["_ColdWar_USSR", 28, "Cold War USSR [CUP]", false, true, false];
};


//////////////////////////
/// OPFOR ONLY FOR NOW////
//////////////////////////


//////////////////////////////
////Define civ group data/////
//////////////////////////////

//USSR
civilian_group_ColdWar_USSR = [
	
];

civilian_big_group_ColdWar_USSR = [
	
];

civilianTruck_ColdWar_USSR = [
	
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USSR
baseEnemyGroup_ColdWar_USSR = [
	"CUP_B_CDF_Officer_FST", 
	"CUP_B_CDF_Soldier_MG_FST", 
	"CUP_B_CDF_Soldier_MG_FST",
	"CUP_B_CDF_Soldier_LAT_FST", 
	"CUP_B_CDF_Soldier_GL_FST", 
	"CUP_B_CDF_Soldier_FST",
	"CUP_B_CDF_Medic_FST",
	"CUP_B_CDF_Medic_FST"
];

baseEnemyATGroup_ColdWar_USSR = [
	"CUP_B_CDF_Officer_FST", 
	"CUP_B_CDF_Soldier_LAT_FST", 
	"CUP_B_CDF_Soldier_LAT_FST",
	"CUP_B_CDF_Soldier_AR_FST"
];

baseEnemyDemoGroup_ColdWar_USSR = [
	"CUP_B_CDF_Engineer_FST", 
	"CUP_B_CDF_Soldier_GL_FST", 
	"CUP_B_CDF_Soldier_RPG18_FST", 
	"CUP_B_CDF_Soldier_LAT_FST", 
	"CUP_B_CDF_Soldier_AA_FST"
];

baseEnemyMortarGroup_ColdWar_USSR = [
	"CUP_B_2b14_82mm_CDF",
	"CUP_B_CDF_Sniper_FST",
	"CUP_B_CDF_Sniper_FST",
	"CUP_B_CDF_Spotter_FST"
];

baseEnemyVehicleGroup_ColdWar_USSR = [
	"CUP_B_Ural_ZU23_CDF", 
	"CUP_B_UAZ_MG_CDF", 
	"CUP_B_UAZ_AGS30_CDF", 
	"CUP_B_UAZ_Unarmed_CDF", 
	"CUP_B_Ural_Open_CDF"
];

baseEnemyLightArmoredVehicleGroup_ColdWar_USSR = [
	"CUP_B_BMP2_CDF", 
	"CUP_B_BRDM2_CDF", 
	"CUP_B_MTLB_pk_CDF"
];

baseEnemyHeavyArmoredVehicleGroup_ColdWar_USSR = [
	"CUP_B_ZSU23_CDF", 
	"CUP_B_BMP_HQ_CDF", 
	"CUP_B_T72_CDF",
	"CUP_B_BM21_CDF" //Not armored but very high value
];

baseEnemyUnarmedChopperGroup_ColdWar_USSR = [
	"CUP_B_MI6T_CDF", 
	"CUP_B_Mi17_CDF", 
	"CUP_B_Mi24_D_Dynamic_CDF"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_ColdWar_USSR = [
	"CUP_B_Su25_Dyn_CDF", 
	"CUP_B_SU34_CDF"
];


////////////////////////
//Vehicle management////
////////////////////////
//USSR
bluforUnarmedVehicle_ColdWar_USSR = [

];

bluforArmedVehicle_ColdWar_USSR = [

];

bluforUnarmedVehicleChopper_ColdWar_USSR = [

];

bluforArmedChopper_ColdWar_USSR = [

];

bluforDrone_ColdWar_USSR = [

];

bluforBoat_ColdWar_USSR = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_ColdWar_USSR = [

];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_ColdWar_USSR = [

];


bluforArmoredVehicle_ColdWar_USSR = [

];


////////////////////////
//Loadout management////
////////////////////////


//USSR
loadout_ColdWar_USSR = [		
	[c_leader, [["CUP_arifle_M16A2","","","",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_roll_gloves_M81_US",[]],["CUP_V_I_RACS_Carrier_Rig_wdl_3",[["FirstAidKit",2],["CUP_15Rnd_9x19_M9",2,15],["CUP_30Rnd_556x45_Stanag",5,30],["CUP_HandGrenade_M67",1,1]]],["CUP_B_USMC_MOLLE_WDL",[]],"CUP_H_PASGTv2_NVG_WDL_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_at, [["CUP_arifle_M16A2","","","",["CUP_30Rnd_556x45_Stanag",30],[],""],["CUP_launch_M72A6_Loaded","","","",["CUP_M72A6_M",1],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_roll_gloves_M81_US",[]],["CUP_V_I_RACS_Carrier_Rig_wdl_3",[["FirstAidKit",2],["CUP_15Rnd_9x19_M9",2,15],["CUP_30Rnd_556x45_Stanag",5,30],["CUP_HandGrenade_M67",1,1]]],["CUP_B_USMC_MOLLE_WDL",[]],"CUP_H_PASGTv2_NVG_WDL_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_rifleman,[["CUP_arifle_M16A2","","","",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_roll_gloves_M81_US",[]],["CUP_V_I_RACS_Carrier_Rig_wdl_3",[["FirstAidKit",2],["CUP_15Rnd_9x19_M9",2,15],["CUP_30Rnd_556x45_Stanag",5,30],["CUP_HandGrenade_M67",1,1]]],["CUP_B_USMC_MOLLE_WDL",[]],"CUP_H_PASGTv2_NVG_WDL_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],//Default stuff
	[c_engineer,[["CUP_arifle_M16A2","","","",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_roll_gloves_M81_US",[]],["CUP_V_I_RACS_Carrier_Rig_wdl_3",[["FirstAidKit",2],["CUP_15Rnd_9x19_M9",2,15],["CUP_30Rnd_556x45_Stanag",5,30],["CUP_HandGrenade_M67",1,1]]],["CUP_B_USMC_MOLLE_WDL",[["MineDetector",1],["ToolKit",1]]],"CUP_H_PASGTv2_NVG_WDL_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_autorifleman, [["CUP_lmg_M60","","","",["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",100],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_roll_gloves_M81_US",[]],["CUP_V_I_RACS_Carrier_Rig_wdl_3",[["FirstAidKit",2],["CUP_15Rnd_9x19_M9",2,15],["CUP_HandGrenade_M67",1,1],["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",1,100]]],["CUP_B_USMC_MOLLE_WDL",[["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",5,100]]],"CUP_H_PASGTv2_NVG_WDL_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_marksman,[["CUP_srifle_M21","","","CUP_optic_artel_m14",["CUP_20Rnd_762x51_DMR",20],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_roll_gloves_M81_US",[["CUP_20Rnd_762x51_DMR",2,20]]],["CUP_V_I_RACS_Carrier_Rig_wdl_3",[["FirstAidKit",2],["CUP_15Rnd_9x19_M9",2,15],["CUP_HandGrenade_M67",1,1],["CUP_20Rnd_762x51_DMR",1,20],["20Rnd_762x51_Mag",3,20]]],["CUP_B_USMC_MOLLE_WDL",[]],"CUP_H_PASGTv2_NVG_WDL_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_medic,[["CUP_arifle_M16A2","","","",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_roll_gloves_M81_US",[]],["CUP_V_I_RACS_Carrier_Rig_wdl_3",[["FirstAidKit",2],["CUP_15Rnd_9x19_M9",2,15],["CUP_30Rnd_556x45_Stanag",5,30],["CUP_HandGrenade_M67",1,1]]],["CUP_B_USMC_MOLLE_WDL",[["Medikit",1],["FirstAidKit",5]]],"CUP_H_PASGTv2_NVG_WDL_GG","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_grenadier, [["CUP_glaunch_6G30","","","",["CUP_6Rnd_HE_GP25_M",6],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_roll_gloves_M81_US",[["CUP_6Rnd_HE_GP25_M",1,6]]],["CUP_V_I_RACS_Carrier_Rig_wdl_3",[["FirstAidKit",2],["CUP_15Rnd_9x19_M9",2,15],["CUP_HandGrenade_M67",1,1],["CUP_6Rnd_HE_GP25_M",2,6]]],["CUP_B_USMC_MOLLE_WDL",[["CUP_6Rnd_HE_GP25_M",6,6],["CUP_1Rnd_HE_GP25_M",22,1],["CUP_IlumFlareWhite_GP25_M",3,1],["CUP_IlumFlareGreen_GP25_M",3,1],["CUP_IlumFlareRed_GP25_M",2,1],["CUP_1Rnd_SMOKE_GP25_M",2,1],["CUP_1Rnd_SmokeRed_GP25_M",2,1]]],"CUP_H_PASGTv2_NVG_WDL_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]] ],//Default stuff
	[c_pilot,[[],[],[],["CUP_U_B_USArmy_PilotOverall",[["FirstAidKit",1]]],["CUP_V_B_USArmy_PilotVest",[]],[],"CUP_H_SPH4_grey","",[],["","","","","",""]]]
];

////////////////////////
///Weapon management////
////////////////////////
//USSR
rifleList_ColdWar_USSR = [		

];	


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_ColdWar_USSR = [		

];

launcherList_ColdWar_USSR = [		

];	

autorifleList_ColdWar_USSR = [			

];	

marksmanrifleList_ColdWar_USSR = [		

];

smgList_ColdWar_USSR = [		

];



//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_ColdWar_USSR	= [

];

attachmentLongList_ColdWar_USSR	= [

];

////////////////////////
////Items management////
////////////////////////
itemList_ColdWar_USSR = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"B_UavTerminal",
	"ItemGPS",
	"Binocular",
	"Rangefinder",
	"ACE_MapTools",
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
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard"
	];

itemEngineerList_ColdWar_USSR = [
	"Medikit",
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", 
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_Clacker",
	"ACE_M26_Clacker",
	"ace_marker_flags_white",
	"ace_marker_flags_yellow",
	"ace_marker_flags_purple",
	"ace_marker_flags_orange",
	"ace_marker_flags_red"
];
	
itemMedicList_ColdWar_USSR = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];


//backpack avalaible for all unit
backPackList_ColdWar_USSR = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"TFAR_rt1523g"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_ColdWar_USSR = [

	];

//Magazine avalaible for all unit
magazineList_ColdWar_USSR = 	[
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow"
];