c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";
c_pilot = "pilot";

//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack ["_USA_2000_DF",15,"1993 USA Delta Force [CUP][ACE]", true, true, false];	
};

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//USA
civilian_group_USA_2000_DF = ["C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F"];

civilian_big_group_USA_2000_DF = ["C_Man_1_enoch_F", 
"C_Man_2_enoch_F", 
"C_Man_3_enoch_F", 
"C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F", 
"C_Farmer_01_enoch_F" ];

civilianTruck_USA_2000_DF = ["CUP_C_Octavia_CIV", 
"C_Offroad_01_comms_F", 
"C_Hatchback_01_sport_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//USA
baseEnemyGroup_USA_2000_DF = ["CUP_B_US_Soldier_SL_OCP", 
"CUP_B_US_Soldier_MG_OCP", 
"CUP_B_US_Soldier_MG_OCP",
"CUP_B_US_Soldier_GL_OCP",
"CUP_B_US_Soldier_GL_OCP",  
"CUP_B_US_Soldier_AMG_OCP", 
"CUP_B_US_Soldier_LAT_OCP",
"CUP_B_US_Soldier_LAT_OCP"];

baseEnemyATGroup_USA_2000_DF = ["CUP_B_US_Soldier_TL_OCP", 
"CUP_B_US_Soldier_AT_OCP", 
"CUP_B_US_Soldier_AT_OCP", 
"CUP_B_US_Soldier_AT_OCP", 
"CUP_B_US_Soldier_AAT_OCP"];

baseEnemyDemoGroup_USA_2000_DF = ["CUP_B_US_Soldier_TL_OCP", 
"CUP_B_US_Soldier_MG_OCP", 
"CUP_B_US_Soldier_GL_OCP", 
"CUP_B_US_Soldier_AMG_OCP"];

baseEnemyMortarGroup_USA_2000_DF = ["B_Mortar_01_F",
"CUP_B_US_Soldier_GL_OCP", 
"CUP_B_US_Soldier_AMG_OCP"];

baseEnemyVehicleGroup_USA_2000_DF = ["CUP_B_M1151_Deploy_USA",
"CUP_B_nM1025_SOV_M2_USA_DES",
"CUP_B_nM1025_M240_USA_DES",
"CUP_B_M1165_GMV_DSRT_USMC"];

baseEnemyLightArmoredVehicleGroup_USA_2000_DF = ["CUP_B_M113A3_desert_USA", 
"CUP_B_RG31E_M2_USA", 
"CUP_B_RG31_Mk19_USA"];

baseEnemyHeavyArmoredVehicleGroup_USA_2000_DF = ["CUP_B_M1126_ICV_M2_Desert", 
"CUP_B_M1128_MGS_Desert", 
"CUP_B_M2A3Bradley_USA_D", 
"CUP_B_M1A2SEP_TUSK_II_Desert_US_Army", 
"CUP_B_M1A1SA_Desert_US_Army"];


//Basic enemy aircraft avalaible
baseFixedWingGroup_USA_2000_DF = [
	"CUP_B_A10_DYN_USA",
	"CUP_B_AV8B_DYN_USMC"
];

baseEnemyUnarmedChopperGroup_USA_2000_DF = [
	"CUP_B_UH60M_Unarmed_US",
	"CUP_B_MH6M_OBS_USA",
	"CUP_B_MH6M_USA"
];

////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_USA_2000_DF = [	
	"CUP_B_nM1025_Unarmed_USA_DES",
	"CUP_B_nM1037sc_USA_DES",
	"CUP_B_MTVR_USA"
	];

bluforArmedVehicle_USA_2000_DF = [
	"CUP_B_HMMWV_M2_GPK_USA"
	];

bluforUnarmedVehicleChopper_USA_2000_DF = [
	"CUP_B_UH60M_Unarmed_US",
	"CUP_B_MH6M_OBS_USA",
	"CUP_B_MH6M_USA"
	];

bluforArmedChopper_USA_2000_DF = [
	"CUP_B_UH60M_US", 
	"CUP_B_AH1Z_Dynamic_USMC"
	];

bluforDrone_USA_2000_DF = [
	"CUP_B_USMC_DYN_MQ9"
	];

bluforBoat_USA_2000_DF = [
	"CUP_B_RHIB_HIL",
	"CUP_B_Zodiac_USMC"
	];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_USA_2000_DF = [
	"CUP_B_A10_DYN_USA",
	"CUP_B_AV8B_DYN_USMC"
];

bluforHQVehicle_USA_2000_DF = [
	"CUP_B_M113A1_HQ_desert_USA"
];

////////////////////////
//Loadout management////
////////////////////////

//USA

loadout_USA_2000_DF = [		
	[c_leader,[["CUP_arifle_Colt727","","CUP_acc_Flashlight","CUP_optic_CompM4",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_BDUv2_roll2_DCU",[["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["Chemlight_green",1,1],["CUP_30Rnd_556x45_Stanag",1,30]]],["CUP_V_PMC_CIRAS_Black_TL",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_556x45_Stanag",6,30]]],[],"CUP_H_Ger_M92_Black_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_at,[["CUP_arifle_Colt727","","CUP_acc_Flashlight","CUP_optic_CompM4",["CUP_30Rnd_556x45_Stanag",30],[],""],["CUP_launch_M136_Loaded","","","",["CUP_M136_M",1],[],""],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_BDUv2_roll2_DCU",[["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["Chemlight_green",1,1],["CUP_30Rnd_556x45_Stanag",1,30]]],["CUP_V_PMC_CIRAS_Black_TL",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_556x45_Stanag",6,30]]],[],"CUP_H_Ger_M92_Black_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_rifleman,[["CUP_arifle_Colt727","","CUP_acc_Flashlight","CUP_optic_CompM4",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_BDUv2_roll2_DCU",[["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["Chemlight_green",1,1],["CUP_30Rnd_556x45_Stanag",1,30]]],["CUP_V_PMC_CIRAS_Black_TL",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_556x45_Stanag",6,30]]],[],"CUP_H_Ger_M92_Black_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],//Default stuff
	[c_engineer,[["CUP_arifle_Colt727","","CUP_acc_Flashlight","CUP_optic_CompM4",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_BDUv2_roll2_DCU",[["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["Chemlight_green",1,1],["CUP_30Rnd_556x45_Stanag",1,30]]],["CUP_V_PMC_CIRAS_Black_TL",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_556x45_Stanag",6,30]]],["CUP_B_USPack_Black",[["ACE_packingBandage",15],["ACE_elasticBandage",15],["ACE_DefusalKit",1],["MineDetector",1],["ToolKit",1],["ACE_Flashlight_XL50",1],["ACE_Fortify",1]]],"CUP_H_Ger_M92_Black_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_autorifleman,[["CUP_lmg_M249_E2","","","",["CUP_200Rnd_TE4_Red_Tracer_556x45_M249",200],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_BDUv2_roll2_DCU",[["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["Chemlight_green",1,1],["CUP_7Rnd_45ACP_1911",2,7]]],["CUP_V_PMC_CIRAS_Black_TL",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["CUP_200Rnd_TE4_Green_Tracer_556x45_M249",2,200]]],["CUP_B_AssaultPack_Black",[["200Rnd_556x45_Box_Red_F",3,200]]],"CUP_H_Ger_M92_Black_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_marksman,[["CUP_srifle_M14_DMR","","","CUP_optic_CompM4",["CUP_20Rnd_762x51_DMR",20],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_BDUv2_roll2_DCU",[["Chemlight_green",1,1],["CUP_20Rnd_TE1_Yellow_Tracer_762x51_DMR",2,20]]],["CUP_V_PMC_CIRAS_Black_TL",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["CUP_7Rnd_45ACP_1911",3,7],["CUP_20Rnd_TE1_Yellow_Tracer_762x51_DMR",5,20]]],[],"CUP_H_Ger_M92_Black_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","",""]]],
	[c_medic,[["CUP_arifle_Colt727","","CUP_acc_Flashlight","CUP_optic_CompM4",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_BDUv2_roll2_DCU",[["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["Chemlight_green",1,1],["CUP_30Rnd_556x45_Stanag",1,30]]],["CUP_V_PMC_CIRAS_Black_TL",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_556x45_Stanag",6,30]]],["CUP_B_USPack_Black",[["ACE_packingBandage",15],["ACE_elasticBandage",15]]],"CUP_H_Ger_M92_Black_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_grenadier,[["CUP_arifle_Colt727_M203","","","CUP_optic_CompM4",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_Colt1911","","","",["CUP_7Rnd_45ACP_1911",7],[],""],["CUP_U_B_BDUv2_roll2_DCU",[["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["Chemlight_green",1,1],["CUP_30Rnd_556x45_Stanag",1,30]]],["CUP_V_PMC_CIRAS_Black_TL",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["CUP_7Rnd_45ACP_1911",2,7],["CUP_30Rnd_556x45_Stanag",6,30],["1Rnd_HE_Grenade_shell",5,1]]],[],"CUP_H_Ger_M92_Black_GG_CB","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_pilot,"CUP_B_US_Pilot"]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_USA_2000_DF = [		
	"CUP_arifle_Colt727",
	"CUP_arifle_M16A1E1",
	"CUP_arifle_M16A1"
];	

launcherList_USA_2000_DF = [		
	"CUP_launch_M136_Loaded",
	"CUP_launch_FIM92Stinger_Loaded"
];	


autorifleList_USA_2000_DF = [			
	"CUP_lmg_M249",
	"CUP_lmg_M249_E2",
	"CUP_lmg_M60"
];	

marksmanrifleList_USA_2000_DF = [		
	"CUP_srifle_M14_DMR"
];

smgList_USA_2000_DF = [		
	"CUP_smg_MP5A5",
	"CUP_hgun_Colt1911",
	"CUP_sgun_M1014_solidstock"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_USA_2000_DF	= [
	"CUP_optic_Aimpoint_5000",
	"CUP_acc_Flashlight",
	"CUP_optic_CompM4",
	"CUP_optic_LeupoldMk4_CQ_T",
	"CUP_optic_SB_11_4x20_PM_pip"
];

attachmentLongList_USA_2000_DF	= [
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_3_12x50_PMII",
	"CUP_optic_SB_3_12x50_PMII_PIP",
	"CUP_optic_LeupoldMk4",
	"CUP_optic_CWS",
	"CUP_optic_CWS_NV",
	"CUP_optic_CWS_NV_RDS"
];

////////////////////////
////Items management////
////////////////////////
itemList_USA_2000_DF = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"CUP_NVG_HMNVS",
	"Binocular",
	"Rangefinder",
	"ACE_MapTools",
	"ACE_DAGR",
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
	"ACE_IR_Strobe_Item"
	];

itemEngineerList_USA_2000_DF = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch",
	"ACE_DefusalKit",
	"ACE_Clacker",
	"ACE_M26_Clacker",
	"ace_marker_flags_white",
	"ace_marker_flags_yellow",
	"ace_marker_flags_purple",
	"ace_marker_flags_orange",
	"ace_marker_flags_red"
	];
	
itemMedicList_USA_2000_DF = [
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
backPackList_USA_2000_DF = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"CUP_B_USPack_Black"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_USA_2000_DF = [
	"CUP_V_PMC_CIRAS_Black_TL",
	"CUP_U_B_BDUv2_roll2_DCU",
	"CUP_U_B_BDUv2_gloves_DCU",
	"CUP_H_Ger_M92_Black_GG_CB",
	"CUP_H_Ger_M92_Black",
	"CUP_G_ESS_BLK"
	];

//Magazine avalaible for all unit
magazineList_USA_2000_DF = [
	];