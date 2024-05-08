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
		factionInfos pushBack ["_HorizonIslandSF", 24, "Horizon Island SF [CUP]", true, true, true];
};

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//USA
civilian_group_HorizonIslandSF = ["C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F"];

civilian_big_group_HorizonIslandSF = ["C_Man_1_enoch_F", 
"C_Man_2_enoch_F", 
"C_Man_3_enoch_F", 
"C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F", 
"C_Farmer_01_enoch_F" ];

civilianTruck_HorizonIslandSF = ["CUP_C_Octavia_CIV", 
"C_Offroad_01_comms_F", 
"C_Hatchback_01_sport_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_HorizonIslandSF = [
	"CUP_B_HIL_SL_SF", 
	"CUP_B_HIL_MMG_SF", 
	"CUP_B_HIL_Soldier_SF", 
	"CUP_B_HIL_GL_SF", 
	"CUP_B_HIL_Soldier_MAT_SF", 
	"CUP_B_HIL_Medic_SF", 
	"CUP_B_HIL_M_SF"
];

baseEnemyATGroup_HorizonIslandSF = [
	"CUP_B_HIL_Soldier_MAT_SF", 
	"CUP_B_HIL_Soldier_HAT_SF", 
	"CUP_B_HIL_Engineer_SF", 
	"CUP_B_HIL_GL_SF"
];

baseEnemyDemoGroup_HorizonIslandSF = [
	"CUP_B_HIL_GL_Recon", 
	"CUP_B_HIL_Engineer_Recon", 
	"CUP_B_HIL_M_Recon", 
	"CUP_B_HIL_Soldier_Recon"
];

baseEnemyMortarGroup_HorizonIslandSF = [
	"CUP_B_HIL_Scout_SF", 
	"CUP_B_HIL_Scout_SF",
	"CUP_B_M252_HIL"
];

baseEnemyVehicleGroup_HorizonIslandSF = [
	"CUP_B_M151_M2_HIL"
];

baseEnemyLightArmoredVehicleGroup_HorizonIslandSF = [
	"CUP_B_Boxer_HMG_HIL", 
	"CUP_B_Boxer_GMG_HIL"
];

baseEnemyHeavyArmoredVehicleGroup_HorizonIslandSF = [
	"CUP_B_Leopard2A6_HIL"
];

baseEnemyUnarmedChopperGroup_HorizonIslandSF = [
	"CUP_B_AW159_Unarmed_HIL", 
	"CUP_B_412_Mil_Transport_HIL",
	"CUP_B_CH47F_HIL"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_HorizonIslandSF = [
	"CUP_B_JAS39_HIL", 
	"CUP_I_CESSNA_T41_ARMED_HIL"
];

////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_HorizonIslandSF = [
	"CUP_B_MTVR_HIL", 
	"CUP_B_M151_HIL"
];

bluforArmedVehicle_HorizonIslandSF = [
	"CUP_B_M151_M2_HIL"
];

bluforUnarmedVehicleChopper_HorizonIslandSF = [
	"CUP_B_AW159_Unarmed_HIL", 
	"CUP_B_412_Mil_Transport_HIL"
];

bluforArmedChopper_HorizonIslandSF = [
	"CUP_B_CH47F_HIL", 
	"CUP_B_412_Military_Armed_HIL"
];

bluforDrone_HorizonIslandSF = [

];

bluforBoat_HorizonIslandSF = [
	"CUP_B_HIL_Boat_Transport_01_F", 
	"CUP_B_LCU1600_HIL", 
	"CUP_B_RHIB_HIL", 
	"CUP_B_RHIB2Turret_HIL"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_HorizonIslandSF = [
	"CUP_B_JAS39_HIL", 
	"CUP_I_CESSNA_T41_ARMED_HIL"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_HorizonIslandSF = [
	"CUP_B_Boxer_Empty_HIL"
];


////////////////////////
//Loadout management////
////////////////////////


//USA
loadout_HorizonIslandSF = [		
	[c_leader, [["CUP_arifle_Mk16_STD_EGLM_woodland","CUP_muzzle_snds_SCAR_L","CUP_acc_ANPEQ_15_OD","CUP_optic_Eotech553_OD",["CUP_30Rnd_556x45_Stanag_Mk16_woodland",30],["CUP_1Rnd_HE_M203",1],""],[],["CUP_hgun_mk23_snds_lam","CUP_muzzle_snds_mk23","CUP_acc_mk23_lam_l","",["CUP_12Rnd_45ACP_mk23",12],[],""],["CUP_U_B_HIL_ACU_Kneepad_Rolled_Gloves_TTS",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag_Mk16_woodland",3,30]]],["CUP_V_PMC_CIRAS_OD_Grenadier",[["CUP_30Rnd_556x45_Stanag_Mk16_woodland",4,30],["CUP_1Rnd_HE_M203",5,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["CUP_12Rnd_45ACP_mk23",3,12]]],[],"CUP_H_HIL_HelmetACH_ESS_Headset_TTS","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_at, "CUP_B_HIL_Soldier_MAT_SF"],
	[c_rifleman,"CUP_B_HIL_Soldier_SF"],//Default stuff
	[c_engineer,"CUP_B_HIL_Engineer_SF"],
	[c_autorifleman, "CUP_B_HIL_MMG_SF"],
	[c_marksman,"CUP_B_HIL_Scout_SF"],
	[c_medic,"CUP_B_HIL_Medic_SF"],
	[c_grenadier, "CUP_B_HIL_GL_SF"],//Default stuff
	[c_pilot,"CUP_B_HIL_Pilot"]
];



////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_HorizonIslandSF = [		
	"CUP_arifle_Mk16_CQC_FG_woodland",
	"CUP_hgun_mk23"
];	


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_HorizonIslandSF = [		
	"CUP_arifle_Mk16_STD_EGLM_woodland"
];

launcherList_HorizonIslandSF = [		
	"CUP_launch_Mk153Mod0_SMAWOptics",
	"CUP_launch_APILAS",
	"CUP_launch_FIM92Stinger"
];	

autorifleList_HorizonIslandSF = [			
	"CUP_lmg_M60E4_jungle"
];	

marksmanrifleList_HorizonIslandSF = [		
	"CUP_arifle_Mk17_CQC_woodland"
];

smgList_HorizonIslandSF = [		
	"CUP_smg_MP7",
	"CUP_smg_MP5SD6"
];



//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_HorizonIslandSF	= [
	"CUP_acc_ANPEQ_15_OD",
	"CUP_optic_CompM2_low",
	"CUP_optic_G33_HWS_OD",
	"CUP_optic_G33_HWS_OD_DWN",
	"CUP_optic_MicroT1_OD",
	"CUP_optic_Eotech553_OD",
	"CUP_optic_Eotech553_Black",
	"CUP_muzzle_snds_mk23",
	"CUP_muzzle_snds_SCAR_L",
	"CUP_acc_mk23_lam_l",
	"CUP_muzzle_snds_MP7"
];

attachmentLongList_HorizonIslandSF	= [
	"CUP_optic_SB_11_4x20_PM_od",
	"CUP_optic_SB_11_4x20_PM_od_PIP",
	"CUP_optic_LeupoldMk4_10x40_LRT_Woodland",
	"CUP_optic_LeupoldMk4_10x40_LRT_Woodland_pip",
	"CUP_muzzle_snds_SCAR_H",
	"CUP_bipod_VLTOR_Modpod_od"
];

////////////////////////
////Items management////
////////////////////////
itemList_HorizonIslandSF = [
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

itemEngineerList_HorizonIslandSF = [
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
	
itemMedicList_HorizonIslandSF = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];


//backpack avalaible for all unit
backPackList_HorizonIslandSF = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"B_TacticalPack_oli",
	"TFAR_rt1523g"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_HorizonIslandSF = [
	"CUP_V_MBSS_PACA2_Green",
	"CUP_H_HIL_HelmetACH_Headset_TTS",
	"CUP_U_B_HIL_ACU_Gloves_TTS",
	"CUP_H_HIL_HelmetACH_GCovered_Headset_TTS",
	"CUP_H_Booniehat_TTS",
	"CUP_H_HIL_HelmetACH_ESS_Headset_TTS"
	];

//Magazine avalaible for all unit
magazineList_HorizonIslandSF = 	[
	"CUP_30Rnd_556x45_Stanag_Mk16_woodland",
	"CUP_12Rnd_45ACP_mk23",
	"CUP_1Rnd_HE_M203",
	"CUP_1Rnd_HE_M203",
	"CUP_40Rnd_46x30_MP7",
	"CUP_20Rnd_762x51_B_SCAR_wdl",
	"CUP_SMAW_HEAA_M",
	"CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"CUP_HandGrenade_M67"
];