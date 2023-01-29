//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Light civilian group
civilian_group_newFaction = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

//Heavy civilian group
civilian_big_group_newFaction = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

//Vehicle avalaible on civilian city
civilianTruck_newFaction = ["C_SUV_01_F","C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_newFaction = ["I_C_Soldier_Bandit_4_F", 
"I_C_Soldier_Bandit_3_F", 
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_5_F", 
"I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_1_F"];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_newFaction = ["I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_2_F",
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_8_F"];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_newFaction = ["I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F",
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_newFaction = ["I_G_Mortar_01_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy chopper avalaible
baseChopperGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy aircraft avalaible
baseFixedWingGroup_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

////////////////////////
//Vehicle management////
////////////////////////

//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_newFaction = ["B_AMF_VAB_ULTIMA_X8_F"];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_newFaction = ["amf_pvp_01_CE_f","AMF_VBMR_L_CE_01"];

//Chopper unarmed chopper avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_newFaction = ["ffaa_nh90_tth_transport","AMF_gazelle_afte_f","ffaa_famet_cougar"];

//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_newFaction = ["ffaa_nh90_tth_transport","AMF_gazelle_afte_f","ffaa_famet_cougar"];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_newFaction = ["B_AMF_VAB_ULTIMA_TOP_X8_F","AMF_VBMR_L_CE_01"];

//Drone vehicle avalaible for blufor
bluforDrone_newFaction = ["B_UAV_02_dynamicLoadout_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_newFaction = ["CUP_B_RHIB_HIL",
"CUP_B_Zodiac_USMC"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_newFaction = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_newFaction = [
	"amf_pvp_01_CE_f"
];

////////////////////////
//Loadout management////
////////////////////////

c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";

//List of Roles accepted in the BIS_fnc_arsenal
//You can add or delete role to this list
//Every role describe on the list must be defined in loadout_newFaction
listOfRoles_newFaction = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier];

//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_newFaction = [		
	[c_leader,[["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_at,"I_C_Soldier_Bandit_4_F"],
	[c_rifleman,""],//Default stuff
	[c_engineer,""],
	[c_autorifleman,""],
	[c_marksman,""],
	[c_medic,""],
	[c_grenadier,""]
];

////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_newFaction = [		
	"AMF_614_short_01_F",
	"AMF_614_long_01_F",
	"AMF_Samas_F1_01_F",
	"AMF_Samas_FELIN_01_F",
	"AMF_Samas_G2_01_F",
	"AMF_Samas_VALO_01_F"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_newFaction = [		

];


//Launcher avalaible for AT
launcherList_newFaction = [		
	"CUP_launch_Metis",
	"CUP_launch_M136_Loaded"
];	

//Autorifle avalaible for autorifleman
autorifleList_newFaction = [			
	"amf_mini_mg_01_f"
];	

//Rifle avalaible for marksman
marksmanrifleList_newFaction = [		
	"CUP_arifle_Mk17_STD",
	"AMF_PGM_ULTIMA_RATIO_01_F",
	"AMF_Perseis_II_01_F",
	"AMF_Perseis_II_02_F",
	"AMF_RFF2_01_F",
	"AMF_714_long_tan_f"
];

//Smg avalaible for all unit
smgList_newFaction = [		
	"amf_hk_mp5_01_f"
];


//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
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

//Long range scope avalaible for marksman
attachmentLongList_newFaction	= [
	"amf_scrome_j4",
	"amf_scrome_j8",
	"amf_schmidt_benderx4",
	"optic_lrps"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_newFaction = [
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

//item avalaible for all engineer
itemEngineerList_newFaction = [
	"Medikit",
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify"
	];

//item avalaible for all medic
itemMedicList_newFaction = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];

//backpack avalaible for all unit
backPackList_newFaction = [
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_newFaction = [
	];

//Magazine avalaible for all unit
magazineList_newFaction = [
	];