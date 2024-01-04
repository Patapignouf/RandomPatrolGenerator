#include "..\classConstant.sqf"

//Include custom classes
//c_drone = "UAV opérator";

////////////////////////
//Vehicle management////
////////////////////////
//French
bluforUnarmedVehicle_KORSAK_KDF = [
	"vtf_kf_B_MRAP_01_F",
	"vtf_kf_B_Offroad_01_covered_F",
	"vtf_kf_B_LSV_01_unarmed_F",
	"vtf_kf_B_Quadbike_01_F",
	"vtf_kf_B_Van_02_vehicle_F",
	"vtf_kf_B_Van_02_transport_F"
];

bluforArmedVehicle_KORSAK_KDF = [

];

bluforUnarmedVehicleChopper_KORSAK_KDF = [
	"vtf_kf_B_Heli_Transport_03_unarmed_F"
];

bluforArmedChopper_KORSAK_KDF = [

];

bluforDrone_KORSAK_KDF = [

];

bluforBoat_KORSAK_KDF = [

];

bluforFixedWing_KORSAK_KDF = [

];

bluforHQVehicle_KORSAK_KDF = [
	"vtf_kf_B_Truck_02_F"
];

bluforArmoredVehicle_KORSAK_KDF = [
	"vtf_kf_B_APC_Wheeled_01_cannon_F",
	"vtf_kf_B_APC_tracked_03_cannon_F",
	"vtf_kf_B_MBT_02_cannon_F"
];

////////////////////////
//Loadout management////
////////////////////////

//Define custom list of role
listOfRoles_KORSAK_KDF = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier,c_pilot];

//USA
loadout_KORSAK_KDF = [		
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
rifleList_KORSAK_KDF = [		
	"vtf_kf_arifle_AK12_ARCO_F",
	"arifle_AK12_F",
	"arifle_AK12U_F",
	"hgun_Pistol_01_F",
	"CUP_arifle_AK12_AFG_black" //For non possessor of contact DLC
];	

grenadeLauncherList_KORSAK_KDF =  [		
	"arifle_AK12_GL_F",
	"CUP_arifle_AK12_GP34_black"
];	

launcherList_KORSAK_KDF = [		
	"launch_B_Titan_olive_F",
	"launch_NLAW_F",
	"ACE_launch_NLAW_ready_F"
];	

autorifleList_KORSAK_KDF = [			
	"LMG_03_F"
];	


marksmanrifleList_KORSAK_KDF = [		
	"srifle_DMR_03_F"
];

smgList_KORSAK_KDF = [		

];


//////////////////////////
//Attachement management//
//////////////////////////

//items avalaible for everyone (optics)
attachmentShortList_KORSAK_KDF	= [
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
attachmentLongList_KORSAK_KDF	= [
	"optic_AMS",
	"optic_lrps",
	"optic_SOS",
	"bipod_01_F_blk"
];


////////////////////////
////Items management////
////////////////////////

//Items avalaible for everyone
itemList_KORSAK_KDF = [
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
itemEngineerList_KORSAK_KDF = [
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
itemMedicList_KORSAK_KDF = [
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
backPackList_KORSAK_KDF = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"B_Carryall_eaf_eng_F",
	"B_AssaultPack_eaf_IELAT_F",
	"B_FieldPack_green_F",
	"B_Fieldpack_oli",
	"TFAR_rt1523g",
	"TFAR_rt1523g_sage"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_KORSAK_KDF = [
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
magazineList_KORSAK_KDF = [
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