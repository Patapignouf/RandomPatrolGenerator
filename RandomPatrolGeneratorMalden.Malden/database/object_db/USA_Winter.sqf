c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman";
c_sniper = "sniper";  
c_medic = "medic";
c_grenadier = "grenadier";
c_drone = "UAV opérator";
c_pilot = "pilot";

//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack ["_USA_Winter",30,"US Army Winter [CUP]", true, false, false];
};

////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_USA_Winter = [
	"CUP_B_M1030_USMC",
	"CUP_B_MTVR_USMC",
	"CUP_I_nM1025_Unarmed_ION_WIN", 
	"CUP_I_nM1025_Unarmed_DF_ION_WIN", 
	"CUP_I_nM1038_4s_ION_WIN",
	"CUP_B_TowingTractor_CZ"
];

bluforArmedVehicle_USA_Winter = [
	"CUP_I_nM1025_M2_ION_WIN", 
	"CUP_I_nM1025_M240_ION_WIN", 
	"CUP_I_RG31E_M2_W_ION",
	"CUP_B_nM1025_SOV_Mk19_ION_WIN", 
	"CUP_I_nM1036_TOW_DF_ION_WIN"
	
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_USA_Winter = [
	"CUP_B_M1A1FEP_OD_USMC"
];

bluforUnarmedVehicleChopper_USA_Winter = [
	"CUP_MH60S_Unarmed_FFV_USN"
];

bluforArmedChopper_USA_Winter = [
	"CUP_B_AH1Z_Dynamic_USMC", 
	"CUP_B_MH60S_USMC", 
	"CUP_B_MH60L_DAP_4x_USN"
];

bluforDrone_USA_Winter = [
	"CUP_B_USMC_DYN_MQ9"
];

bluforBoat_USA_Winter = [
	"CUP_B_Zodiac_USMC"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_USA_Winter = [
	"CUP_B_A10_DYN_USA", 
	"CUP_B_AV8B_DYN_USMC"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_USA_Winter = [
	"CUP_I_nM1037sc_ION_WIN",
	"CUP_B_M113A1_HQ_olive_USA"
];


////////////////////////
//Loadout management////
////////////////////////


//USA
loadout_USA_Winter = [		
	[c_leader, [["CUP_arifle_M4A1_standard_winter","","CUP_acc_ANPEQ_15_Black","CUP_optic_AC11704_Black",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_gloves_dirty_Winter",[["CUP_30Rnd_556x45_Stanag_Tracer_Green",2,30]]],["CUP_V_PMC_CIRAS_Black_Patrol",[["ACE_elasticBandage",20],["ACE_morphine",3],["ACE_splint",4],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["CUP_30Rnd_556x45_Stanag_Tracer_Green",5,30],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],["B_AssaultPack_blk",[["ACE_EarPlugs",1],["FirstAidKit",3],["CUP_HandGrenade_L109A1_HE",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
	[c_at, [["CUP_arifle_M4A1_standard_winter","","CUP_acc_ANPEQ_15_Black","CUP_optic_AC11704_Black",["CUP_30Rnd_556x45_Stanag",30],[],""],["CUP_launch_M136_Loaded","","","",["CUP_M136_M",1],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_gloves_dirty_Winter",[["CUP_30Rnd_556x45_Stanag_Tracer_Green",2,30]]],["CUP_V_PMC_CIRAS_Black_Patrol",[["ACE_elasticBandage",20],["ACE_morphine",3],["ACE_splint",4],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["CUP_30Rnd_556x45_Stanag_Tracer_Green",4,30],["CUP_15Rnd_9x19_M9",2,15],["CUP_30Rnd_556x45_Stanag_Tracer_Green",4,30]]],["B_AssaultPack_blk",[["ACE_EarPlugs",1],["FirstAidKit",3],["CUP_HandGrenade_L109A1_HE",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
	[c_rifleman, [["CUP_arifle_M4A1_standard_winter","","CUP_acc_ANPEQ_15_Black","CUP_optic_AC11704_Black",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_gloves_dirty_Winter",[["CUP_30Rnd_556x45_Stanag_Tracer_Green",2,30]]],["CUP_V_PMC_CIRAS_Black_Patrol",[["ACE_elasticBandage",20],["ACE_morphine",3],["ACE_splint",4],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1], ["CUP_30Rnd_556x45_Stanag_Tracer_Green",4,30],["CUP_15Rnd_9x19_M9",2,15]]],[],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],//Default stuff
	[c_engineer, [["CUP_arifle_M4A1_standard_winter","","CUP_acc_ANPEQ_15_Black","CUP_optic_AC11704_Black",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_gloves_dirty_Winter",[["CUP_30Rnd_556x45_Stanag_Tracer_Green",5,30]]],["CUP_V_PMC_CIRAS_Black_Patrol",[["ACE_elasticBandage",20],["ACE_morphine",3],["ACE_splint",4],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],["B_Carryall_blk",[["ACE_DefusalKit",1],["ACE_EntrenchingTool",1],["ACE_Fortify",1],["ToolKit",1],["MineDetector",1]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
	[c_autorifleman, [["CUP_lmg_Mk48","","CUP_acc_ANPEQ_15_Black","CUP_optic_ElcanM145_3D",["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",100],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_Winter",[]],["CUP_V_PMC_CIRAS_Black_Patrol",[["ACE_elasticBandage",28],["ACE_morphine",4],["ACE_splint",6],["ACE_tourniquet",2],["ACE_CableTie",2],["ACE_MapTools",1],["ACE_WaterBottle",1],["ACE_EarPlugs",1],["ACE_microDAGR",1],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],["B_Carryall_blk",[["150Rnd_762x51_Box",6,150]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152_3","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
	[c_marksman, [["CUP_srifle_M2010_blk","","","CUP_optic_LeupoldMk4",["CUP_5Rnd_762x67_M2010_M",5],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_Winter",[]],["CUP_V_PMC_CIRAS_Black_Patrol",[["ACE_elasticBandage",28],["ACE_morphine",4],["ACE_splint",6],["ACE_tourniquet",2],["ACE_CableTie",2],["ACE_MapTools",1],["ACE_WaterBottle",1],["ACE_EarPlugs",1],["ACE_microDAGR",1],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],["B_AssaultPack_blk",[["CUP_15Rnd_9x19_M9",1,15],["CUP_5Rnd_TE1_Red_Tracer_762x67_M2010_M",8,5]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
	[c_sniper, [["CUP_srifle_M107_Snow","","","CUP_optic_LeupoldMk4_25x50_LRT_SNOW",["CUP_10Rnd_127x99_M107",10],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["U_I_FullGhillie_ard",[]],["CUP_V_PMC_CIRAS_Black_Empty",[["ACE_elasticBandage",20],["ACE_morphine",3],["ACE_splint",4],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1]]],["B_AssaultPack_blk",[["CUP_10Rnd_127x99_M107",6,10],["CUP_15Rnd_9x19_M9",1,15]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
	[c_medic, [["CUP_arifle_M4A1_standard_winter","","CUP_acc_ANPEQ_15_Black","CUP_optic_AC11704_Black",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_gloves_dirty_Winter",[["CUP_30Rnd_556x45_Stanag_Tracer_Green",2,30]]],["CUP_V_PMC_CIRAS_Black_Patrol",[["ACE_elasticBandage",20],["ACE_morphine",3],["ACE_splint",4],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],["B_Carryall_blk",[["ACE_EarPlugs",1],["Medikit",1],["ACE_bodyBag",1],["ACE_bodyBag_blue",1],["ACE_bodyBag_white",1],["CUP_HandGrenade_L109A1_HE",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
	[c_grenadier, [["CUP_arifle_M4A1_BUIS_GL","","CUP_acc_ANPEQ_15_Black","CUP_optic_AC11704_Black",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_gloves_dirty_Winter",[["CUP_30Rnd_556x45_Stanag_Tracer_Green",2,30]]],["CUP_V_PMC_CIRAS_Black_Patrol",[["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],["B_AssaultPack_blk",[["ACE_EarPlugs",1],["FirstAidKit",3],["CUP_30Rnd_556x45_Stanag_Tracer_Green",4,30],["CUP_HandGrenade_L109A1_HE",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["1Rnd_HE_Grenade_shell",4,1],["CUP_1Rnd_Smoke_M203",4,1],["CUP_1Rnd_StarCluster_White_M203",1,1]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],//Default stuff
	[c_drone, [["CUP_arifle_M4A1_standard_winter","","CUP_acc_ANPEQ_15_Black","CUP_optic_AC11704_Black",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_B_BDUv2_gloves_dirty_Winter",[["CUP_30Rnd_556x45_Stanag_Tracer_Green",2,30]]],["CUP_V_PMC_CIRAS_Black_Patrol",[["ACE_elasticBandage",20],["ACE_morphine",3],["ACE_splint",4],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],["B_AssaultPack_blk",[["ACE_EarPlugs",1],["FirstAidKit",3],["CUP_30Rnd_556x45_Stanag_Tracer_Green",4,30],["CUP_HandGrenade_L109A1_HE",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],"CUP_H_OpsCore_Black","CUP_PMC_Facewrap_Winter",["Rangefinder","","","",[],[],""],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
	[c_pilot,"CUP_B_US_Pilot"]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_USA_Winter = [
	//AR	
	"CUP_arifle_M4A1_MOE_short_winter",
	"CUP_arifle_M4A1_standard_short_winter",
	"CUP_arifle_M4A1_MOE_winter",
	"CUP_arifle_M4A1_standard_winter",
	"CUP_arifle_M4A1_SOMMOD_snow",
	"CUP_arifle_M4A1_SOMMOD_Grip_snow",

	//Pistol
	"CUP_hgun_M9"
];	


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_USA_Winter = [		
	"CUP_arifle_mk18_m203_tan_holo_laserflash",
	"CUP_arifle_M16A4_GL_ACOG_Laser",
	"CUP_arifle_mk18_m203_black",
	"CUP_arifle_M4A1_M203_CCO_Laser",
	"CUP_arifle_Colt727_M203"
];

launcherList_USA_Winter = [		
	"CUP_launch_Javelin",
	"CUP_launch_FIM92Stinger_Loaded",
	"CUP_launch_MAAWS",
	"CUP_launch_MAAWS_Scope",
	"CUP_launch_M136_Loaded"
];	

autorifleList_USA_Winter = [			
	"CUP_lmg_Mk48",
	"CUP_lmg_M249",
	"CUP_lmg_m249_pip2",
	"CUP_lmg_M240_B"
];	

marksmanrifleList_USA_Winter = [		
	"CUP_srifle_M107_Snow",
	"CUP_srifle_M2010_winter",
	"CUP_srifle_RSASS_Winter"
];

smgList_USA_Winter = [		
	"CUP_smg_MP7",
	"CUP_smg_MP5SD6"
];



//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_USA_Winter = [
	"CUP_optic_AC11704_Black",
	"CUP_optic_VortexRazor_UH1_Black",		
	"CUP_optic_artel_m14",
	"CUP_optic_artel_m14_pip",
	"CUP_optic_Aimpoint_5000",
	"CUP_optic_HoloBlack",
	"CUP_optic_Eotech553_Black",		
	"CUP_optic_CompM2_Black",			
	"CUP_optic_CompM2_low",			
	"CUP_optic_CompM4",
	"CUP_optic_MicroT1",			
	"CUP_optic_MicroT1_low",			
	"CUP_optic_MARS",
	"CUP_optic_MEPRO",
	"CUP_optic_MEPRO_openx_orange",
	"CUP_optic_MEPRO_moa_clear",
	"CUP_optic_MEPRO_tri_clear",
	"CUP_optic_SUSAT",
	"CUP_optic_SUSAT_PIP",
	"CUP_optic_SUSAT_3D",
	"CUP_optic_ACOG",  //Add but too versatile optics to test players new choice
	"CUP_optic_ACOG_PIP",
	"CUP_optic_ACOG_3D",
	"CUP_optic_ACOG2",
	"CUP_optic_ACOG2_PIP",
	"CUP_optic_ACOG2_3D",
	"CUP_optic_RCO",
	"CUP_optic_ACOG_TA01NSN_Black_PIP",
	"CUP_optic_ACOG_TA01NSN_Black_3D",
	"CUP_optic_ACOG_TA01B_Black",
	"CUP_optic_ACOG_TA01B_Black_PIP",
	"CUP_optic_ACOG_TA01B_Black_3D",
	"CUP_optic_ZDDot",
	"CUP_optic_MRad",
	"CUP_optic_TrijiconRx01_black",
	"CUP_optic_TrijiconRx01_kf_black",
	"CUP_optic_ZeissZPoint",
	"CUP_optic_HensoldtZO",
	"CUP_optic_ElcanM145",
	"CUP_optic_ElcanM145_PIP",
	"CUP_optic_ElcanM145_3D",
	"CUP_acc_ANPEQ_15",
	"CUP_acc_ANPEQ_15_Black",
	"CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L",
	"CUP_acc_ANPEQ_2",
	"CUP_acc_ANPEQ_2_Black_Top",
	"CUP_acc_ANPEQ_2_desert",
	"CUP_acc_ANPEQ_2_grey",
	"CUP_bipod_Harris_1A2_L_BLK",
	"CUP_bipod_VLTOR_Modpod",
	"CUP_muzzle_PB6P9",
	"CUP_muzzle_Bizon",
	"CUP_muzzle_PBS4",
	"CUP_muzzle_TGPA",
	"CUP_muzzle_snds_KZRZP_Base",
	"CUP_muzzle_snds_KZRZP_SVD",
	"CUP_muzzle_snds_KZRZP_AK762",
	"CUP_muzzle_snds_KZRZP_AK545",
	"CUP_muzzle_snds_KZRZP_PK",
	"CUP_optic_LeupoldMk4_CQ_T",
	"CUP_optic_SB_11_4x20_PM_pip",
	"CUP_acc_ANPEQ_2_grey",
	"CUP_optic_MAAWS_Scope"
];

attachmentLongList_USA_Winter = [
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_11_4x20_PM_pip",
	"CUP_optic_SB_3_12x50_PMII",
	"CUP_optic_SB_3_12x50_PMII_PIP",
	"CUP_optic_LeupoldMk4_25x50_LRT_SNOW",
	"CUP_optic_LeupoldMk4_25x50_LRT_SNOW_PIP",
	"CUP_optic_LeupoldMk4",
	"CUP_optic_CWS",
	"CUP_optic_CWS_NV",
	"CUP_optic_CWS_NV_RDS",
	"CUP_U_CRYE_G3C_MC_US",
	"CUP_V_CPC_tlbelt_mc",
	"CUP_B_USArmy_MG_SpecOp",
	"CUP_H_OpsCore_Tan_SF",
	"CUP_optic_LeupoldMk4_MRT_tan",
	"CUP_optic_LeupoldMk4_MRT_tan_pip",
	"CUP_optic_LeupoldMk4_pip"
];

////////////////////////
////Items management////
////////////////////////
itemList_USA_Winter = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"Laserdesignator",
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
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP"
	];

itemEngineerList_USA_Winter = [
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
	
itemMedicList_USA_Winter = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];


//backpack avalaible for all unit
backPackList_USA_Winter = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"CUP_B_USPack_Black",
	"CUP_B_AssaultPack_ACU",
	"B_AssaultPack_blk",
	"B_Carryall_blk",
	"TFAR_rt1523g",
	"TFAR_rt1523g_sage"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_USA_Winter = [
	//Uniform
	"CUP_U_B_BDUv2_Winter",
	"CUP_U_B_BDUv2_dirty_Winter",
	"CUP_U_B_BDUv2_gloves_Winter",
	"CUP_U_B_BDUv2_gloves_dirty_Winter",
	"CUP_U_B_BDUv2_Winter_M81",
	"CUP_U_B_BDUv2_dirty_M81_Winter",

	//Head 
	"CUP_H_PMC_Cap_EP_Grey",
	"CUP_H_PMC_Beanie_Headphones_Winter",
	"H_Watchcap_blk",

	//Vest
	"CUP_V_PMC_CIRAS_Black_Veh",
	"CUP_V_PMC_CIRAS_Black_Patrol",
	"CUP_V_PMC_CIRAS_Winter_Patrol"
	];

uniformListSniper_USA_Winter = [
	"CUP_U_B_CZ_DST_Ghillie",
	"U_B_FullGhillie_ard"
];

//Magazine avalaible for all unit
magazineList_USA_Winter = 	[
	"30Rnd_556x45_Stanag_Tracer_Green",
	"CUP_1Rnd_HEDP_M203",
	"CUP_1Rnd_HE_M203",
	"CUP_FlareWhite_M203",
	"CUP_Javelin_M",
	"CUP_Stinger_M",
	"CUP_MAAWS_HEAT_M",
	"CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M",
	"CUP_200Rnd_TE4_Red_Tracer_556x45_M249",
	"CUP_20Rnd_556x45_Stanag",
	"CUP_5Rnd_762x51_M24",
	"CUP_20Rnd_762x51_B_M110",
	"CUP_40Rnd_46x30_MP7",
	"CUP_15Rnd_9x19_M9",
	"20Rnd_762x51_Mag",
	"CUP_HandGrenade_M67",
	"CUP_20Rnd_762x51_B_SCAR",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"Laserbatteries"
];