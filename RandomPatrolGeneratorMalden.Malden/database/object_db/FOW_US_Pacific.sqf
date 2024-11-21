#include "..\classConstant.sqf"

factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "fow_main")) then 
{
	factionInfos pushBack["FOW_US_Pacific", factionID,"US Army Pacific [FOW]", true, false, false];
};

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicleFOW_US_Pacific = [
	"fow_v_willys_usa", 
	"fow_v_gmc_usa", 
	"fow_v_gmc_open_usa"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicleFOW_US_Pacific = [

];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopperFOW_US_Pacific = [

];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopperFOW_US_Pacific = [

];

bluforExtractVehicleChopperFOW_US_Pacific = [

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicleFOW_US_Pacific = [
	"fow_v_m4a2_usa",
	"fow_v_m5a1_usa",
	"fow_v_lvta2_usa_p"
];



//Drone vehicle avalaible for blufor
bluforDroneFOW_US_Pacific = [
	
];

//Boat vehicle avalaible for blufor
bluforBoatFOW_US_Pacific = [
	"fow_usa_lcvp"
];

//FixedWing vehicle avalaible for bluforq
bluforFixedWingFOW_US_Pacific = [
	"fow_va_f6f",
	"fow_va_f6f_c",
	"fow_va_f6f_c_sweet",
	"fow_va_f6f_c_kick"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicleFOW_US_Pacific = [
	"fow_v_lvta2_usa"
];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"

loadoutFOW_US_Pacific = [		
	[c_leader, "fow_s_us_mm_officer"],
	[c_at, "fow_s_us_mm_at"],
	[c_rifleman, "fow_s_us_mm_rifleman"],//Default stuff
	//[c_grenadier, "fow_s_us_p_rifleman_gl"], //There is a bug, the GL cannot be launched
	[c_engineer, "fow_s_us_p_engineer"],
	[c_autorifleman, "fow_s_us_mm_bar_gunner"],
	[c_marksman, "fow_s_us_p_sniper_m1903a1"],
	[c_medic, "fow_s_us_mm_medic"],
	[c_pilot, "fow_s_us_pilot_green"],
	[c_radioman, "fow_s_us_mm_radio_operator"]
];


////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleListFOW_US_Pacific = [		
	"fow_w_m1a1_thompson",
	"fow_w_m1_garand",
	"fow_w_m1_carbine",
	"fow_w_m1903A1",
	"fow_w_M1912",
	"fow_w_ithaca37",
	"fow_w_m1911"
];	

//Launcher avalaible for AT
launcherListFOW_US_Pacific = [
	"fow_w_m1a1_bazooka"
];	

grenadeLauncherListFOW_US_Pacific =  [		
	//Vanilla

];	


//Autorifle avalaible for autorifleman
autorifleListFOW_US_Pacific = [
	"fow_w_m1919a6",
	"fow_w_m1919a4",
	"fow_w_m1918a2"
];	

//Rifle avalaible for marksman
marksmanrifleListFOW_US_Pacific = [
	"fow_w_m1903A1_sniper"
];

//Smg avalaible for all unit
smgListFOW_US_Pacific = [
	"fow_w_m3",
	"fow_w_m55_reising"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortListFOW_US_Pacific	= [
	"fow_w_acc_m1918a2_bipod",
	"fow_w_acc_m1918a2_handle",
	"fow_w_acc_m1_bayo"
];

//Long range scope avalaible for marksman
attachmentLongListFOW_US_Pacific	= [

];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemListFOW_US_Pacific = [
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
itemEngineerListFOW_US_Pacific = [
	"DemoCharge_Remote_Mag"
];

//item avalaible for all medic
itemMedicListFOW_US_Pacific = [
];


//backpack avalaible for all unit
backPackListFOW_US_Pacific = [
	"fow_b_us_m1928",
	"fow_b_us_bandoleer",
	"fow_b_us_m1944_ropes",
	"fow_b_us_m2_mortar_support",
	"fow_b_us_m2_mortar_weapon",
	"fow_b_us_radio"
];


//Uniform, vest, headgear, avalaible for all unit
uniformListFOW_US_Pacific = [
	//Uniform
	"fow_u_us_hbt_01_private",
	"fow_u_us_hbt_02_private",
	
	//Vest
	"fow_v_us_asst_mg",
	"fow_v_us_45",

	//Head
	"fow_h_us_m1_folded",
	"fow_h_us_m1_net",
	"fow_h_us_m1",
	"fow_h_us_daisy_mae_01",
	"fow_h_us_daisy_mae_02"
];



uniformListSniperFOW_US_Pacific = [

];


magazineListFOW_US_Pacific = [

];