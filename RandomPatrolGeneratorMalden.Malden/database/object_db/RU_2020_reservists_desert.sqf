#include "..\classConstant.sqf"

//Add specific RHS factions
if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	factionID = factionID+1;
	//factionInfos pushBack [c_USA_SOCOM_2020,_USA_SOCOM_2020,"2020 USA SOCOM [RHS]", true, true, false];
	factionInfos pushBack ["_RU_2020_reservists_desert", factionID,"2020 Russian regular and reservists desert CAMO [RHS]", false, true, false];
};

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_RU_2020_reservists_desert = [
	"rhs_mvd_izlom_sergeant", 
	"rhs_mvd_izlom_marksman", 
	"rhs_mvd_izlom_machinegunner", 
	"rhs_mvd_izlom_grenadier_rpg", 
	"rhs_mvd_izlom_arifleman", 
	"rhs_mvd_izlom_arifleman_rpk", 
	"rhs_mvd_izlom_rifleman", 
	"rhs_mvd_izlom_rifleman_LAT"
];

baseEnemyATGroup_RU_2020_reservists_desert = [
	"rhs_msv_emr_engineer", 
	"rhs_msv_emr_medic", 
	"rhs_msv_emr_junior_sergeant", 
	"rhs_msv_emr_at", 
	"rhs_msv_emr_aa"
];

baseEnemyDemoGroup_RU_2020_reservists_desert = [
	"rhs_mvd_izlom_arifleman_rpk", 
	"rhs_mvd_izlom_grenadier_rpg", 
	"rhs_mvd_izlom_sergeant", 
	"rhs_mvd_izlom_rifleman_LAT", 
	"rhs_mvd_izlom_rifleman_asval"
];

baseEnemyMortarGroup_RU_2020_reservists_desert = [
	"rhs_2b14_82mm_msv", 
	"rhs_msv_emr_arifleman", 
	"rhs_msv_emr_sergeant", 
	"rhs_msv_emr_marksman", 
	"rhs_msv_rifleman"
];

baseEnemyVehicleGroup_RU_2020_reservists_desert = [
	"rhs_tigr_vv", 
	"rhs_tigr_sts_vv", 
	"rhs_tigr_m_vv",
	"rhs_Igla_AA_pod_msv" //AA Turret
];

baseEnemyLightArmoredVehicleGroup_RU_2020_reservists_desert = [
	//Btr
	"rhs_btr60_vv", 
	"rhs_btr70_vv", 
	"rhs_btr80_vv",
	//Anti air
	"rhs_gaz66_zu23_vv"
];

baseEnemyHeavyArmoredVehicleGroup_RU_2020_reservists_desert = [
	"rhs_bmp1_vv", 
	"rhs_prp3_vv", 
	"rhs_bmp2d_vv",
	"rhs_bmp3mera_msv",
	"rhs_bmp3mera_msv", 
	"rhs_t80", 
	"rhs_t90_tv", 
	"rhs_t72be_tv", 
	"rhs_t72ba_tv"
];

baseEnemyUnarmedChopperGroup_RU_2020_reservists_desert = [
	"RHS_Mi8t_vv"
];

baseEnemyArmedChopperGroup_RU_2020_reservists_desert = [
	"RHS_Mi8mt_vv"
];

baseFixedWingGroup_RU_2020_reservists_desert = [
	"RHS_T50_vvs_generic_ext", 
	"rhs_mig29s_vvs", 
	"rhs_mig29s_vmf", 
	"RHS_Su25SM_vvsc"
];


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_RU_2020_reservists_desert = [
	"rhs_gaz66_vdv",
	"rhs_kamaz5350_vdv",
	"RHS_Ural_Open_VDV_01",
	"rhs_tigr_vdv",
	"rhs_tigr_3camo_vdv",
	"rhs_uaz_vdv",
	"rhs_uaz_open_vdv",
	"rhs_tigr_m_vdv"
];

bluforArmedVehicle_RU_2020_reservists_desert = [
	"rhs_tigr_sts_3camo_vdv",
	"rhs_tigr_sts_vdv"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_RU_2020_reservists_desert = [
	"rhs_bmd1",
	"rhs_bmp2d_vdv",
	"rhs_sprut_vdv",
	"rhs_btr60_vdv"
];

bluforUnarmedVehicleChopper_RU_2020_reservists_desert = [
	"RHS_Mi8mt_vdv",
	"RHS_Mi8mt_Cargo_vdv",
	"rhs_ka60_c"
];

bluforArmedChopper_RU_2020_reservists_desert = [
	"RHS_Ka52_vvs",
	"RHS_Mi24P_vvs",
	"RHS_Mi8AMTSh_vvs",
	"RHS_Mi24P_vdv",
	"RHS_Mi8MTV3_vdv"
];

bluforDrone_RU_2020_reservists_desert = [

];

bluforBoat_RU_2020_reservists_desert = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_RU_2020_reservists_desert = [
	"rhs_mig29s_vvs",
	"RHS_Su25SM_vvs",
	"RHS_T50_vvs_generic"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_RU_2020_reservists_desert = [

];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_RU_2020_reservists_desert = [		
	[c_leader, "rhs_msv_emr_sergeant"],
	[c_at, "rhs_msv_emr_LAT"],
	[c_rifleman, "rhs_msv_emr_rifleman"],//Default stuff
	[c_engineer,"rhs_msv_emr_engineer"],
	[c_autorifleman, "rhs_msv_emr_machinegunner"],
	[c_marksman, "rhs_msv_emr_marksman"],
	[c_medic,"rhs_msv_emr_medic"],
	[c_grenadier, "rhs_msv_emr_grenadier"],//Default stuff
	[c_pilot,"rhs_msv_emr_driver"]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_RU_2020_reservists_desert = [		
	"rhs_weap_ak74m",
	"rhs_weap_makarov_pm",
	"rhs_weap_ak74mr",
	"rhs_weap_aks74n_npz",
	"rhs_weap_aks74n_2",
	"rhs_weap_ak103",
	"rhs_weap_ak105",
	"rhs_weap_ak105_zenitco01",
	"rhs_weap_pya",
	"rhs_weap_6p53"
];	


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_RU_2020_reservists_desert = [		
	"rhs_weap_ak74m_gp25",
	"rhs_weap_ak74mr_gp25",
	"rhs_weap_ak74m_fullplum_gp25_npz",
	"rhs_weap_ak74n_gp25"
];


launcherList_RU_2020_reservists_desert = [		
	"rhs_weap_rpg26",
	"rhs_weap_rpg7",
	"rhs_weap_igla"
];	

autorifleList_RU_2020_reservists_desert = [			
	"rhs_weap_pkm",
	"rhs_weap_pkp",
	"rhs_weap_rpk74m",
	"rhs_weap_rpk74m_npz"

];	

marksmanrifleList_RU_2020_reservists_desert = [		
	"rhs_asval",
	"rhs_weap_svds",
	"rhs_weap_vss",
	"rhs_weap_t5000",
	"rhs_weap_svds_npz",
	"rhs_weap_vss_grip_npz"
];


smgList_RU_2020_reservists_desert = [		
	"rhs_weap_aks74u",
	"rhs_weap_ak74m_folded",
	"rhs_weap_pp2000_folded",
	"rhs_weap_pp2000"
];

//////////////////////////
attachmentShortList_RU_2020_reservists_desert	= [
	"rhs_acc_dtk",
	"rhs_acc_pkas",
	"rhs_acc_pgo7v3",
	"rhs_acc_1p78",
	"rhs_acc_uuk",
	"rhs_acc_1p87",
	"rhs_acc_rakursPM",
	"rhs_acc_pgs64",
	"rhs_acc_2dpZenit",
	"rhs_acc_okp7_picatinny",
	"rhs_acc_perst1ik_ris",
	"rhs_acc_pkas_pkp",
	"rhs_acc_pgo7v3_pkp",
	"rhs_acc_pgo7v3_ak"
];

attachmentLongList_RU_2020_reservists_desert	= [
	"rhs_acc_pso1m21",
	"rhs_acc_pso1m2",
	"rhs_weap_svds_npz",
	"rhs_acc_dh520x56"
];


////////////////////////
itemList_RU_2020_reservists_desert = [
	"NVGoggles",
	"Laserdesignator",
	"B_UavTerminal",
	"ItemGPS",
	"Rangefinder",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard",
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP"
	//"rhs_radio_R187P1",
	//"rhs_radio_R169P1"
];

itemEngineerList_RU_2020_reservists_desert = [

];
	
itemMedicList_RU_2020_reservists_desert = [

];

//backpack avalaible for all unit
backPackList_RU_2020_reservists_desert = [
	"rhs_rk_sht_30_emr",
	"rhs_tortila_olive",
	"rhs_assault_umbts",
	"TFAR_mr3000_rhs"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_RU_2020_reservists_desert = [
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
	"rhs_balaclava",
	"rhs_scarf"
];


factionDefaultRadios_RU_2020_reservists_desert = [
	"tfar_fadak"
];

//Magazine avalaible for all unit
magazineList_RU_2020_reservists_desert = 	[
];