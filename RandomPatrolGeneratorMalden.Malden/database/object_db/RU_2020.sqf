#include "..\classConstant.sqf"

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_RU_2020 = [
	"rhs_vdv_sergeant",
	"rhs_vdv_efreitor",
	"rhs_vdv_arifleman",
	"rhs_vdv_machinegunner_assistant",
	"rhs_vdv_LAT",
	"rhs_vdv_grenadier",
	"rhs_msv_emr_medic",
	"rhs_msv_emr_rifleman",
	"rhs_msv_emr_rifleman"
];

baseEnemyATGroup_RU_2020 = [
	"rhs_vdv_junior_sergeant",
	"rhs_vdv_at",
	"rhs_vdv_strelok_rpg_assist",
	"rhs_vdv_LAT",
	"rhs_vdv_rifleman",
	"rhs_vdv_aa"
];

baseEnemyDemoGroup_RU_2020 = [
	"rhs_vdv_sergeant",
	"rhs_vdv_efreitor",
	"rhs_vdv_arifleman",
	"rhs_vdv_machinegunner_assistant",
	"rhs_vdv_arifleman",
	"rhs_vdv_machinegunner_assistant"
];

baseEnemyMortarGroup_RU_2020 = [
	
];

baseEnemyVehicleGroup_RU_2020 = [
	"rhs_tigr_3camo_vdv",
	"rhs_tigr_sts_3camo_vdv"
];

baseEnemyLightArmoredVehicleGroup_RU_2020 = [
	"rhs_btr60_vdv"
];

baseEnemyHeavyArmoredVehicleGroup_RU_2020 = [
	"rhs_bmd1",
	"rhs_bmp2d_vdv",
	"rhs_sprut_vdv"
];

baseEnemyUnarmedChopperGroup_RU_2020 = [
	"RHS_Mi8mt_vdv"
];

baseFixedWingGroup_RU_2020 = [
	"rhs_mig29s_vvs",
	"RHS_Su25SM_vvs",
	"RHS_T50_vvs_generic"
];


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_RU_2020 = [
	"rhs_gaz66_vdv",
	"rhs_kamaz5350_vdv",
	"RHS_Ural_Open_VDV_01",
	"rhs_tigr_vdv",
	"rhs_tigr_3camo_vdv",
	"rhs_uaz_vdv",
	"rhs_uaz_open_vdv",
	"rhs_tigr_m_vdv"
];

bluforArmedVehicle_RU_2020 = [
	"rhs_tigr_sts_3camo_vdv",
	"rhs_tigr_sts_vdv"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_RU_2020 = [
	"rhs_bmd1",
	"rhs_bmp2d_vdv",
	"rhs_sprut_vdv",
	"rhs_btr60_vdv"
];

bluforUnarmedVehicleChopper_RU_2020 = [
	"RHS_Mi8mt_vdv",
	"RHS_Mi8mt_Cargo_vdv"
];

bluforArmedChopper_RU_2020 = [
	"RHS_Ka52_vvs",
	"RHS_Mi24P_vvs",
	"RHS_Mi8AMTSh_vvs",
	"RHS_Mi24P_vdv",
	"RHS_Mi8MTV3_vdv"
];

bluforDrone_RU_2020 = [

];

bluforBoat_RU_2020 = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_RU_2020 = [
	"rhs_mig29s_vvs",
	"RHS_Su25SM_vvs",
	"RHS_T50_vvs_generic"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_RU_2020 = [

];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_RU_2020 = [		
	[c_leader, "rhs_vdv_junior_sergeant"],
	[c_at, "rhs_vdv_at"],
	[c_rifleman, "rhs_vdv_rifleman"],//Default stuff
	[c_engineer,"rhs_vdv_engineer"],
	[c_autorifleman, "rhs_vdv_machinegunner"],
	[c_marksman, "rhs_vdv_marksman_asval"],
	[c_sniper,"rhs_vdv_marksman"],
	[c_medic,"rhs_vdv_medic"],
	[c_grenadier, "rhs_vdv_grenadier"],//Default stuff
	[c_pilot,"rhs_pilot_combat_heli"]
];


////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_RU_2020 = [		
	"rhs_weap_ak74m",
	"rhs_weap_makarov_pm",
	"rhs_weap_ak74mr"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_RU_2020 = [		
	"rhs_weap_ak74m_gp25",
	"rhs_weap_ak74mr_gp25"
];


launcherList_RU_2020 = [		
	"rhs_weap_rpg26",
	"rhs_weap_rpg7"
];	

autorifleList_RU_2020 = [			
	"rhs_weap_pkm",
	"rhs_weap_pkp",
	"rhs_weap_rpk74m"
];	

marksmanrifleList_RU_2020 = [		
	"rhs_asval",
	"rhs_weap_svds",
	"rhs_weap_vss"
];

smgList_RU_2020 = [		
	"rhs_weap_aks74u",
	"rhs_weap_ak74m_folded"
];

//////////////////////////
attachmentShortList_RU_2020	= [
"rhs_acc_dtk",
"rhs_acc_pkas",
"rhs_acc_pgo7v3",
"rhs_acc_1p78",
"rhs_acc_uuk",
"rhs_acc_1p87",
"rhs_acc_rakursPM",
"rhs_acc_dtk4short"
];

attachmentLongList_RU_2020	= [
	"rhs_acc_pso1m21",
	"rhs_acc_pso1m2"
];

////////////////////////
////Items management////
////////////////////////
itemList_RU_2020 = [
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
	"ACE_NVG_Wide_Green_WP"
	];

itemEngineerList_RU_2020 = [

];
	
itemMedicList_RU_2020 = [

];

//backpack avalaible for all unit
backPackList_RU_2020 = [
	"rhs_rk_sht_30_emr",
	"rhs_tortila_olive",
	"rhs_assault_umbts",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_RU_2020 = [
	"rhs_uniform_vkpo_gloves",
	"rhs_6b47_emr_1",
	"rhs_facewear_6m2_1",
	"rhs_6b45_light",
	"rhs_6b45_holster",
	"rhs_6b45_rifleman",
	"rhs_6b45_rifleman_2",
	"rhs_6b45_off",
	"rhs_6b45_mg",
	"rhs_uniform_6sh122_v1",
	"rhs_6b23_digi_medic",
	"rhs_balaclava"
];

//Magazine avalaible for all unit
magazineList_RU_2020 = 	[
];