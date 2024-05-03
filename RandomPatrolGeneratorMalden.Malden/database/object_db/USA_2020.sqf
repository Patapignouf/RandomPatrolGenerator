#include "..\classConstant.sqf"

//Add specific RHS factions
if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	factionInfos pushBack ["_USA_2020", 41,"2020 USA [RHS]", true, true, false];
};

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_USA_2020 = [
	"rhsusf_army_ocp_arb_teamleader", 
	"rhsusf_army_ocp_arb_squadleader", 
	"rhsusf_army_ocp_arb_marksman", 
	"rhsusf_army_ocp_arb_rifleman", 
	"rhsusf_army_ocp_arb_engineer", 
	"rhsusf_army_ocp_arb_medic", 
	"rhsusf_army_ocp_arb_maaws", 
	"rhsusf_army_ocp_rifleman_arb_m16"
];

baseEnemyATGroup_USA_2020 = [
	"rhsusf_army_ocp_arb_squadleader",
	"rhsusf_army_ocp_aa", 
	"rhsusf_army_ocp_arb_riflemanat", 
	"rhsusf_army_ocp_arb_riflemanat",
	"rhsusf_army_ocp_arb_medic", 
	"rhsusf_army_ocp_arb_maaws"
];

baseEnemyDemoGroup_USA_2020 = [
	"rhsusf_army_ocp_arb_teamleader", 
	"rhsusf_army_ocp_arb_rifleman_m590", 
	"rhsusf_army_ocp_arb_grenadier", 
	"rhsusf_army_ocp_arb_engineer",
	"rhsusf_army_ocp_arb_engineer",
	"rhsusf_army_ocp_uav"
];

baseEnemyMortarGroup_USA_2020 = [
	"RHS_M252_D", 
	"rhsusf_army_ocp_arb_marksman", 
	"rhsusf_army_ocp_arb_autorifleman", 
	"rhsusf_army_ocp_rifleman"
];

baseEnemyVehicleGroup_USA_2020 = [
	"rhsusf_m1025_d_m2", 
	"rhsusf_m1025_d", 
	"rhsusf_m1151_m240_v1_usarmy_d"
];

baseEnemyLightArmoredVehicleGroup_USA_2020 = [
	"rhsusf_M1220_M153_M2_usarmy_d", 
	"rhsusf_M1220_M2_usarmy_d", 
	"rhsusf_m1240a1_m2_usarmy_d", 
	"rhsusf_m113d_usarmy_supply"
];

baseEnemyHeavyArmoredVehicleGroup_USA_2020 = [
	"RHS_M2A2", 
	"RHS_M6", 
	"rhsusf_m1a1aimd_usarmy", 
	"rhsusf_m1a2sep1d_usarmy"
];

baseEnemyUnarmedChopperGroup_USA_2020 = [
	"RHS_MELB_MH6M",
	"RHS_UH60M2",
	"RHS_CH_47F_10"
];

baseEnemyArmedChopperGroup_USA_2020 = [
	"RHS_AH64D", 
	"RHS_AH64DGrey"
];

baseFixedWingGroup_USA_2020 = [
	"RHS_A10",
	"rhsusf_f22"
];


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_USA_2020 = [
	"rhsusf_m1151_usarmy_d", 
	"rhsusf_m998_d_2dr_fulltop",
	"rhsusf_M1078A1P2_B_D_flatbed_fmtv_usarmy", 
	"rhsusf_M977A4_BKIT_usarmy_d"
];

bluforArmedVehicle_USA_2020 = [
	"rhsusf_m1025_d_m2", 
	"rhsusf_m1151_m2crows_usarmy_d", 
	"rhsusf_m1151_m240_v1_usarmy_d", 
	"rhsusf_m1151_m240_v2_usarmy_d"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_USA_2020 = [
	"RHS_M2A3", 
	"RHS_M2A2", 
	"RHS_M6", 
	"rhsusf_m1a1aimd_usarmy",
	"rhsusf_M1117_D", 
	"rhsusf_M1220_M153_M2_usarmy_d", 
	"rhsusf_M1232_M2_usarmy_d", 
	"rhsusf_m1240a1_m2_uik_usarmy_d",
	"rhsusf_m113d_usarmy_M240"
];

bluforUnarmedVehicleChopper_USA_2020 = [
	"RHS_UH60M2_d"
];

bluforArmedChopper_USA_2020 = [
	"RHS_AH64D", 
	"RHS_CH_47F_10", 
	"RHS_UH60M_d"
];

bluforDrone_USA_2020 = [

];

bluforBoat_USA_2020 = [
	"rhsusf_mkvsoc"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_USA_2020 = [
	"RHS_A10",
	"RHS_C130J"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_USA_2020 = [
	"rhsusf_M1078A1P2_B_M2_D_fmtv_usarmy", 
	"rhsusf_M977A4_BKIT_M2_usarmy_d", 
	"rhsusf_m113d_usarmy_M240", 
	"rhsusf_stryker_m1126_m2_d"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_USA_2020 = [		
	[c_leader, "rhsusf_army_ocp_teamleader"],
	[c_at, "rhsusf_army_ocp_javelin"],
	[c_rifleman, "rhsusf_army_ocp_rifleman"],//Default stuff
	[c_engineer,"rhsusf_army_ocp_engineer"],
	[c_autorifleman, "rhsusf_army_ocp_machinegunner"],
	[c_marksman, "rhsusf_army_ocp_marksman"],
	[c_sniper,"rhsusf_army_ocp_sniper"],
	[c_medic,"rhsusf_army_ocp_medic"],
	[c_grenadier, "rhsusf_army_ocp_grenadier"],
	[c_drone,"rhsusf_army_ocp_uav"],
	[c_pilot,"rhsusf_army_ocp_ah64_pilot"]
];


////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_USA_2020 = [		
	//M4A1
	"rhs_weap_m4a1_mstock_grip3",
	"rhs_weap_m4a1_mstock",
	"rhs_weap_m4a1_blockII_KAC_bk",
	"rhs_weap_m4a1_blockII",
	"rhs_weap_m4a1_blockII_bk",
	"rhs_weap_m4a1_carryhandle",
	"rhs_weap_m4_grip3",

	//misc
	"rhs_weap_m14ebrri",
	"rhs_weap_m16a4",
	"rhs_weap_m16a4_imod",
	"rhs_weap_m16a4_carryhandle",
	
	//Pistols
	"rhsusf_weap_glock17g4",
	"rhsusf_weap_m9"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_USA_2020 = [		
	"rhs_weap_m4a1_blockII_M203",
	"rhs_weap_m4a1_m203",
	"rhs_weap_m4a1_m203s",
	"rhs_m4_m203",
	"rhs_weap_m32",
	"rhs_weap_M320"
];


launcherList_USA_2020 = [		
	"rhs_weap_M136_hedp",
	"rhs_weap_fgm148",
	"rhs_weap_fim92",
	"rhs_weap_smaw",
	"rhs_weap_maaws"
];	

autorifleList_USA_2020 = [			
	"rhs_weap_m249_light_L",
	"rhs_weap_m249_pip",
	"rhs_weap_m249",
	"rhs_weap_m249_S",
	"rhs_weap_m249_light_S",
	"rhs_weap_m249_pip_S",
	"rhs_weap_m240B"
];	

marksmanrifleList_USA_2020 = [		
	"rhs_weap_mk17_LB",
	"rhs_weap_M107",
	"rhs_weap_m24sws",
	"rhs_weap_m40a5_d",
	"rhs_weap_m14_socom_rail",
	"rhs_weap_XM2010",
	"rhs_weap_XM2010_d",
	"srifle_LRR_F",
	"rhs_weap_sr25",
	"rhs_weap_sr25_ec"
];


smgList_USA_2020 = [		
	"rhsusf_weap_MP7A2_folded",
	"rhsusf_weap_MP7A2",
	"rhs_weap_M590_5RD",
	"rhs_weap_M590_8RD"
];


//////////////////////////
attachmentShortList_USA_2020	= [
	"rhsusf_acc_anpeq15",
	"rhsusf_acc_anpeq15_wmx",
	"rhsusf_acc_eotech_xps3",
	"rhsusf_acc_ACOG_USMC",
	"rhsusf_acc_SF3P556",
	"rhsusf_acc_anpeq15_top",
	"rhsusf_acc_g33_xps3_tan",
	"rhsusf_acc_anpeq15_wmx_sc",
	"rhsusf_acc_ACOG3",
	"rhsusf_acc_ACOG2",
	"rhsusf_acc_ACOG",
	"rhsusf_acc_eotech_552_d",
	"rhsusf_acc_eotech_552",
	"rhsusf_acc_ELCAN",
	"rhsusf_acc_compm4",
	"rhsusf_acc_M2A1",
	"rhsusf_acc_mrds",
	"rhsusf_acc_anpeq15side",
	"rhsusf_acc_kac_grip",
	"rhsusf_acc_T1_low",
	"rhsusf_acc_T1_high",

	//Launcher optics
	"rhs_weap_optic_smaw",
	"rhs_optic_maaws"
];

attachmentLongList_USA_2020	= [
	"rhsusf_acc_M8541_mrds",
	"rhsusf_acc_anpeq15side",
	"rhsusf_acc_premier",
	"rhsusf_acc_LEUPOLDMK4",
	"rhsusf_acc_premier_mrds",
	"rhsusf_acc_LEUPOLDMK4_2",
	"rhsusf_acc_harris_bipod"
];

////////////////////////
////Items management////
////////////////////////
itemList_USA_2020 = [
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

itemEngineerList_USA_2020 = [

];
	
itemMedicList_USA_2020 = [

];

//backpack avalaible for all unit
backPackList_USA_2020 = [
	"B_rhsusf_B_BACKPACK",
	"rhsusf_falconii",
	"rhsusf_falconii_mc",
	"rhsusf_assault_eagleaiii_ocp",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_USA_2020 = [
	"rhs_uniform_acu_oefcp",
	"rhsusf_ach_helmet_ocp",
	"rhsusf_ach_helmet_camo_ocp",
	"rhsusf_ach_helmet_headset_ess_ocp",
	"rhsusf_ach_helmet_headset_ocp",
	"rhsusf_ach_helmet_ESS_ocp",
	"rhsusf_ach_bare_des",
	"rhsusf_iotv_ocp_Rifleman",
	"rhsusf_iotv_ocp_Medic",
	"rhsusf_iotv_ocp_Repair",
	"rhsusf_iotv_ocp_Grenadier",

	//Plateframe
	"rhsusf_plateframe_light",
	"rhsusf_plateframe_machinegunner",
	"rhsusf_plateframe_marksman",
	"rhsusf_plateframe_medic",
	"rhsusf_plateframe_rifleman",
	"rhsusf_plateframe_teamleader"
];


//Magazine avalaible for all unit
magazineList_USA_2020 = 	[
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Pull",
	"rhsusf_mag_40Rnd_46x30_FMJ"
];


