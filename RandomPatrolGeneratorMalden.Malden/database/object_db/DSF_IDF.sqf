#include "..\classConstant.sqf"

//Add specific DSF factions
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "DSF_core")) then 
{
	factionInfos pushBack ["_DSF_IDF", factionID,"Israeli defense forces [DSF]", true, false, false];
};


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_DSF_IDF = [
	"B_MRAP_01_F"
];

bluforArmedVehicle_DSF_IDF = [
	"DSF_IDF_MRAP_MG"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_DSF_IDF = [
	"DSF_IDF_Merkava",
	"DSF_IDF_Namer"
];

bluforUnarmedVehicleChopper_DSF_IDF = [

];

bluforArmedChopper_DSF_IDF = [
	"DSF_IDF_gunship", 
	"DSF_IDF_helo"
];

bluforDrone_DSF_IDF = [

];

bluforBoat_DSF_IDF = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_DSF_IDF = [
	"B_Plane_Fighter_01_F" //To replace israeli F35
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_DSF_IDF = [
	"DSF_IDF_Namer"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_DSF_IDF = [		
	[c_leader, "DSF_IDF_SquadLeader"],
	[c_at, "DSF_IDF_ATSoldier"],
	[c_rifleman, "DSF_IDF_Rifleman"],//Default stuff
	[c_engineer,"DSF_IDF_Engineer"],
	[c_autorifleman, "DSF_IDF_MachineGunner"],
	[c_marksman, [["srifle_LRR_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["DSF_IDF_BDU",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16]]],["V_CarrierRigKBT_01_light_Olive_F",[["7Rnd_408_Mag",9,7],["Chemlight_green",1,1],["Chemlight_red",1,1]]],[],"H_HelmetB_snakeskin","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_medic,"DSF_IDF_Medic"], //Taken from Navy (No medic in USMC)
	[c_grenadier, "DSF_IDF_Grenadier"],
	[c_pilot,"DSF_IDF_HeliPilot"]
];


////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_DSF_IDF = [	
	"arifle_TRG21_F",
	"arifle_TRG20_F",
	"hgun_P07_F"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_DSF_IDF = [		
	"arifle_TRG21_GL_F"
];


launcherList_DSF_IDF = [		
	"launch_MRAWS_olive_F",
	"launch_NLAW_F",
	"launch_B_Titan_F"
];	

autorifleList_DSF_IDF = [			
	"LMG_Zafir_F",
	"lmg_03_F"
];	

marksmanrifleList_DSF_IDF = [		
	"srifle_LRR_F"
];

smgList_DSF_IDF = [		

];


//////////////////////////
attachmentShortList_DSF_IDF	= [
	"optic_Arco_blk_F",
	"optic_MRCO"
];

attachmentLongList_DSF_IDF	= [
	"optic_DMS",
	"optic_LRPS"
];

////////////////////////
////Items management////
////////////////////////
itemList_DSF_IDF = [
	"NVGoggles",
	"Laserdesignator",
	"B_UavTerminal",
	"ItemGPS",
	"Binocular",
	"Rangefinder",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard",
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP"
];

itemEngineerList_DSF_IDF = [
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_DSF_IDF = [

];

//backpack avalaible for all unit
backPackList_DSF_IDF = [
	"DSF_AT4_Backpack",
	"B_TacticalPack_blk",
	"B_Carryall_oli",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green",
	"B_parachute"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_DSF_IDF = [
	//Uniform
	"DSF_IDF_BDU",
	"DSF_IDF_BDU_rolled",

	//Vest
	"V_CarrierRigKBT_01_light_Olive_F",
	"V_Chestrig_oli",

	//Helmet
	"H_HelmetB_snakeskin",
	"H_Cap_oli"
];


//Magazine avalaible for all unit
magazineList_DSF_IDF = 	[
	"1Rnd_HE_Grenade_shell",
	"30Rnd_556x45_Stanag",
	"HandGrenade",
	"SmokeShell"
];


