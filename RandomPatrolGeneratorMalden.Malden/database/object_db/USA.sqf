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
	factionInfos pushBack ["_USA",1,"US Army [CUP]", true, true, true];
};

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//USA
civilian_group_USA = ["C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F"];

civilian_big_group_USA = ["C_Man_1_enoch_F", 
"C_Man_2_enoch_F", 
"C_Man_3_enoch_F", 
"C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F", 
"C_Farmer_01_enoch_F" ];

civilianTruck_USA = ["CUP_C_Octavia_CIV", 
"C_Offroad_01_comms_F", 
"C_Hatchback_01_sport_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_USA = ["CUP_B_US_Soldier_SL_OCP", 
"CUP_B_US_Soldier_MG_OCP", 
"CUP_B_US_Soldier_MG_OCP",
"CUP_B_US_Soldier_GL_OCP",
"CUP_B_US_Soldier_GL_OCP",  
"CUP_B_US_Soldier_AMG_OCP", 
"CUP_B_US_Soldier_LAT_OCP",
"CUP_B_US_Soldier_LAT_OCP"];

baseEnemyATGroup_USA = ["CUP_B_US_Soldier_TL_OCP", 
"CUP_B_US_Soldier_AT_OCP", 
"CUP_B_US_Soldier_AT_OCP", 
"CUP_B_US_Soldier_AT_OCP", 
"CUP_B_US_Soldier_AAT_OCP"];

baseEnemyDemoGroup_USA = ["CUP_B_US_Soldier_TL_OCP", 
"CUP_B_US_Soldier_MG_OCP", 
"CUP_B_US_Soldier_GL_OCP", 
"CUP_B_US_Soldier_AMG_OCP"];

baseEnemyMortarGroup_USA = ["B_Mortar_01_F",
"CUP_B_US_Soldier_GL_OCP", 
"CUP_B_US_Soldier_AMG_OCP"];

baseEnemyVehicleGroup_USA = ["CUP_B_M1151_Deploy_USA",
"CUP_B_nM1025_SOV_M2_USA_DES",
"CUP_B_nM1025_M240_USA_DES",
"CUP_B_M1165_GMV_DSRT_USMC"];

baseEnemyLightArmoredVehicleGroup_USA = ["CUP_B_M113A3_desert_USA", 
"CUP_B_RG31E_M2_USA", 
"CUP_B_RG31_Mk19_USA"];

baseEnemyHeavyArmoredVehicleGroup_USA = ["CUP_B_M1126_ICV_M2_Desert", 
"CUP_B_M1128_MGS_Desert", 
"CUP_B_M2A3Bradley_USA_D", 
"CUP_B_M1A2SEP_TUSK_II_Desert_US_Army", 
"CUP_B_M1A1SA_Desert_US_Army"];

baseEnemyUnarmedChopperGroup_USA = [
	"CUP_B_UH60M_Unarmed_US",
	"CUP_B_MH6M_OBS_USA",
	"CUP_B_MH6M_USA"
];

////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_USA = [
	"CUP_B_nM1025_Unarmed_DF_USA_DES",
	"CUP_B_MTVR_USMC",
	"CUP_B_MTVR_USA",
	"CUP_B_nM1025_Unarmed_DF_USA_WDL",
	"CUP_B_M1030_USMC"
];

bluforArmedVehicle_USA = [
	"CUP_B_M1151_Deploy_USA",
	"CUP_B_nM1025_SOV_M2_USA_DES",
	"CUP_B_nM1025_M240_USA_DES",
	"CUP_B_M1165_GMV_DSRT_USMC",
	"CUP_B_RG31_M2_USMC", 
	"CUP_B_RG31E_M2_USMC",
	"CUP_B_nM1025_SOV_M2_USA_DES",
	"CUP_B_nM1025_SOV_M2_USA_WDL",
	"CUP_B_nM1025_M2_USA_WDL",
	"CUP_B_M1151_M2_WDL_USA"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_USA = [
	"CUP_B_M7Bradley_USA_W", 
	"CUP_B_LAV25_USMC", 
	"CUP_B_M113A3_USA"
];

bluforUnarmedVehicleChopper_USA = [
	"CUP_B_MH6J_USA",
	"CUP_B_UH60M_Unarmed_US",
	"CUP_B_CH53E_USMC"
];

bluforArmedChopper_USA = [
	"CUP_B_AH64_DL_USA", 
	"CUP_B_AH6M_USA", 
	"CUP_B_UH60M_US", 
	"CUP_B_AH1Z_Dynamic_USMC",
	"CUP_B_AH6J_USA",
	"CUP_B_CH47F_USA", 
	"CUP_B_MH47E_USA"
];

bluforDrone_USA = [
	"B_UAV_02_dynamicLoadout_F"
];

bluforBoat_USA = [
	"CUP_B_RHIB_HIL",
	"CUP_B_Zodiac_USMC"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_USA = [
	"CUP_B_A10_DYN_USA",
	"CUP_B_AV8B_DYN_USMC",
	"CUP_B_F35B_Stealth_USMC"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_USA = [
	"CUP_B_M113A1_HQ_desert_USA",
	"CUP_B_AAV_Unarmed_USMC",
	"CUP_B_M113A3_HQ_USA"
];


////////////////////////
//Loadout management////
////////////////////////


//USA
loadout_USA = [		
	[c_leader, [["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],[],["CUP_hgun_M9_snds","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["CUP_1Rnd_HEDP_M203",1,1],["CUP_1Rnd_SmokeGreen_M203",1,1],["CUP_1Rnd_SmokeRed_M203",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops_TL",[["CUP_1Rnd_HEDP_M203",4,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_at, [["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],["CUP_launch_M136","","","",[],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops",[["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_rifleman,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops",[["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],//Default stuff
	[c_engineer,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USMC_MOLLE_WDL",[["ToolKit",1],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_autorifleman, "CUP_B_US_SpecOps_MG"],
	[c_marksman,"CUP_B_US_SpecOps_M"],
	[c_medic,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9_snds","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_medicalbelt_mc",[["CUP_30Rnd_556x45_Stanag",3,30],["CUP_15Rnd_9x19_M9",1,15],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["CUP_B_USArmy_Medic2",[["Medikit",1],["FirstAidKit",10]]],"CUP_H_OpsCore_Spray_US","CUP_G_Tan_Scarf_GPS_Beard_Blonde",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_grenadier, [["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_1Rnd_HEDP_M203",3,1],["CUP_15Rnd_9x19_M9",1,15],["B_IR_Grenade",1,1],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],["CUP_B_AssaultPack_Coyote_Specops_GL",[["CUP_1Rnd_HEDP_M203",6,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_HandGrenade_M67",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","CUP_G_Oakleys_Drk",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],//Default stuff
	[c_drone,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_Tan_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_communicationsbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_AssaultPack_Coyote_Specops_UAV",[["CUP_HandGrenade_M67",1,1],["SmokeShellRed",2,1],["SmokeShellGreen",2,1]]],"CUP_H_OpsCore_Spray_US_SF","CUP_G_Tan_Scarf_GPS",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_pilot,"CUP_B_US_Pilot"]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_USA = [		
	"CUP_arifle_mk18_black",
	"CUP_arifle_SBR_black",
	"CUP_arifle_M4A1_SOMMOD_Grip_black",
	"CUP_arifle_mk18_tan_holo_laserflash",
	"CUP_hgun_M9",
	"CUP_arifle_M16A4_Base",
	"CUP_arifle_M4A1_black"
];	


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_USA = [		
	"CUP_arifle_mk18_m203_tan_holo_laserflash",
	"CUP_arifle_M16A4_GL_ACOG_Laser",
	"CUP_arifle_mk18_m203_black",
	"CUP_arifle_M4A1_M203_CCO_Laser",
	"CUP_arifle_Colt727_M203"
];

launcherList_USA = [		
	"CUP_launch_Javelin",
	"CUP_launch_FIM92Stinger_Loaded",
	"CUP_launch_MAAWS",
	"CUP_launch_MAAWS_Scope",
	"CUP_launch_M136_Loaded"
];	

autorifleList_USA = [			
	"CUP_lmg_Mk48",
	"CUP_lmg_M249",
	"CUP_lmg_m249_pip2",
	"CUP_lmg_M240_B"
];	

marksmanrifleList_USA = [		
	"CUP_srifle_Mk12SPR",
	"CUP_srifle_M40A3",
	"CUP_srifle_M110_black",
	"CUP_srifle_M110",
	"CUP_srifle_Mk18_blk_LP4",
	"CUP_srifle_M14",
	"CUP_srifle_DMR_LeupoldMk4",
	"CUP_arifle_Mk20"
];

smgList_USA = [		
	"CUP_smg_MP7",
	"CUP_smg_MP5SD6"
];



//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_USA	= [
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

attachmentLongList_USA	= [
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_11_4x20_PM_pip",
	"CUP_optic_SB_3_12x50_PMII",
	"CUP_optic_SB_3_12x50_PMII_PIP",
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
itemList_USA = [
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

itemEngineerList_USA = [
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
	
itemMedicList_USA = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];


//backpack avalaible for all unit
backPackList_USA = [
	"CUP_B_US_IIID_OEFCP",
	"CUP_B_US_IIID_OCP",
	"CUP_B_AssaultPack_Coyote",
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"CUP_B_US_Assault_UCP",
	"CUP_B_USMC_MOLLE_AR",
	"TFAR_rt1523g"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_USA = [
	"CUP_U_B_USArmy_ACU_Kneepad_Rolled_Gloves_OEFCP", //Body
	"CUP_H_USArmy_HelmetACH_ESS_Headset_OEFCP",       //Helmet
	"CUP_V_B_IOTV_OEFCP_MG_USArmy",                    //Chest 
	"CUP_V_B_IOTV_OEFCP_SL_USArmy",
	"CUP_U_B_USArmy_ACU_Kneepad_Rolled_OCP",
	"CUP_H_USArmy_HelmetACH_ESS_Headset_OCP",
	"CUP_H_USArmy_HelmetACH_GCOVERED_Headset_OCP",
	"CUP_V_B_IOTV_OCP_Rifleman_USArmy",
	"CUP_H_USArmy_Boonie_hs_OCP",
	"CUP_PMC_Facewrap_Tropical",
	"CUP_H_OpsCore_Black_SF",
	"CUP_G_White_Scarf_GPS",
	"CUP_V_CPC_communicationsbelt_mc",
	"CUP_U_CRYE_G3C_RGR_MC_US",
	"CUP_V_B_IOTV_OCP_TL_USArmy",
	"CUP_U_B_USArmy_ACU_Gloves_OCP",
	"CUP_U_B_USArmy_ACU_Kneepad_Gloves_UCP",
	"CUP_V_B_IOTV_UCP_SL_USArmy",
	"CUP_H_USArmy_HelmetACH_ESS_Headset_UCP",
	"CUP_H_USArmy_HelmetACH_UCP",
	"CUP_V_B_IOTV_UCP_Rifleman_Deltoid_USArmy",
	"CUP_V_B_IOTV_UCP_Rifleman_USArmy",
	"CUP_U_B_USArmy_ACU_Kneepad_Rolled_UCP",
	"CUP_U_B_USArmy_ACU_Kneepad_UCP",
	"CUP_H_LWHv2_MARPAT_des_NVG_gog_cov2",
	"CUP_V_B_Eagle_SPC_GL"
	];

//Magazine avalaible for all unit
magazineList_USA = 	[
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
	"SmokeShellYellow"
];