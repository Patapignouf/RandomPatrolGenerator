#include "..\classConstant.sqf"

//Add specific RHS factions
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	factionInfos pushBack ["_USA_2020_MA", factionID,"2020 USA Marines Corps [RHS]", true, false, false];
};

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_USA_2020_MA = [

];

baseEnemyATGroup_USA_2020_MA = [

];

baseEnemyDemoGroup_USA_2020_MA = [

];

baseEnemyMortarGroup_USA_2020_MA = [

];

baseEnemyVehicleGroup_USA_2020_MA = [

];

baseEnemyLightArmoredVehicleGroup_USA_2020_MA = [

];

baseEnemyHeavyArmoredVehicleGroup_USA_2020_MA = [

];

baseEnemyUnarmedChopperGroup_USA_2020_MA = [

];

baseEnemyArmedChopperGroup_USA_2020_MA = [

];

baseFixedWingGroup_USA_2020_MA = [

];


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_USA_2020_MA = [
	"rhsusf_m1025_d_s", 
	"rhsusf_m998_d_s_2dr",
	"rhsusf_CGRCAT1A2_usmc_d"
];

bluforArmedVehicle_USA_2020_MA = [
	"rhsusf_m1025_d_s_m2", 
	"rhsusf_m1151_m2_v3_usmc_d"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_USA_2020_MA = [
	"rhsusf_m1a1fep_d",
	"rhsusf_m1240a1_m2crows_usmc_d", 
	"rhsusf_CGRCAT1A2_M2_usmc_d"
];

bluforUnarmedVehicleChopper_USA_2020_MA = [
	"rhsusf_CH53E_USMC_D", 
	"RHS_UH1Y_UNARMED_d"
];

bluforArmedChopper_USA_2020_MA = [
	"RHS_AH1Z", 
	"RHS_UH1Y_FFAR_d"
];

bluforDrone_USA_2020_MA = [

];

bluforBoat_USA_2020_MA = [
	"rhsusf_mkvsoc"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_USA_2020_MA = [
	"RHS_A10",
	"rhsusf_f22"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_USA_2020_MA = [
	"rhsusf_M1232_MC_M2_usmc_d",
	"rhsusf_m1240a1_m240_usmc_d"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_USA_2020_MA = [		
	[c_leader, "rhsusf_usmc_recon_marpat_d_officer"],
	[c_at, "rhsusf_usmc_marpat_d_javelin"],
	[c_rifleman, "rhsusf_usmc_recon_marpat_d_rifleman_fast"],//Default stuff
	[c_engineer,"rhsusf_usmc_marpat_d_engineer"],
	[c_autorifleman, "rhsusf_usmc_recon_marpat_d_machinegunner_m249"],
	[c_marksman, "rhsusf_usmc_recon_marpat_d_marksman"],
	[c_sniper,"rhsusf_usmc_recon_marpat_d_sniper_M107"],
	[c_medic,"rhsusf_navy_sarc_d"], //Taken from Navy (No medic in USMC)
	[c_grenadier, "rhsusf_usmc_recon_marpat_d_grenadier_m32"],
	[c_drone,"rhsusf_usmc_marpat_d_uav"],
	[c_pilot,"rhsusf_usmc_marpat_d_helipilot"]
];




////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_USA_2020_MA = [		
	//M4A1
	"rhs_weap_m4",
	"rhs_weap_m4a1_mstock_grip3",
	"rhs_weap_m4a1_grip3",
	"rhs_weap_m4a1_mstock",
	"rhs_weap_m4a1_blockII_KAC_bk",
	"rhs_weap_m4a1_blockII_grip_KAC_bk",
	"rhs_weap_m4a1_blockII_grip_bk",
	"rhs_weap_m4a1_blockII_grip",
	"rhs_weap_m4a1_blockII",
	"rhs_weap_m4a1_blockII_bk",
	"rhs_weap_m4a1_carryhandle",
	"rhs_weap_m4a1_carryhandle_grip3",
	"rhs_weap_m4_grip3",

	//M16A4
	"rhs_weap_m16a4",
	"rhs_weap_m16a4_imod",
	"rhs_weap_m16a4_carryhandle",
	"rhs_weap_m16a4_grip2",
	"rhs_weap_m16a4_imod_grip2",
	"rhs_weap_m16a4_imod_grip3",
	"rhs_weap_m16a4_carryhandle_grip2",
	"rhs_weap_m16a4_carryhandle_grip3",

	//M14
	"rhs_weap_m14ebrri",
	
	//Pistols
	"rhsusf_weap_glock17g4",
	"rhsusf_weap_m9"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_USA_2020_MA = [		
	"rhs_weap_m4a1_blockII_M203",
	"rhs_weap_m4a1_m203",
	"rhs_weap_m4a1_m203s",
	"rhs_m4_m203",
	"rhs_weap_m32",
	"rhs_weap_M320"
];


launcherList_USA_2020_MA = [		
	"rhs_weap_M136_hedp",
	"rhs_weap_fgm148",
	"rhs_weap_fim92",
	"rhs_weap_smaw",
	"rhs_weap_maaws"
];	

autorifleList_USA_2020_MA = [			
	"rhs_weap_m249_light_L",
	"rhs_weap_m249_light_L_vfg3",
	"rhs_weap_m249_pip_S_para_vfg3",
	"rhs_weap_m249_S_para_vfg3",
	"rhs_weap_m249_pip_S_para",
	"rhs_weap_m249_pip",
	"rhs_weap_m249",
	"rhs_weap_m249_S",
	"rhs_weap_m249_light_S",
	"rhs_weap_m249_pip_S",
	"rhs_weap_m240B"
];	

marksmanrifleList_USA_2020_MA = [		
	"rhs_weap_mk17_LB",
	"rhs_weap_M107",
	"rhs_weap_m24sws",
	"rhs_weap_m40a5_d",
	"rhs_weap_m14_socom_rail",
	"rhs_weap_XM2010",
	"rhs_weap_XM2010_d",
	"srifle_LRR_F",
	"rhs_weap_sr25",
	"rhs_weap_sr25_ec",
	"rhs_weap_m27iar_bipod_acog_usmc_sup_tan",
	"rhs_weap_m27iar",
	"rhs_weap_m27iar_grip3"
];

smgList_USA_2020_MA = [		
	"rhsusf_weap_MP7A2_folded",
	"rhsusf_weap_MP7A2",
	"rhsusf_weap_MP7A2_grip3",
	"rhsusf_weap_MP7A2_folded_grip3",
	"rhs_weap_M590_5RD",
	"rhs_weap_M590_8RD"
];


//////////////////////////
attachmentShortList_USA_2020_MA	= [
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
	"rhsusf_acc_anpeq15A",
	"rhsusf_acc_M952V",

	//Launcher optics
	"rhs_weap_optic_smaw",
	"rhs_optic_maaws"
];

attachmentLongList_USA_2020_MA	= [
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
itemList_USA_2020_MA = [
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

itemEngineerList_USA_2020_MA = [
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_USA_2020_MA = [

];

//backpack avalaible for all unit
backPackList_USA_2020_MA = [
	"B_rhsusf_B_BACKPACK",
	"rhsusf_falconii",
	"rhsusf_falconii_mc",
	"B_Carryall_cbr",
	"rhsusf_assault_eagleaiii_ocp",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green",
	"B_parachute"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_USA_2020_MA = [
	"rhs_uniform_FROG01_d",

	//Plateframe
	"rhsusf_spc_light",
	"rhsusf_spc_iar",
	"rhsusf_spc_mg",
	"rhsusf_spc_teamleader",

	//Shemag 
	"rhsusf_shemagh_gogg_tan",
	"rhsusf_shemagh2_gogg_tan",
	"rhsusf_shemagh_gogg_od",
	"rhsusf_shemagh2_gogg_od",
	"rhsusf_oakley_goggles_blk",
	"rhsusf_oakley_goggles_clr",
	"rhs_booniehat2_marpatd",
	"rhsusf_mich_helmet_marpatd_norotos",
	"rhsusf_opscore_ut",
	"rhsusf_mich_bare_norotos_arc_tan",
	"rhsusf_lwh_helmet_marpatd_ess"
];


//Magazine avalaible for all unit
magazineList_USA_2020_MA = 	[
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Pull",
	"rhsusf_mag_40Rnd_46x30_FMJ"
];


