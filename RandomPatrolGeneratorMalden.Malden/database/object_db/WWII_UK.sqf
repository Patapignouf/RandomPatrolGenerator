c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_radioman = "radioman";
c_pilot = "pilot";

//Add specific IFA3 factions
if (isClass (configFile >> "CfgPatches" >> "IFA3_Core")) then 
{
	factionInfos pushBack ["_WWII_UK", 6, "WWII UK [IFA3]", true, true, false];
};

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//WWII_UK
// Civs have a prefix in "LIB_CIV"
civilian_group_WWII_UK = [
	"LIB_CIV_Citizen_1",
	"LIB_CIV_Villager_4",
	"LIB_CIV_Citizen_5"
];

civilian_big_group_WWII_UK = [
	"LIB_CIV_Citizen_2",
	"LIB_CIV_Citizen_8",
	"LIB_CIV_Woodlander_1",
	"LIB_CIV_Worker_2",
	"LIB_CIV_Rocker",
	"LIB_CIV_Functionary_4",
	"LIB_CIV_Doctor"
];

civilianTruck_WWII_UK = [
"LIB_GazM1", 
"LIB_GazM1_dirty"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//WWII_UK
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_WWII_UK = [
	"LIB_UK_Officer",
	"LIB_UK_Medic",
	"LIB_UK_LanceCorporal",
	"LIB_UK_Sniper",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman"
];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_WWII_UK = [
	"LIB_UK_Officer",
	"LIB_UK_LanceCorporal",
	"LIB_UK_LanceCorporal",
	"LIB_UK_AT_Soldier",
	"LIB_UK_AT_Soldier"
];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_WWII_UK = [
	"LIB_UK_Officer",
	"LIB_UK_Engineer",
	"LIB_UK_Engineer",
	"LIB_UK_Engineer",
	"LIB_UK_Grenadier",
	"LIB_UK_Grenadier",
	"LIB_UK_Grenadier",
	"LIB_UK_Grenadier"
];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_WWII_UK = [
	"LIB_M2_60",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman",
	"LIB_UK_Rifleman"
];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_WWII_UK = [
	"LIB_UK_Willys_MB_M1919"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_WWII_UK = [
	"LIB_UK_M3_Halftrack"
];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
// other choices are commented
baseEnemyHeavyArmoredVehicleGroup_WWII_UK = [
	"LIB_Churchill_Mk7"
//	"LIB_Churchill_Mk7_AVRE"
//	"LIB_Churchill_Mk7_Howitzer"
//	"LIB_Churchill_Mk7_Crocodile"
//	"LIB_Cromwell_Mk4"
//	"LIB_M4A4_FIREFLY"
];


//Basic enemy aircraft avalaible
baseFixedWingGroup_WWII_UK = [
	"LIB_RAF_P39",
	"LIB_RAAF_P39",
	"LIB_C47_RAF"
];

////////////////////////
//Vehicle management////
////////////////////////
//WWII_UK
bluforUnarmedVehicle_WWII_UK = [
	"LIB_UK_Willys_MB",
	"LIB_UK_Willys_MB_Hood"
	// "LIB_UK_Willys_MB_Ambulance",
	
];

bluforArmedVehicle_WWII_UK = [
	"LIB_UK_Willys_MB_M1919",
	"LIB_UK_DR_M3_Halftrack"
//	"LIB_UK_M3_Halftrack"
];

bluforUnarmedVehicleChopper_WWII_UK = [
	// nein
];

bluforArmoredVehicle_WWII_UK = [
	"LIB_UniversalCarrier",
	"LIB_Churchill_Mk7", 
	"LIB_M4A4_FIREFLY", 
	"LIB_Cromwell_Mk4",
	"LIB_Churchill_Mk7_desert",
	"LIB_UK_DR_M4A3_75"
];

bluforDrone_WWII_UK = [
	// ...
];

bluforBoat_WWII_UK = [
	"LIB_UK_LCA",
	"LIB_UK_LCA"
];

bluforFixedWing_WWII_UK = [
	"LIB_RAF_P39",
	"LIB_C47_RAF",
	"LIB_HORSA_RAF",
	"LIB_MKI_HADRIAN",
	"LIB_MKI_HADRIAN_raf2",
	"LIB_MKI_HADRIAN_raf3"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_WWII_UK = [
	"LIB_UniversalCarrier", 
	"LIB_UK_Willys_MB_Hood"
];

////////////////////////
//Loadout management////
////////////////////////


//WWII_UK
loadout_WWII_UK = [		
	[c_leader, [["LIB_LeeEnfield_No4","","","",["LIB_10Rnd_770x56",10],[],""],[],["LIB_Webley_mk6","","","",["LIB_6Rnd_455",6],[],""],["U_LIB_UK_P37_Sergeant",[["ACE_MapTools",1],["ACE_EarPlugs",1],["LIB_6Rnd_455",3,6]]],["V_LIB_UK_P37_Rifleman_Blanco",[["ACE_EntrenchingTool",1],["LIB_6Rnd_455",4,6],["LIB_MillsBomb",2,1],["LIB_10Rnd_770x56",10,10]]],["B_LIB_UK_HSack",[["LIB_MillsBomb",4,1],["LIB_6Rnd_455",4,6],["LIB_10Rnd_770x56",8,10]]],"H_LIB_UK_Helmet_Mk3_Camo","",["LIB_Binocular_UK","","","",[],[],""],["ItemMap","","","ItemCompass","LIB_GER_ItemWatch",""]]],
	[c_at, [["LIB_LeeEnfield_No1","","","",["LIB_10Rnd_770x56",10],[],""],["LIB_PIAT","","","",["LIB_1Rnd_89m_PIAT",1],[],""],["LIB_Webley_mk6","","","",["LIB_6Rnd_455",6],[],""],["U_LIB_UK_P37",[["ACE_MapTools",1],["ACE_EarPlugs",2],["LIB_6Rnd_455",3,6]]],["V_LIB_UK_P37_Rifleman_Blanco",[["ACE_EntrenchingTool",1],["LIB_10Rnd_770x56",10,10],["LIB_6Rnd_455",4,6],["LIB_MillsBomb",1,1]]],["B_LIB_UK_HSack",[["LIB_1Rnd_89m_PIAT",2,1]]],"H_LIB_UK_Helmet_Mk3","",["LIB_Binocular_UK","","","",[],[],""],["ItemMap","","","ItemCompass","LIB_GER_ItemWatch",""]]],
	[c_rifleman, [["LIB_LeeEnfield_No4","","","",["LIB_10Rnd_770x56",10],[],""],[],["LIB_Webley_mk6","","","",["LIB_6Rnd_455",6],[],""],["U_LIB_UK_P37",[["ACE_MapTools",1],["ACE_EarPlugs",1],["LIB_6Rnd_455",3,6]]],["V_LIB_UK_P37_Rifleman_Blanco",[["ACE_EntrenchingTool",1],["LIB_6Rnd_455",4,6],["LIB_MillsBomb",2,1],["LIB_10Rnd_770x56",10,10]]],["B_LIB_UK_HSack",[["LIB_MillsBomb",4,1],["LIB_6Rnd_455",4,6],["LIB_10Rnd_770x56",8,10]]],"H_LIB_UK_Helmet_Mk3_Camo","",["LIB_Binocular_UK","","","",[],[],""],["ItemMap","","","ItemCompass","LIB_GER_ItemWatch",""]]],
	[c_engineer, [["LIB_DELISLE","","","",["LIB_7Rnd_45ACP_DeLisle",7],[],""],[],["LIB_Webley_mk6","","","",["LIB_6Rnd_455",6],[],""],["U_LIB_UK_P37_LanceCorporal",[["ACE_MapTools",1],["ACE_EarPlugs",2],["LIB_6Rnd_455",3,6]]],["V_LIB_UK_P37_Holster_Blanco",[["ACE_EntrenchingTool",1],["LIB_6Rnd_455",4,6],["LIB_MillsBomb",2,1],["LIB_7Rnd_45ACP_DeLisle",10,7]]],["B_LIB_UK_HSack_Blanco_Cape",[["MineDetector",1],["LIB_7Rnd_45ACP_DeLisle",10,7],["LIB_6Rnd_455",5,6],["LIB_Ladung_Small_MINE_mag",2,1]]],"H_LIB_UK_Helmet_Mk3_Camo","",["LIB_Binocular_UK","","","",[],[],""],["ItemMap","","","ItemCompass","LIB_GER_ItemWatch",""]]],
	[c_autorifleman, [["LIB_Bren_Mk2","","","",["LIB_30Rnd_770x56",30],[],""],[],["LIB_Webley_mk6","","","",["LIB_6Rnd_455",6],[],""],["U_LIB_UK_P37",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_6Rnd_455",3,6]]],["V_LIB_UK_P37_Heavy_Blanco",[["ACE_EntrenchingTool",1],["LIB_6Rnd_455",2,6],["LIB_MillsBomb",2,1],["LIB_30Rnd_770x56",5,30]]],["B_LIB_UK_HSack_Blanco_Tea",[["LIB_MillsBomb",4,1],["LIB_30Rnd_770x56",4,30]]],"H_LIB_UK_Helmet_Mk3_Net","",["LIB_Binocular_UK","","","",[],[],""],["ItemMap","","","ItemCompass","LIB_GER_ItemWatch",""]]],
	[c_marksman, [["LIB_LeeEnfield_No4_Scoped","","","",["LIB_10Rnd_770x56",10],[],""],[],["LIB_Webley_mk6","","","",["LIB_6Rnd_455",6],[],""],["U_LIB_UK_P37Jerkins",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_6Rnd_455",3,6]]],["V_LIB_UK_P37_Gasmask_Blanco",[["ACE_EntrenchingTool",1],["LIB_6Rnd_455",2,6],["LIB_MillsBomb",2,1],["LIB_10Rnd_770x56",11,10]]],["B_LIB_UK_HSack_Blanco",[["LIB_MillsBomb",4,1],["LIB_10Rnd_770x56",10,10]]],"H_LIB_UK_Helmet_Mk3_Camo","",["LIB_Binocular_UK","","","",[],[],""],["ItemMap","","","ItemCompass","LIB_GER_ItemWatch",""]]],
	[c_medic, [["LIB_LeeEnfield_No4","","","",["LIB_10Rnd_770x56",10],[],""],[],["LIB_Webley_mk6","","","",["LIB_6Rnd_455",6],[],""],["U_LIB_UK_P37",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_6Rnd_455",3,6],["LIB_10Rnd_770x56",2,10]]],["V_LIB_UK_P37_Rifleman_Blanco",[["LIB_10Rnd_770x56",10,10]]],["B_LIB_US_Backpack_RocketBag_Empty",[]],"H_LIB_UK_Helmet_Mk3_Camo","",["LIB_Binocular_UK","","","",[],[],""],["ItemMap","","","ItemCompass","LIB_GER_ItemWatch",""]]],
	[c_radioman,[["LIB_LeeEnfield_No4","","","",["LIB_10Rnd_770x56",10],[],""],[],["LIB_Webley_mk6","","","",["LIB_6Rnd_455",6],[],""],["U_LIB_UK_P37",[["ACE_MapTools",1],["ACE_EarPlugs",1],["LIB_6Rnd_455",3,6]]],["V_LIB_UK_P37_Rifleman_Blanco",[["ACE_EntrenchingTool",1],["LIB_6Rnd_455",4,6],["LIB_MillsBomb",2,1],["LIB_10Rnd_770x56",10,10]]],["B_LIB_US_Radio",[["LIB_MillsBomb",4,1],["LIB_6Rnd_455",4,6],["LIB_10Rnd_770x56",8,10]]],"H_LIB_UK_Helmet_Mk3_Camo","",["LIB_Binocular_UK","","","",[],[],""],["ItemMap","","","ItemCompass","LIB_GER_ItemWatch",""]]],
	[c_pilot,"LIB_UK_Tank_Crew"]
];

////////////////////////
///Weapon management////
////////////////////////
//WWII_UK
rifleList_WWII_UK = [		
	"LIB_DELISLE",
	"LIB_LeeEnfield_No1",
	"LIB_LeeEnfield_No4",
	"LIB_Webley_mk6"
];	

launcherList_WWII_UK = [		
	"LIB_PIAT"
];	

autorifleList_WWII_UK = [	
	"LIB_Bren_Mk2"
];	

marksmanrifleList_WWII_UK = [		
	"LIB_LeeEnfield_No4_Scoped"
];

smgList_WWII_UK = [
	"LIB_Sten_Mk2",
	"LIB_Sten_Mk5"
];


//////////////////////////
//Attachement management//
//////////////////////////

// Nothing more than bayonets i think.
attachmentShortList_WWII_UK	= [
	"lib_acc_gl_enfield_cup_empty",
	"lib_acc_p1903_bayo",
	"lib_acc_no4_mk2_bayo",
	"LIB_ACC_No4_Mk2_Bayo"
];

attachmentLongList_WWII_UK	= [
	// no optics, sorry...
];

////////////////////////
////Items management////
////////////////////////
itemList_WWII_UK = [
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

itemEngineerList_WWII_UK = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", 
	"ACE_Fortify"
];
	
itemMedicList_WWII_UK = [
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
backPackList_WWII_UK = [
	"B_LIB_UK_HSack",
	"B_LIB_UK_HSack_Blanco",
	"B_LIB_UK_HSack_Blanco_Cape",
	"B_LIB_UK_HSack_Cape",
	"B_LIB_UK_HSack_Blanco_Tea",
	"B_LIB_UK_HSack_Tea"
];

uniformList_WWII_UK = [
	"U_LIB_UK_DenisonSmock",
	"U_LIB_UK_P37Jerkins",
	"U_LIB_UK_P37Jerkins_Corporal",
	"U_LIB_UK_P37Jerkins_LanceCorporal",
	"U_LIB_UK_P37Jerkins_Sergeant",
	"U_LIB_UK_P37",
	"U_LIB_UK_P37_Corporal",
	"U_LIB_UK_P37_LanceCorporal",
	"U_LIB_UK_P37_Sergeant",
	"H_LIB_UK_Helmet_Mk2_FAK",
	"H_LIB_UK_Helmet_Mk2_FAK_Camo",
// Winter uniforms
	"U_LIB_UK_DenisonSmock_w",
	"U_LIB_UK_P37Jerkins_w",
	"U_LIB_UK_P37_w",
// Desert
	"H_LIB_UK_Helmet_Mk2_Desert",
	"H_LIB_UK_Helmet_Mk2_Desert_Bowed",
	"H_LIB_UK_Helmet_Mk2_Cover",
	"U_LIB_UK_KhakiDrills",
	"H_LIB_UK_Para_Beret"
];

magazineList_WWII_UK = [
	"LIB_30Rnd_770x56",
	"LIB_30Rnd_770x56_MKVIII",
	"LIB_7Rnd_45ACP",
	"LIB_7Rnd_45ACP_DeLisle",
	"LIB_30Rnd_45ACP",
	"LIB_30Rnd_45ACP_t",
	"LIB_50Rnd_45ACP",
	"LIB_10Rnd_770x56",
	"LIB_10Rnd_770x56_MkVIII",
	"LIB_1Rnd_89m_PIAT",
	"LIB_1Rnd_89m_G_PIAT",
	"LIB_32Rnd_9x19_Sten",
	"LIB_1Rnd_G_MillsBomb",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"LIB_6Rnd_455"
];