c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack ["_Russian_Winter", 16, "Russian Winter [CUP]", true, true, true];	
};

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Russian
civilian_group_Russian_Winter = ["CUP_C_R_Rocker_03", 
"CUP_C_R_Villager_01", 
"CUP_C_R_Woodlander_02"];

civilian_big_group_Russian_Winter = ["CUP_C_R_Assistant_01", 
"CUP_C_R_Bully_02", 
"CUP_C_R_Bully_03", 
"CUP_C_R_Citizen_04", 
"CUP_C_R_Worker_05", 
"CUP_C_R_Rescuer_01", 
"CUP_C_R_Policeman_01" ];

civilianTruck_Russian_Winter = ["C_Truck_02_transport_F"];

//////////////////////////////  
///Define enemy group data////
//////////////////////////////
//Russian Ratnik_Winter
baseEnemyGroup_Russian_Winter  = ["CUP_O_RU_Soldier_SL_Ratnik_Winter", 
"CUP_O_RU_Soldier_Ratnik_Winter",
"CUP_O_RU_Soldier_GL_Ratnik_Winter",
"CUP_O_RU_Soldier_AR_Ratnik_Winter",
"CUP_O_RU_Soldier_Medic_Ratnik_Winter",
"CUP_O_RU_Soldier_AT_Ratnik_Winter",
"CUP_O_RU_Soldier_Marksman_Ratnik_Winter",
"CUP_O_RU_Soldier_MG_Ratnik_Winter",
"CUP_O_RU_Soldier_A_Ratnik_Winter"];

baseEnemyATGroup_Russian_Winter  = ["CUP_O_RU_Soldier_SL_Ratnik_Winter", 
"CUP_O_RU_Soldier_Ratnik_Winter", 
"CUP_O_RU_Soldier_HAT_Ratnik_Winter",
"CUP_O_RU_Soldier_AT_Ratnik_Winter"];

baseEnemyDemoGroup_Russian_Winter  = ["CUP_O_RU_Recon_TL_Ratnik_Winter",
"CUP_O_RU_Recon_Medic_Ratnik_Winter", 
"CUP_O_RU_Recon_LAT_Ratnik_Winter", 
"CUP_O_RU_Recon_Marksman_Ratnik_Winter",
"CUP_O_RU_Recon_Exp_Ratnik_Winter"];

baseEnemyMortarGroup_Russian_Winter  = ["CUP_O_2b14_82mm_RU_M_BeigeDigital",
"CUP_O_RU_Soldier_SL_Ratnik_Winter", 
"CUP_O_RU_Soldier_Ratnik_Winter"];

baseEnemyVehicleGroup_Russian_Winter  = [ 
"CUP_O_UAZ_MG_RU", 
"CUP_O_UAZ_Open_RU"];

baseEnemyLightArmoredVehicleGroup_Russian_Winter = [
"CUP_O_GAZ_Vodnik_Unarmed_RU",
"CUP_O_GAZ_Vodnik_KPVT_RU",
"CUP_O_Ural_ZU23_RU",
"CUP_O_MTLB_pk_Winter_RU"];

baseEnemyHeavyArmoredVehicleGroup_Russian_Winter = [
"CUP_O_BTR60_Winter_RU", 
"CUP_O_BTR80_WINTER_RU"];


baseEnemyUnarmedChopperGroup_Russian_Winter = [
	"CUP_O_Mi8AMT_RU"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_Russian_Winter = [
	"CUP_O_Su25_Dyn_RU", 
	"CUP_O_SU34_RU"
];

////////////////////////
//Vehicle management////
////////////////////////
//Russian
bluforUnarmedVehicle_Russian_Winter = ["CUP_O_UAZ_Unarmed_RU", 
"CUP_O_GAZ_Vodnik_Unarmed_RU"];

bluforArmedVehicle_Russian_Winter = ["CUP_O_GAZ_Vodnik_PK_RU", 
"CUP_O_UAZ_MG_RU"];

bluforUnarmedVehicleChopper_Russian_Winter = ["CUP_O_Mi8AMT_RU"];


bluforDrone_Russian_Winter = ["CUP_O_Pchela1T_RU"
];

bluforBoat_Russian_Winter = ["CUP_O_PBX_RU"
];

////////////////////////
//Loadout management////
////////////////////////

//Russian
loadout_Russian_Winter = [		
	[c_leader,"CUP_O_RU_Soldier_TL_Ratnik_Summer"],
	[c_at,"CUP_O_RU_Soldier_HAT_Ratnik_Summer" ],
	[c_rifleman,"CUP_O_RU_Soldier_Ratnik_Summer"],//Default stuff
	[c_engineer,"CUP_O_RU_Soldier_Engineer_Ratnik_Summer"],
	[c_autorifleman,"CUP_O_RU_Soldier_MG_Ratnik_Summer"],
	[c_marksman,"CUP_O_RU_Soldier_Marksman_Ratnik_Summer"],
	[c_medic,"CUP_O_RU_Soldier_Medic_Ratnik_Summer"]
];


//Sample stuff
////////////////////////
///Weapon management////
////////////////////////
//Russian
rifleList_Russian_Winter = [		
	"CUP_arifle_AK12_black_1P87"
];	

launcherList_Russian_Winter = [		
	"CUP_launch_Metis"
];

autorifleList_Russian_Winter = [			
	"CUP_arifle_RPK74M_1p78",
	"CUP_lmg_Pecheneg_PScope"
];	


marksmanrifleList_Russian_Winter = [		
	"CUP_srifle_SVD_pso",
	"CUP_srifle_VSSVintorez_pso",
	"CUP_arifle_AS_VAL_VFG_pso_open"
];

smgList_Russian_Winter = [		
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_Russian_Winter	= [
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

attachmentLongList_Russian_Winter	= [
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
itemList_Russian_Winter = [
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
	"ACE_microDAGR",
	"ACE_SpraypaintRed",
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

itemEngineerList_Russian_Winter = [
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
	
itemMedicList_Russian_Winter = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
	];