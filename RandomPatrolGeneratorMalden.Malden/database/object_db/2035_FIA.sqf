c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_grenadier = "grenadier";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

factionInfos pushBack ["_2035_FIA", 21,"2035 FIA", true, true, true];

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Light civilian group
civilian_group_2035_FIA = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

//Heavy civilian group
civilian_big_group_2035_FIA = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

//Vehicle avalaible on civilian city
civilianTruck_2035_FIA = [
	"C_SUV_01_F",
	"C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_2035_FIA = [
	"O_G_Soldier_SL_F", 
	"O_G_Soldier_AR_F", 
	"O_G_Soldier_AR_F", 
	"O_G_Sharpshooter_F", 
	"O_G_Soldier_M_F", 
	"O_G_Soldier_F", 
	"O_G_Soldier_F", 
	"O_G_medic_F"
];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_2035_FIA = [
	"O_G_Soldier_LAT2_F", 
	"O_G_Soldier_LAT_F", 
	"O_G_Soldier_F", 
	"O_G_Soldier_F", 
	"O_G_officer_F"
];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_2035_FIA = [
	"O_G_Soldier_GL_F", 
	"O_G_Soldier_exp_F", 
	"O_G_engineer_F", 
	"O_G_Soldier_F", 
	"O_G_officer_F"
];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_2035_FIA = [
	"O_G_Soldier_M_F", 
	"O_G_medic_F", 
	"O_G_Soldier_AR_F", 
	"O_G_Mortar_01_F"
];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_2035_FIA = [
	//Vehicle
	"O_G_Offroad_01_F", 
	"O_G_Offroad_01_AT_F", 
	"O_G_Van_02_vehicle_F", 
	"O_G_Van_01_transport_F", 
	"O_G_Offroad_01_armed_F",

	//Turret
	"O_G_HMG_02_high_F"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_2035_FIA = [

];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_2035_FIA = [
	
];

//Basic enemy chopper avalaible
baseEnemyUnarmedChopperGroup_2035_FIA = [
	"I_Heli_light_03_unarmed_F"
];


//Basic enemy chopper avalaible
baseEnemyArmedChopperGroup_2035_FIA = [
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_2035_FIA = [
	
];

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_FIA = [
	"O_G_Offroad_01_F", 
	"O_G_Van_01_transport_F", 
	"O_G_Van_02_vehicle_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_FIA = [
	"O_G_Offroad_01_armed_F", 
	"O_G_Offroad_01_AT_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_FIA = [


];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_FIA = [


];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_FIA = [


];

//Drone vehicle avalaible for blufor
bluforDrone_2035_FIA = [


];

//Boat vehicle avalaible for blufor
bluforBoat_2035_FIA = [


];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_FIA = [
	"B_G_Van_01_transport_F"
];


//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_2035_FIA = [

];


////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_2035_FIA = [		
	[c_leader, "O_G_Soldier_SL_F"],
	[c_at,"O_G_Soldier_LAT2_F"],
	[c_rifleman,"O_G_Soldier_F"],//Default stuff
	[c_engineer,"O_G_engineer_F"],
	[c_autorifleman,"O_G_Soldier_AR_F"],
	[c_marksman,"O_G_Sharpshooter_F"],
	[c_medic,"O_G_medic_F"],
	[c_grenadier,"O_G_Soldier_TL_F"]
];

////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_2035_FIA = [		
	"arifle_TRG21_F",
	"arifle_TRG20_F"
];	

grenadeLauncherList_2035_FIA = [
	"arifle_TRG21_GL_F"
];


//Launcher avalaible for AT
launcherList_2035_FIA = [
	"launch_MRAWS_olive_F"
];	

//Autorifle avalaible for autorifleman
autorifleList_2035_FIA = [
	"LMG_Mk200_F"
];	

//Rifle avalaible for marksman
marksmanrifleList_2035_FIA = [
	"srifle_DMR_06_camo_khs_F"
];

//Smg avalaible for all unit
smgList_2035_FIA = [
	"hgun_PDW2000_F"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_FIA	= [
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
	"optic_mrco",
	"acc_pointer_IR",
	"optic_ERCO_snd_F",
	"muzzle_snds_m_snd_F"
];

//Long range scope avalaible for marksman
attachmentLongList_2035_FIA	= [
	"optic_dms",
	"optic_sos",
	"optic_khs_tan",
	"optic_nvs",
	"muzzle_snds_B_snd_F",
	"optic_AMS_snd"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_2035_FIA = [
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
	"muzzle_snds_H_snd_F",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_RangeCard"
];

//item avalaible for all engineer
itemEngineerList_2035_FIA = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch"
];

//item avalaible for all medic
itemMedicList_2035_FIA = [
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
backPackList_2035_FIA = [
	"B_TacticalPack_mcamo",
	"B_Carryall_mcamo",
	"B_AssaultPack_rgr",
	"B_AssaultPack_cbr",
	"B_Kitbag_cbr"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_FIA = [
	"U_OG_Guerilla1_1",
	"V_Chestrig_oli",
	"H_Shemag_olive",
	"U_OG_Guerilla2_3",
	"H_Booniehat_khk",
	"U_OG_Guerilla3_1",
	"U_OG_Guerilla2_2"
];

//Magazine avalaible for all unit
//Special note throwing items must be placed here too
magazineList_2035_FIA = [
	"30Rnd_9x21_Green_Mag",
	"200Rnd_65x39_cased_Box",
	"20Rnd_762x51_Mag",
	"30Rnd_556x45_Stanag",
	"30Rnd_556x45_Stanag_green",
	"1Rnd_HE_Grenade_shell",
	"MRAWS_HEAT_F",
	"HandGrenade",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellRed"
];

//Get magazine with following command
//getArray (configfile >> "CfgWeapons" >> weaponName >> "magazines");