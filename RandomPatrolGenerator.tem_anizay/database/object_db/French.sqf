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

//French
civilian_group_French = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

civilian_big_group_French = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

civilianTruck_French = ["C_SUV_01_F","C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//French
baseEnemyGroup_French = ["I_C_Soldier_Bandit_4_F", 
"I_C_Soldier_Bandit_3_F", 
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_5_F", 
"I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_1_F"];

baseEnemyATGroup_French = ["I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_2_F",
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_8_F"];

baseEnemyDemoGroup_French = ["I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F",
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyMortarGroup_French = ["I_G_Mortar_01_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyVehicleGroup_French = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

baseEnemyLightArmoredVehicleGroup_French = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

baseEnemyHeavyArmoredVehicleGroup_French = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

////////////////////////
//Vehicle management////
////////////////////////
//French
bluforUnarmedVehicle_French = ["B_AMF_VAB_ULTIMA_X8_F","AMF_GBC180_PERS_01"];

bluforArmedVehicle_French = ["amf_pvp_01_top_CE_f",
"amf_pvp_01_mag_CE_f",
"B_AMF_VAB_ULTIMA_TOP_X8_F",
"AMF_VBMR_L_CE_01"];

bluforUnarmedVehicleChopper_French = ["amf_cougar", 
"AMF_panther_FRA", 
"AMF_gazelle_afte_f", 
"B_AMF_Heli_Transport_01_F", 
"amf_nh90_tth_transport"];

bluforArmedChopper_French = [
	"AMF_TIGRE_01",
	"AMF_gazelle_minigun_da_f"
	];

bluforDrone_French = ["B_AMF_REAPER_dynamicLoadout_F"
];

bluforBoat_French = ["CUP_B_RHIB_HIL",
"CUP_B_Zodiac_USMC"
];

////////////////////////
//Loadout management////
////////////////////////

//French
loadout_French = [		
	[c_leader,[["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_OPSCORE3_TAN1_2","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_at,[["AMF_614_short_fs2_blk","","","AMF_EOTECH_553",["30Rnd_556x45_Stanag",30],[],""],["CUP_launch_M136_Loaded","","","",["CUP_M136_M",1],[],""],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_EarPlugs",1],["ACE_CableTie",2],["ACE_MapTools",1],["16Rnd_9x21_Mag",2,17]]],["amf_plate_ca3_green",[["30Rnd_556x45_Stanag_green",8,30],["CUP_HandGrenade_M67",1,1],["SmokeShell",2,1]]],[],"AMF_OPSCORE3_TAN1_2","amf_balaclava_od",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_rifleman,[["AMF_614_long_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_01_CE",[["ACE_CableTie",2],["ACE_MapTools",1],["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_in_grn",[["30Rnd_556x45_Stanag_green",9,30],["SmokeShellBlue",3,1],["HandGrenade",2,1]]],[],"AMF_OPSCORE3_TAN1_2","amf_balaclava_sordin_rangertan",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],//Default stuff
	[c_engineer,[["AMF_614_long_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_01_CE",[["ACE_CableTie",2],["ACE_MapTools",1],["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_in_grn",[["30Rnd_556x45_Stanag_green",9,30],["SmokeShellBlue",3,1],["HandGrenade",2,1]]],["AMF_rush24_01_TDF",[["ACE_EntrenchingTool",1],["ACE_wirecutter",1],["ToolKit",1],["ACE_M26_Clacker",1],["MineDetector",1],["DemoCharge_Remote_Mag",3,1]]],"AMF_OPSCORE3_TAN1_2","amf_balaclava_sordin_rangertan",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_autorifleman,[["amf_mini_mg_01_f","","","AMF_specter",["150Rnd_MINI_MG_mag_Tracer_red",150],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_EarPlugs",1],["ACE_CableTie",2],["16Rnd_9x21_Mag",2,17],["SmokeShell",2,1]]],["amf_smb_mc_grn",[["150Rnd_MINI_MG_mag_Tracer_red",1,150],["150Rnd_MINI_MG_mag",1,150]]],["AMF_rush24_01_TDF",[["150Rnd_MINI_MG_mag_Tracer_red",3,150]]],"AMF_OPSCORE3_TAN1_2","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_marksman,[["CUP_arifle_Mk17_STD","","","AMF_schmidt_benderx4_tan",["CUP_20Rnd_762x51_B_SCAR",20],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_01_CE_OD_2",[["16Rnd_9x21_Mag",1,17],["SmokeShell",2,1]]],["amf_smb_tp_scarh_grn",[["CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR_bkl",5,20]]],["AMF_rush24_01_TDF",[["CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR_bkl",5,20]]],"AMF_OPSCORE3_TAN1_2","amf_balaclava_sordin_rangertan",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_medic,[["AMF_614_long_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_01_CE",[["SmokeShell",3,1]]],["amf_smb_me_grn",[["ACE_EarPlugs",1],["ACE_CableTie",1],["16Rnd_9x21_Mag",2,17],["30Rnd_556x45_Stanag_red",7,30]]],["AMF_FELIN_BACKPACK_MEDIC",[]],"AMF_OPSCORE3_TAN1_2","amf_balaclava_ranger",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]]
];

////////////////////////
///Weapon management////
////////////////////////
//French
rifleList_French = [		
	"AMF_614_short_01_F",
	"AMF_614_long_01_F",
	"AMF_Samas_F1_01_F",
	"AMF_Samas_FELIN_01_F",
	"AMF_Samas_G2_01_F",
	"AMF_Samas_VALO_01_F",
	"amf_sig552"
];	

launcherList_French = [		
	"CUP_launch_Metis",
	"AMF_AT4CS_F"
];	

autorifleList_French = [			
	"amf_mini_mg_01_f"
];	


marksmanrifleList_French = [		
	"CUP_arifle_Mk17_STD",
	"AMF_PGM_ULTIMA_RATIO_01_F",
	"AMF_Perseis_II_01_F",
	"AMF_Perseis_II_02_F",
	"AMF_RFF2_01_F",
	"AMF_714_long_tan_f"
];

smgList_French = [		
	"amf_hk_mp5_01_f",
	"amf_hk_mp5_02_f"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_French	= [
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

attachmentLongList_French	= [
	"amf_scrome_j4",
	"amf_scrome_j8",
	"amf_schmidt_benderx4",
	"optic_lrps"
];


////////////////////////
////Items management////
////////////////////////
itemList_French = [
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

itemEngineerList_French = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
	];
	
itemMedicList_French = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];