#include "..\classConstant.sqf"

factionInfos pushBack ["_2035_NATO_Recon", 35,"2035 NATO Recon", true, false, false];

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_NATO_Recon = [
	"B_Quadbike_01_F",
	"B_Truck_01_transport_F",
	"B_LSV_01_unarmed_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_NATO_Recon = [
	"B_LSV_01_armed_F",
	"B_LSV_01_AT_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_NATO_Recon = [
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Light_01_F",
	"B_Heli_Transport_01_F"
];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_NATO_Recon = [
	"B_Heli_Attack_01_dynamicLoadout_F",
	"B_Heli_Light_01_dynamicLoadout_F"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_NATO_Recon = [
	"B_APC_Wheeled_01_cannon_F"
];

//Drone vehicle avalaible for blufor
bluforDrone_2035_NATO_Recon = [
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F",
	"B_UGV_02_Science_F",
	"B_UAV_06_F",
	"B_UAV_01_F",
	"B_UAV_05_F",
	"B_UAV_02_dynamicLoadout_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_2035_NATO_Recon = [
	"B_Boat_Armed_01_minigun_F",
	"B_Boat_Transport_01_F"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_NATO_Recon = [
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_Stealth_F",
	"B_Plane_Fighter_01_F",
	"B_T_VTOL_01_armed_F",
	"B_T_VTOL_01_infantry_F",
	"B_T_VTOL_01_vehicle_F"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_2035_NATO_Recon = [
	"B_Truck_01_box_F"
];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_2035_NATO_Recon = [		
	[c_leader, "B_recon_TL_F"],
	[c_at, "B_recon_LAT_F"],
	[c_rifleman, "B_recon_F"],//Default stuff
	[c_grenadier, "B_recon_JTAC_F"],
	[c_engineer, "B_recon_exp_F"],
	[c_marksman, "B_recon_M_F"],
	[c_medic, "B_recon_medic_F"],
	[c_sniper, "B_sniper_F"]
];



////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_2035_NATO_Recon = [	
	"hgun_P07_F",	
	"hgun_Pistol_heavy_01_F",
	"arifle_MX_F",
	"arifle_MXC_F",
	"arifle_MX_khk_F",
	"arifle_MXC_khk_F",
	"arifle_MX_Black_F",
	"arifle_MXC_Black_F"
];	

grenadeLauncherList_2035_NATO_Recon = [
	"arifle_MX_GL_khk_F",
	"arifle_MX_GL_F",
	"arifle_MX_GL_Black_F"
];


//Launcher avalaible for AT
launcherList_2035_NATO_Recon = [
	"launch_I_Titan_short_F",
	"launch_NLAW_F",
	"ACE_launch_NLAW_ready_F",
	"launch_MRAWS_olive_F"
];	

//Autorifle avalaible for autorifleman
autorifleList_2035_NATO_Recon = [

];	

//Rifle avalaible for marksman
marksmanrifleList_2035_NATO_Recon = [
	"arifle_MXM_F",
	"srifle_EBR_F",
	"srifle_DMR_06_camo_F",
	"srifle_DMR_02_sniper_F",
	"srifle_LRR_camo_F"
];

//Smg avalaible for all unit
smgList_2035_NATO_Recon = [
	"SMG_01_F"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_NATO_Recon	= [
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
	"optic_MRD",
	"muzzle_snds_acp",
	"muzzle_snds_H"
];

//Long range scope avalaible for marksman
attachmentLongList_2035_NATO_Recon	= [
	"optic_dms",
	"optic_ams_snd",
	"optic_sos",
	"optic_khs_tan",
	"optic_nvs",
	"muzzle_snds_338_sand",
	"bipod_01_F_snd",
	"optic_LRPS",
	"muzzle_snds_L",
	"muzzle_snds_B",
	"muzzle_snds_H"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_2035_NATO_Recon = [
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
	"HandGrenade",
	"MiniGrenade",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_RangeCard",
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP"
	];

//item avalaible for all engineer
itemEngineerList_2035_NATO_Recon = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch",
	"ACE_DefusalKit",
	"ACE_Clacker",
	"ACE_M26_Clacker",
	"ace_marker_flags_white",
	"ace_marker_flags_yellow",
	"ace_marker_flags_purple",
	"ace_marker_flags_orange",
	"ace_marker_flags_red"
	];

//item avalaible for all medic
itemMedicList_2035_NATO_Recon = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_morphine",
	"ACE_splint",
	"ACE_tourniquet",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture",
	"ACE_bodyBag"
	];


//backpack avalaible for all unit
backPackList_2035_NATO_Recon = [
	"B_TacticalPack_mcamo",
	"B_AssaultPack_rgr",
	"B_Kitbag_rgr",
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"TFAR_rt1523g",
	"TFAR_rt1523g_sage"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_NATO_Recon = [
	"G_Combat",
	"G_Combat_Goggles_tna_F",
	"U_B_CombatUniform_mcam_tshirt",
	"G_Tactical_Clear",
	"H_HelmetB_camo",
	"H_Booniehat_mcamo",
	"V_PlateCarrier2_rgr",
	"H_HelmetB_grass",
	"G_Combat",
	"V_Chestrig_rgr"
	];

uniformListSniper_2035_NATO_Recon = [
	"U_B_FullGhillie_lsh",
	"U_B_FullGhillie_sard",
	"U_B_FullGhillie_ard",
	"U_B_GhillieSuit"
];

//Magazine avalaible for all unit
magazineList_2035_NATO_Recon = [
	"30Rnd_65x39_caseless_mag_Tracer"
	];
