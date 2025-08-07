#include "..\classConstant.sqf"

//Add specific DSF factions
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "INDO_Mod")) then 
{
	factionInfos pushBack ["_INDO_FR", factionID,"Indochine France [INDOCHINE]", true, false, false];
};


////////////////////////f
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_INDO_FR = [
	"GMC_CCKW_353_OPEN",
	"INDO_DODGE_WC51_OPEN",
	"GMC_CCKW_353_Munitions",
	"GMC_CCKW_353_Carburant"
];

bluforArmedVehicle_INDO_FR = [

];

bluforStaticWeapon_INDO_FR = 
[
	"INDO_105HM2",
	"INDO_MORTIER_81"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_INDO_FR = [

];

bluforUnarmedVehicleChopper_INDO_FR = [
	"INDO_H19"
];

bluforArmedChopper_INDO_FR = [

];

bluforDrone_INDO_FR = [

]; 

bluforBoat_INDO_FR = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_INDO_FR = [

];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_INDO_FR = [
	"GMC_CCKW_353_OPEN"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_INDO_FR = [		
	[c_leader, "INDO_6BPC_Teamleader_MAT49", [], false, []],
	[c_rifleman, "INDO_6BPC_Rifleman_MAS36CR39"],//Default stuff
	[c_engineer,"INDO_6BPC_Rifleman_MAS36CR39"],
	[c_autorifleman, "INDO_6BPC_Machinegunner_FM2429"],
	[c_medic,"INDO_6BPC_Rifleman_MAS36CR39"], //Taken from Navy (No medic in USMC)
	[c_pilot,"INDO_Pilote_H19"]
];


if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	loadout_INDO_FR append [
			[c_at, [["INDO_MAS36CR39","","","",["INDO_5Rnd_75x54_MAS36",5],[],""],["uns_m1a1_bazooka","","","",["uns_M28A2_mag",1],[],""],[],["INDO_Uniform_6BPC",[["ACE_elasticBandage",8],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["INDO_OF_Mle_37_V",1,1]]],["INDO_Vest_Brelage_TAP_MAS36",[["ACE_tourniquet",1],["ACE_splint",2],["ACE_CableTie",2],["ACE_MapTools",1],["ACE_morphine",1],["ACE_WaterBottle",1],["INDO_5Rnd_75x54_MAS36",6,5]]],["INDO_bags_MusetteTAP51",[["INDO_5Rnd_75x54_MAS36",6,5],["uns_M28A2_mag",2,1]]],"INDO_Helmet_USM1_Para","",[],["","","TFAR_anprc152_6","","ItemWatch",""]],[]],
			[c_marksman, [["uns_mas4956","","","uns_o_APXSOM",["uns_mas4956mag",10],[],""],[],[],["INDO_Uniform_6BPC",[["ACE_elasticBandage",8],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["INDO_OF_Mle_37_V",1,1]]],["INDO_Vest_Brelage_TAP_MAS36",[["ACE_tourniquet",1],["ACE_splint",2],["ACE_CableTie",2],["ACE_MapTools",1],["ACE_morphine",1],["ACE_WaterBottle",1],["uns_mas4956mag_T",4,10]]],["INDO_bags_MusetteTAP51",[["uns_mas4956mag_T",4,10]]],"INDO_Helmet_USM1_Para","",[],["","","TFAR_anprc152_4","","ItemWatch",""]],[]],
			[c_grenadier, [["uns_mas36short_gl","","","",["uns_mas36mag",5],[],""],[],[],["INDO_Uniform_6BPC",[["ACE_elasticBandage",8],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["INDO_OF_Mle_37_V",1,1]]],["INDO_Vest_Brelage_TAP_MAS36",[["ACE_tourniquet",1],["ACE_CableTie",2],["ACE_MapTools",1],["Uns_1Rnd_22mm_FRAG",5,1],["Uns_1Rnd_22mm_smoke",1,1]]],["INDO_bags_MusetteTAP51",[["ACE_splint",2],["ACE_morphine",1],["ACE_WaterBottle",1],["uns_mas36mag_T",20,5]]],"INDO_Helmet_USM1_Para","",[],["","","TFAR_anprc152_5","","ItemWatch",""]],[]]
	];
};




////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_INDO_FR = [	
	"INDO_MAS36CR39",
	"INDO_P38",
	"INDO_Kar98k",
	"INDO_M1A1_Carbine",
	"INDO_M1_Carbine"
];	

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	rifleList_INDO_FR append [
		"uns_mas36",
		"uns_mas36short",
		"uns_mas4956"
	];
};


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_INDO_FR = [		

];

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	grenadeLauncherList_INDO_FR append [
		"uns_mas36_gl",
		"uns_mas4956_gl"
	];
};

launcherList_INDO_FR = [		

];	

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	launcherList_INDO_FR append [
		"uns_m1a1_bazooka"
	];
};

autorifleList_INDO_FR = [			
	"INDO_FM2429"
];	

marksmanrifleList_INDO_FR = [		

];

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	marksmanrifleList_INDO_FR append [
		"uns_smle",
		"uns_smle_sniper"
	];
};

smgList_INDO_FR = [		
	"INDO_32Rnd_9x19_MAT49",
	"INDO_PPSh41"
];

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	smgList_INDO_FR append [
		"uns_sten",
		"uns_mat49",
		"uns_thompson"
	];
};



//////////////////////////
attachmentShortList_INDO_FR	= [
	"INDO_Bipod_FM2429"
];

attachmentLongList_INDO_FR	= [
	"uns_o_APXSOM"
];

////////////////////////
////Items management////
////////////////////////
itemList_INDO_FR = [
	"Binocular",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard"
];

itemEngineerList_INDO_FR = [
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_INDO_FR = [

];

//backpack avalaible for all unit
backPackList_INDO_FR = [
	"INDO_bags_MusetteTAP51",
	"INDO_bags_Musette_canon60",
	"INDO_bags_Musette_trepied60",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green",
	"B_parachute"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_INDO_FR = [
	//Uniform
	"INDO_OF_Mle_37_V",
	"INDO_Uniform_TTA47_Long",
	"INDO_Uniform_TTA47_Short",

	//Vest
	"INDO_Vest_Brelage_TAP_USM1",
	"INDO_Vest_Brelage_TAP_MAS36",
	"INDO_Vest_Brelage_TAP_MAT49",

	//Helmet
	"INDO_Helmet_USM1_Para",
	"INDO_Helmet_Broussard02"
];


//Magazine avalaible for all unit
magazineList_INDO_FR = 	[
	"HandGrenade",
	"Uns_1Rnd_22mm_FRAG"
];


