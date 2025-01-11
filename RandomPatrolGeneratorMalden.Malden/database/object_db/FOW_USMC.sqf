#include "..\classConstant.sqf"

factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "fow_main")) then 
{
	factionInfos pushBack["_FOW_USMC", factionID,"US Marines [FOW]", true, true, false];
};

//////////////////////////////
///Define enemy group data////
//////////////////////////////

baseEnemyGroup_FOW_USMC = [
	"fow_s_usmc_nco", 
	"fow_s_usmc_teamleader", 
	"fow_s_usmc_bar_gunner", 
	"fow_s_usmc_bar_asst", 
	"fow_s_usmc_rifleman",
	"fow_s_usmc_medic", 
	"fow_s_usmc_rifleman_m1903", 
	"fow_s_usmc_rifleman_ithaca37"
];

baseEnemyATGroup_FOW_USMC = [
	"fow_s_usmc_at", 
	"fow_s_usmc_at_asst", 
	"fow_s_usmc_nco", 
	"fow_s_usmc_bar_gunner"
];

baseEnemyDemoGroup_FOW_USMC = [
	"fow_s_usmc_radio_operator", 
	"fow_s_usmc_officer", 
	"fow_s_usmc_m1919a6_gunner", 
	"fow_s_usmc_bar_asst", 
	"fow_s_usmc_bar_gunner"
];

baseEnemyMortarGroup_FOW_USMC = [
	"fow_w_m2_mortar_usmc"
];

baseEnemyVehicleGroup_FOW_USMC = [
	"fow_v_gmc_usmc",
	"fow_v_gmc_open_usmc",
	"fow_v_willys_usmc"
];

baseEnemyLightArmoredVehicleGroup_FOW_USMC = [
	"fow_v_lvta2_usmc"
];

baseEnemyHeavyArmoredVehicleGroup_FOW_USMC = [
	"fow_v_m5a1_usmc",
	"fow_v_m4a2_usmc"
];


baseEnemyTurretGroup_FOW_USMC = [
	//Turrets 
	["fow_w_m1919a6_deployed_middle_usmc_camo02", "SMALLBUNKER"],
	["fow_w_m1919a6_deployed_high_usmc_camo01", "SMALLBUNKER"]
];


//Basic enemy aircraft avalaible
baseFixedWingGroup_FOW_USMC = [
	"fow_va_f6f",
	"fow_va_f6f_c",
	"fow_va_f6f_c_sweet",
	"fow_va_f6f_c_kick"
];



////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_FOW_USMC = [
	"fow_v_gmc_usmc",
	"fow_v_gmc_open_usmc",
	"fow_v_willys_usmc"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_FOW_USMC = [

];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_FOW_USMC = [

];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_FOW_USMC = [

];

bluforExtractVehicleChopper_FOW_USMC = [

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_FOW_USMC = [
	"fow_v_m5a1_usmc",
	"fow_v_m4a2_usmc",
	"fow_v_lvta2_usmc"
];

//Drone vehicle avalaible for blufor
bluforDrone_FOW_USMC = [
	
];

//Boat vehicle avalaible for blufor
bluforBoat_FOW_USMC = [
	"fow_usmc_lcvp"
];

//FixedWing vehicle avalaible for bluforq
bluforFixedWing_FOW_USMC = [
	"fow_va_f6f",
	"fow_va_f6f_c",
	"fow_va_f6f_c_sweet",
	"fow_va_f6f_c_kick"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_FOW_USMC = [
	"fow_v_gmc_usmc"
];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"

loadout_FOW_USMC = [		
	[c_leader, "fow_s_usmc_teamleader"],
	[c_at, "fow_s_usmc_at"],
	[c_rifleman, "fow_s_usmc_rifleman"],//Default stuff
	//[c_grenadier, "fow_s_us_p_rifleman_gl"], //There is a bug, the GL cannot be launched
	[c_engineer, "fow_s_us_p_engineer"],
	[c_autorifleman, "fow_s_usmc_bar_gunner"],
	[c_marksman, "fow_s_us_p_sniper_m1903a1"],
	[c_medic, "fow_s_usmc_medic"],
	[c_pilot, "fow_s_usmc_coxswain"],
	[c_radioman, "fow_s_usmc_radio_operator"]
];


////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_FOW_USMC = [		
	"fow_w_m1a1_thompson",
	"fow_w_m1_garand",
	"fow_w_m1_carbine",
	"fow_w_m1903A1",
	"fow_w_M1912",
	"fow_w_ithaca37",
	"fow_w_m1911"
];	

//Launcher avalaible for AT
launcherList_FOW_USMC = [
	"fow_w_m1a1_bazooka"
];	

grenadeLauncherList_FOW_USMC =  [		
	//Vanilla

];	


//Autorifle avalaible for autorifleman
autorifleList_FOW_USMC = [
	"fow_w_m1919a6",
	"fow_w_m1919a4",
	"fow_w_m1918a2"
];	

//Rifle avalaible for marksman
marksmanrifleList_FOW_USMC = [
	"fow_w_m1903A1_sniper"
];

//Smg avalaible for all unit
smgList_FOW_USMC = [
	"fow_w_m3",
	"fow_w_m55_reising"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_FOW_USMC	= [
	"fow_w_acc_m1918a2_bipod",
	"fow_w_acc_m1918a2_handle",
	"fow_w_acc_m1_bayo"
];

//Long range scope avalaible for marksman
attachmentLongList_FOW_USMC	= [

];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_FOW_USMC = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"Binocular",
	"ACE_MapTools",
	"ACE_SpraypaintRed",
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
	"acc_flashlight",
	"ACE_Banana",
	"HandGrenade",
	"MiniGrenade",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_RangeCard"
	];

//item avalaible for all engineer
itemEngineerList_FOW_USMC = [
	"DemoCharge_Remote_Mag"
];

//item avalaible for all medic
itemMedicList_FOW_USMC = [
];


//backpack avalaible for all unit
backPackList_FOW_USMC = [
	"fow_b_us_rocket_bag_at",
	"fow_b_usmc_m1928_medic",
	"fow_b_usmc_m1928_02",
	"fow_b_usmc_m1928",
	"fow_b_us_radio"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_FOW_USMC = [
	//Uniform
	"fow_u_usmc_p41_01_private",
	"fow_u_usmc_p42_01_camo01_1_private",
	"fow_u_us_hbt_01_private",
	
	//Vest
	"fow_v_usmc_bar",
	"fow_v_usmc_garand",

	//Head
	"fow_h_usmc_m1",
	"fow_h_us_m1",
	"fow_h_usmc_m1_camo_01",
	"fow_h_us_daisy_mae_01",
	"fow_h_us_daisy_mae_02"
];

uniformListSniper_FOW_USMC = [

];


magazineList_FOW_USMC = [

];