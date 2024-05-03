#include "..\classConstant.sqf"

if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	factionInfos pushBack ["_USA_SOCOM_2020", 38,"2020 USA SOCOM [RHS]", true, true, false];
};

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_USA_SOCOM_2020 = [
	"rhsusf_socom_marsoc_elementleader",
	"rhsusf_socom_marsoc_cso",
	"rhsusf_socom_marsoc_teamleader",
	"rhsusf_socom_marsoc_teamchief",
	"rhsusf_socom_marsoc_cso_breacher",
	"rhsusf_socom_marsoc_cso_mechanic",
	"rhsusf_socom_marsoc_sarc",
	"rhsusf_socom_marsoc_elementleader",
	"rhsusf_socom_marsoc_cso",
	"rhsusf_socom_marsoc_cso_breacher",
	"rhsusf_socom_marsoc_cso_mechanic",
	"rhsusf_socom_marsoc_sarc"
];

baseEnemyATGroup_USA_SOCOM_2020 = [
	"rhsusf_socom_marsoc_elementleader",
	"rhsusf_socom_marsoc_cso",
	"rhsusf_socom_marsoc_sarc",
	"rhsusf_usmc_marpat_wd_javelin",
	"rhsusf_usmc_marpat_wd_riflemanat"
];

baseEnemyDemoGroup_USA_SOCOM_2020 = [
	"rhsusf_socom_marsoc_elementleader",
	"rhsusf_socom_marsoc_cso",
	"rhsusf_socom_marsoc_cso_breacher",
	"rhsusf_socom_marsoc_cso_mechanic",
	"rhsusf_socom_marsoc_sarc"
];

baseEnemyMortarGroup_USA_SOCOM_2020 = [
	
];

baseEnemyVehicleGroup_USA_SOCOM_2020 = [
	"rhsusf_m1025_d_m2",
	"rhsusf_m1025_d"
];

baseEnemyLightArmoredVehicleGroup_USA_SOCOM_2020 = [
	"rhsusf_m1151_m2_v2_usarmy_d",
	"rhsusf_M1237_M2_usarmy_d"
];

baseEnemyHeavyArmoredVehicleGroup_USA_SOCOM_2020 = [
	"rhsusf_m1240a1_m240_uik_usarmy_d",
	"rhsusf_m113d_usarmy_unarmed",
	"rhsusf_M1230_M2_usarmy_d"
];

baseEnemyUnarmedChopperGroup_USA_SOCOM_2020 = [
	"RHS_MELB_MH6M",
	"RHS_UH60M2",
	"RHS_CH_47F_10"
];

baseEnemyArmedChopperGroup_USA_SOCOM_2020 = [
	"RHS_AH64D", 
	"RHS_AH64DGrey"
];

baseFixedWingGroup_USA_SOCOM_2020 = [
	"RHS_A10",
	"rhsusf_f22"
];


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_USA_SOCOM_2020 = [
	"rhsusf_mrzr4_d",
	"rhsusf_M1239_socom_d",
	"rhsusf_M1238A1_socom_d"
];

bluforArmedVehicle_USA_SOCOM_2020 = [
	"rhsusf_m1025_d_m2",
	"rhsusf_m1151_m2_v2_usarmy_d",
	"rhsusf_m1240a1_m240_uik_usarmy_d",
	"rhsusf_M1237_M2_usarmy_d",
	"rhsusf_m1165a1_gmv_m2_m240_socom_d",
	"rhsusf_m1165a1_gmv_m134d_m240_socom_d",
	"rhsusf_m1165a1_gmv_mk19_m240_socom_d",
	"rhsusf_M1084A1R_SOV_M2_D_fmtv_socom",
	"rhsusf_M1078A1R_SOV_M2_D_fmtv_socom"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_USA_SOCOM_2020 = [
	"RHS_M2A2"
];

bluforUnarmedVehicleChopper_USA_SOCOM_2020 = [
	"RHS_MELB_MH6M"
];

bluforArmedChopper_USA_SOCOM_2020 = [
	"RHS_MELB_AH6M"
];

bluforDrone_USA_SOCOM_2020 = [

];

bluforBoat_USA_SOCOM_2020 = [
	"rhsusf_mkvsoc"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_USA_SOCOM_2020 = [
	"RHS_A10",
	"RHS_C130J"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_USA_SOCOM_2020 = [
	"rhsusf_M1084A1R_SOV_M2_D_fmtv_socom", 
	"rhsusf_M1078A1R_SOV_M2_D_fmtv_socom"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_USA_SOCOM_2020 = [		
	[c_leader, "rhsusf_socom_marsoc_teamchief"],
	[c_at, [["rhs_weap_mk18_eotech","","rhsusf_acc_anpeq15","rhsusf_acc_eotech_xps3",["rhs_mag_30Rnd_556x45_Mk318_Stanag",30],[],""],["rhs_weap_M136_hedp","","","",[],[],""],["rhsusf_weap_glock17g4","","","",["rhsusf_mag_17Rnd_9x19_FMJ",17],[],""],["rhs_uniform_g3_m81",[["FirstAidKit",1],["rhsusf_ANPVS_15",1],["rhs_Booniehat_m81",1]]],["rhsusf_plateframe_rifleman",[["rhsusf_acc_nt4_black",1],["rhs_mag_30Rnd_556x45_Mk318_Stanag",6,30],["rhsusf_mag_17Rnd_9x19_FMJ",2,17],["rhs_mag_mk84",4,1],["rhs_mag_m67",1,1],["Chemlight_red",4,1]]],[],"rhsusf_opscore_mar_ut_pelt","rhs_googles_clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_rifleman, "rhsusf_socom_marsoc_cso_cqb"],//Default stuff
	[c_engineer,"rhsusf_socom_marsoc_cso_mechanic"],
	[c_autorifleman, [["rhs_weap_m249_light_L","","","rhsusf_acc_ACOG_USMC",["rhsusf_200Rnd_556x45_box",200],[],"rhsusf_acc_saw_bipod"],[],["rhsusf_weap_glock17g4","","","",["rhsusf_mag_17Rnd_9x19_FMJ",17],[],""],["rhs_uniform_g3_m81",[["FirstAidKit",1],["rhsusf_ANPVS_15",1],["rhs_Booniehat_m81",1]]],["rhsusf_plateframe_rifleman",[["rhsusf_acc_nt4_black",1],["rhsusf_mag_17Rnd_9x19_FMJ",2,17],["rhs_mag_mk84",4,1],["rhs_mag_m67",1,1],["Chemlight_red",4,1]]],["rhsusf_assault_eagleaiii_coy",[["rhsusf_200rnd_556x45_mixed_box",4,200]]],"rhsusf_opscore_mar_ut_pelt","rhs_googles_clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_marksman, "rhsusf_socom_marsoc_marksman"],
	[c_sniper,"rhsusf_socom_marsoc_sniper_m107"],
	[c_medic,"rhsusf_socom_marsoc_sarc"],
	[c_grenadier, "rhsusf_socom_marsoc_cso_grenadier"],
	[c_pilot,"rhsusf_airforce_pilot"]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_USA_SOCOM_2020 = [		
	//Mk18
	"rhs_weap_mk18_KAC_bk",
	"rhs_weap_mk18_KAC",
	"rhs_weap_mk18_KAC_d",
	"rhs_weap_mk18_bk",
	"rhs_weap_mk18",

	//M4A1
	"rhs_weap_m4a1_mstock_grip3",
	"rhs_weap_m4a1_mstock",
	"rhs_weap_m4a1_blockII_KAC_bk",
	"rhs_weap_m4a1_blockII_KAC",
	"rhs_weap_m4a1_blockII",
	"rhs_weap_m4a1_blockII_bk",
	"rhs_weap_m4a1_carryhandle",

	//misc
	"rhs_weap_mk17_CQC",
	"rhs_weap_m14ebrri",
	"rhs_weap_m16a4_imod",
	"rhs_weap_m16a4_carryhandle",
	
	//Pistols
	"rhsusf_weap_glock17g4"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_USA_SOCOM_2020 = [		
	"rhs_weap_m4a1_blockII_M203",
	"rhs_weap_m4a1_m203",
	"rhs_weap_m4a1_m203s",
	"rhs_weap_mk18_m320",
	"rhs_weap_m32",
	"rhs_weap_M320"
];


launcherList_USA_SOCOM_2020 = [		
	"rhs_weap_M136_hedp",
	"rhs_weap_fgm148",
	"rhs_weap_fim92",
	"rhs_weap_smaw",
	"rhs_weap_maaws"
];	

autorifleList_USA_SOCOM_2020 = [			
	"rhs_weap_m249_light_L",
	"rhs_weap_m249_pip",
	"rhs_weap_m249",
	"rhs_weap_m249_S",
	"rhs_weap_m249_light_S",
	"rhs_weap_m249_pip_S",
	"rhs_weap_m240B"
];	

marksmanrifleList_USA_SOCOM_2020 = [		
	"rhs_weap_mk17_LB",
	"rhs_weap_M107",
	"rhs_weap_m24sws",
	"rhs_weap_m40a5_d",
	"rhs_weap_m14_socom_rail",
	"rhs_weap_XM2010",
	"srifle_LRR_F",
	"rhs_weap_sr25",
	"rhs_weap_sr25_ec"
];

smgList_USA_SOCOM_2020 = [		
	"rhsusf_weap_MP7A2_folded",
	"rhsusf_weap_m9",
	"rhsusf_weap_MP7A2",
	"rhs_weap_M590_5RD",
	"rhs_weap_M590_8RD"
];

//////////////////////////
attachmentShortList_USA_SOCOM_2020	= [
	"rhsusf_acc_anpeq15",
	"rhsusf_acc_anpeq15_wmx",
	"rhsusf_acc_eotech_xps3",
	"rhsusf_acc_ACOG_USMC",
	"rhsusf_acc_su230",
	"rhsusf_acc_su230_mrds_c",
	"rhsusf_acc_SF3P556",
	"rhsusf_acc_anpeq15_top",
	"rhsusf_acc_su230a_c",
	"rhsusf_acc_g33_xps3_tan",
	"rhsusf_acc_anpeq15_wmx_sc",
	"rhsusf_acc_ACOG3",
	"rhsusf_acc_ACOG2",
	"rhsusf_acc_ACOG",
	"rhsusf_acc_eotech_552_d",
	"rhsusf_acc_eotech_552",
	"rhsusf_acc_ELCAN",
	"rhsusf_acc_compm4",
	"rhsusf_acc_su230a",
	"rhsusf_acc_M2A1",
	"rhsusf_acc_mrds",

	//Launcher optics
	"rhs_weap_optic_smaw",
	"rhs_optic_maaws"
];

attachmentLongList_USA_SOCOM_2020	= [
	"rhsusf_acc_M8541_mrds",
	"rhsusf_acc_anpeq15side",
	"rhsusf_acc_premier",
	"rhsusf_acc_LEUPOLDMK4",
	"rhsusf_acc_premier_mrds"
];

////////////////////////
////Items management////
////////////////////////
itemList_USA_SOCOM_2020 = [
	"NVGoggles",
	"Laserdesignator",
	"B_UavTerminal",
	"ItemGPS",
	"Binocular",
	"Rangefinder",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard",
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP",
	"rhsusf_ANPVS_14"
];

itemEngineerList_USA_SOCOM_2020 = [

];
	
itemMedicList_USA_SOCOM_2020 = [

];

//backpack avalaible for all unit
backPackList_USA_SOCOM_2020 = [
	"rhsusf_falconii_mc",
	"rhsusf_falconii_coy",
	"rhsusf_assault_eagleaiii_coy",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_USA_SOCOM_2020 = [
	"rhs_ess_black",
	"rhsusf_mbav",
	"rhsusf_mbav_rifleman",
	"rhsusf_mbav_light",
	"rhsusf_mbav_medic",
	"rhs_uniform_g3_m81",
	"rhsusf_mich_bare_norotos",
	"rhsusf_mich_bare_norotos_arc_alt_tan",
	"rhs_Booniehat_m81",
	"rhs_uniform_g3_mc",
	"rhsusf_shemagh_gogg_od",
	"rhsusf_mich_bare_norotos_arc_alt",
	"rhsusf_opscore_mar_ut_pelt",
	"rhsusf_opscore_fg_pelt_nsw",
	"rhsusf_shemagh_gogg_od",
	"rhsusf_shemagh2_gogg_tan",
	"rhsusf_shemagh2_od",
	"rhs_uniform_cu_ocp",
	"rhsusf_opscore_fg_pelt_cam",

	//Plateframe
	"rhsusf_plateframe_light",
	"rhsusf_plateframe_machinegunner",
	"rhsusf_plateframe_marksman",
	"rhsusf_plateframe_medic",
	"rhsusf_plateframe_rifleman",
	"rhsusf_plateframe_teamleader"
];


//Magazine avalaible for all unit
magazineList_USA_SOCOM_2020 = 	[
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Pull",
	"rhsusf_mag_40Rnd_46x30_FMJ"
];


