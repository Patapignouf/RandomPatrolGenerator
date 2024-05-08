c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman";
c_sniper = "sniper";  
c_medic = "medic";
c_grenadier = "grenadier";
c_pilot = "pilot";

//Add specific KORSAC factions
if (isClass (configFile >> "CfgPatches" >> "vtf_kf_main")) then 
{
	factionInfos pushBack ["_KORSAC_KFL",33,"KFL Foreign legion [KORSAC]", true, true, false];	
};

//////////////////////////////  
///Define enemy group data////
//////////////////////////////
//Russian Ratnik_Winter
baseEnemyGroup_KORSAC_KFL  = [
	"vtf_kf_B_FL_SquadLeader_F", 
	"vtf_kf_B_FL_Medic_F", 
	"vtf_kf_B_FL_Rifleman_AT_F", 
	"vtf_kf_B_FL_Marksman_F", 
	"vtf_kf_B_FL_Grenadier_F", 
	"vtf_kf_B_FL_Rifleman_F", 
	"vtf_kf_B_FL_Autorifleman_F", 
	"vtf_kf_B_FL_Engineer_F"
];

baseEnemyATGroup_KORSAC_KFL  = [
	"vtf_kf_B_FL_SquadLeader_F", 
	"vtf_kf_B_FL_Rifleman_AT_F", 
	"vtf_kf_B_FL_Rifleman_AT_F",
	"vtf_kf_B_FL_Grenadier_F", 
	"vtf_kf_B_FL_Autorifleman_F"
];

baseEnemyDemoGroup_KORSAC_KFL  = [
	"vtf_kf_B_FL_SquadLeader_F", 
	"vtf_kf_B_FL_Engineer_F", 
	"vtf_kf_B_FL_Grenadier_F", 
	"vtf_kf_B_FL_Autorifleman_F"
];	

baseEnemyMortarGroup_KORSAC_KFL  = [

];

baseEnemyVehicleGroup_KORSAC_KFL  = [ 
	"vtf_kf_B_FL_Quadbike_01_F", 
	"vtf_kf_B_FL_Offroad_01_covered_F"
];

baseEnemyLightArmoredVehicleGroup_KORSAC_KFL = [

];

baseEnemyHeavyArmoredVehicleGroup_KORSAC_KFL = [

];


baseEnemyUnarmedChopperGroup_KORSAC_KFL = [
	"vtf_kf_B_Heli_Transport_03_unarmed_F" //Helicopter from another faction
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_KORSAC_KFL = [
	
];





////////////////////////
//Vehicle management////
////////////////////////
//French
bluforUnarmedVehicle_KORSAC_KFL = [
	"vtf_kf_B_FL_Offroad_01_covered_F",
	"vtf_kf_B_FL_Quadbike_01_F"
];

bluforArmedVehicle_KORSAC_KFL = [

];

bluforUnarmedVehicleChopper_KORSAC_KFL = [

];

bluforExtractVehicleChopper_KORSAC_KFL = [
	"vtf_kf_B_Heli_Transport_03_unarmed_F"
];

bluforArmedChopper_KORSAC_KFL = [

];

bluforDrone_KORSAC_KFL = [

];

bluforBoat_KORSAC_KFL = [

];

bluforFixedWing_KORSAC_KFL = [

];

bluforHQVehicle_KORSAC_KFL = [
	"vtf_kf_B_Truck_02_F"
];

bluforArmoredVehicle_KORSAC_KFL = [

];

////////////////////////
//Loadout management////
////////////////////////


//USA
loadout_KORSAC_KFL = [		
	[c_leader, "vtf_kf_B_FL_SquadLeader_F"],
	[c_at, "vtf_kf_B_FL_Rifleman_AT_F"],
	[c_rifleman, "vtf_kf_B_FL_Rifleman_F"],//Default stuff
	[c_engineer, "vtf_kf_B_FL_Engineer_F"],
	[c_autorifleman, "vtf_kf_B_FL_Autorifleman_F"],
	[c_marksman, "vtf_kf_B_FL_Marksman_F"],
	[c_medic, "vtf_kf_B_FL_Medic_F"],
	[c_grenadier, "vtf_kf_B_FL_Grenadier_F"]
];

////////////////////////
///Weapon management////
////////////////////////
//French
rifleList_KORSAC_KFL = [		
	"arifle_AK12U_F",
	"arifle_AK12_F",
	"optic_Arco",
	"optic_Arco_blk_F",
	"arifle_SPAR_02_blk_F",
	"arifle_SPAR_01_blk_F",
	"CUP_arifle_HK416_Black",
	"hgun_Pistol_01_F",
	"arifle_MSBS65_black_F",
	"srifle_DMR_03_F",
	"CUP_arifle_AK15_black" //For non possessor of contact DLC
];	

grenadeLauncherList_KORSAC_KFL =  [		
	"arifle_SPAR_01_GL_blk_ACO_Pointer_F",
	"arifle_SPAR_01_GL_blk_F",
	"CUP_arifle_HK416_CQB_M203_Black" //For non possessor of contact DLC
];	

launcherList_KORSAC_KFL = [		
	"launch_B_Titan_olive_F",
	"launch_NLAW_F",
	"ACE_launch_NLAW_ready_F"
];

autorifleList_KORSAC_KFL = [			
	"LMG_03_F"
];	

marksmanrifleList_KORSAC_KFL = [		
	"arifle_SPAR_03_blk_F",
	"CUP_arifle_HK417_20" //For non possessor of contact DLC
];

smgList_KORSAC_KFL = [		
	"hgun_ACPC2_F",
	"hgun_PDW2000_F"
];



//////////////////////////
//Attachement management//
//////////////////////////

//items avalaible for everyone (optics)
attachmentShortList_KORSAC_KFL	= [
	"optic_Holosight",
	"optic_Holosight",
	"optic_Holosight_arid_F",
	"optic_Holosight_blk_F",
	"optic_Holosight_khk_F",
	"optic_Holosight_lush_F",
	"optic_Holosight_smg",
	"optic_Holosight_smg_blk_F",
	"optic_Holosight_smg_khk_F",
	"optic_Arco_AK_blk_F",
	"optic_ERCO_blk_F"
];

//Items avalaible only for marksman
attachmentLongList_KORSAC_KFL	= [
	"optic_AMS",
	"optic_lrps",
	"optic_SOS",
	"bipod_01_F_blk"
];


////////////////////////
////Items management////
////////////////////////

//Items avalaible for everyone
itemList_KORSAC_KFL = [
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
itemEngineerList_KORSAC_KFL = [
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
itemMedicList_KORSAC_KFL = [
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
backPackList_KORSAC_KFL = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"B_Carryall_eaf_eng_F",
	"B_Carryall_eaf_F",
	"B_Carryall_oli",
	"B_AssaultPack_eaf_IELAT_F",
	"B_FieldPack_green_F",
	"TFAR_rt1523g",
	"TFAR_rt1523g_sage"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_KORSAC_KFL = [
	"vtf_kf_sweater",
	"vtf_kf_deserter",
	"V_CarrierRigKBT_01_light_Olive_F",
	"H_HelmetHBK_F",
	"H_Cap_headphones",
	"H_Booniehat_eaf",
	"H_HelmetHBK_headset_F",
	"V_PlateCarrierL_CTRG",
	"H_HelmetHBK_headset_F",
	"H_HelmetB_light",
	"H_HelmetSpecB_snakeskin"
];

//Magazine avalaible for all unit
magazineList_KORSAC_KFL = [
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell",
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