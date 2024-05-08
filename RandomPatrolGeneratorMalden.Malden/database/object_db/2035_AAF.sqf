#include "..\classConstant.sqf"


factionInfos pushBack ["_2035_AAF", 13,"2035 AAF", true, true, false];


//////////////////////////////
////Define civ group data/////
//////////////////////////////


civilian_group_2035_AAF = [
	"C_Man_casual_9_F", 
	"C_Man_casual_4_v2_F", 
	"C_Man_casual_6_v2_F", 
	"C_Man_casual_7_F", 
	"C_Man_ConstructionWorker_01_Blue_F"
];

civilian_big_group_2035_AAF = [
	"C_Man_casual_9_F", 
	"C_Man_casual_4_v2_F", 
	"C_Man_casual_6_v2_F", 
	"C_Man_casual_7_F", 
	"C_Man_ConstructionWorker_01_Blue_F", 
	"C_man_w_worker_F", 
	"C_Man_UtilityWorker_01_F", 
	"C_man_polo_2_F" 
];

civilianTruck_2035_AAF = [
	"C_Hatchback_01_sport_F", 
	"C_Hatchback_01_F", 
	"C_SUV_01_F", 
	"C_Quadbike_01_F", 
	"C_Van_01_box_F", 
	"C_Van_01_fuel_F", 
	"C_Offroad_01_repair_F"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

baseEnemyGroup_2035_AAF = [
	"I_soldier_F", 
	"I_Soldier_AR_F", 
	"I_Soldier_AR_F",
	"I_Soldier_GL_F", 
	"I_medic_F",
	"I_Soldier_M_F", 
	"I_Soldier_LAT2_F", 
	"I_soldier_F", 
	"I_medic_F"
];


baseEnemyATGroup_2035_AAF = [
	"I_soldier_F", 
	"I_Soldier_AT_F", 
	"I_Soldier_LAT2_F",
	"I_support_GMG_F", 
	"I_support_AMG_F"
];

baseEnemyDemoGroup_2035_AAF = [
	"I_soldier_F", 
	"I_Soldier_AAT_F", 
	"I_Soldier_GL_F", 
	"I_soldier_mine_F",
	"I_soldier_UAV_F"
];

baseEnemyMortarGroup_2035_AAF = [
	"I_Mortar_01_F",
	"I_soldier_F", 
	"I_Soldier_AR_F", 
	"I_ghillie_sard_F"
];

baseEnemyVehicleGroup_2035_AAF = [
	"I_MRAP_03_F", 
	"I_MRAP_03_hmg_F", 
	"I_Truck_02_transport_F"
];

baseEnemyLightArmoredVehicleGroup_2035_AAF = [
	"I_LT_01_AT_F", 
	"I_LT_01_scout_F", 
	"I_LT_01_cannon_F"
];

baseEnemyHeavyArmoredVehicleGroup_2035_AAF = [
	"I_MBT_03_cannon_F", 
	"I_APC_Wheeled_03_cannon_F", 
	"I_APC_tracked_03_cannon_F"
];

baseEnemyUnarmedChopperGroup_2035_AAF = [
	"I_Heli_Transport_02_F", 
	"I_Heli_light_03_unarmed_F"
];

baseEnemyArmedChopperGroup_2035_AAF = [
	"I_Heli_light_03_dynamicLoadout_F"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_2035_AAF = [
	"I_Plane_Fighter_03_dynamicLoadout_F", 
	"I_Plane_Fighter_04_F"
];


////////////////////////
//Vehicle management////
////////////////////////
bluforUnarmedVehicle_2035_AAF = [
	"I_Truck_02_transport_F", 
	"I_Truck_02_covered_F", 
	"I_MRAP_03_F",
	"I_Quadbike_01_F"
];

bluforArmedVehicle_2035_AAF = [
	"I_MRAP_03_hmg_F"
];

bluforArmoredVehicle_2035_AAF = [
	"I_APC_tracked_03_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_LT_01_cannon_F",
	"I_MBT_03_cannon_F"
];

bluforUnarmedVehicleChopper_2035_AAF = [
	"I_Heli_Transport_02_F", 
	"I_Heli_light_03_unarmed_F"
];

bluforArmedChopper_2035_AAF = [
	"I_Heli_light_03_dynamicLoadout_F"
];


bluforDrone_2035_AAF = [
	"I_UAV_02_dynamicLoadout_F"
];

bluforBoat_2035_AAF = [
	
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_AAF = [
	"I_Plane_Fighter_03_dynamicLoadout_F", 
	"I_Plane_Fighter_04_F"
];

bluforHQVehicle_2035_FIA = [
	"I_Truck_02_covered_F",
	"I_LT_01_scout_F"
];


////////////////////////
//Loadout management////
////////////////////////

loadout_2035_AAF = [		
	[c_leader,"I_Soldier_SL_F"],
	[c_at,"I_Soldier_AT_F"],
	[c_rifleman,"I_soldier_F"],//Default stuff
	[c_engineer,"I_engineer_F"],
	[c_autorifleman,"I_Soldier_AR_F"],
	[c_marksman,"I_Soldier_M_F"],
	[c_medic,"I_medic_F"],
	[c_grenadier,"I_Soldier_GL_F"],
	[c_drone,"I_soldier_UAV_F"],
	[c_pilot,"I_helipilot_F"]
];

////////////////////////
///Weapon management////
////////////////////////
rifleList_2035_AAF = [		
	"arifle_Mk20_F",
	"arifle_Mk20_plain_F",
	"arifle_Mk20C_F",
	"arifle_Mk20C_plain_F",
	"hgun_ACPC2_F"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_2035_AAF = [		
	"arifle_Mk20_GL_F",
	"arifle_Mk20_GL_plain_F"
];

launcherList_2035_AAF = [		
	"launch_I_Titan_short_F",
	"launch_I_Titan_F",
	"launch_NLAW_F",
	"ACE_launch_NLAW_ready_F"
];	

autorifleList_2035_AAF = [			
	"LMG_Mk200_F"
];	


marksmanrifleList_2035_AAF = [		
	"srifle_EBR_F",
	"srifle_GM6_F"
];

smgList_2035_AAF = [		
	"hgun_ACPC2_F",
	"hgun_PDW2000_F"
];

           
//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_2035_AAF	= [
	"acc_pointer_IR",
	"optic_MRCO",
	"optic_ACO_grn",
	"optic_Holosight_smg",
	"bipod_03_F_blk",
	"muzzle_snds_H",
	"acc_pointer_IR"
];

attachmentLongList_2035_AAF	= [
	"optic_LRPS",
	"optic_tws"
];

////////////////////////
////Items management////
////////////////////////
itemList_2035_AAF = [
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
	"ACE_NVG_Wide_Green_WP",
	"NVGoggles_INDEP"
];

itemEngineerList_2035_AAF = [
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
	"ace_marker_flags_red"
];
	
itemMedicList_2035_AAF = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];


backPackList_2035_AAF = [
	"B_Fieldpack_oli_AT",
	"B_Fieldpack_oli_Medic",
	"B_Fieldpack_oli",
	"B_TacticalPack_oli",
	"B_Fieldpack_oli_Ammo",
	"B_Carryall_oli",
	"tfar_anprc155"
];

uniformList_2035_AAF = [
	"U_I_CombatUniform_shortsleeve",
	"U_I_CombatUniform",
	"V_PlateCarrierIA2_dgtl",
	"H_HelmetIA",
	"H_MilCap_dgtl",
	"H_Booniehat_dgtl",
	"V_Chestrig_oli"
];

factionDefaultRadios_2035_AAF = [
	"tfar_anprc148jem"
];

magazineList_2035_AAF = [
	"30Rnd_556x45_Stanag",
	"30Rnd_556x45_Stanag_Tracer_Green",
	"9Rnd_45ACP_Mag",
	"30Rnd_9x21_Yellow_Mag",
	"5Rnd_127x108_Mag",
	"200Rnd_65x39_cased_Box",
	"Titan_AT",
	"Titan_AP",
	"Titan_AA",
	"20Rnd_762x51_Mag",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"HandGrenade",
	"O_IR_Grenade"
];