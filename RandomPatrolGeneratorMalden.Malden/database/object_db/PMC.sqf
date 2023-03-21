c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//PMC
civilian_group_PMC = [
	"C_Man_4_enoch_F", 
	"C_Man_5_enoch_F", 
	"C_Man_6_enoch_F"
];

civilian_big_group_PMC = [
	"C_Man_1_enoch_F", 
	"C_Man_2_enoch_F", 
	"C_Man_3_enoch_F", 
	"C_Man_4_enoch_F", 
	"C_Man_5_enoch_F", 
	"C_Man_6_enoch_F", 
	"C_Farmer_01_enoch_F"
];

civilianTruck_PMC = [
	"CUP_C_Octavia_CIV", 
	"C_Offroad_01_comms_F", 
	"C_Hatchback_01_sport_F"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//PMC
baseEnemyGroup_PMC = [
	"CUP_I_PMC_Soldier_TL", 
	"CUP_I_PMC_Sniper", 
	"CUP_I_PMC_Soldier_AT", 
	"CUP_I_PMC_Soldier_MG", 
	"CUP_I_PMC_Soldier_MG_PKM", 
	"CUP_I_PMC_Soldier_GL", 
	"CUP_I_PMC_Soldier_GL_M16A2", 
	"CUP_I_PMC_Soldier_M4A3", 
	"CUP_I_PMC_Soldier"
];

baseEnemyATGroup_PMC = [
	"CUP_I_PMC_Soldier_GL", 
	"CUP_I_PMC_Soldier_GL_M16A2", 
	"CUP_I_PMC_Soldier_AT", 
	"CUP_I_PMC_Soldier_AT", 
	"CUP_I_PMC_Soldier_AA"
];

baseEnemyDemoGroup_PMC = [
	"CUP_I_PMC_Soldier_TL", 
	"CUP_I_PMC_Engineer", 
	"CUP_I_PMC_Engineer", 
	"CUP_I_PMC_Medic", 
	"CUP_I_PMC_Bodyguard_AA12"
];

baseEnemyMortarGroup_PMC = [
	"B_Mortar_01_F",
	"CUP_I_PMC_Sniper", 
	"CUP_I_PMC_Sniper_KSVK"
];

baseEnemyVehicleGroup_PMC = [
	"CUP_I_SUV_Armored_ION", 
	"CUP_I_nM1025_Mk19_DF_ION", 
	"CUP_I_RG31E_M2_ION"
];

baseEnemyLightArmoredVehicleGroup_PMC = [
	"CUP_I_FENNEK_GMG_ION", 
	"CUP_I_FENNEK_HMG_ION", 
	"CUP_I_MATV_HMG_ION"
];

baseEnemyHeavyArmoredVehicleGroup_PMC = [
	"CUP_I_BTR80A_ION", 
	"CUP_I_BTR80_ION"
];

////////////////////////
//Vehicle management////
////////////////////////
//PMC
bluforUnarmedVehicle_PMC = [
	"CUP_I_SUV_ION", 
	"CUP_I_Van_Transport_ION", 
	"CUP_I_MATV_ION", 
	"CUP_I_nM1025_Unarmed_DF_ION", 
	"CUP_I_nM1038_4s_ION",
	"CUP_I_Pickup_Unarmed_PMC"
];

bluforArmedVehicle_PMC = [
	"CUP_I_LSV_02_Minigun_ION", 
	"CUP_I_SUV_Armored_ION", 
	"CUP_I_nM1025_M2_DF_ION"
];

bluforUnarmedVehicleChopper_PMC = [
	"CUP_I_Merlin_HC3_PMC_Transport_black", 
	"CUP_I_Merlin_HC3_PMC_Lux_3C", 
	"CUP_I_412_Mil_Transport_PMC", 
	"CUP_I_MH6M_ION"
];

bluforArmedChopper_PMC = [
	"CUP_I_Mi24_D_Dynamic_ION", 
	"CUP_I_412_Military_Armed_PMC"
];

bluforDrone_PMC = [
	"B_UAV_02_dynamicLoadout_F"
];

bluforBoat_PMC = [
	"CUP_B_RHIB_HIL",
	"CUP_B_Zodiac_USMC"
];


////////////////////////
//Loadout management////
////////////////////////

listOfRoles_PMC = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier];

//PMC
loadout_PMC = [		
	[c_leader,"CUP_I_PMC_Soldier_M4A3"],
	[c_at,"CUP_I_PMC_Soldier_AT"],
	[c_rifleman,"CUP_I_PMC_Contractor1"],//Default stuff
	[c_engineer,"CUP_I_PMC_Engineer"],
	[c_autorifleman,"CUP_I_PMC_Soldier_MG_PKM"],
	[c_marksman,"CUP_I_PMC_Sniper"],
	[c_medic,"CUP_I_PMC_Medic"],
	[c_grenadier,"CUP_I_PMC_Soldier_GL"]
];

////////////////////////
///Weapon management////
////////////////////////
//PMC
rifleList_PMC = [		
	"CUP_arifle_M4A1_SOMMOD_Grip_black",
	"CUP_arifle_X95_Grippod_mars",
	"CUP_arifle_M4A1_ACOG_flashlight",
	"CUP_arifle_G36C_VFG_holo",
	"CUP_arifle_AKM_Early"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_PMC = [		
	"CUP_arifle_mk18_m203_tan_holo_laserflash",
	"CUP_arifle_Mk16_STD_EGLM_Specter"
];

launcherList_PMC = [		
	"CUP_launch_M136",
	"CUP_launch_FIM92Stinger",
	"CUP_launch_MAAWS"
];	

autorifleList_PMC = [			
	"CUP_arifle_MG36",
	"CUP_lmg_PKM"
];	


marksmanrifleList_PMC = [		
	"CUP_srifle_M107_LeupoldMk4",
	"CUP_arifle_HK417_20_Scope"
];

smgList_PMC = [		
	"CUP_smg_MP7",
	"CUP_smg_MP5SD6",
	"CUP_hgun_Glock17",
	"CUP_hgun_M9"
];



//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_PMC	= [
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

attachmentLongList_PMC	= [
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
itemList_PMC = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"B_UavTerminal",
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
	"ACE_IR_Strobe_Item"
	];

itemEngineerList_PMC = [
	"Medikit",
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", 
	"ACE_Fortify"
];
	
itemMedicList_PMC = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
];

//backpack avalaible for all unit
backPackList_PMC = [
	"CUP_B_AlicePack_Khaki"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_PMC = [
	"CUP_V_B_Ciras_Olive4",
	"CUP_V_I_RACS_Carrier_Rig_wdl_2",
	"CUP_I_B_PMC_Unit_43",
	"CUP_I_B_PMC_Unit_37",
	"CUP_I_B_PMC_Unit_43",
	"CUP_I_B_PMC_Unit_36",
	"CUP_I_B_PMC_Unit_38",
	"CUP_I_B_PMC_Unit_39",
	"CUP_H_PMC_Cap_PRR_Burberry"
	];

//Magazine avalaible for all unit
magazineList_PMC = [
	];