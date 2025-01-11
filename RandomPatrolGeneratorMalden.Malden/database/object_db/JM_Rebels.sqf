#include "..\classConstant.sqf"

factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "JMSLLTE_empire_mod")) then 
{
	factionInfos pushBack["_JM_Rebels", factionID,"Rebels [JM]", true, false, true];
};

////////////////////////
//Vehicle management////
////////////////////////



//Light civilian group
civilian_group_JM_Rebels = [
	"JMSLLTE_civ_worker",
	"JMSLLTE_civ_worker2",
	"JMSLLTE_civ_al_traveler",
	"JMSLLTE_civ_al_traveler2",
	"JMSLLTE_civ_al_worker2"
];

//Heavy civilian group
civilian_big_group_JM_Rebels = [
	"JMSLLTE_civ_worker",
	"JMSLLTE_civ_worker2",
	"JMSLLTE_civ_al_traveler",
	"JMSLLTE_civ_al_traveler2",
	"JMSLLTE_civ_al_worker2",
	"JMSLLTE_civ_traveler",
	"JMSLLTE_civ_traveler2",
	"JMSLLTE_civ_al_spacepilot3",
	"JMSLLTE_civ_spacepilot",
	"JMSLLTE_civ_al_traveler2"
];

//Vehicle avalaible on civilian city
civilianTruck_JM_Rebels = [
	"JMSLLTE_C_veh_AA2_F",
	"JMSLLTE_C_veh_AA5_F",
	"JMSLLTE_C_veh_g17_F",
	"JMSLLTE_C_veh_x34_F",
	"JMSLLTE_C_veh_v35c_F"
];


//Light vehicle avalaible for blufor : Ex light hummvee, quad
//USA version
bluforUnarmedVehicle_JM_Rebels = [
	"JMSLLTE_O_veh_AA2_reb_F",
	"JMSLLTE_B_veh_g17_reb_F",
	"JMSLLTE_B_veh_x34_reb_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_JM_Rebels = [
	"JMSLLTE_O_veh_AA2mk2_reb_F",
	"JMSLLTE_B_veh_x34mk2_reb_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_JM_Rebels = [
	"JMSLLTE_UwingHeli_Reb_F"
];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_JM_Rebels = [

];

bluforExtractVehicleChopper_JM_Rebels = [

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_JM_Rebels = [
	"JMSLLTE_O_veh_AA5_reb_F"
];

//Drone vehicle avalaible for blufor
bluforDrone_JM_Rebels = [
	
];

//Boat vehicle avalaible for blufor
bluforBoat_JM_Rebels = [

];

//FixedWing vehicle avalaible for bluforq
bluforFixedWing_JM_Rebels = [
	"JMSLLTE_YwingA4_veh_F",
	"JMSLLTE_YwingS3_veh_F",
	"JMSLLTE_Awing_veh_F",
	"JMSLLTE_Xwing_veh_F",
	"JMSLLTE_XwingT70_reb_F",
	"JMSLLTE_Uwing_veh_F"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_JM_Rebels = [

];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"

loadout_JM_Rebels = [		
	[c_leader, "JMSLLTE_scum_desert_serg", ["JMSLLTE_scum_commando_serg", "JMSLLTE_scum_snow_serg", "JMSLLTE_scum_navy_serg"], false],
	[c_at, "JMSLLTE_scum_desert_trooperAT", ["JMSLLTE_scum_commando_trooperAT"], false],
	[c_rifleman, "JMSLLTE_scum_desert_al_trooper", ["JMSLLTE_scum_commando_trooper", "JMSLLTE_scum_sf_desert_trooper", "JMSLLTE_scum_sf_desert_al_trooper"], false],//Default stuff
	[c_engineer, "JMSLLTE_scum_desert_al_trooper", ["JMSLLTE_scum_commando_cpl", "JMSLLTE_scum_snow_trooper"], false],
	[c_autorifleman, "JMSLLTE_scum_desert_al_trooperH", ["JMSLLTE_scum_commando_trooperH", "JMSLLTE_scum_commando_al_trooperH", "JMSLLTE_scum_snow_trooperH"], false],
	[c_marksman, "JMSLLTE_scum_desert_snip", ["JMSLLTE_scum_sf_desert_snip", "JMSLLTE_scum_snow_snip", "JMSLLTE_scum_commando_snip", "JMSLLTE_scum_commando_marksman"], false],
	[c_medic, "JMSLLTE_scum_desert_medic", ["JMSLLTE_scum_commando_medic", "JMSLLTE_scum_snow_medic"], false],
	[c_pilot, "JMSLLTE_scum_navy_Xpilot", [], false]
];

////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_JM_Rebels = [		
	// "JMSLLTE_a280",
	// "JMSLLTE_a280c",
	// "JMSLLTE_dh17rifle_Scoped"
];	

//Launcher avalaible for AT
launcherList_JM_Rebels = [

];	

grenadeLauncherList_JM_Rebels =  [		
	//Vanilla

];	


//Autorifle avalaible for autorifleman
autorifleList_JM_Rebels = [
	// "JMSLLTE_rt97c_Scoped"
];	

//Rifle avalaible for marksman
marksmanrifleList_JM_Rebels = [
	// "JMSLLTE_a310",
	// "JMSLLTE_dlt20a"
];

//Smg avalaible for all unit
smgList_JM_Rebels = [

];

//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_JM_Rebels	= [
	// "JMSLLTE_a280c_bl_Scope",
	// "JMSLLTE_a280_bl_Scope",
	// "JMSLLTE_rt97c_bl_Scope",
	// "JMSLLTE_dh17_holo_Scope",
	// "JMSLLTE_a280_holo_Scope"
];

//Long range scope avalaible for marksman
attachmentLongList_JM_Rebels	= [
	// "JMSLLTE_a300_bl_Scope"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_JM_Rebels = [
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
itemEngineerList_JM_Rebels = [
	"DemoCharge_Remote_Mag"
];

//item avalaible for all medic
itemMedicList_JM_Rebels = [
];


//backpack avalaible for all unit
backPackList_JM_Rebels = [
	"JMSLLTE_back_rebsmall_v1"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_JM_Rebels = [
	//Uniform

	
	//Vest


	//Head


];

uniformListSniper_JM_Rebels = [

];


magazineList_JM_Rebels = [

];