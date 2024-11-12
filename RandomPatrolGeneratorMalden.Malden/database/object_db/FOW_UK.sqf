#include "..\classConstant.sqf"

factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "fow_main")) then 
{
	factionInfos pushBack["_FOW_UK", factionID,"United Kingdom [FOW]", true, false, false];
};

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
//USA version
bluforUnarmedVehicle_FOW_UK = [
	"fow_v_gmc_usa", 
	"fow_v_willys_usa", 
	"fow_v_gmc_open_usa"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_FOW_UK = [

];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_FOW_UK = [

];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_FOW_UK = [

];

bluforExtractVehicleChopper_FOW_UK = [

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_FOW_UK = [
	"fow_v_universalCarrier",
	"fow_v_cromwell_uk"
];

//Drone vehicle avalaible for blufor
bluforDrone_FOW_UK = [
	
];

//Boat vehicle avalaible for blufor
bluforBoat_FOW_UK = [
	"fow_usa_lcvp"
];

//FixedWing vehicle avalaible for bluforq
bluforFixedWing_FOW_UK = [
	"fow_va_f6f_faa", 
	"fow_va_f6f_c_faa"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_FOW_UK = [
	"fow_v_universalCarrier"
];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"

loadout_FOW_UK = [		
	[c_leader, "fow_s_uk_officer"],
	[c_at, "fow_s_uk_at"],
	[c_rifleman, "fow_s_uk_rifleman"],//Default stuff
	[c_engineer, [[["fow_w_leeenfield_no4mk1","","","",["fow_10Rnd_303",10],[],""],[],[],["fow_u_uk_bd40_01_private",[["FirstAidKit",1],["fow_e_no36mk1",2,1],["fow_10Rnd_303",5,10]]],["fow_v_uk_base_green",[["fow_30Rnd_303_bren",2,30]]],["fow_b_uk_bergenpack",[["ACE_DefusalKit",1],["ToolKit",1]]],"fow_h_uk_mk2","",[],["ItemMap","","","ItemCompass","ItemWatch",""]],[]]],
	[c_autorifleman, "fow_s_uk_bren_gunner"],
	[c_marksman, "fow_s_hi_sniper_m1903a1"],
	[c_medic, "fow_s_uk_medic"],
	[c_pilot, "fow_s_uk_crewman"],
	["radioman", "fow_s_uk_radio_operator"]
];


////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_FOW_UK = [		
	"fow_w_leeenfield_no4mk1",
	"fow_w_m1_thompson",
	"fow_w_webley"
];	

//Launcher avalaible for AT
launcherList_FOW_UK = [
	"fow_1Rnd_piat_HEAT"
];	

grenadeLauncherList_FOW_UK =  [		
	//Vanilla

];	


//Autorifle avalaible for autorifleman
autorifleList_FOW_UK = [
	"fow_w_bren"
];	

//Rifle avalaible for marksman
marksmanrifleList_FOW_UK = [
	"fow_w_m1903A1_sniper"
];

//Smg avalaible for all unit
smgList_FOW_UK = [
	"fow_w_sten_mk5",
	"fow_w_sten_mk2"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_FOW_UK	= [
	"fow_w_acc_no4_bayo"
];

//Long range scope avalaible for marksman
attachmentLongList_FOW_UK	= [

];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_FOW_UK = [
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
itemEngineerList_FOW_UK = [
	"DemoCharge_Remote_Mag"
];

//item avalaible for all medic
itemMedicList_FOW_UK = [
];


//backpack avalaible for all unit
backPackList_FOW_UK = [
	"fow_b_uk_piat_at",
	"fow_b_uk_bergenpack",
	"fow_b_uk_p37_radio_blanco",
	"fow_b_uk_p37",
	"TFAR_rt1523g",
	"TFAR_rt1523g_big_rhs"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_FOW_UK = [
	//Uniform
	"fow_u_uk_parasmock",
	"fow_u_uk_bd40_kieffer_02",
	"fow_u_uk_bd40_pib_01_private",
	"fow_u_uk_bd40_bp_01_private",
	
	//Vest
	"fow_v_uk_para_bren_green",
	"fow_v_uk_sten_green",
	"fow_v_uk_bren_green",

	//Head
	"fow_h_uk_mk2_para",
	"fow_h_uk_beret_commando_kieffer",
	"fow_h_uk_mk2_net",
	"fow_h_uk_mk2"

];

uniformListSniper_FOW_UK = [

];


magazineList_FOW_UK = [

];