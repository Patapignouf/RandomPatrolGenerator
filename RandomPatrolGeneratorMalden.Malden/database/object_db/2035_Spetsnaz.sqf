c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_grenadier = "grenadier";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_pilot = "pilot";

factionInfos pushBack ["_2035_Spetsnaz",22,"2035 Spetsnaz", true, true, false];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_2035_Spetsnaz = [
	"O_R_Soldier_TL_F", 
	"O_R_Soldier_AR_F", 
	"O_R_Soldier_AR_F",
	"O_R_medic_F", 
	"O_R_Soldier_LAT_F", 
	"O_R_Soldier_GL_F", 
	"O_R_soldier_M_F"
];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_2035_Spetsnaz = [
	"O_R_Soldier_TL_F", 
	"O_R_Soldier_AR_F", 
	"O_R_Soldier_LAT_F",
	"O_R_Soldier_LAT_F",
	"O_R_soldier_M_F"
];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_2035_Spetsnaz = [
	"O_R_recon_exp_F", 
	"O_R_recon_GL_F", 
	"O_R_recon_JTAC_F", 
	"O_R_recon_TL_F"
];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_2035_Spetsnaz = [

];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_2035_Spetsnaz = [

];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_2035_Spetsnaz = [

];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_2035_Spetsnaz = [

];

//Basic enemy aircraft avalaible
baseFixedWingGroup_2035_Spetsnaz = [
	"O_Plane_CAS_02_dynamicLoadout_F",
	"O_Plane_Fighter_02_F"
];


baseEnemyUnarmedChopperGroup_2035_Spetsnaz = [
	"O_Heli_Light_02_unarmed_F"
];


////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_Spetsnaz = [
	"O_T_LSV_02_unarmed_F", 
	"O_T_MRAP_02_ghex_F", 
	"O_T_Quadbike_01_ghex_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_Spetsnaz = [
	"O_T_LSV_02_armed_F", 
	"O_T_LSV_02_AT_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_Spetsnaz = [
	"O_Heli_Transport_04_covered_F", 
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Transport_04_bench_F"
];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_Spetsnaz = [
	"O_Heli_Attack_02_dynamicLoadout_F"

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_Spetsnaz = [

];

//Drone vehicle avalaible for blufor
bluforDrone_2035_Spetsnaz = [
	"O_T_UAV_04_CAS_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_2035_Spetsnaz = [


];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_Spetsnaz = [
	"O_T_VTOL_02_infantry_dynamicLoadout_F"
];


//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_2035_Spetsnaz = [

];


////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : ],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_2035_Spetsnaz = [		
	[c_leader,"O_R_Patrol_Soldier_TL_F"],
	[c_at,"O_R_Patrol_Soldier_LAT_F"],
	[c_rifleman,"O_R_JTAC_F"],//Default stuff
	[c_engineer,"O_R_Patrol_Soldier_Engineer_F"],
	[c_autorifleman,"O_R_Patrol_Soldier_AR_F"],
	[c_marksman,"O_R_Patrol_Soldier_M2_F"],
	[c_medic,"O_R_Patrol_Soldier_Medic"],
	[c_grenadier,"O_R_Soldier_GL_F"]
];

////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_2035_Spetsnaz = [		
	"arifle_AK12_lush_F",
	"arifle_AK12U_lush_F"
];	

grenadeLauncherList_2035_Spetsnaz = [
	"arifle_AK12_GL_lush_F"
];


//Launcher avalaible for AT
launcherList_2035_Spetsnaz = [
	"launch_RPG32_green_F"

];	

//Autorifle avalaible for autorifleman
autorifleList_2035_Spetsnaz = [
	"arifle_RPK12_lush_F"
];	

//Rifle avalaible for marksman
marksmanrifleList_2035_Spetsnaz = [
	"srifle_DMR_04_F"

];

//Smg avalaible for all unit
smgList_2035_Spetsnaz = [
	"hgun_Rook40_F"

];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_Spetsnaz	= [
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
attachmentLongList_2035_Spetsnaz	= [
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
itemList_2035_Spetsnaz = [
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
itemEngineerList_2035_Spetsnaz = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch",
	"ACE_Clacker"
];

//item avalaible for all medic
itemMedicList_2035_Spetsnaz = [
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
backPackList_2035_Spetsnaz = [
	"tfar_mr3000"

];

factionDefaultRadios_2035_Spetsnaz = [
	"tfar_fadak"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_Spetsnaz = [
	"H_HelmetAggressor_cover_taiga_F",
	"U_O_R_Gorka_01_F",
	"V_SmershVest_01_F",
	"B_FieldPack_taiga_F",
	"U_O_R_Gorka_01_camo_F",
	"G_Balaclava_blk"
];

//Magazine avalaible for all unit
//Special note throwing items must be placed here too
magazineList_2035_Spetsnaz = [
	"16Rnd_9x21_Mag",
	"30rnd_762x39_AK12_Lush_Mag_F",
	"RPG32_F",
	"10Rnd_127x54_Mag",
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell",
	"SmokeShell"
];

//Get magazine with following command
//getArray (configfile >> "CfgWeapons" >> weaponName >> "magazines");