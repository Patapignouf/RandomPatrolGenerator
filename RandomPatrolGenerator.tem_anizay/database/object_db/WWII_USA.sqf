c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//WWII_USA
// Civs have a prefix in "LIB_CIV"
civilian_group_WWII_USA = [
	"LIB_CIV_Citizen_1",
	"LIB_CIV_Villager_4",
	"LIB_CIV_Citizen_5"
];

civilian_big_group_WWII_USA = [
	"LIB_CIV_Citizen_2",
	"LIB_CIV_Citizen_8",
	"LIB_CIV_Woodlander_1",
	"LIB_CIV_Worker_2",
	"LIB_CIV_Rocker",
	"LIB_CIV_Functionary_4",
	"LIB_CIV_Doctor"
];

civilianTruck_WWII_USA = [
	"LIB_GazM1", 
	"LIB_GazM1_dirty"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//WWII_USA
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_WWII_USA = [
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
baseEnemyATGroup_WWII_USA = [
	"LIB_UK_Officer",
	"LIB_UK_LanceCorporal",
	"LIB_UK_LanceCorporal",
	"LIB_UK_AT_Soldier",
	"LIB_UK_AT_Soldier"
];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_WWII_USA = [
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
baseEnemyMortarGroup_WWII_USA = [
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
baseEnemyVehicleGroup_WWII_USA = [
	"LIB_UK_Willys_MB_M1919"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_WWII_USA = [
	"LIB_UK_M3_Halftrack"
];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
// other choices are commented
baseEnemyHeavyArmoredVehicleGroup_WWII_USA = [
	"LIB_Churchill_Mk7"
//	"LIB_Churchill_Mk7_AVRE"
//	"LIB_Churchill_Mk7_Howitzer"
//	"LIB_Churchill_Mk7_Crocodile"
//	"LIB_Cromwell_Mk4"
//	"LIB_M4A4_FIREFLY"
];

//Basic enemy chopper avalaible
baseChopperGroup_WWII_USA = [
	// lol
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_WWII_USA = [
	"LIB_RAF_P39"
];

////////////////////////
//Vehicle management////
////////////////////////
//WWII_USA
bluforUnarmedVehicle_WWII_USA = [
	"LIB_US_GMC_Tent", 
	"LIB_US_GMC_Open", 
	"LIB_US_Willys_MB_Hood", 
	"LIB_US_Willys_MB"
];

bluforArmedVehicle_WWII_USA = [
	"LIB_US_Scout_M3", 
	"LIB_US_Willys_MB_M1919"
];

bluforUnarmedVehicleChopper_WWII_USA = [
	// nein
];

bluforArmoredVehicle_WWII_USA = [
	"LIB_M8_Greyhound", 
	"LIB_M3A3_Stuart", 
	"LIB_M4A3_76", 
	"LIB_M4A3_75"
];

bluforDrone_WWII_USA = [
	// ...
];

bluforBoat_WWII_USA = [
	// nope
];

bluforFixedWing_WWII_USA = [
	"LIB_RAF_P39",
	"LIB_HORSA_RAF",
	"LIB_C47_RAF",
	"LIB_MKI_HADRIAN",
	"LIB_MKI_HADRIAN_raf2",
	"LIB_MKI_HADRIAN_raf3"
];

////////////////////////
//Loadout management////
////////////////////////

//WWII_USA
loadout_WWII_USA = [		
	[c_leader,"LIB_US_Corporal"],
	[c_at,"LIB_US_Rangers_AT_soldier"],
	[c_rifleman,"LIB_US_FC_Rifleman"],//Default stuff
	[c_engineer,"LIB_US_Engineer"],
	[c_autorifleman,"LIB_US_MGunner"],
	[c_marksman,"LIB_US_Sniper"],
	[c_medic,"LIB_US_Medic"]
];


////////////////////////
///Weapon management////
////////////////////////
//WWII_USA
rifleList_WWII_USA = [		
	"LIB_M1_Carbine",
	"LIB_M1_Garand_M7"

];	

launcherList_WWII_USA = [		
	"LIB_M1A1_Bazooka"
];	

autorifleList_WWII_USA = [	
	"LIB_M1918A2_BAR"
];	

marksmanrifleList_WWII_USA = [		
	"LIB_M1903A4_Springfield"
];

smgList_WWII_USA = [
	"LIB_M1A1_Thompson",
	"LIB_M1928_Thompson"
];


//////////////////////////
//Attachement management//
//////////////////////////

// Nothing more than bayonets i think.
attachmentShortList_WWII_USA	= [
	"lib_acc_gl_enfield_cup_empty",
	"lib_acc_p1903_bayo",
	"lib_acc_no4_mk2_bayo"
];

attachmentLongList_WWII_USA	= [
	// no optics, sorry...
];

////////////////////////
////Items management////
////////////////////////
itemList_WWII_USA = [
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

itemEngineerList_WWII_USA = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter"
];
	
itemMedicList_WWII_USA = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
];

// Those lists might not be correct...
backPackList_WWII_USA = [
	"B_LIB_UK_HSack",
	"B_LIB_UK_HSack_Blanco",
	"B_LIB_UK_HSack_Blanco_Cape",
	"B_LIB_UK_HSack_Cape",
	"B_LIB_UK_HSack_Blanco_Tea",
	"B_LIB_UK_HSack_Tea"
];

uniformList_WWII_USA = [
	"U_LIB_UK_KhakiDrills",
	"U_LIB_UK_DenisonSmock",
	"U_LIB_UK_P37Jerkins",
	"U_LIB_UK_P37Jerkins_Corporal",
	"U_LIB_UK_P37Jerkins_LanceCorporal",
	"U_LIB_UK_P37Jerkins_Sergeant",
	"U_LIB_UK_P37",
	"U_LIB_UK_P37_Corporal",
	"U_LIB_UK_P37_LanceCorporal",
	"U_LIB_UK_P37_Sergeant"
];

magazineList_WWII_USA = [
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
	"LIB_1Rnd_G_MillsBomb"
];