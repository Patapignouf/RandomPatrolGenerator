c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

///////////////////////////
/////Civilian Management///
///////////////////////////

//Taki
civilian_group_taki = ["CUP_C_TK_Man_06_Coat", 
"CUP_C_TK_Man_05_Coat", 
"CUP_C_TK_Man_08"];

civilian_big_group_taki = ["CUP_C_TK_Man_06_Coat", 
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
bluforUnarmedVehicle_Taki = ["CUP_O_LR_Transport_TKM","CUP_O_Hilux_unarmed_TK_INS"];

bluforArmedVehicle_Taki = ["CUP_O_LR_MG_TKM"];

bluforUnarmedVehicleChopper_Taki = [];


bluforDrone_Taki = [];

bluforBoat_Taki = [];

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
	[c_medic,"CUP_O_TK_INS_Guerilla_Medic"]
];


//Sample loadout
// [["CUP_arifle_AK74_GL","","","",["CUP_30Rnd_545x39_AK_M",30],["CUP_1Rnd_HE_GP25_M",1],""],[],[],["CUP_O_TKI_Khet_Partug_01",[["FirstAidKit",1],["CUP_30Rnd_545x39_AK_M",3,30],["SmokeShell",1,1]]],["CUP_V_OI_TKI_Jacket1_03",[["SmokeShellBlue",1,1],["CUP_1Rnd_HE_GP25_M",3,1]]],[],"","CUP_FR_NeckScarf3",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["CUP_arifle_AKS74_pso","","","CUP_optic_PSO_1_AK",["CUP_30Rnd_545x39_AK_M",30],[],""],[],[],["CUP_O_TKI_Khet_Partug_04",[["FirstAidKit",1],["CUP_30Rnd_545x39_AK_M",3,30],["SmokeShell",1,1]]],["CUP_V_OI_TKI_Jacket2_02",[["SmokeShellBlue",1,1]]],[],"","CUP_FR_NeckScarf4",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["CUP_arifle_AK74","","","",["CUP_30Rnd_545x39_AK_M",30],[],""],["CUP_launch_RPG7V","","","",["CUP_PG7VL_M",1],[],""],[],["CUP_O_TKI_Khet_Partug_02",[["FirstAidKit",1],["CUP_30Rnd_545x39_AK_M",3,30]]],["CUP_V_OI_TKI_Jacket4_03",[]],["CUP_B_TKI_Backpack_Gunner_RPG",[["CUP_PG7VL_M",1,1]]],"","CUP_FR_NeckScarf2",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["CUP_lmg_PKM","","","",["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",100],[],""],[],[],["CUP_O_TKI_Khet_Partug_05",[["FirstAidKit",1]]],["CUP_V_OI_TKI_Jacket3_01",[["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",1,100]]],["CUP_B_TKI_AlicePack_MG",[["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",2,100]]],"","CUP_FR_NeckScarf",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["CUP_srifle_LeeEnfield","","","",["CUP_10x_303_M",10],[],""],[],[],["CUP_O_TKI_Khet_Partug_06",[["FirstAidKit",1],["CUP_10x_303_M",4,10]]],["CUP_V_OI_TKI_Jacket4_01",[]],[],"","CUP_FR_NeckScarf4",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["CUP_arifle_FNFAL","","","",["CUP_20Rnd_762x51_FNFAL_M",20],[],""],[],[],["CUP_O_TKI_Khet_Partug_04",[["FirstAidKit",1],["CUP_20Rnd_762x51_FNFAL_M",2,20]]],["CUP_V_OI_TKI_Jacket3_01",[["CUP_20Rnd_762x51_FNFAL_M",1,20]]],["CUP_B_TIK_CivPack_WDL_Ammo",[["CUP_20Rnd_762x51_FNFAL_M",2,20],["CUP_10Rnd_762x54_SVD_M",2,10],["CUP_1Rnd_HEDP_M203",2,1],["CUP_HandGrenade_RGD5",2,1]]],"","CUP_FR_NeckScarf5",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]

////////////////////////
///Weapon management////
////////////////////////
//Takistani
rifleList_Taki = [		
	"CUP_arifle_AK74",
	"CUP_arifle_FNFAL"
];	

launcherList_Taki = [		
	"CUP_launch_RPG7V"
];	

autorifleList_Taki = [			
	"CUP_lmg_PKM"
];	


marksmanrifleList_Taki = [		
	"CUP_arifle_AKS74_pso",
	"CUP_srifle_LeeEnfield"
];

smgList_Taki = [		
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_Taki	= [
	"CUP_optic_AC11704_Black",
	"CUP_optic_VortexRazor_UH1_Black",		
	"CUP_optic_artel_m14",
	"CUP_optic_artel_m14_pip",
	"CUP_optic_Aimpoint_5000",
	"CUP_optic_HoloBlack",
	"CUP_optic_Eotech553_Black",		
	"CUP_optic_CompM2_Black",			
	"CUP_optic_CompM2_low",			
	"CUP_optic_CompM4",
	"CUP_optic_MicroT1",			
	"CUP_optic_MicroT1_low",			
	"CUP_optic_MARS",
	"CUP_optic_MEPRO",
	"CUP_optic_MEPRO_openx_orange",
	"CUP_optic_MEPRO_moa_clear",
	"CUP_optic_MEPRO_tri_clear",
	"CUP_optic_SUSAT",
	"CUP_optic_SUSAT_PIP",
	"CUP_optic_SUSAT_3D",
	//"CUP_optic_ACOG",  //Remove too versatile optics to test players new choice
	"CUP_optic_ACOG_PIP",
	"CUP_optic_ACOG_3D",
	"CUP_optic_ACOG2",
	"CUP_optic_ACOG2_PIP",
	"CUP_optic_ACOG2_3D",
	"CUP_optic_RCO",
	"CUP_optic_ACOG_TA01NSN_Black_PIP",
	"CUP_optic_ACOG_TA01NSN_Black_3D",
	"CUP_optic_ACOG_TA01B_Black",
	"CUP_optic_ACOG_TA01B_Black_PIP",
	"CUP_optic_ACOG_TA01B_Black_3D",
	"CUP_optic_ZDDot",
	"CUP_optic_MRad",
	"CUP_optic_TrijiconRx01_black",
	"CUP_optic_TrijiconRx01_kf_black",
	"CUP_optic_ZeissZPoint",
	"CUP_optic_HensoldtZO",
	"CUP_acc_ANPEQ_15",
	"CUP_acc_ANPEQ_15_Black",
	"CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L",
	"CUP_acc_ANPEQ_2",
	"CUP_acc_ANPEQ_2_Black_Top",
	"CUP_acc_ANPEQ_2_desert",
	"CUP_acc_ANPEQ_2_grey",
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
	"CUP_muzzle_snds_KZRZP_PK"
];

attachmentLongList_Taki	= [
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_11_4x20_PM_pip",
	"CUP_optic_SB_3_12x50_PMII",
	"CUP_optic_SB_3_12x50_PMII_PIP",
	"CUP_optic_LeupoldMk4",
	"CUP_optic_CWS",
	"CUP_optic_CWS_NV",
	"CUP_optic_CWS_NV_RDS"
];


////////////////////////
////Items management////
////////////////////////
itemList_Taki = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"Binocular",
	"Rangefinder",
	"ACE_MapTools",
	"ACE_microDAGR",
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
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item"
	];

itemEngineerList_Taki = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
	];
	
itemMedicList_Taki = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];