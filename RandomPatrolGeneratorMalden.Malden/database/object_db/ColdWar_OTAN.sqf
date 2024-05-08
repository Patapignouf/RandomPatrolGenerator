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
	factionInfos pushBack ["_ColdWar_OTAN", 27, "Cold War OTAN [CUP]", true, false, false];
};


//////////////////////////
/// BLUFOR ONLY FOR NOW////
//////////////////////////




//////////////////////////////
////Define civ group data/////
//////////////////////////////

//USA
civilian_group_ColdWar_OTAN = [
	
];

civilian_big_group_ColdWar_OTAN = [
	
];

civilianTruck_ColdWar_OTAN = [
	
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_ColdWar_OTAN = [
	
];

baseEnemyATGroup_ColdWar_OTAN = [
	
];

baseEnemyDemoGroup_ColdWar_OTAN = [
	
];

baseEnemyMortarGroup_ColdWar_OTAN = [
	
];

baseEnemyVehicleGroup_ColdWar_OTAN = [
	
];

baseEnemyLightArmoredVehicleGroup_ColdWar_OTAN = [
	
];

baseEnemyHeavyArmoredVehicleGroup_ColdWar_OTAN = [];

baseEnemyUnarmedChopperGroup_ColdWar_OTAN = [

];

////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_ColdWar_OTAN = [
	"CUP_B_nM1025_Unarmed_USA_WDL", 
	"CUP_B_nM1025_Unarmed_DF_USA_WDL",
	"CUP_B_nM1038_4s_USA_WDL",
	"CUP_B_M1030_USA"
];

bluforArmedVehicle_ColdWar_OTAN = [
	"CUP_B_nM1025_M2_USA_WDL", 
	"CUP_B_nM1025_M240_USA_WDL", 
	"CUP_B_nM1036_TOW_DF_USA_WDL",
	"CUP_B_LR_MG_GB_W"
];

bluforUnarmedVehicleChopper_ColdWar_OTAN = [
	"CUP_B_UH60M_Unarmed_US",
	"CUP_B_SA330_Puma_HC1_BAF",
	"CUP_B_MH6M_OBS_USA", 
	"CUP_B_MH6J_USA"
];

bluforArmedChopper_ColdWar_OTAN = [
	"CUP_B_UH1D_GER_KSK_Des",
	"CUP_B_CH47F_USA", 
	"CUP_B_AH6J_USA", 
	"CUP_B_AH1Z_Dynamic_USMC"
];

bluforDrone_ColdWar_OTAN = [

];

bluforBoat_ColdWar_OTAN = [
	"CUP_B_RHIB_HIL",
	"CUP_B_Zodiac_USMC"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_ColdWar_OTAN = [
	"CUP_B_AV8B_DYN_USMC",
	"CUP_B_A10_DYN_USA"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_ColdWar_OTAN = [
	"CUP_B_M113A1_HQ_USA", 
	"CUP_B_M113A3_HQ_USA",
	"CUP_B_FV432_GB_GPMG"
];


bluforArmoredVehicle_ColdWar_OTAN = [
	"CUP_B_M1129_MC_MK19_Woodland", 
	"CUP_B_M1126_ICV_M2_Woodland", 
	"CUP_B_M7Bradley_USA_W", 
	"CUP_B_LAV25_USMC", 
	"CUP_B_M1128_MGS_Woodland", 
	"CUP_B_M113A3_USA",
	"CUP_B_M1A1SA_Woodland_US_Army",
	"CUP_B_M60A3_USMC",
	"CUP_B_Leopard2A6_GER"
];


////////////////////////
//Loadout management////
////////////////////////


//USA
loadout_ColdWar_OTAN = [		
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
//USA
rifleList_ColdWar_OTAN = [		
	"CUP_arifle_M16A2",
	"CUP_arifle_M16A1",
	"CUP_arifle_FNFAL5060",
	"CUP_arifle_G3A3_ris",
	"CUP_arifle_AUG_A1",
	"CUP_srifle_M14",
	"CUP_Famas_F1",
	"CUP_hgun_Colt1911",
	"CUP_arifle_Gewehr1"
];	


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_ColdWar_OTAN = [		
	"CUP_glaunch_6G30",
	"CUP_arifle_M16A2_GL"
];

launcherList_ColdWar_OTAN = [		
	"CUP_launch_FIM92Stinger_Loaded",
	"CUP_launch_MAAWS",
	"CUP_launch_MAAWS_Scope",
	"CUP_launch_M72A6_Loaded",
	"CUP_launch_M72A6"
];	

autorifleList_ColdWar_OTAN = [			
	"CUP_lmg_M60",
	"CUP_lmg_M60E4_norail",
	"CUP_lmg_MG3",
	"CUP_lmg_minimi"
];	

marksmanrifleList_ColdWar_OTAN = [		
	"CUP_srifle_M21",
	"CUP_srifle_M24_wdl",
	"CUP_srifle_M14_DMR",
	"CUP_srifle_AWM_wdl",
	"CUP_srifle_Remington700"
];

smgList_ColdWar_OTAN = [		
	"CUP_smg_MP5SD6",
	"CUP_smg_MP5A5",
	"CUP_smg_M3A1_blk",
	"CUP_arifle_Colt727",
	"CUP_sgun_SPAS12"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_ColdWar_OTAN	= [
	"CUP_bipod_Harris_1A2_L_BLK",
	"CUP_bipod_VLTOR_Modpod",
	"CUP_muzzle_PB6P9",
	"CUP_muzzle_Bizon",
	"CUP_muzzle_PBS4",
	"CUP_muzzle_TGPA",
	"CUP_muzzle_snds_KZRZP_Base",
	"CUP_muzzle_snds_KZRZP_SVD",
	"CUP_muzzle_snds_KZRZP_AK762",
	"CUP_muzzle_snds_KZRZP_AK545",
	"CUP_muzzle_snds_KZRZP_PK",
	"CUP_optic_MAAWS_Scope"
];

attachmentLongList_ColdWar_OTAN	= [
	"CUP_optic_artel_m14",
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_11_4x20_PM_pip",
	"CUP_optic_SB_3_12x50_PMII",
	"CUP_optic_SB_3_12x50_PMII_PIP",
	"CUP_optic_LeupoldMk4",
	"CUP_optic_CWS",
	"CUP_optic_CWS_NV",
	"CUP_optic_CWS_NV_RDS",
	"CUP_U_CRYE_G3C_MC_US",
	"CUP_V_CPC_tlbelt_mc",
	"CUP_B_USArmy_MG_SpecOp",
	"CUP_H_OpsCore_Tan_SF",
	"CUP_optic_Remington"
];

////////////////////////
////Items management////
////////////////////////
itemList_ColdWar_OTAN = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"ItemGPS",
	"Binocular",
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
	"ACE_RangeCard",
	"CUP_NVG_PVS7_Hide",
	"CUP_NVG_PVS7"
	];

itemEngineerList_ColdWar_OTAN = [
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
	
itemMedicList_ColdWar_OTAN = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];


//backpack avalaible for all unit
backPackList_ColdWar_OTAN = [
	"CUP_B_USMC_MOLLE_WDL",
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"TFAR_rt1523g",
	"B_FieldPack_oli"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_ColdWar_OTAN = [
	//Woodland
	"CUP_H_PASGTv2_WDL",
	"CUP_H_PASGTv2_NVG_WDL_CF",
	"CUP_H_PASGTv2_NVG_WDL_GG_CB",
	"CUP_V_I_RACS_Carrier_Rig_wdl_3",
	"CUP_U_B_BDUv2_roll_gloves_M81_US",
	"V_TacVest_camo",
	"CUP_V_B_PASGT",
	"CUP_V_B_PASGT_no_bags",
	"CUP_U_B_BDUv2_gloves_dirty_M81_US",
	"CUP_U_B_BDUv2_dirty_M81_US",
	"CUP_U_B_BDUv2_M81_US",

	//Desert
	"CUP_H_Ger_M92_Tan_GG_CF",
	"CUP_V_I_RACS_Carrier_Rig_3",
	"CUP_U_B_BDUv2_roll_gloves_DCU_US",
	"CUP_U_B_BDUv2_dirty_DCU_US",
	"CUP_U_B_BDUv2_roll_gloves_dirty_DCU_US"
	];

//Magazine avalaible for all unit
magazineList_ColdWar_OTAN = 	[
	"30Rnd_556x45_Stanag_Tracer_Green",
	"ACE_2Rnd_12Gauge_Pellets_No0_Buck",
	"CUP_8Rnd_12Gauge_Pellets_No0_Buck",
	"CUP_1Rnd_12Gauge_Pellets_No00_Buck",
	"CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",
	"CUP_200Rnd_TE4_Red_Tracer_556x45_M249",
	"CUP_20Rnd_762x51_DMR",
	"CUP_30Rnd_9x19_MP5",
	"20Rnd_762x51_Mag",
	"CUP_25Rnd_556x45_Famas",
	"CUP_5Rnd_86x70_L115A1",
	"CUP_120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",
	"CUP_7Rnd_45ACP_1911",
	"CUP_6Rnd_762x51_R700",
	"CUP_30Rnd_45ACP_M3A1_BLK_M",
	"CUP_Stinger_M",
	"CUP_MAAWS_HEAT_M",
	"MRAWS_HEAT_F",
	"CUP_MAAWS_HEDP_M",
	"MRAWS_HEAT55_F",
	"CUP_20Rnd_556x45_Stanag",
	"CUP_20Rnd_762x51_FNFAL_M",
	"CUP_30Rnd_556x45_G36",
	"CUP_20Rnd_762x51_G3",
	"CUP_30Rnd_556x45_AUG",
	"CUP_15Rnd_9x19_M9",
	"CUP_IlumFlareRed_GP25_M",
	"CUP_IlumFlareWhite_GP25_M",
	"CUP_1Rnd_HE_GP25_M",
	"CUP_1Rnd_SMOKE_GP25_M",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell",
	"UGL_FlareWhite_F",
	"UGL_FlareGreen_F",
	"UGL_FlareRed_F",
	"UGL_FlareCIR_F"
];