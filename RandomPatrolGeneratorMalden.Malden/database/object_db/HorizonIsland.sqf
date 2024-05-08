c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";
c_drone = "UAV opérator";
c_pilot = "pilot";

//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack ["_HorizonIsland", 23, "Horizon Island [CUP]", true, true, true];
};

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//USA
civilian_group_HorizonIsland = ["C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F"];

civilian_big_group_HorizonIsland = ["C_Man_1_enoch_F", 
"C_Man_2_enoch_F", 
"C_Man_3_enoch_F", 
"C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F", 
"C_Farmer_01_enoch_F" ];

civilianTruck_HorizonIsland = ["CUP_C_Octavia_CIV", 
"C_Offroad_01_comms_F", 
"C_Hatchback_01_sport_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_HorizonIsland = [
	"CUP_B_HIL_SL_Res", 
	"CUP_B_HIL_MMG_Res", 
	"CUP_B_HIL_Soldier_Res", 
	"CUP_B_HIL_GL_Res", 
	"CUP_B_HIL_Soldier_MAT_Res", 
	"CUP_B_HIL_Medic_Res", 
	"CUP_B_HIL_M_Res"
];

baseEnemyATGroup_HorizonIsland = [
	"CUP_B_HIL_SL_Recon",
	"CUP_B_HIL_Medic_Recon",
	"CUP_B_HIL_Soldier_HAT_Recon",
	"CUP_B_HIL_Soldier_MAT_Recon"
];

baseEnemyDemoGroup_HorizonIsland = [
	"CUP_B_HIL_GL_Recon", 
	"CUP_B_HIL_Engineer_Recon", 
	"CUP_B_HIL_M_Recon", 
	"CUP_B_HIL_Soldier_Recon"
];

baseEnemyMortarGroup_HorizonIsland = [
	"CUP_B_HIL_M", 
	"CUP_B_HIL_M",
	"CUP_B_M252_HIL"
];

baseEnemyVehicleGroup_HorizonIsland = [
	"CUP_B_M151_M2_HIL"
];

baseEnemyLightArmoredVehicleGroup_HorizonIsland = [
	"CUP_B_Boxer_HMG_HIL", 
	"CUP_B_Boxer_GMG_HIL" 
];

baseEnemyHeavyArmoredVehicleGroup_HorizonIsland = [
	"CUP_B_Leopard2A6_HIL"
];

baseEnemyUnarmedChopperGroup_HorizonIsland = [
	"CUP_B_AW159_Unarmed_HIL", 
	"CUP_B_412_Mil_Transport_HIL",
	"CUP_B_CH47F_HIL"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_HorizonIsland = [
	"CUP_B_JAS39_HIL", 
	"CUP_I_CESSNA_T41_ARMED_HIL"
];

////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_HorizonIsland = [
	"CUP_B_MTVR_HIL", 
	"CUP_B_M151_HIL"
];

bluforArmedVehicle_HorizonIsland = [
	"CUP_B_M151_M2_HIL"
];

bluforUnarmedVehicleChopper_HorizonIsland = [
	"CUP_B_AW159_Unarmed_HIL", 
	"CUP_B_412_Mil_Transport_HIL",
	"CUP_B_412_Military_Radar_HIL"
];

bluforArmedChopper_HorizonIsland = [
	"CUP_B_412_Military_Armed_HIL",
	"CUP_B_CH47F_HIL"
];

bluforDrone_HorizonIsland = [

];

bluforBoat_HorizonIsland = [
	"CUP_B_HIL_Boat_Transport_01_F", 
	"CUP_B_LCU1600_HIL", 
	"CUP_B_RHIB_HIL", 
	"CUP_B_RHIB2Turret_HIL"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_HorizonIsland = [
	"CUP_B_JAS39_HIL", 
	"CUP_I_CESSNA_T41_ARMED_HIL"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_HorizonIsland = [
	"CUP_B_Boxer_Empty_HIL"
];


////////////////////////
//Loadout management////
////////////////////////


//USA
loadout_HorizonIsland = [		
	[c_leader, "CUP_B_HIL_Officer"],
	[c_at, "CUP_B_HIL_Soldier_MAT"],
	[c_rifleman,"CUP_B_HIL_Soldier"],//Default stuff
	[c_engineer,"CUP_B_HIL_Engineer"],
	[c_autorifleman, "CUP_B_HIL_MMG"],
	[c_marksman,"CUP_B_HIL_M"],
	[c_medic,"CUP_B_HIL_Medic"],
	[c_grenadier, "CUP_B_HIL_GL"],//Default stuff
	[c_pilot,"CUP_B_HIL_Pilot"]
];


////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_HorizonIsland = [	
	"CUP_Famas_F1_Rail_Wood",
	"CUP_Famas_F1_Wood",
	"CUP_Famas_F1_Rail",
	"CUP_Famas_F1",
	"CUP_Famas_F1_Rail_Arid",
	"CUP_Famas_F1_Arid",
	"CUP_hgun_M9"
];	


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_HorizonIsland = [		
	"CUP_glaunch_M32",
	"CUP_glaunch_M79"
];

launcherList_HorizonIsland = [		
	"CUP_launch_Javelin",
	"CUP_SMAW_HEAA_M",
	"CUP_launch_FIM92Stinger"
];	

autorifleList_HorizonIsland = [			
	"CUP_lmg_M60E4_jungle",
	"CUP_lmg_FNMAG"
];	

marksmanrifleList_HorizonIsland = [		
	"CUP_srifle_M14_DMR",
	"CUP_srifle_M14"
];

smgList_HorizonIsland = [		
	"CUP_smg_MP7"
];



//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_HorizonIsland	= [
	"CUP_optic_Eotech553_OD",
	"CUP_optic_CompM2_low",
	"CUP_optic_G33_HWS_OD",
	"CUP_optic_G33_HWS_OD_DWN",
	"CUP_optic_Eotech553_Black",
	"CUP_optic_G33_HWS_BLK",
	"CUP_optic_G33_HWS_BLK_DWN",
	"CUP_optic_ZeissZPoint"
];

attachmentLongList_HorizonIsland	= [
	"CUP_optic_LeupoldMk4",
	"CUP_optic_LeupoldMk4_pip"
];

////////////////////////
////Items management////
////////////////////////
itemList_HorizonIsland = [
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
	"ACE_CableTie",
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
	"CUP_HandGrenade_M67",
	"CUP_bipod_VLTOR_Modpod_od"
	];

itemEngineerList_HorizonIsland = [
	"Medikit",
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
	
itemMedicList_HorizonIsland = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];


//backpack avalaible for all unit
backPackList_HorizonIsland = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"CUP_B_TacticalPack_CCE",
	"TFAR_rt1523g"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_HorizonIsland = [
	"CUP_U_B_HIL_ACU_Kneepad_Gloves_CCE",
	"H_Cap_oli_hs",
	"CUP_V_B_RRV_MG",
	"CUP_U_B_HIL_ACU_Rolled_Gloves_CCE",
	"CUP_V_B_RRV_Scout",
	"CUP_H_Booniehat_CCE",
	"CUP_V_B_PASGT_CCE",
	"CUP_U_B_BDUv2_roll2_OD",
	"CUP_U_B_HIL_ACU_Rolled_CCE",
	"CUP_H_HIL_HelmetACH_GCovered_Headset_CCE",
	"CUP_H_HIL_HelmetACH_Headset_CCE"
	];

//Magazine avalaible for all unit
magazineList_HorizonIsland = 	[
	"CUP_15Rnd_9x19_M9",
	"CUP_25Rnd_556x45_Famas_Wood",
	"CUP_25Rnd_556x45_Famas",
	"CUP_Javelin_M",
	"CUP_20Rnd_762x51_DMR",
	"CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",
	"CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",
	"CUP_1Rnd_HEDP_M203",
	"CUP_1Rnd_HE_M203",
	"CUP_40Rnd_46x30_MP7",
	"CUP_SMAW_HEAA_M",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"CUP_HandGrenade_M67"
];