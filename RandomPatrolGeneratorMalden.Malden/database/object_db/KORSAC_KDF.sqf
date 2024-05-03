#include "..\classConstant.sqf"

//Add specific KORSAC factions
if (isClass (configFile >> "CfgPatches" >> "vtf_kf_main")) then 
{
	factionInfos pushBack ["_KORSAC_KDF",31,"KDF Army [KORSAC]", true, false, false];
};

////////////////////////
//Vehicle management////
////////////////////////
//French
bluforUnarmedVehicle_KORSAC_KDF = [
	"vtf_kf_B_MRAP_01_F",
	"vtf_kf_B_Offroad_01_covered_F",
	"vtf_kf_B_LSV_01_unarmed_F",
	"vtf_kf_B_Quadbike_01_F",
	"vtf_kf_B_Van_02_vehicle_F",
	"vtf_kf_B_Van_02_transport_F"
];

bluforArmedVehicle_KORSAC_KDF = [

];

bluforUnarmedVehicleChopper_KORSAC_KDF = [
	"vtf_kf_B_Heli_Transport_03_unarmed_F"
];

bluforArmedChopper_KORSAC_KDF = [

];

bluforDrone_KORSAC_KDF = [

];

bluforBoat_KORSAC_KDF = [

];

bluforFixedWing_KORSAC_KDF = [

];

bluforHQVehicle_KORSAC_KDF = [
	"vtf_kf_B_Truck_02_F"
];

bluforArmoredVehicle_KORSAC_KDF = [
	"vtf_kf_B_APC_Wheeled_01_cannon_F",
	"vtf_kf_B_APC_tracked_03_cannon_F",
	"vtf_kf_B_MBT_02_cannon_F"
];

////////////////////////
//Loadout management////
////////////////////////

//Define custom list of role

//USA
loadout_KORSAC_KDF = [		
	[c_leader, "vtf_kf_B_SquadLeader_F"],
	[c_at, "vtf_kf_B_Rifleman_AT_F"],
	[c_rifleman, "vtf_kf_B_Rifleman_F"],//Default stuff
	[c_engineer, "vtf_kf_B_Engineer_F"],
	[c_autorifleman, "vtf_kf_B_Autorifleman_F"],
	[c_marksman, "vtf_kf_B_Marksman_F"],
	[c_medic, "vtf_kf_B_Medic_F"],
	[c_grenadier, "vtf_kf_B_Grenadier_F"],//Default stuff
	[c_pilot,"vtf_kf_B_Helipilot_F"]
];

////////////////////////
///Weapon management////
////////////////////////
//French
rifleList_KORSAC_KDF = [		
	"vtf_kf_arifle_AK12_ARCO_F",
	"optic_Arco",
	"optic_Arco_blk_F",
	"arifle_AK12_F",
	"arifle_AK12U_F",
	"hgun_Pistol_01_F",
	"CUP_arifle_AK12_AFG_black" //For non possessor of contact DLC
];	

grenadeLauncherList_KORSAC_KDF =  [		
	"arifle_AK12_GL_F",
	"CUP_arifle_AK12_GP34_black"
];	

launcherList_KORSAC_KDF = [		
	"launch_B_Titan_olive_F",
	"launch_NLAW_F",
	"ACE_launch_NLAW_ready_F"
];	

autorifleList_KORSAC_KDF = [			
	"LMG_03_F"
];	


marksmanrifleList_KORSAC_KDF = [		
	"srifle_DMR_03_F"
];

smgList_KORSAC_KDF = [		

];


//////////////////////////
//Attachement management//
//////////////////////////

//items avalaible for everyone (optics)
attachmentShortList_KORSAC_KDF	= [
	"optic_Holosight",
	"optic_Holosight",
	"optic_Holosight_arid_F",
	"optic_Holosight_blk_F",
	"optic_Holosight_khk_F",
	"optic_Holosight_lush_F",
	"optic_Holosight_smg",
	"optic_Holosight_smg_blk_F",
	"optic_Holosight_smg_khk_F",
	"optic_Arco_AK_blk_F"
];

//Items avalaible only for marksman
attachmentLongList_KORSAC_KDF	= [
	"optic_AMS",
	"optic_lrps",
	"optic_SOS",
	"bipod_01_F_blk"
];


////////////////////////
////Items management////
////////////////////////

//Items avalaible for everyone
itemList_KORSAC_KDF = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"B_UavTerminal",
	"ItemGPS",
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
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard",
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP"
	];

//items avalaible only for engineer
itemEngineerList_KORSAC_KDF = [
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
	"ace_marker_flags_red",
	"DemoCharge_Remote_Mag"
	];

//item avalaible only for medics
itemMedicList_KORSAC_KDF = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
	];


//backpack avalaible for all unit
backPackList_KORSAC_KDF = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"B_Carryall_eaf_eng_F",
	"B_Carryall_eaf_F",
	"B_Carryall_oli",
	"B_AssaultPack_eaf_IELAT_F",
	"B_FieldPack_green_F",
	"B_Fieldpack_oli",
	"TFAR_rt1523g",
	"TFAR_rt1523g_sage"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_KORSAC_KDF = [
	"vtf_kf_sweater",
	"vtf_kf_deserter",
	"V_CarrierRigKBT_01_light_Olive_F",
	"V_PlateCarrier2_rgr_noflag_F", //For non possessor of contact DLC
	"H_HelmetHBK_F",
	"H_Cap_headphones",
	"H_Booniehat_eaf",
	"H_HelmetHBK_headset_F",
	"H_HelmetB_light",
	"H_HelmetSpecB_snakeskin"
	];

//Magazine avalaible for all unit
magazineList_KORSAC_KDF = [
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell",
	"CUP_1Rnd_HE_GP25_M",
	"CUP_1Rnd_SMOKE_GP25_M",
	"HandGrenade",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"Laserbatteries"
	];