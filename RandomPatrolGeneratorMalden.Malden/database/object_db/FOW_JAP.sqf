#include "..\classConstant.sqf"

factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "fow_main")) then 
{
	factionInfos pushBack ["_FOW_JAP", factionID,"Japanese [FOW]", true, true, false];
};
//////////////////////////////
///Define enemy group data////
//////////////////////////////

baseEnemyGroup_FOW_JAP = [
	"fow_s_ija_nco",
	"fow_s_ija_type99_gunner",
	"fow_s_ija_type99_asst",
	"fow_s_ija_type99_asst",
	"fow_s_ija_type99_asst",
	"fow_s_ija_rifleman",
	"fow_s_ija_rifleman",
	"fow_s_ija_rifleman",
	"fow_s_ija_medic"
];

baseEnemyATGroup_FOW_JAP = [
	"fow_s_ija_f_rifleman_at",
	"fow_s_ija_f_rifleman_at",
	"fow_s_ija_f_rifleman_at",
	"fow_s_ija_f_nco",
	"fow_s_ija_f_type99_asst",
	"fow_s_ija_f_medic"
];

baseEnemyDemoGroup_FOW_JAP = [
	"fow_s_ija_officer",
	"fow_s_ija_radio_operator",
	"fow_s_ija_medic",
	"fow_s_ija_type99_gunner",
	"fow_s_ija_rifleman",
	"fow_s_ija_rifleman",
	"fow_s_ija_rifleman"
];

baseEnemyMortarGroup_FOW_JAP = [
	"fow_w_type97_mortar_ija",
	"fow_s_ija_f_rifleman",
	"fow_s_ija_f_radio_operator"
];

baseEnemyVehicleGroup_FOW_JAP = [
	"fow_v_type97_truck_ija",
	"fow_v_type97_truck_open_ija"
];

baseEnemyLightArmoredVehicleGroup_FOW_JAP = [

];

baseEnemyHeavyArmoredVehicleGroup_FOW_JAP = [
	"fow_ija_type95_HaGo_1_ija",
	"fow_ija_type95_HaGo_2_ija",
	"fow_ija_type95_HaGo_3_ija"
];


baseEnemyTurretGroup_FOW_JAP = [
	//Turrets 
	["fow_w_type92_tripod_ija", "SMALLBUNKER"],
	["fow_w_type92_tripod_middle_ija", "SMALLBUNKER"],
	["fow_w_6Pounder_ija", "SMALLBUNKER"],
	["fow_w_type92_tripod_low_s_ija", "NOTHING"]
];


//Basic enemy aircraft avalaible
baseFixedWingGroup_FOW_JAP = [
	"fow_va_a6m_green",
	"fow_va_a6m_white"
];


////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_FOW_JAP = [
	"fow_v_type97_truck_open_ija", 
	"fow_v_type97_truck_ija"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_FOW_JAP = [

];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_FOW_JAP = [

];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_FOW_JAP = [

];

bluforExtractVehicleChopper_FOW_JAP = [

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_FOW_JAP = [
	"fow_ija_type95_HaGo_2_ija", 
	"fow_ija_type95_HaGo_3_ija", 
	"fow_ija_type95_HaGo_1_ija"
];

//Drone vehicle avalaible for blufor
bluforDrone_FOW_JAP = [
	
];

//Boat vehicle avalaible for blufor
bluforBoat_FOW_JAP = [

];

//FixedWing vehicle avalaible for bluforq
bluforFixedWing_FOW_JAP = [
	"fow_va_a6m_green",
	"fow_va_a6m_white"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_FOW_JAP = [
	"fow_v_type97_truck_fuel_ija"
];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"

loadout_FOW_JAP = [		
	[c_leader, "fow_s_ija_officer"],
	[c_at, "fow_s_ija_rifleman_at"],
	[c_rifleman, "fow_s_ija_rifleman"],//Default stuff
	[c_engineer, [[["fow_w_type99","","","",["fow_5Rnd_77x58",5],[],""],[],[],["fow_u_ija_type98",[["FirstAidKit",1],["fow_5Rnd_77x58",3,5]]],["fow_v_ija_rifle",[["fow_5Rnd_77x58",15,5],["fow_e_type97",2,1]]],["fow_b_ija_backpack",[["ACE_DefusalKit",1],["ACE_EntrenchingTool",1],["ACE_Fortify",1]]],"fow_h_ija_type90","",[],["ItemMap","","","ItemCompass","ItemWatch",""]],[]]],
	[c_autorifleman, "fow_s_ija_type99_gunner"],
	[c_marksman, "fow_s_ija_f_rifleman"],
	[c_medic, "fow_s_ija_medic"],
	[c_pilot, "fow_s_ija_pilot"],
	[c_radioman, "fow_s_ija_radio_operator"]
];


////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_FOW_JAP = [		
	"fow_w_type99",
	"fow_w_type14"
];	

//Launcher avalaible for AT
launcherList_FOW_JAP = [

];	

grenadeLauncherList_FOW_JAP =  [		
	//Vanilla
];	


//Autorifle avalaible for autorifleman
autorifleList_FOW_JAP = [
	"fow_w_type99_lmg"
];	

//Rifle avalaible for marksman
marksmanrifleList_FOW_JAP = [
	"fow_w_type99_sniper"
];

//Smg avalaible for all unit
smgList_FOW_JAP = [
	"fow_w_type100"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_FOW_JAP	= [
	"fow_w_acc_type30_bayo"
];

//Long range scope avalaible for marksman
attachmentLongList_FOW_JAP	= [

];


////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_FOW_JAP = [
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
itemEngineerList_FOW_JAP = [
	"DemoCharge_Remote_Mag"
];

//item avalaible for all medic
itemMedicList_FOW_JAP = [
];


//backpack avalaible for all unit
backPackList_FOW_JAP = [
	"fow_b_ija_backpack",
	"fow_b_ija_radio",
	"fow_b_ija_type97_mortar_support",
	"fow_b_ija_type97_mortar_weapon"
];


uniformList_FOW_JAP = [
	//uniform
	"fow_u_ija_type98",
	"fow_u_ija_type98_snlf",

	//vest
	"fow_v_ija_rifle",

	//head
	"fow_h_ija_type90",
	"fow_h_ija_fieldcap",
	"fow_h_ija_fieldcap_marine_neck"
];

uniformListSniper_FOW_JAP = [

];


magazineList_FOW_JAP = [

];