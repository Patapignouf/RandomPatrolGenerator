c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_grenadier = "grenadier";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_pilot = "pilot";
c_drone = "UAV operator";

factionInfos pushBack ["_2035_CSAT", 25, "2035 CSAT", true, true, true];

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Light civilian group
civilian_group_2035_CSAT = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

//Heavy civilian group
civilian_big_group_2035_CSAT = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

//Vehicle avalaible on civilian city
civilianTruck_2035_CSAT = ["C_SUV_01_F","C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_2035_CSAT = [
	"O_Soldier_SL_F", 
	"O_Soldier_F", 
	"O_Soldier_LAT_F", 
	"O_soldier_M_F", 
	"O_Soldier_TL_F", 
	"O_Soldier_AR_F", 
	"O_Soldier_A_F", 
	"O_medic_F"
];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_2035_CSAT = [
	"O_Soldier_TL_F", 
	"O_Soldier_HAT_F", 
	"O_Soldier_HAT_F",
	"O_Soldier_AHAT_F",
	"O_support_AMG_F", 
	"O_support_MG_F"
];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_2035_CSAT = [
	"O_Soldier_AA_F",
	"O_soldier_exp_F", 
	"O_soldier_UAV_F", 
	"O_Soldier_AAT_F"
];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_2035_CSAT = [
	"O_Mortar_01_F",
	"O_sniper_F", 
	"O_spotter_F",
	"O_support_AMG_F", 
	"O_support_MG_F"
];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_2035_CSAT = [
	"O_LSV_02_AT_F", 
	"O_LSV_02_armed_F"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_2035_CSAT = [
	"O_T_MRAP_02_gmg_ghex_F", 
	"O_T_MRAP_02_hmg_ghex_F"
];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_2035_CSAT = [
	"O_T_APC_Tracked_02_AA_ghex_F", 
	"O_T_APC_Tracked_02_cannon_ghex_F", 
	"O_T_APC_Wheeled_02_rcws_v2_ghex_F"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_2035_CSAT = [
	"O_Plane_CAS_02_dynamicLoadout_F"
];


baseEnemyUnarmedChopperGroup_2035_CSAT = [
	"O_Heli_Light_02_unarmed_F",
	"O_T_VTOL_02_infantry_dynamicLoadout_F"
];

baseEnemyArmedChopperGroup_2035_CSAT = [
	"O_Heli_Attack_02_dynamicLoadout_F", 
	"O_Heli_Light_02_dynamicLoadout_F"
];

baseEnemyArmedChopperGroup_2035_CSAT = [

];

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_CSAT = [
	"O_MRAP_02_F", 
	"O_LSV_02_unarmed_F",
	"O_Truck_02_transport_F", 
	"O_Truck_02_covered_F", 
	"O_Truck_03_transport_F", 
	"O_Truck_03_covered_F", 
	"O_Quadbike_01_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_CSAT = [
	"O_T_LSV_02_armed_F", 
	"O_T_LSV_02_AT_F",
	"O_MRAP_02_gmg_F", 
	"O_MRAP_02_hmg_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_CSAT = [
	"O_Heli_Transport_04_covered_F", 
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Transport_04_bench_F"
];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_CSAT = [
	"O_Heli_Attack_02_dynamicLoadout_F", 
	"O_Heli_Light_02_dynamicLoadout_F"
	
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_CSAT = [
	"O_APC_Wheeled_02_rcws_v2_F"
];

//Drone vehicle avalaible for blufor
bluforDrone_2035_CSAT = [
	"O_T_UAV_04_CAS_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_2035_CSAT = [
	"O_Boat_Armed_01_hmg_F", 
	"O_Boat_Transport_01_F",
	"O_SDV_01_F"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_CSAT = [
	"O_Plane_CAS_02_dynamicLoadout_F", 
	"O_Plane_Fighter_02_F"
];


//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_2035_CSAT = [
	"Land_Pod_Heli_Transport_04_covered_F"
];


////////////////////////
//Loadout management////
////////////////////////

//Two options : 
// - ACE Arsenal : ],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_2035_CSAT = [		
	[c_leader,"O_Soldier_SL_F"],
	[c_at,"O_Soldier_LAT_F"],
	[c_rifleman,"O_Soldier_F"],//Default stuff
	[c_engineer,"O_engineer_F"],
	[c_autorifleman,"O_Soldier_AR_F"],
	[c_marksman,"O_Sharpshooter_F"],
	[c_medic,"O_medic_F"],
	[c_grenadier,"O_Soldier_GL_F"],
	[c_drone,"O_soldier_UAV_F"],
	[c_pilot,"O_helipilot_F"]
];



////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_2035_CSAT = [		
	"arifle_Katiba_F",
	"arifle_Katiba_C_F",
	"arifle_SDAR_F",
	"arifle_ARX_hex_F",
	"arifle_ARX_ghex_F",
	"arifle_ARX_blk_F",
	"arifle_CTAR_blk_F",
	"arifle_CTAR_hex_F",
	"arifle_CTAR_ghex_F"
];	

grenadeLauncherList_2035_CSAT = [
	"arifle_Katiba_GL_F",
	"arifle_CTAR_GL_blk_F",
	"arifle_CTAR_GL_hex_F",
	"arifle_CTAR_GL_ghex_F"
];


//Launcher avalaible for AT
launcherList_2035_CSAT = [
	"launch_RPG32_F",
	"launch_RPG32_green_F",
	"launch_O_Vorona_brown_F"

];	

//Autorifle avalaible for autorifleman
autorifleList_2035_CSAT = [
	"MMG_01_hex_F",
	"LMG_Zafir_F"
];	

//Rifle avalaible for marksman
marksmanrifleList_2035_CSAT = [
	"srifle_DMR_01_F",
	"srifle_DMR_05_blk_F",
	"srifle_DMR_04_F",
	"srifle_GM6_camo_F",
	"srifle_DMR_07_blk_F"
];

//Smg avalaible for all unit
smgList_2035_CSAT = [
	"hgun_Rook40_F",
	"SMG_02_F"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_CSAT	= [
	"optic_Arco",
	"optic_ACO_grn_smg",
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
	"optic_mrco",
	"acc_pointer_IR",
	"optic_ERCO_snd_F",
	"muzzle_snds_m_snd_F",
	"optic_Arco_blk_F",
	"acc_pointer_IR",
	"bipod_02_F_hex",
	"bipod_02_F_blk"
];

//Long range scope avalaible for marksman
attachmentLongList_2035_CSAT	= [
	"optic_sos",
	"optic_khs_tan",
	"optic_nvs",
	"muzzle_snds_B_snd_F",
	"optic_AMS_snd",
	"optic_DMS",
	"optic_KHS_blk",
	"optic_Nightstalker",
	"optic_LRPS"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_2035_CSAT = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"B_UavTerminal",
	"ItemGPS",
	"Binocular",
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
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_RangeCard",
	"SmokeShell",
	"SmokeShellRed",
	"SmokeShellOrange",
	"SmokeShellYellow",
	"NVGoggles_OPFOR"
];

//item avalaible for all engineer
itemEngineerList_2035_CSAT = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch",
	"ACE_Clacker"
];

//item avalaible for all medic
itemMedicList_2035_CSAT = [
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
backPackList_2035_CSAT = [
	"B_FieldPack_ocamo",
	"B_FieldPack_oucamo",
	"B_FieldPack_Taiga_F",
	"B_Carryall_ocamo",
	"B_Carryall_Taiga_F",
	"B_Carryall_oucamo",
	"tfar_mr3000"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_CSAT = [
	"H_HelmetLeaderO_ocamo",
	"U_O_CombatUniform_ocamo",
	"V_TacVest_khk",
	"V_HarnessO_brn",
	"V_BandollierB_khk",
	"H_MilCap_ocamo",
	"H_HelmetLeaderO_ghex_F",
	"U_O_T_Soldier_F",
	"U_O_CombatUniform_oucamo",
	"V_HarnessO_gry",
	"H_HelmetO_oucamo"
];

factionDefaultRadios_2035_CSAT = [
	"tfar_fadak"
];

//Magazine avalaible for all unit
//Special note throwing items must be placed here too
magazineList_2035_CSAT = [
	"16Rnd_9x21_Mag",
	"30Rnd_580x42_Mag_F",
	"RPG32_F",
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell",
	"SmokeShell",
	"30Rnd_65x39_caseless_green",
	"30Rnd_65x39_caseless_green_mag_Tracer",
	"150Rnd_93x64_Mag",
	"10Rnd_762x54_Mag",
	"150Rnd_762x54_Box",
	"10Rnd_93x64_DMR_05_Mag",
	"30Rnd_9x21_Mag_SMG_02_Tracer_Green",
	"Vorona_HEAT",
	"Vorona_HE",
	"10Rnd_127x54_Mag",
	"5Rnd_127x108_Mag",
	"20Rnd_556x45_UW_mag",
	"30Rnd_65x39_caseless_green",
	"10Rnd_50BW_Mag_F",
	"20Rnd_650x39_Cased_Mag_F",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow"
];

//Get magazine with following command
//getArray (configfile >> "CfgWeapons" >> weaponName >> "magazines");