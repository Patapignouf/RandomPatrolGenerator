#include "..\classConstant.sqf"

//Add specific DSF factions
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "INDO_Mod")) then 
{
	factionInfos pushBack ["_INDO", factionID,"Indochine France [INDOCHINE]", true, false, false];
};


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_INDO = [
	"GMC_CCKW_353_OPEN",
	"INDO_DODGE_WC51_OPEN",
	"GMC_CCKW_353_Munitions",
	"GMC_CCKW_353_Carburant"
];

bluforArmedVehicle_INDO = [
	// "INDO_105HM2",
	// "INDO_MORTIER_81"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_INDO = [

];

bluforUnarmedVehicleChopper_INDO = [
	"INDO_H19",
	"INDO_H19_EVASAN"
];

bluforArmedChopper_INDO = [

];

bluforDrone_INDO = [

];

bluforBoat_INDO = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_INDO = [

];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_INDO = [
	"GMC_CCKW_353_OPEN"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_INDO = [		
	[c_leader, "INDO_6BPC_Teamleader_MAT49", [], false, []],
	[c_rifleman, "INDO_6BPC_Rifleman_MAS36CR39"],//Default stuff
	[c_engineer,"INDO_6BPC_Rifleman_MAS36CR39"],
	[c_autorifleman, "INDO_6BPC_Machinegunner_FM2429"],
	[c_medic,"INDO_6BPC_Rifleman_MAS36CR39"], //Taken from Navy (No medic in USMC)
	[c_pilot,"INDO_Pilote_H19"]
];


if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	loadout_INDO append [
			[c_at, [["INDO_MAS36CR39","","","",["INDO_5Rnd_75x54_MAS36",5],[],""],["uns_m1a1_bazooka","","","",["uns_M28A2_mag",1],[],""],[],["INDO_Uniform_6BPC",[["FirstAidKit",1],["INDO_OF_Mle_37_V",1,1]]],["INDO_Vest_Brelage_TAP_MAS36",[["INDO_5Rnd_75x54_MAS36",4,5]]],["INDO_bags_MusetteTAP51",[]],"INDO_Helmet_USM1_Para","",[],["","","","","ItemWatch",""]],[]],
			[c_marksman, [["uns_mas4956","","","uns_o_APXSOM",["uns_mas4956mag",10],[],""],[],[],["INDO_Uniform_6BPC",[["FirstAidKit",1],["INDO_OF_Mle_37_V",1,1]]],["INDO_Vest_Brelage_TAP_MAS36",[]],["INDO_bags_MusetteTAP51",[]],"INDO_Helmet_USM1_Para","",[],["","","","","ItemWatch",""]],[]],
			[c_grenadier, [["uns_mas36short_gl","","","",["uns_mas36mag",5],[],""],[],[],["INDO_Uniform_6BPC",[["FirstAidKit",1],["INDO_OF_Mle_37_V",1,1]]],["INDO_Vest_Brelage_TAP_MAS36",[["Uns_1Rnd_22mm_FRAG",5,1],["Uns_1Rnd_22mm_smoke",1,1]]],["INDO_bags_MusetteTAP51",[]],"INDO_Helmet_USM1_Para","",[],["","","","","ItemWatch",""]],[]]
	];
};




////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_INDO = [	
	"INDO_MAS36CR39",
	"INDO_P38",
	"INDO_Kar98k",
	"INDO_M1A1_Carbine",
	"INDO_M1_Carbine"
];	

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	rifleList_INDO append [
		"uns_mas36",
		"uns_mas36short",
		"uns_mas4956"
	];
};


//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_INDO = [		

];

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	grenadeLauncherList_INDO append [
		"uns_mas36_gl",
		"uns_mas4956_gl"
	];
};

launcherList_INDO = [		

];	

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	launcherList_INDO append [
		"uns_m1a1_bazooka"
	];
};

autorifleList_INDO = [			
	"INDO_FM2429"
];	

marksmanrifleList_INDO = [		

];

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	marksmanrifleList_INDO append [
		"uns_smle",
		"uns_smle_sniper"
	];
};

smgList_INDO = [		
	"INDO_32Rnd_9x19_MAT49",
	"INDO_PPSh41"
];

if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	smgList_INDO append [
		"uns_sten",
		"uns_mat49",
		"uns_thompson"
	];
};



//////////////////////////
attachmentShortList_INDO	= [
	"INDO_Bipod_FM2429"
];

attachmentLongList_INDO	= [
	"uns_o_APXSOM"
];

////////////////////////
////Items management////
////////////////////////
itemList_INDO = [
	"Binocular",
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

itemEngineerList_INDO = [
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_INDO = [

];

//backpack avalaible for all unit
backPackList_INDO = [
	"INDO_bags_MusetteTAP51",
	"INDO_bags_Musette_canon60",
	"INDO_bags_Musette_trepied60",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green",
	"B_parachute"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_INDO = [
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
magazineList_INDO = 	[
	"HandGrenade",
	"Uns_1Rnd_22mm_FRAG"
];


