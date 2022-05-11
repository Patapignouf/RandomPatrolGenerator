c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//newFaction
civilian_group_newFaction = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

civilian_big_group_newFaction = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

civilianTruck_newFaction = ["C_SUV_01_F","C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//newFaction
baseEnemyGroup_newFaction = ["I_C_Soldier_Bandit_4_F", 
"I_C_Soldier_Bandit_3_F", 
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_5_F", 
"I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_1_F"];

baseEnemyATGroup_newFaction = ["I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_2_F",
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_8_F"];

baseEnemyDemoGroup_newFaction = ["I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F",
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyMortarGroup_newFaction = ["I_G_Mortar_01_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyVehicleGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

baseEnemyLightArmoredVehicleGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

baseEnemyHeavyArmoredVehicleGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

baseChopperGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

baseFixedWingGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

////////////////////////
//Vehicle management////
////////////////////////
//newFaction
bluforUnarmedVehicle_newFaction = ["B_AMF_VAB_ULTIMA_X8_F"];

bluforArmedVehicle_newFaction = ["amf_pvp_01_CE_f","B_AMF_VAB_ULTIMA_TOP_X8_F","AMF_VBMR_L_CE_01"];

bluforUnarmedVehicleChopper_newFaction = ["ffaa_nh90_tth_transport","AMF_gazelle_afte_f","ffaa_famet_cougar"];

bluforArmoredVehicle_newFaction = ["B_AMF_VAB_ULTIMA_TOP_X8_F","AMF_VBMR_L_CE_01"];

bluforDrone_newFaction = ["B_UAV_02_dynamicLoadout_F"
];

bluforBoat_newFaction = ["CUP_B_RHIB_HIL",
"CUP_B_Zodiac_USMC"
];

bluforFixedWing_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

////////////////////////
//Loadout management////
////////////////////////

//newFaction
loadout_newFaction = [		
	[c_leader,],
	[c_at,],
	[c_rifleman,],//Default stuff
	[c_engineer,],
	[c_autorifleman,],
	[c_marksman,],
	[c_medic,]
];

////////////////////////
///Weapon management////
////////////////////////
//newFaction
rifleList_newFaction = [		
	"AMF_614_short_01_F",
	"AMF_614_long_01_F",
	"AMF_Samas_F1_01_F",
	"AMF_Samas_FELIN_01_F",
	"AMF_Samas_G2_01_F",
	"AMF_Samas_VALO_01_F"
];	

launcherList_newFaction = [		
	"CUP_launch_Metis",
	"CUP_launch_M136_Loaded"
];	

autorifleList_newFaction = [			
	"amf_mini_mg_01_f"
];	


marksmanrifleList_newFaction = [		
	"CUP_arifle_Mk17_STD",
	"AMF_PGM_ULTIMA_RATIO_01_F",
	"AMF_Perseis_II_01_F",
	"AMF_Perseis_II_02_F",
	"AMF_RFF2_01_F",
	"AMF_714_long_tan_f"
];

smgList_newFaction = [		
	"amf_hk_mp5_01_f"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_newFaction	= [
	"AMF_Aimpoint_CompM5",
	"AMF_AIMPOINT_MICRO_T1",
	"AMF_AIMPOINT_MICRO_T2",
	"AMF_Aimpoint_Pro_Patrol",
	"AMF_ALPHA900",
	"AMF_AN_PEQ_15_black",
	"AMF_AN_PEQ_15_green",
	"AMF_AN_PEQ_15_painted",
	"AMF_AN_PEQ_15_tan",
	"amf_red_dot_sight",
	"amf_xps3_magnifier_side",
	"amf_specter",
	"AMF_EOTECH_553"

];

attachmentLongList_newFaction	= [
	"amf_scrome_j4",
	"amf_scrome_j8",
	"amf_schmidt_benderx4",
	"optic_lrps"
];

////////////////////////
////Items management////
////////////////////////
itemList_newFaction = [
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"B_UavTerminal",
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
	"ACE_RangeTable_82mm"
	];

itemEngineerList_newFaction = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter"
	];
	
itemMedicList_newFaction = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];

backPackList_newFaction = [

	];

uniformList_newFaction = [

	];

magazineList_newFaction = [

	];