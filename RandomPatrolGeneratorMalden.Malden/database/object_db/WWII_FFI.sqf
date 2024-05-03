c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_pilot = "pilot";

//Add specific IFA3 factions
if (isClass (configFile >> "CfgPatches" >> "IFA3_Core")) then 
{
	factionInfos pushBack ["_WWII_FFI",26,"WWII FFI [IFA3]", true, true, true];
};


//////////////////////////////
////Define civ group data/////
//////////////////////////////

//WWII_USA
// Civs have a prefix in "LIB_CIV"
civilian_group_WWII_FFI = [
	"LIB_CIV_Citizen_6", 
	"LIB_CIV_Citizen_7", 
	"LIB_CIV_Citizen_8"
];

civilian_big_group_WWII_FFI = [
	"LIB_CIV_Villager_1", 
	"LIB_CIV_Villager_4", 
	"LIB_CIV_Villager_2", 
	"LIB_CIV_Villager_3", 
	"LIB_CIV_Woodlander_1", 
	"LIB_CIV_Woodlander_2", 
	"LIB_CIV_Woodlander_3", 
	"LIB_CIV_Woodlander_4"
];

civilianTruck_WWII_FFI = [
	"LIB_GazM1", 
	"LIB_GazM1_dirty",
	"LIB_CIV_FFI_CitC4",
	"LIB_CIV_FFI_CitC4_3"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//WWII_USA
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_WWII_FFI = [

];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_WWII_FFI = [

];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_WWII_FFI = [

];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_WWII_FFI = [

];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_WWII_FFI = [

];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_WWII_FFI = [

];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
// other choices are commented
baseEnemyHeavyArmoredVehicleGroup_WWII_FFI = [

];



//Basic enemy aircraft avalaible
baseFixedWingGroup_WWII_FFI = [

];

////////////////////////
//Vehicle management////
////////////////////////
//WWII_USA
bluforUnarmedVehicle_WWII_FFI = [
	"LIB_CIV_FFI_CitC4", 
	"LIB_CIV_FFI_CitC4_3", 
	"LIB_CIV_FFI_CitC4_5", 
	"LIB_GazM1_FFI", 
	"LIB_GazM1_FFI_camo_sand", 
	"LIB_GazM1_FFI_camo", 
	"LIB_GazM1_FFI_sand"
];

bluforArmedVehicle_WWII_FFI = [

];

bluforUnarmedVehicleChopper_WWII_FFI = [
	// nein
];

bluforArmoredVehicle_WWII_FFI = [

];

bluforDrone_WWII_FFI = [
	// ...
];

bluforBoat_WWII_FFI = [

];

bluforFixedWing_WWII_FFI = [

];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_WWII_FFI = [
	"LIB_CIV_FFI_CitC4_4"
];

////////////////////////
//Loadout management////
////////////////////////

//WWII_USA
loadout_WWII_FFI = [		
	[c_leader,"LIB_FFI_Soldier_3"],
	[c_at,"LIB_FFI_LAT_Soldier"],
	[c_rifleman,"LIB_FFI_Soldier_1"],//Default stuff
	[c_engineer,[["LIB_Sten_Mk2","","","",["LIB_32Rnd_9x19_Sten",32],[],""],[],[],["U_LIB_CIV_Woodlander_4",[["LIB_32Rnd_9x19_Sten",2,32],["LIB_M39",1,1]]],[],["B_LIB_GER_Tonister34_cowhide",[["ToolKit",1],["ACE_DefusalKit",1],["ACE_EntrenchingTool",1],["ACE_Fortify",1]]],"","",[],["ItemMap","","","ItemCompass","ItemWatch",""]]],
	[c_autorifleman,"LIB_FFI_Soldier_5"],
	[c_medic,[["LIB_Sten_Mk2","","","",["LIB_32Rnd_9x19_Sten",32],[],""],[],[],["U_LIB_CIV_Villager_2",[["LIB_32Rnd_9x19_Sten",2,32],["LIB_M39",1,1]]],[],["B_LIB_GER_Tonister34_cowhide",[["Medikit",1],["FirstAidKit",3]]],"H_LIB_CIV_Villager_Cap_2","",[],["ItemMap","","","ItemCompass","ItemWatch",""]]]
];


////////////////////////
///Weapon management////
////////////////////////
//WWII_USA
rifleList_WWII_FFI = [		
	"LIB_K98",
	"LIB_K98_Late"
];	

launcherList_WWII_FFI = [		
	"LIB_PzFaust_30m"
];	

autorifleList_WWII_FFI = [	
	"LIB_MG34",
	"LIB_Bren_Mk2"
];	

marksmanrifleList_WWII_FFI = [		
];

smgList_WWII_FFI = [
	"LIB_Sten_Mk2",
	"LIB_MP40"
];


//////////////////////////
//Attachement management//
//////////////////////////

// Nothing more than bayonets i think.
attachmentShortList_WWII_FFI	= [
	"lib_acc_gl_enfield_cup_empty",
	"lib_acc_p1903_bayo",
	"lib_acc_no4_mk2_bayo",
	"LIB_ACC_M1_Bayo",
	"LIB_ACC_GL_M7"
];

attachmentLongList_WWII_FFI	= [
	// no optics, sorry...
];

////////////////////////
////Items management////
////////////////////////
itemList_WWII_FFI = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"LIB_Binocular_UK",
	"ACE_MapTools",
	"ACE_CableTie",
	"ACE_Canteen",
	"ACE_EarPlugs",
	"ACE_fieldDressing",
	"ACE_packingBandage",
	"ACE_elasticBandage",
	"ACE_tourniquet",
	"ACE_splint",
	"ACE_morphine",
	"ACE_quikclot",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm"
];

itemEngineerList_WWII_FFI = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
];
	
itemMedicList_WWII_FFI = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];

// Those lists might not be correct...
backPackList_WWII_FFI = [
	"B_LIB_GER_Tonister34_cowhide"
];

uniformList_WWII_FFI = [
	"U_LIB_CIV_Villager_2",
	"U_LIB_CIV_Woodlander_4",
	"U_LIB_CIV_Functionary_4",
	"H_LIB_CIV_Villager_Cap_2",
	"U_LIB_CIV_Citizen_4",
	"U_LIB_CIV_Citizen_3",
	"U_LIB_CIV_Woodlander_2"
];

magazineList_WWII_FFI = [

];