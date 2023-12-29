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


////////////////////////
//Vehicle management////
////////////////////////
//French
bluforUnarmedVehicle_KORSAK_KFL = [
	"vtf_kf_B_FL_Offroad_01_covered_F",
	"vtf_kf_B_FL_Quadbike_01_F"
];

bluforArmedVehicle_KORSAK_KFL = [

];

bluforUnarmedVehicleChopper_KORSAK_KFL = [

];

bluforArmedChopper_KORSAK_KFL = [

];

bluforDrone_KORSAK_KFL = [

];

bluforBoat_KORSAK_KFL = [

];

bluforFixedWing_KORSAK_KFL = [

];

bluforHQVehicle_KORSAK_KFL = [
	"vtf_kf_B_Truck_02_F"
];

bluforArmoredVehicle_KORSAK_KFL = [

];

////////////////////////
//Loadout management////
////////////////////////

listOfRoles_KORSAK_KFL = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier];

//USA
loadout_KORSAK_KFL = [		
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
rifleList_KORSAK_KFL = [		
	"arifle_AK12U_F",
	"arifle_SPAR_02_blk_F",
	"arifle_SPAR_01_blk_F",
	"CUP_arifle_HK416_Black",
	"hgun_Pistol_01_F",
	"arifle_MSBS65_black_F",
	"srifle_DMR_03_F",
	"CUP_arifle_AK15_black" //For non possessor of contact DLC
];	

grenadeLauncherList_KORSAK_KFL =  [		
	"arifle_SPAR_01_GL_blk_ACO_Pointer_F",
	"arifle_SPAR_01_GL_blk_F",
	"CUP_arifle_HK416_CQB_M203_Black" //For non possessor of contact DLC
];	

launcherList_KORSAK_KFL = [		
	"launch_B_Titan_olive_F",
	"launch_NLAW_F",
	"ACE_launch_NLAW_ready_F"
];

autorifleList_KORSAK_KFL = [			
	"LMG_03_F"
];	

marksmanrifleList_KORSAK_KFL = [		
	"arifle_SPAR_03_blk_F",
	"CUP_arifle_HK417_20" //For non possessor of contact DLC
];

smgList_KORSAK_KFL = [		
	"hgun_ACPC2_F",
	"hgun_PDW2000_F"
];



//////////////////////////
//Attachement management//
//////////////////////////

//items avalaible for everyone (optics)
attachmentShortList_KORSAK_KFL	= [
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
attachmentLongList_KORSAK_KFL	= [
	"optic_AMS",
	"optic_lrps",
	"optic_SOS",
	"bipod_01_F_blk"
];


////////////////////////
////Items management////
////////////////////////

//Items avalaible for everyone
itemList_KORSAK_KFL = [
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
itemEngineerList_KORSAK_KFL = [
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
itemMedicList_KORSAK_KFL = [
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
backPackList_KORSAK_KFL = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"B_Carryall_eaf_eng_F",
	"B_AssaultPack_eaf_IELAT_F",
	"B_FieldPack_green_F",
	"TFAR_rt1523g",
	"TFAR_rt1523g_sage"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_KORSAK_KFL = [
	"vtf_kf_sweater",
	"vtf_kf_deserter",
	"V_CarrierRigKBT_01_light_Olive_F",
	"H_HelmetHBK_F",
	"H_Cap_headphones",
	"H_Booniehat_eaf",
	"H_HelmetHBK_headset_F",
	"V_PlateCarrierL_CTRG"
];

//Magazine avalaible for all unit
magazineList_KORSAK_KFL = [
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