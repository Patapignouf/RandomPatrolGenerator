c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";
c_drone = "UAV opérator";

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

////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_USA = [
	"CUP_B_M1151_USA",
	"CUP_B_nM1037sc_DF_USMC_DES", 
	"CUP_B_nM1038_DF_USMC_DES", 
	"CUP_B_M1152_DSRT_USMC"
];

bluforArmedVehicle_USA = [
	"CUP_B_M1151_Deploy_USA",
	"CUP_B_nM1025_SOV_M2_USA_DES",
	"CUP_B_nM1025_M240_USA_DES",
	"CUP_B_M1165_GMV_DSRT_USMC",
	"CUP_B_RG31_M2_USMC", 
	"CUP_B_RG31E_M2_USMC"
];

bluforUnarmedVehicleChopper_USA = [
	"CUP_B_MH6J_USA",
	"CUP_B_UH60M_Unarmed_US",
	"B_Heli_Transport_03_unarmed_F",
	"CUP_B_CH53E_USMC"
];

bluforArmedChopper_USA = [
	"CUP_B_AH64_DL_USA", 
	"CUP_B_AH6M_USA", 
	"CUP_B_UH60M_US", 
	"CUP_B_AH1Z_Dynamic_USMC"
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
	"CUP_B_A10_DYN_USA"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_USA = [
	"CUP_B_M113A1_HQ_desert_USA"
];


////////////////////////
//Loadout management////
////////////////////////

listOfRoles_USA = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier,c_drone];

//USA
loadout_USA = [		
	[c_leader, "CUP_B_US_Soldier_SL_OEFCP"],
	[c_at, "CUP_B_US_Soldier_LAT_OEFCP"],
	[c_rifleman,"CUP_B_US_Soldier_OEFCP"],//Default stuff
	[c_engineer,"CUP_B_US_Soldier_Engineer_OEFCP"],
	[c_autorifleman, "CUP_B_US_Soldier_MG_OEFCP"],
	[c_marksman,"CUP_B_US_Soldier_Marksman_EBR_OEFCP"],
	[c_medic,"CUP_B_US_Medic_OEFCP"],
	[c_grenadier, "CUP_B_US_Soldier_GL_OEFCP"],//Default stuff
	[c_drone,"CUP_B_US_Soldier_UAV_OEFCP"]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_USA = [		
	"CUP_arifle_mk18_black",
	"CUP_arifle_SBR_black",
	"CUP_arifle_M4A1_SOMMOD_Grip_black"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_USA = [		
	"CUP_arifle_mk18_m203_tan_holo_laserflash",
	"CUP_arifle_mk18_m203_black"
];

launcherList_USA = [		
	"CUP_launch_Javelin",
	"CUP_launch_FIM92Stinger",
	"CUP_launch_MAAWS",
	"CUP_launch_MAAWS_Scope"
];	

autorifleList_USA = [			
	"CUP_lmg_Mk48",
	"CUP_lmg_m249_pip2",
	"CUP_lmg_M240_B_ElcanM143_ANPEQ15"
];	


marksmanrifleList_USA = [		
	"CUP_srifle_Mk12SPR",
	"CUP_srifle_M40A3",
	"CUP_srifle_M110_black"
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
	"CUP_optic_SB_11_4x20_PM_pip"
];

attachmentLongList_USA	= [
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_11_4x20_PM_pip",
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
itemList_USA = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"B_UavTerminal",
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
	"ACE_RangeCard"
	];

itemEngineerList_USA = [
	"Medikit",
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", 
	"ACE_Fortify"
];
	
itemMedicList_USA = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
];


//backpack avalaible for all unit
backPackList_USA = [
	"CUP_B_US_IIID_OEFCP",
	"CUP_B_US_IIID_OCP"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_USA = [
	"CUP_U_B_USArmy_ACU_Kneepad_Rolled_Gloves_OEFCP", //Body
	"CUP_H_USArmy_HelmetACH_ESS_Headset_OEFCP",       //Helmet
	"CUP_V_B_IOTV_OEFCP_MG_USArmy",                    //Chest 
	"CUP_V_B_IOTV_OEFCP_SL_USArmy",
	"CUP_U_B_USArmy_ACU_Kneepad_Rolled_OCP",
	"CUP_H_USArmy_HelmetACH_ESS_Headset_OCP",
	"CUP_V_B_IOTV_OCP_Rifleman_USArmy",
	"CUP_H_USArmy_Boonie_hs_OCP",
	"CUP_PMC_Facewrap_Tropical"

	];

//Magazine avalaible for all unit
magazineList_USA = [

	];