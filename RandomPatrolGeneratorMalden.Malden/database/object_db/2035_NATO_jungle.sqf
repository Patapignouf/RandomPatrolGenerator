#include "..\classConstant.sqf"

factionID = factionID+1;
factionInfos pushBack["_2035_NATO_jungle", factionID,"2035 NATO Jungle", true, true, false];


////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_NATO_jungle = [
	"B_T_Truck_01_transport_F", 
	"B_T_Truck_01_covered_F", 
	"B_T_LSV_01_unarmed_F", 
	"B_T_MRAP_01_F", 
	"B_T_Quadbike_01_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_NATO_jungle = [
	"B_T_MRAP_01_hmg_F", 
	"B_T_LSV_01_AT_F", 
	"B_T_LSV_01_armed_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_NATO_jungle = [
	"B_Heli_Transport_03_unarmed_F"
];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_NATO_jungle = [
	"B_CTRG_Heli_Transport_01_tropic_F"
];

bluforExtractVehicleChopper_2035_NATO_jungle = [
	"B_CTRG_Heli_Transport_01_tropic_F"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_NATO_jungle = [
	"B_T_APC_Wheeled_01_cannon_F", 
	"B_T_APC_Tracked_01_rcws_F", 
	"B_T_AFV_Wheeled_01_cannon_F", 
	"B_T_MBT_01_cannon_F"
];

//Drone vehicle avalaible for blufor
bluforDrone_2035_NATO_jungle = [
	"B_T_UGV_01_rcws_olive_F", 
	"B_T_UAV_03_dynamicLoadout_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_2035_NATO_jungle = [
	"B_Boat_Armed_01_minigun_F",
	"B_Boat_Transport_01_F"
];

//FixedWing vehicle avalaible for bluforq
bluforFixedWing_2035_NATO_jungle = [
	"B_T_VTOL_01_armed_F", 
	"B_T_VTOL_01_infantry_F", 
	"B_T_VTOL_01_vehicle_F"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_2035_NATO_jungle = [

];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"

loadout_2035_NATO_jungle = [		
	[c_leader, "B_T_Soldier_SL_F"],
	[c_at, "B_T_Soldier_LAT_F"],
	[c_rifleman, "B_T_Soldier_F"],//Default stuff
	[c_grenadier, "B_T_Soldier_GL_F"],
	[c_engineer, "B_T_Engineer_F"],
	[c_autorifleman, "B_T_Soldier_AR_F"],
	[c_marksman, "B_T_soldier_M_F"],
	[c_sniper, "B_T_ghillie_tna_F"],
	[c_medic, "B_T_Medic_F"],
	[c_pilot, "B_T_Helipilot_F"],
	[c_drone,"B_T_Soldier_UAV_F"]
];


////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_2035_NATO_jungle = [		
	"arifle_MX_F",
	"arifle_MXC_F",
	"arifle_MX_khk_F",
	"arifle_MXC_khk_F",
	"arifle_MX_Black_F",
	"arifle_MXC_Black_F"
];	

//Launcher avalaible for AT
launcherList_2035_NATO_jungle = [
	"launch_I_Titan_short_F",
	"launch_B_Titan_tna_F",
	"launch_B_Titan_short_tna_F",
	"launch_NLAW_F",
	"ACE_launch_NLAW_ready_F",
	"launch_MRAWS_olive_F"
];	

grenadeLauncherList_2035_NATO_jungle =  [		
	//Vanilla
	"arifle_MX_GL_khk_F"
];	


//Autorifle avalaible for autorifleman
autorifleList_2035_NATO_jungle = [
	"LMG_Mk200_F",
	"MMG_02_camo_F",
	"arifle_MX_SW_F",
	"arifle_MX_SW_Black_F",
	"arifle_MX_SW_khk_F",
	"LMG_Zafir_F",
	"srifle_LRR_tna_F"
];	

//Rifle avalaible for marksman
marksmanrifleList_2035_NATO_jungle = [
	"arifle_MXM_F",
	"arifle_MXM_Black_F",
	"arifle_MXM_khk_F",
	"srifle_EBR_F",
	"srifle_DMR_06_camo_F",
	"srifle_LRR_F",
	"srifle_LRR_camo_F"
];

//Smg avalaible for all unit
smgList_2035_NATO_jungle = [
	"hgun_P07_F",
	"SMG_01_F"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_NATO_jungle	= [
	"optic_Arco",
	"optic_Arco_blk_F",
	"ACE_optic_Arco_2D",
	"optic_Hamr",
	"optic_Holosight",
	"optic_Holosight_arid_F",
	"optic_Holosight_blk_F",
	"optic_Holosight_khk_F",
	"optic_Holosight_lush_F",
	"optic_Holosight_smg",
	"optic_Holosight_smg_blk_F",
	"optic_Holosight_smg_khk_F",
	"optic_Aco",
	"optic_Aco_smg",
	"optic_ACO_grn",
	"optic_ACO_grn_smg",
	"optic_erco_snd_f",
	"optic_ERCO_blk_F",
	"optic_ERCO_khk_F",
	"optic_mrco",
	"acc_pointer_IR",
	"bipod_01_F_snd",
	"ACE_muzzle_mzls_H"
];

//Long range scope avalaible for marksman
attachmentLongList_2035_NATO_jungle	= [
	"optic_dms",
	"optic_ams_snd",
	"optic_sos",
	"optic_khs_tan",
	"optic_nvs"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_2035_NATO_jungle = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"B_UavTerminal",
	"ItemGPS",
	"Binocular",
	"Laserdesignator",
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
	"acc_flashlight",
	"ACE_Banana",
	"muzzle_snds_H_snd_F",
	"HandGrenade",
	"MiniGrenade",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_RangeCard",
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP",
	"ACE_HuntIR_monitor"
	];

//item avalaible for all engineer
itemEngineerList_2035_NATO_jungle = [
	"DemoCharge_Remote_Mag"
];

//item avalaible for all medic
itemMedicList_2035_NATO_jungle = [
];


//backpack avalaible for all unit
backPackList_2035_NATO_jungle = [
	"B_TacticalPack_mcamo",
	"B_Kitbag_mcamo",
	"B_AssaultPack_rgr",
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"TFAR_rt1523g",
	"TFAR_rt1523g_big_rhs"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_NATO_jungle = [
	"H_HelmetB_Enh_tna_F",
	"H_HelmetB_tna_F",
	"H_Watchcap_camo",
	"V_PlateCarrier1_tna_F",
	"V_PlateCarrier2_tna_F",
	"V_Chestrig_rgr",
	"U_B_T_Soldier_F",
	"U_B_T_Soldier_AR_F"
];

uniformListSniper_2035_NATO_jungle = [
	"U_B_T_FullGhillie_tna_F",
	"U_B_T_Sniper_F"
];


magazineList_2035_NATO_jungle = [
	"ACE_HuntIR_M203"
];