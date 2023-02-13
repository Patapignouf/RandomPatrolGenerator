c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_grenadier = "grenadier";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_pilot = "pilot";

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Light civilian group
civilian_group_2035_NATO_FS = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

//Heavy civilian group
civilian_big_group_2035_NATO_FS = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

//Vehicle avalaible on civilian city
civilianTruck_2035_NATO_FS = ["C_SUV_01_F","C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_2035_NATO_FS = ["I_C_Soldier_Bandit_4_F", 
"I_C_Soldier_Bandit_3_F", 
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_5_F", 
"I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_1_F"];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_2035_NATO_FS = ["I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_2_F",
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_8_F"];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_2035_NATO_FS = ["I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F",
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_2035_NATO_FS = ["I_G_Mortar_01_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy chopper avalaible
baseChopperGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy aircraft avalaible
baseFixedWingGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_NATO_FS = [
	"B_MRAP_01_F",
	"B_Truck_01_transport_F",
	"B_LSV_01_unarmed_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_NATO_FS = [
	"B_MRAP_01_gmg_F",
	"B_MRAP_01_hmg_F",
	"B_LSV_01_armed_F",
	"B_LSV_01_AT_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_NATO_FS = [
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Light_01_F",
	"B_Heli_Transport_01_F"
];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_NATO_FS = [
	"B_Heli_Attack_01_dynamicLoadout_F",
	"B_Heli_Light_01_dynamicLoadout_F"
	];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_NATO_FS = [
	"B_APC_Wheeled_01_cannon_F",
	"B_APC_Tracked_01_CRV_F",
	"B_AFV_Wheeled_01_up_cannon_F"
];

//Drone vehicle avalaible for blufor
bluforDrone_2035_NATO_FS = [
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F",
	"B_UGV_02_Science_F",
	"B_UAV_06_F",
	"B_UAV_01_F",
	"B_UAV_05_F",
	"B_UAV_02_dynamicLoadout_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_2035_NATO_FS = [
	"B_Boat_Armed_01_minigun_F",
	"B_Boat_Transport_01_F"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_NATO_FS = [
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_Stealth_F"
];

////////////////////////
//Loadout management////
////////////////////////

listOfRoles_2035_NATO_FS = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier];

//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_2035_NATO_FS = [		
	[c_leader,""],
	[c_at,""],
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
rifleList_2035_NATO_FS = [		

];	

grenadeLauncherList_2035_NATO_FS = [

];


//Launcher avalaible for AT
launcherList_2035_NATO_FS = [
	"launch_I_Titan_short_F",
	"launch_NLAW_F",
	"launch_MRAWS_olive_F"
];	

//Autorifle avalaible for autorifleman
autorifleList_2035_NATO_FS = [
	"LMG_Mk200_F",
	"MMG_02_camo_F"
];	

//Rifle avalaible for marksman
marksmanrifleList_2035_NATO_FS = [
	"srifle_EBR_F",
	"srifle_DMR_06_camo_F"
];

//Smg avalaible for all unit
smgList_2035_NATO_FS = [
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_NATO_FS	= [
	"optic_Arco",
	"optic_Hamr",
	"optic_Holosight",
	"optic_Holosight_arid_F",
	"optic_Holosight_blk_F",
	"optic_Holosight_khk_F",
	"optic_Holosight_lush_F",
	"optic_Holosight_smg",
	"optic_Holosight_smg_blk_F",
	"optic_Holosight_smg_khk_F",
	"optic_Aco",
	"optic_Aco_smg",
	"optic_ACO_grn",
	"optic_ACO_grn_smg",
	"optic_erco_snd_f",
	"optic_mrco"
];

//Long range scope avalaible for marksman
attachmentLongList_2035_NATO_FS	= [
	"optic_dms",
	"optic_ams_snd",
	"optic_sos",
	"optic_khs_tan",
	"optic_nvs"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_2035_NATO_FS = [
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
	"ACE_RangeTable_82mm",
	"acc_flashlight",
	"ACE_Banana",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"muzzle_snds_H_snd_F",
	"HandGrenade",
	"MiniGrenade",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed"
	];

//item avalaible for all engineer
itemEngineerList_2035_NATO_FS = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch"
	];

//item avalaible for all medic
itemMedicList_2035_NATO_FS = [
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
	"ACE_bodyBag"
	];


//backpack avalaible for all unit
backPackList_2035_NATO_FS = [
	"B_TacticalPack_mcamo",
	"B_AssaultPack_rgr"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_NATO_FS = [
	"G_Combat",
	"G_Combat_Goggles_tna_F"
	];

//Magazine avalaible for all unit
magazineList_2035_NATO_FS = [
	];