c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_pilot = "pilot";
c_radioman = "radioman";

//Add specific IFA3 factions
if (isClass (configFile >> "CfgPatches" >> "IFA3_Core")) then 
{
	factionInfos pushBack ["_WWII_USA", 9,"WWII USA [IFA3]", true, true, false];
};

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
	"LIB_US_Willys_MB_M1919",
	"LIB_M8_Greyhound"
];

bluforUnarmedVehicleChopper_WWII_USA = [
	// nein
];

bluforArmoredVehicle_WWII_USA = [
	"LIB_M3A3_Stuart", 
	"LIB_M5A1_Stuart",
	"LIB_M4A3_76", 
	"LIB_M4A3_75"
];

bluforDrone_WWII_USA = [
	// ...
];

bluforBoat_WWII_USA = [
	"LIB_LCA", 
	"LIB_LCM3_Armed", 
	"LIB_LCVP"
];

bluforFixedWing_WWII_USA = [
	"LIB_RAF_P39",
	"LIB_US_P39_2",
	"LIB_P47",
	"LIB_C47_RAF"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_WWII_USA = [
	"LIB_US_Scout_M3",
	"LIB_US_GMC_Open"
];

////////////////////////
//Loadout management////
////////////////////////

//WWII_USA
loadout_WWII_USA = [		
	[c_leader,[["LIB_M1928A1_Thompson","","","",["LIB_30Rnd_45ACP",30],[],""],[],["LIB_Colt_M1911","","","",["LIB_7Rnd_45ACP",7],[],""],["U_LIB_US_AB_Uniform_M43_NCO",[["ACE_Canteen",1],["LIB_US_M18",1,1]]],["V_LIB_US_Assault_Vest_Light",[["ACE_EntrenchingTool",1],["LIB_30Rnd_45ACP",8,30]]],["B_LIB_US_Backpack",[["LIB_7Rnd_45ACP",5,7],["LIB_30Rnd_45ACP",2,30],["LIB_US_Mk_2",2,1]]],"H_LIB_US_AB_Helmet_5","",["LIB_Binocular_US","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_at,[["LIB_M1_Garand_Bayonet","LIB_ACC_M1_Bayo","","",["LIB_8Rnd_762x63",8],[],""],["LIB_M1A1_Bazooka","","","",["LIB_1Rnd_60mm_M6",1],[],""],[],["U_LIB_US_AB_Uniform_M43_FC",[["ACE_Canteen",1],["LIB_US_M18",1,1]]],["V_LIB_US_Assault_Vest_Light",[["LIB_MillsBomb",2,1],["LIB_No82",2,1],["LIB_8Rnd_762x63",10,8]]],["B_LIB_US_RocketBag_Empty",[["LIB_1Rnd_60mm_M6",3,1]]],"H_LIB_US_AB_Helmet_5","",["LIB_Binocular_US","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_rifleman,[["LIB_M1_Garand_M7","LIB_ACC_GL_M7","","",["LIB_8Rnd_762x63",8],["LIB_1Rnd_G_Mk2",1],""],[],[],["U_LIB_US_AB_Uniform_M43_FC",[["ACE_Canteen",1],["ACE_EntrenchingTool",1]]],["V_LIB_US_Assault_Vest_Light",[["LIB_ACC_M1_Bayo",1],["LIB_US_M18_Green",2,1],["LIB_US_Mk_2",2,1],["LIB_1Rnd_G_M9A1",3,1],["LIB_1Rnd_G_Mk2",2,1],["LIB_8Rnd_762x63",10,8]]],["B_LIB_US_Backpack_Mk2",[["LIB_1Rnd_G_M9A1",2,1],["LIB_1Rnd_G_Mk2",2,1],["LIB_8Rnd_762x63",20,8]]],"H_LIB_US_AB_Helmet_5","",[],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],//Default stuff
	[c_engineer,[["LIB_M1_Garand_Bayonet","LIB_ACC_M1_Bayo","","",["LIB_8Rnd_762x63",8],[],""],[],[],["U_LIB_US_AB_Uniform_M43_FC",[["ACE_Canteen",1],["LIB_US_M18",1,1]]],["V_LIB_US_Assault_Vest_Light",[["MineDetector",1],["ACE_EntrenchingTool",1],["ACE_Clacker",1],["LIB_MillsBomb",2,1],["DemoCharge_Remote_Mag",2,1],["LIB_8Rnd_762x63",10,8]]],["B_LIB_US_Backpack",[["ToolKit",1]]],"H_LIB_US_AB_Helmet_5","",["LIB_Binocular_US","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_autorifleman,[["LIB_M1918A2_BAR","","","",["LIB_20Rnd_762x63_M1",20],[],"LIB_M1918A2_BAR_Bipod"],[],[],["U_LIB_US_AB_Uniform_M43_FC",[["ACE_Canteen",1],["LIB_US_M18",1,1]]],["V_LIB_US_Assault_Vest_Light",[["LIB_MillsBomb",2,1],["LIB_20Rnd_762x63_M1",10,20]]],["B_LIB_US_Backpack",[["ACE_EntrenchingTool",1]]],"H_LIB_US_AB_Helmet_5","",["LIB_Binocular_US","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_marksman,[["LIB_M1903A4_Springfield","","","",["LIB_5Rnd_762x63",5],[],""],[],[],["U_LIB_US_AB_Uniform_M43_FC",[["ACE_Canteen",1]]],["V_LIB_US_Assault_Vest_Light",[["ACE_EntrenchingTool",1],["LIB_MillsBomb",2,1],["LIB_5Rnd_762x63",20,5],["LIB_US_M18_Green",2,1]]],["B_LIB_US_Backpack",[]],"H_LIB_US_AB_Helmet_5","",["LIB_Binocular_US","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_radioman,[["LIB_M1_Garand","","","",["LIB_8Rnd_762x63",8],[],""],[],[],["U_LIB_US_Private",[["LIB_ACC_M1_Bayo",1],["ACE_EarPlugs",1],["ACE_fieldDressing",1],["ACE_packingBandage",1],["ACE_morphine",1],["ACE_tourniquet",1],["LIB_8Rnd_762x63",5,8]]],["V_LIB_US_Vest_Garand",[["LIB_8Rnd_762x63",2,8],["LIB_US_Mk_2",2,1]]],["B_LIB_US_Radio",[]],"H_LIB_US_Helmet_Net_ns","",[],["ItemMap","","","ItemCompass","",""]]],
	[c_medic,[["LIB_M1_Garand_Bayonet","LIB_ACC_M1_Bayo","","",["LIB_8Rnd_762x63",8],[],""],[],[],["U_LIB_US_AB_Uniform_M43_Medic",[["ACE_Canteen",1]]],["V_LIB_US_Assault_Vest_Light",[["LIB_US_M18_Green",2,1],["LIB_US_Mk_2",2,1],["LIB_8Rnd_762x63",10,8]]],["B_LIB_US_Backpack",[["ACE_EntrenchingTool",1]]],"H_LIB_US_AB_Helmet_Medic_1","",[],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_pilot, "LIB_US_Pilot"]
];


////////////////////////
///Weapon management////
////////////////////////
//WWII_USA
rifleList_WWII_USA = [		
	"LIB_M1_Carbine",
	"LIB_M1_Garand",
	"LIB_M1903A3_Springfield",
	"LIB_M1903A4_Springfield",
	"LIB_Colt_M1911",
	"LIB_M3_GreaseGun"
];	

launcherList_WWII_USA = [		
	"LIB_M1A1_Bazooka"
];	

autorifleList_WWII_USA = [	
	"LIB_M1918A2_BAR",
	"LIB_M1919A4",
	"LIB_M1919A6"
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
	"lib_acc_no4_mk2_bayo",
	"LIB_ACC_M1_Bayo",
	"LIB_ACC_GL_M7"
];

attachmentLongList_WWII_USA	= [
	// no optics, sorry...
];

////////////////////////
////Items management////
////////////////////////
itemList_WWII_USA = [
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

itemEngineerList_WWII_USA = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
];
	
itemMedicList_WWII_USA = [
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
backPackList_WWII_USA = [
	"B_LIB_UK_HSack",
	"B_LIB_UK_HSack_Blanco",
	"B_LIB_UK_HSack_Blanco_Cape",
	"B_LIB_UK_HSack_Cape",
	"B_LIB_UK_HSack_Blanco_Tea",
	"B_LIB_UK_HSack_Tea"
];

uniformList_WWII_USA = [
	"U_LIB_US_Corp",
	"U_LIB_US_Private_1st",
	"U_LIB_US_Private",
	"U_LIB_US_Sergeant",
	"U_LIB_US_Eng",
	"U_LIB_US_Med",
// Rangers
	"U_LIB_US_Rangers_Uniform",
	"U_LIB_US_Rangers_Corp",
	"U_LIB_US_Rangers_Private_1st",
	"U_LIB_US_Rangers_Sergeant",
	"U_LIB_US_Rangers_Eng",
	"U_LIB_US_Rangers_Med",
// North Arfican Corps
	"U_LIB_US_NAC_Uniform",
	"U_LIB_US_NAC_Uniform_2",
	"U_LIB_US_NAC_Med",
// Airborne
	"U_LIB_US_AB_Uniform_M42",
	"U_LIB_US_AB_Uniform_M42_506",
	"U_LIB_US_AB_Uniform_M42_corporal",
	"U_LIB_US_AB_Uniform_M42_FC",
	"U_LIB_US_AB_Uniform_M42_Gas",
	"U_LIB_US_AB_Uniform_M42_Medic",
	"U_LIB_US_AB_Uniform_M42_NCO",
	"U_LIB_US_AB_Uniform_M43",
	"U_LIB_US_AB_Uniform_M43_corporal",
	"U_LIB_US_AB_Uniform_M43_FC",
	"U_LIB_US_AB_Uniform_M43_Flag",
	"U_LIB_US_AB_Uniform_M43_Medic",
	"U_LIB_US_AB_Uniform_M43_NCO",
// Pilots
	"U_LIB_US_Bomber_Crew",
	"U_LIB_US_Bomber_Pilot",
	"U_LIB_US_Pilot",
	"U_LIB_US_Pilot_2",
// Tank crews
	"U_LIB_US_Tank_Crew",
	"U_LIB_US_Tank_Crew2",
// Winter uniforms
	"U_LIB_US_Private_w",
	"U_LIB_US_AB_Uniform_M42_w",
	"U_LIB_US_AB_Uniform_M43_w"
];

magazineList_WWII_USA = [
	"LIB_30Rnd_770x56",
	"LIB_30Rnd_770x56_MKVIII",
	"LIB_7Rnd_45ACP",
	"LIB_7Rnd_45ACP_DeLisle",
	"LIB_30Rnd_45ACP",
	"LIB_30Rnd_45ACP_t",
	"LIB_10Rnd_770x56",
	"LIB_10Rnd_770x56_MkVIII",
	"LIB_1Rnd_89m_PIAT",
	"LIB_1Rnd_89m_G_PIAT",
	"LIB_32Rnd_9x19_Sten",
	"LIB_1Rnd_G_MillsBomb",
	"LIB_50Rnd_762x63",
	"LIB_50Rnd_762x63_M1",
	"LIB_5Rnd_762x63",
	"LIB_5Rnd_762x63_M1",
	"LIB_5Rnd_762x63_t",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"LIB_7Rnd_45ACP",
	"LIB_30Rnd_M3_GreaseGun_45ACP"
];