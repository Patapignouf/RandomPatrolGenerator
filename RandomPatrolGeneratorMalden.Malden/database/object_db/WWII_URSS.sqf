c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

//Add specific IFA3 factions
if (isClass (configFile >> "CfgPatches" >> "IFA3_Core")) then 
{
	factionInfos pushBack ["_WWII_URSS", 8,"WWII URSS [IFA3]", true, true, false];
};

//////////////////////////////
////Define civ group data/////
//////////////////////////////

// WWII_URSS
// Civs have a prefix in "LIB_CIV"
civilian_group_WWII_URSS = [
	"LIB_CIV_Citizen_1",
	"LIB_CIV_Villager_4",
	"LIB_CIV_Citizen_5"
];

civilian_big_group_WWII_URSS = [
	"LIB_CIV_Citizen_2",
	"LIB_CIV_Citizen_8",
	"LIB_CIV_Woodlander_1",
	"LIB_CIV_Worker_2",
	"LIB_CIV_Rocker",
	"LIB_CIV_Functionary_4",
	"LIB_CIV_Doctor"
];

civilianTruck_WWII_URSS = [
	// Nothing to see here, Kamarad. The trucks were all taken for our glorious army.
	"LIB_GazM1",
	"LIB_GazM1_dirty"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//WWII_URSS
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_WWII_URSS = [
	"LIB_SOV_lieutenant",
	"LIB_SOV_scout_sniper",
	"LIB_SOV_mgunner",
	"LIB_SOV_medic",
	"LIB_SOV_rifleman",
	"LIB_SOV_rifleman",
	"LIB_SOV_rifleman",
	"LIB_SOV_rifleman"
];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_WWII_URSS = [
	"LIB_SOV_lieutenant",
	"LIB_SOV_mgunner",
	"LIB_SOV_mgunner",
	"LIB_SOV_AT_soldier",
	"LIB_SOV_AT_soldier"
];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_WWII_URSS = [
	"LIB_SOV_lieutenant",
	"LIB_SOV_sapper",
	"LIB_SOV_sapper",
	"LIB_SOV_sapper",
	"LIB_SOV_grenadier",
	"LIB_SOV_grenadier",
	"LIB_SOV_grenadier",
	"LIB_SOV_grenadier"
];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_WWII_URSS = [
	"LIB_BM37",
	"LIB_SOV_operator",
	"LIB_SOV_rifleman",
	"LIB_SOV_rifleman",
	"LIB_SOV_rifleman",
	"LIB_SOV_rifleman",
	"LIB_SOV_rifleman",
	"LIB_SOV_rifleman"
];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_WWII_URSS = [
	"LIB_Zis5v"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_WWII_URSS = [
	"LIB_SOV_M3_Halftrack"
];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
// other choices are commented
baseEnemyHeavyArmoredVehicleGroup_WWII_URSS = [
	"LIB_T34_76"
//	"LIB_T34_85"
//	"LIB_JS2_43"
//	"LIB_M4A2_SOV"
//	"LIB_SU85"
];



//Basic enemy aircraft avalaible
baseFixedWingGroup_WWII_URSS = [
	"LIB_P39"
];

////////////////////////
//Vehicle management////
////////////////////////
//WWII_URSS
bluforUnarmedVehicle_WWII_URSS = [
	"LIB_GazM1_SOV",
	"LIB_GazM1_SOV_camo_sand",
	"LIB_US6_Tent",
	"LIB_US6_Tent_Cargo",
	"LIB_US6_Ammo",
	"LIB_US6_Open",
	"LIB_US6_Open_Cargo",
	"LIB_Willys_MB",
	"LIB_Willys_MB_w",
	"LIB_Willys_MB_Hood",
	"LIB_Willys_MB_Ambulance",
	"LIB_Zis5v",
	"LIB_Zis5v_w",
	"LIB_Zis5v_Med",
	"LIB_Zis5v_med_w",
	"LIB_Zis5v_Fuel",
	"LIB_Zis5v_fuel_w",
	"LIB_Zis6_Parm",
	"LIB_Zis6_parm_w"
];

bluforArmedVehicle_WWII_URSS = [
	"LIB_Zis5v_61K",
//	"LIB_SOV_M3_Halftrack",
//	"LIB_SOV_M3_Halftrack_w",
//	"LIB_SdKfz251_captured",
//	"LIB_SdKfz251_captured_FFV",
//	"LIB_SdKfz251_captured_w",
//	"LIB_SdKfz251_captured_FFV_w",
	"LIB_Scout_M3",
	"LIB_Scout_m3_w",
	"LIB_Scout_M3_FFV",
	"LIB_Scout_M3_FFV_w",
	"LIB_US6_BM13"
];

bluforUnarmedVehicleChopper_WWII_URSS = [
	// nyet
];

bluforArmoredVehicle_WWII_URSS = [
	"LIB_SOV_M3_Halftrack",
	"LIB_SOV_M3_Halftrack_w",
	"LIB_SdKfz251_captured",
	"LIB_SdKfz251_captured_FFV",
	"LIB_SdKfz251_captured_w",
	"LIB_SdKfz251_captured_FFV_w"
];

bluforDrone_WWII_URSS = [
	// nope
];

bluforBoat_WWII_URSS = [
	// nope
];

bluforFixedWing_WWII_URSS = [
	"LIB_Li2",
	"LIB_P39",
	"LIB_P39_w",
	"LIB_RA_P39_2",
	"LIB_RA_P39_3",
	"LIB_Pe2",
	"LIB_Pe2_w",
	"LIB_Pe2_2_w"
];


//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_WWII_URSS = [
	"LIB_US6_Tent_Cargo"
];

////////////////////////
//Loadout management////
////////////////////////

//WWII_URSS
loadout_WWII_URSS = [		
	[c_leader, [["LIB_SVT_40","","","",["LIB_10Rnd_762x54",10],[],""],[],["LIB_TT33","","","",["LIB_8Rnd_762x25",8],[],""],["U_LIB_SOV_Kapitan",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_762x25",4,8],["LIB_10Rnd_762x54",1,10]]],["V_LIB_SOV_RA_TankOfficerSet",[["LIB_ACC_M1891_Bayo",1],["LIB_8Rnd_762x25",2,8],["LIB_10Rnd_762x54",2,10]]],["B_LIB_SOV_RA_Rucksack_Green",[["ACE_EntrenchingTool",1],["LIB_8Rnd_762x25",2,8],["LIB_Rg42",2,1],["LIB_RDG",2,1],["LIB_10Rnd_762x54",8,10]]],"H_LIB_SOV_RA_OfficerCap","",["LIB_Binocular_SU","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],// SVT40 as it was supposed to be a better rifle
	[c_at, [["LIB_M38","","","",["LIB_5Rnd_762x54",5],[],""],["LIB_RPzB","","","",["LIB_1Rnd_RPzB",1],[],""],["LIB_TT33","","","",["LIB_8Rnd_762x25",8],[],""],["U_LIB_SOV_Strelokart",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_762x25",4,8],["LIB_5Rnd_762x54",4,5]]],["V_LIB_SOV_RA_MosinBelt",[["LIB_RDG",2,1],["LIB_5Rnd_762x54",4,5],["LIB_8Rnd_762x25",2,8]]],["B_LIB_SOV_RA_Rucksack2_Gas_Kit_Shinel_Green",[["LIB_1Rnd_RPzB",2,1],["LIB_5Rnd_762x54",4,5]]],"H_LIB_SOV_RA_Helmet","",["LIB_Binocular_SU","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]], // RPzB as there are no soviet launchers (but there are documented occurences of captured german weapons being used, so...)
	[c_rifleman, [["LIB_M9130","","","",["LIB_5Rnd_762x54",5],[],""],[],["LIB_TT33","","","",["LIB_8Rnd_762x25",8],[],""],["U_LIB_SOV_Efreitor",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_762x25",4,8],["LIB_5Rnd_762x54",2,5]]],["V_LIB_SOV_RA_MosinBelt",[["LIB_ACC_M1891_Bayo",1],["LIB_RDG",2,1],["LIB_8Rnd_762x25",2,8],["LIB_5Rnd_762x54",4,5]]],["B_LIB_SOV_RA_Rucksack_Green",[["ACE_EntrenchingTool",1],["LIB_8Rnd_762x25",2,8],["LIB_Rg42",2,1],["LIB_RDG",2,1],["LIB_5Rnd_762x54",10,5]]],"H_LIB_SOV_RA_Helmet","",["LIB_Binocular_SU","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],// Mosin 91-30
	[c_engineer, [["LIB_M38","","","",["LIB_5Rnd_762x54",5],[],""],[],["LIB_TT33","","","",["LIB_8Rnd_762x25",8],[],""],["U_LIB_SOV_Strelokart",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_762x25",4,8],["LIB_5Rnd_762x54",4,5]]],["V_LIB_SOV_RA_MGBelt",[["LIB_RDG",2,1],["LIB_8Rnd_762x25",2,8],["LIB_5Rnd_762x54",4,5]]],["B_LIB_SOV_RA_Rucksack2_Gas_Kit_Shinel_Green",[["ACE_EntrenchingTool",1],["LIB_Ladung_Small_MINE_mag",2,1],["LIB_Rg42",2,1],["LIB_5Rnd_762x54",4,5]]],"H_LIB_SOV_RA_Helmet","",["LIB_Binocular_SU","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],// Mosin 38, historically supplied to engineers, artillery and signal troops
	[c_autorifleman, [["LIB_DP28","","","",["LIB_47Rnd_762x54",47],[],""],[],["LIB_TT33","","","",["LIB_8Rnd_762x25",8],[],""],["U_LIB_SOV_Efreitor",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_762x25",4,8]]],["V_LIB_SOV_RA_MGBelt_Kit",[["LIB_RDG",2,1],["LIB_Rg42",2,1],["LIB_47Rnd_762x54",6,47]]],["B_LIB_SOV_RA_MGAmmoBag_Empty",[["ACE_EntrenchingTool",1],["LIB_8Rnd_762x25",2,8],["LIB_47Rnd_762x54",4,47]]],"H_LIB_SOV_RA_Helmet","",["LIB_Binocular_SU","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],// DP, as the DT was the vehicle-mounted version
	[c_marksman, [["LIB_M9130PU","","","",["LIB_5Rnd_762x54",5],[],""],[],["LIB_TT33","","","",["LIB_8Rnd_762x25",8],[],""],["U_LIB_SOV_Sniper_spring",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_762x25",4,8],["LIB_5Rnd_762x54_t46",2,5]]],["V_LIB_SOV_RA_MosinBelt",[["LIB_RDG",2,1],["LIB_8Rnd_762x25",2,8],["LIB_Rg42",1,1],["LIB_5Rnd_762x54_t46",4,5]]],["B_LIB_SOV_RA_Rucksack",[["ACE_EntrenchingTool",1],["LIB_8Rnd_762x25",2,8],["LIB_Rg42",2,1],["LIB_RDG",2,1],["LIB_5Rnd_762x54_t46",15,5]]],"H_LIB_SOV_Ushanka","",["LIB_Binocular_SU","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]],// Mosin 91-30 with optics
	[c_medic, [["LIB_M38","","","",["LIB_5Rnd_762x54",5],[],""],[],["LIB_TT33","","","",["LIB_8Rnd_762x25",8],[],""],["U_LIB_SOV_Efreitor",[["ACE_EarPlugs",2],["ACE_MapTools",1],["LIB_8Rnd_762x25",4,8],["LIB_5Rnd_762x54",6,5]]],["V_LIB_SOV_RA_OfficerVest",[]],["B_LIB_SOV_RA_MedicalBag_Empty",[]],"H_LIB_SOV_RA_Helmet","",["LIB_Binocular_SU","","","",[],[],""],["ItemMap","","","LIB_GER_ItemCompass_deg","LIB_GER_ItemWatch",""]]]// Mosin 38 ?
];

////////////////////////
///Weapon management////
////////////////////////
//WWII_URSS
rifleList_WWII_URSS = [		
	"LIB_SVT_40",
	"LIB_M38",
	"LIB_M44",
	"LIB_M9130",
	"LIB_PTRD" // anti-material rifle, should maybe be in another list ?
];	

launcherList_WWII_URSS = [		
	"LIB_RPzB"
];	

autorifleList_WWII_URSS = [	
	"LIB_DP28",
	"LIB_DT",
	"LIB_DT_OPTIC"
];	

marksmanrifleList_WWII_URSS = [		
	"LIB_M9130PU"
];

smgList_WWII_URSS = [	
	"LIB_PPSh41_m"
];


//////////////////////////
//Attachement management//
//////////////////////////

// Nothing more than bayonets i think.
attachmentShortList_WWII_URSS	= [
	"LIB_ACC_GL_DYAKONOV_Empty",
	"LIB_ACC_M1891_Bayo"
];

attachmentLongList_WWII_URSS	= [
	// no optics, sorry...
];

////////////////////////
////Items management////
////////////////////////
itemList_WWII_URSS = [
	"FirstAidKit",
	"ItemMap",
	"LIB_GER_ItemCompass",
	"LIB_GER_ItemCompass_deg",
	"ItemWatch",
	"LIB_GER_ItemWatch",
	"LIB_Binocular_SU",
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

itemEngineerList_WWII_URSS = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
];
	
itemMedicList_WWII_URSS = [
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
backPackList_WWII_URSS = [
	"B_LIB_SOV_RA_Rucksack",
	"B_LIB_SOV_RA_Rucksack_Green",
	"B_LIB_SOV_RA_Rucksack_Gas_Kit",
	"B_LIB_SOV_RA_Rucksack_Gas_Kit_Green",
	"B_LIB_SOV_RA_Rucksack2",
	"B_LIB_SOV_RA_Rucksack2_Green",
	"B_LIB_SOV_RA_Rucksack2_Gas_Kit",
	"B_LIB_SOV_RA_Rucksack2_Gas_Kit_Green",
	"B_LIB_SOV_RA_Rucksack2_Shinel",
	"B_LIB_SOV_RA_Rucksack2_Shinel_Green",
	"B_LIB_SOV_RA_Rucksack2_Gas_Kit_Shinel",
	"B_LIB_SOV_RA_Rucksack2_Gas_Kit_Shinel_Green",
	"B_LIB_SOV_RA_MGAmmoBag_Empty",
	"B_LIB_SOV_RA_GasBag",
	"B_LIB_SOV_RA_MedicalBag_Empty",
	"B_LIB_SOV_RA_Shinel",
	"B_LIB_SOV_RA_Radio",
	"B_LIB_SOV_RA_Paradrop",
	"B_LIB_SOV_Parachute"
];

uniformList_WWII_URSS = [
	"U_LIB_SOV_Tank_kapitan",
	// "U_LIB_SOV_Leutenant",
	"U_LIB_SOV_Starshina",
	"U_LIB_SOV_Stsergeant",
	"U_LIB_SOV_Artleutenant",
	"U_LIB_SOV_Strelokart",
	"U_LIB_SOV_Razvedchik_am",
	"U_LIB_SOV_Razvedchik_autumn",
	"U_LIB_SOV_Razvedchik_lis",
	"U_LIB_SOV_Razvedchik_mix",
	// "U_LIB_SOV_Leutenant_inset_pocket",
	// "U_LIB_SOV_Sergeant_inset_pocket",
	"U_LIB_SOV_Sniper_autumn",
	"U_LIB_SOV_Sniper_spring",
	"U_LIB_SOV_Sniper",
	"U_LIB_SOV_Efreitor",
	"U_LIB_SOV_Efreitor_summer",
	"U_LIB_SOV_Kapitan",
	"U_LIB_SOV_Kapitan_summer",
	"U_LIB_SOV_Strelok",
	"U_LIB_SOV_Strelok_summer",
	"U_LIB_SOV_Sergeant",
	"U_LIB_SOV_Tank_ryadovoi",
	"U_LIB_SOV_Tank_leutenant",
	"U_LIB_SOV_Tank_sergeant",
	"U_LIB_SOV_Tank_private_field",
	"U_LIB_SOV_Stleutenant",
	"U_LIB_SOV_Pilot",
// Winter uniforms start here
	"U_LIB_SOV_Strelok_2_w",
	"U_LIB_SOV_Strelok_w",
	"U_LIB_SOV_Sniper_w"
];

magazineList_WWII_URSS = [
	"LIB_5Rnd_762x54",
	"LIB_5Rnd_762x54_t46",
	"LIB_5Rnd_762x54_t30",
	"LIB_5Rnd_762x54_D",
	"LIB_5Rnd_762x54_b30",
	"LIB_10Rnd_762x54",
	"LIB_10Rnd_762x54_t46",
	"LIB_10Rnd_762x54_t462",
	"LIB_10Rnd_762x54_t30",
	"LIB_10Rnd_762x54_t302",
	"LIB_10Rnd_762x54_d",
	"LIB_10Rnd_762x54_b30",
	"LIB_35Rnd_762x25",
	"LIB_35Rnd_762x25_t",
	"LIB_35Rnd_762x25_t2",
	"LIB_35Rnd_762x25_ap",
	"LIB_71Rnd_762x25",
	"LIB_71Rnd_762x25_t",
	"LIB_71Rnd_762x25_t2",
	"LIB_71Rnd_762x25_ap",
	"LIB_47Rnd_762x54",
	"LIB_47Rnd_762x54d",
	"LIB_8Rnd_762x54",
	"LIB_7Rnd_762x38",
	"LIB_1Rnd_G_DYAKONOV",
	"LIB_1Rnd_145x114" // PTRD ammo
];