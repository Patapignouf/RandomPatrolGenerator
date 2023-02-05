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

//WWII_Wehrmacht
// Civs have a prefix in "LIB_CIV"
civilian_group_WWII_Wehrmacht = [
	"LIB_CIV_Citizen_1",
	"LIB_CIV_Villager_4",
	"LIB_CIV_Citizen_5"
];

civilian_big_group_WWII_Wehrmacht = [
	"LIB_CIV_Citizen_2",
	"LIB_CIV_Citizen_8",
	"LIB_CIV_Woodlander_1",
	"LIB_CIV_Worker_2",
	"LIB_CIV_Rocker",
	"LIB_CIV_Functionary_4",
	"LIB_CIV_Doctor"
];

civilianTruck_WWII_Wehrmacht = [
//	"LIB_GazM1"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//WWII_Wehrmacht
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_WWII_Wehrmacht = [
	"LIB_GER_unterofficer",
	"LIB_GER_medic",
	"LIB_GER_mgunner",
	"LIB_GER_scout_sniper",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman"
];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_WWII_Wehrmacht = [
	"LIB_GER_unterofficer",
	"LIB_GER_mgunner",
	"LIB_GER_mgunner",
	"LIB_GER_AT_soldier",
	"LIB_GER_AT_soldier"
];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_WWII_Wehrmacht = [
	"LIB_GER_unterofficer",
	"LIB_GER_ober_grenadier",
	"LIB_GER_ober_grenadier",
	"LIB_GER_ober_grenadier",
	"LIB_GER_ober_grenadier",
	"LIB_GER_ober_grenadier",
	"LIB_GER_sapper",
	"LIB_GER_sapper"
];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_WWII_Wehrmacht = [
	"LIB_GrWr34",
	"LIB_GER_radioman",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman",
	"LIB_GER_rifleman"
];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_WWII_Wehrmacht = [
	"LIB_Kfz1_MG42"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_WWII_Wehrmacht = [
	"LIB_SdKfz251"
];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
// other choices are commented
baseEnemyHeavyArmoredVehicleGroup_WWII_Wehrmacht = [
	"LIB_PzKpfwIV_H"
//	"LIB_PzKpfwV"
//	"LIB_PzKpfwVI"
//	"LIB_SdKfz124"
//	"LIB_StuG_III_G"
];

//Basic enemy chopper avalaible
baseChopperGroup_WWII_Wehrmacht = [
	// lol
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_WWII_Wehrmacht = [
	"LIB_FW190F8"
];

////////////////////////
//Vehicle management////
////////////////////////
//WWII_Wehrmacht
bluforUnarmedVehicle_WWII_Wehrmacht = [
	"LIB_Kfz1",
	"LIB_Kfz1_camo",
	"LIB_Kfz1_Hood",
	"LIB_Kfz1_Hood_camo",
	"LIB_Kfz1_Hood_sernyt",
	"LIB_Kfz1_sernyt",
	"LIB_OpelBlitz_Ambulance",
	"LIB_OpelBlitz_Ammo",
	"LIB_OpelBlitz_Fuel",
	"LIB_OpelBlitz_Open_Y_Camo",
	"LIB_OpelBlitz_Parm",
	"LIB_OpelBlitz_Tent_Y_Camo"
];

bluforArmedVehicle_WWII_Wehrmacht = [
	"LIB_Kfz1_MG42",
	"LIB_Kfz1_MG42_camo",
	"LIB_Kfz1_MG42_sernyt"
//	"LIB_SdKfz251",
//	"LIB_SdKfz251_FFV",
//	"LIB_SdKfz_7",
//	"LIB_SdKfz_7_Ammo",
//	"LIB_SdKfz_7_AA",
];

bluforUnarmedVehicleChopper_WWII_Wehrmacht = [
	// nein
];

bluforArmoredVehicle_WWII_Wehrmacht = [
	"LIB_SdKfz251",
	"LIB_SdKfz251_FFV",
	"LIB_SdKfz_7",
	"LIB_SdKfz_7_Ammo",
	"LIB_SdKfz_7_AA"
];

bluforDrone_WWII_Wehrmacht = [
	// ...
];

bluforBoat_WWII_Wehrmacht = [
	// nope
];

bluforFixedWing_WWII_Wehrmacht = [
	"LIB_Ju87",
	"LIB_FW190F8",
	"LIB_FW190F8_2",
	"LIB_FW190F8_3",
	"LIB_FW190F8_4",
	"LIB_FW190F8_5"
];

////////////////////////
//Loadout management////
////////////////////////

//WWII_Wehrmacht
loadout_WWII_Wehrmacht = [		
	[c_leader, [["LIB_G43","","","",["LIB_10Rnd_792x57",10],[],""],[],["LIB_P38","","","",["LIB_8Rnd_9x19",8],[],""],["U_LIB_GER_Unterofficer",[["ACE_MapTools",1],["ACE_EarPlugs",2],["LIB_8Rnd_9x19",3,8],["LIB_10Rnd_792x57",1,10]]],["V_LIB_GER_VestG43",[["ACE_EntrenchingTool",1],["LIB_10Rnd_792x57",10,10],["LIB_8Rnd_9x19",4,8],["LIB_NB39",1,1]]],["B_LIB_GER_A_frame_zeltbahn",[["LIB_10Rnd_792x57",5,10],["LIB_M39",2,1]]],"H_LIB_GER_Helmet_net","",["LIB_Binocular_GER","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_at, [["LIB_K98","","","",["LIB_5Rnd_792x57",5],[],""],["LIB_RPzB","","","",["LIB_1Rnd_RPzB",1],[],""],["LIB_P38","","","",["LIB_8Rnd_9x19",8],[],""],["U_LIB_GER_Art_schutze",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_9x19",3,8],["LIB_5Rnd_792x57",2,5]]],["V_LIB_GER_VestKar98",[["ACE_EntrenchingTool",1],["LIB_M39",3,1],["LIB_NB39",2,1],["LIB_5Rnd_792x57",6,5]]],["B_LIB_GER_Tonister34_cowhide",[["LIB_M39",2,1],["LIB_NB39",1,1],["LIB_1Rnd_RPzB",1,1]]],"H_LIB_GER_Helmet","",["LIB_Binocular_GER","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_rifleman, [["LIB_K98","","","",["LIB_5Rnd_792x57",5],[],""],[],["LIB_P38","","","",["LIB_8Rnd_9x19",8],[],""],["U_LIB_GER_Recruit",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_9x19",3,8],["LIB_5Rnd_792x57",2,5]]],["V_LIB_GER_VestG43",[["ACE_EntrenchingTool",1],["LIB_8Rnd_9x19",4,8],["LIB_NB39",2,1],["LIB_5Rnd_792x57",10,5],["LIB_M39",1,1]]],["B_LIB_GER_A_frame_zeltbahn",[["LIB_M39",2,1],["LIB_5Rnd_792x57",10,5]]],"H_LIB_GER_Helmet","",["LIB_Binocular_GER","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_engineer, [["LIB_G3340","","","",["LIB_5Rnd_792x57",5],[],""],[],["LIB_P38","","","",["LIB_8Rnd_9x19",8],[],""],["U_LIB_GER_Recruit",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_9x19",3,8],["LIB_5Rnd_792x57",2,5],["LIB_Ladung_Small_MINE_mag",2,1]]],["V_LIB_GER_VestG43",[["ACE_EntrenchingTool",1],["LIB_8Rnd_9x19",4,8],["LIB_NB39",2,1],["LIB_M39",1,1],["LIB_5Rnd_792x57",10,5]]],["B_LIB_GER_SapperBackpack_empty",[["MineDetector",1],["ToolKit",1],["LIB_5Rnd_792x57",5,5]]],"H_LIB_GER_Helmet","",["LIB_Binocular_GER","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_autorifleman, [["LIB_MG42","","","",["LIB_50Rnd_792x57",50],[],""],[],["LIB_P38","","","",["LIB_8Rnd_9x19",8],[],""],["U_LIB_GER_Schutze",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_9x19",3,8]]],["V_LIB_GER_VestMG",[["ACE_EntrenchingTool",1],["LIB_50Rnd_792x57",3,50]]],["B_LIB_GER_SapperBackpack_empty",[["LIB_50Rnd_792x57",3,50],["LIB_M39",2,1],["LIB_NB39",2,1]]],"H_LIB_GER_Helmet","",["LIB_Binocular_GER","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_marksman, [["LIB_K98ZF39","","","",["LIB_5Rnd_792x57",5],[],""],[],["LIB_P38","","","",["LIB_8Rnd_9x19",8],[],""],["U_LIB_GER_Soldier3",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_9x19",3,8],["LIB_5Rnd_792x57_t",2,5]]],["V_LIB_GER_VestKar98",[["ACE_EntrenchingTool",1],["LIB_M39",2,1],["LIB_NB39",2,1],["LIB_5Rnd_792x57_t",10,5]]],["B_LIB_GER_A_frame",[["LIB_M39",2,1],["LIB_NB39",1,1],["LIB_5Rnd_792x57_t",2,5]]],"H_LIB_GER_Helmet","",["LIB_Binocular_GER","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],
	[c_medic, [["LIB_K98","","","",["LIB_5Rnd_792x57",5],[],""],[],["LIB_P38","","","",["LIB_8Rnd_9x19",8],[],""],["U_LIB_GER_Medic",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_9x19",2,8],["LIB_5Rnd_792x57",3,5]]],["V_LIB_GER_PioneerVest",[["LIB_5Rnd_792x57",8,5]]],["B_LIB_GER_MedicBackpack_Empty",[["LIB_M39",2,1],["LIB_5Rnd_792x57",4,5]]],"H_LIB_GER_FSJ_M44_Helmet_Medic","",["LIB_Binocular_GER","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]]
];

////////////////////////
///Weapon management////
////////////////////////
//WWII_Wehrmacht
rifleList_WWII_Wehrmacht = [		
	"LIB_K98",
	"LIB_K98_Late",
	"LIB_G3340",
	"LIB_G41",
	"LIB_G43"
];	

launcherList_WWII_Wehrmacht = [		
	"LIB_Faustpatrone",
	"LIB_PzFaust_30m",
	"LIB_PzFaust_60m",
	"LIB_RPzB",
	"LIB_RPzB_w",
	"LIB_M2_Flamethrower"
];	

autorifleList_WWII_Wehrmacht = [	
	"LIB_MG34",
	"LIB_MG42",
	"LIB_FG42G"
];	

marksmanrifleList_WWII_Wehrmacht = [		
	"LIB_K98ZF39"
];

smgList_WWII_Wehrmacht = [
	"LIB_MP38",
	"LIB_MP40",
	"LIB_MP44"
];


//////////////////////////
//Attachement management//
//////////////////////////

// Nothing more than bayonets i think.
attachmentShortList_WWII_Wehrmacht	= [
	"lib_optic_zf4",
	"lib_acc_k98_bayo",
	"lib_acc_gw_sb_empty"
];

attachmentLongList_WWII_Wehrmacht	= [
	// no optics, sorry...
];

////////////////////////
////Items management////
////////////////////////
itemList_WWII_Wehrmacht = [
	"FirstAidKit",
	"ItemMap",
	"LIB_GER_ItemCompass",
	"LIB_GER_ItemCompass_deg",
	"ItemWatch",
	"LIB_GER_ItemWatch",
	"LIB_Binocular_GER",
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

itemEngineerList_WWII_Wehrmacht = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
];
	
itemMedicList_WWII_Wehrmacht = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
];

// Those lists might not be correct...
backPackList_WWII_Wehrmacht = [
	"B_LIB_GER_A_frame_kit",
	"B_LIB_GER_A_frame_zeltbahn",
	"B_LIB_GER_A_frame",
	"B_LIB_DAK_A_frame",
	"B_LIB_DAK_A_frame_kit",
	"B_LIB_GER_SapperBackpack_empty",
	"B_LIB_GER_Backpack",
	"B_LIB_GER_Parachute",
	"B_LIB_GER_Radio",
	"B_LIB_GER_LW_Paradrop",
	"B_LIB_GER_Panzer_Empty",
	"B_LIB_GER_Tonister34_cowhide",
	"B_LIB_GER_MedicBackpack_Empty"
];

uniformList_WWII_Wehrmacht = [
	"U_LIB_GER_Funker",
	// "U_LIB_GER_DAK_Spg_crew_leutnant",
	// "U_LIB_GER_DAK_Spg_crew_private",
	// "U_LIB_GER_DAK_Spg_crew_unterofficer",
	"U_LIB_FSJ_Soldier_dak",
	"U_LIB_FSJ_Soldier",
	"U_LIB_FSJ_Soldier_dak_camo",
	"U_LIB_FSJ_Soldier_camo",
	"U_LIB_GER_LW_pilot",
	// "U_LIB_DAK_Lieutenant",
	"U_LIB_DAK_Shorts",
	"U_LIB_DAK_Shorts_2",
	"U_LIB_DAK_Shorts_3",
	"U_LIB_GER_Hauptmann",
	"U_LIB_GER_Leutnant",
	"U_LIB_GER_Oberleutnant",
	"U_LIB_GER_Oberst",
	"U_LIB_GER_Art_leutnant",
	"U_LIB_DAK_Sentry",
	"U_LIB_DAK_Sentry_2",
	"U_LIB_DAK_NCO",
	"U_LIB_DAK_NCO_2",
	"U_LIB_DAK_Soldier",
	"U_LIB_DAK_Soldier_2",
	"U_LIB_DAK_Soldier_3",
	"U_LIB_DAK_Medic",
	"U_LIB_GER_Pionier",
	"U_LIB_GER_Oberschutze",
	"U_LIB_GER_Recruit",
	"U_LIB_GER_Schutze",
	"U_LIB_GER_Unterofficer",
	"U_LIB_GER_Soldier3",
	"U_LIB_GER_Soldier2",
	"U_LIB_GER_Art_schutze",
	"U_LIB_GER_Art_unterofficer",
	"U_LIB_GER_Soldier_camo2",
	"U_LIB_GER_Scharfschutze",
	"U_LIB_GER_Soldier_camo",
	"U_LIB_GER_Soldier_camo4",
	"U_LIB_GER_Soldier_camo3",
	"U_LIB_GER_Soldier_camo5",
	"U_LIB_GER_Schutze_HBT",
	"U_LIB_GER_Unterofficer_HBT",
	"U_LIB_GER_MG_schutze_HBT",
	"U_LIB_GER_Gefreiter",
	"U_LIB_GER_MG_schutze",
	"U_LIB_GER_Medic",
	// "U_LIB_GER_Tank_crew_leutnant",
	// "U_LIB_GER_Tank_crew_private",
	// "U_LIB_GER_Tank_crew_unterofficer",
	// "U_LIB_GER_Spg_crew_leutnant",
	"U_LIB_GER_Spg_crew_private",
	"U_LIB_GER_Spg_crew_unterofficer",
// Winter uniforms
	"U_LIB_GER_Soldier3_w",
	"U_LIB_GER_Soldier_camo_w",
	"U_LIB_GER_Scharfschutze_w",
	"U_LIB_GER_Scharfschutze_2_w"
];

magazineList_WWII_Wehrmacht = [
	"LIB_30Rnd_792x33",
	"LIB_30Rnd_792x33_t",
	"LIB_32Rnd_9x19",
	"LIB_32rnd_9x19_t",
	"LIB_50Rnd_792x57",
	"LIB_50Rnd_792x57_SMK",
	"LIB_50Rnd_792x57_sS",
	"LIB_5Rnd_792x57",
	"LIB_5Rnd_792x57_t",
	"LIB_5Rnd_792x57_SMK",
	"LIB_5Rnd_792x57_sS",
	"LIB_10Rnd_792x57",
	"LIB_10Rnd_792x57_T2",
	"LIB_10Rnd_792x57_SMK",
	"LIB_10Rnd_792x57_sS",
	"LIB_10Rnd_792x57_T",
	"LIB_10Rnd_792x57_clip",
	"LIB_20Rnd_792x57",
	"LIB_1Rnd_G_PZGR_30",
	"LIB_1Rnd_G_PZGR_40",
	"LIB_1Rnd_G_SPZGR_30"
];