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

//newFaction
civilian_group_ColdWar_ARVN = ["uns_civilian1", 
"uns_civilian4", 
"uns_civilian3", 
"uns_civilian2", 
"uns_civilian4_b1", 
"uns_civilian2_b2"];

civilian_big_group_ColdWar_ARVN = ["uns_civilian1", 
"uns_civilian4", 
"uns_civilian3", 
"uns_civilian2", 
"uns_civilian4_b1", 
"uns_civilian2_b1", 
"uns_civilian1_b3", 
"uns_civilian4_b2", 
"uns_civilian3_b1", 
"uns_civilian2_b3"];

civilianTruck_ColdWar_ARVN = ["CUP_C_Skoda_CR_CIV",
"CUP_C_LR_Transport_CTK", 
"CUP_C_UAZ_Open_TK_CIV"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//newFaction
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_ColdWar_ARVN = ["uns_men_ARVN_COM", 
"uns_men_ARVN_RTO", 
"uns_men_ARVN_RF5", 
"uns_men_ARVN_HMG", 
"uns_men_ARVN_AHMG", 
"uns_men_ARVN_RF1", 
"uns_men_ARVN_GL", 
"uns_men_ARVN_AT", 
"uns_men_ARVN_MRK", 
"uns_men_ARVN_ENG"];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_ColdWar_ARVN = ["uns_men_ARVN_COM", 
"uns_men_ARVN_RTO", 
"uns_men_ARVN_AT", 
"uns_men_ARVN_AT",
"uns_men_ARVN_AT",
"uns_men_ARVN_MED", 
"uns_men_ARVN_TRI", 
"uns_men_ARVN_MTSG", 
"uns_men_ARVN_RF2"];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_ColdWar_ARVN = ["uns_men_ARVN_COM", 
"uns_men_ARVN_RTO", 
"uns_men_ARVN_AT", 
"uns_men_ARVN_MED", 
"uns_men_ARVN_TRI", 
"uns_men_ARVN_MTSG", 
"uns_men_ARVN_RF2", 
"uns_men_ARVN_MRK", 
"uns_men_ARVN_SCT"];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_ColdWar_ARVN = ["uns_m1941_82mm_mortarVC",
"uns_men_ARVN_RTO", 
"uns_men_ARVN_MED"];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_ColdWar_ARVN = ["uns_willys_2_arvn", 
"uns_willys_2_m1919_arvn", 
"uns_men_ARVN_RF2", 
"uns_willys_2_m60_arvn"];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_ColdWar_ARVN = ["uns_xm706"];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_ColdWar_ARVN = ["uns_xm706"];

//Basic enemy chopper avalaible
baseChopperGroup_ColdWar_ARVN = ["uns_UH1D_vnaf_m60"];

//Basic enemy aircraft avalaible
baseFixedWingGroup_ColdWar_ARVN = ["uns_A1H_CAS"];

////////////////////////
//Vehicle management////
////////////////////////
//newFaction
bluforUnarmedVehicle_ColdWar_ARVN = ["uns_willys_2_arvn"];

bluforArmedVehicle_ColdWar_ARVN = ["uns_willys_2_m1919_arvn", 
"uns_willys_2_m60_arvn"];

bluforUnarmedVehicleChopper_ColdWar_ARVN = ["uns_ch47_m60_arvn", 
"uns_UH1D_vnaf_m60", 
"uns_ch34_VNAF"];

//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_ColdWar_ARVN = ["UNS_AH1G","uns_ach47_m200"];

bluforArmoredVehicle_ColdWar_ARVN = ["uns_xm706"];

bluforDrone_ColdWar_ARVN = [];

bluforBoat_ColdWar_ARVN = [];

bluforFixedWing_ColdWar_ARVN = ["uns_A1H_CAS"];

////////////////////////
//Loadout management////
////////////////////////

//newFaction
loadout_ColdWar_ARVN = [		
	[c_leader,"uns_men_ARVN_COM"],
	[c_at,"uns_men_ARVN_AT"],
	[c_rifleman,"uns_men_ARVN_RF3"],//Default stuff
	[c_engineer,"uns_men_ARVN_ENG"],
	[c_autorifleman,"uns_men_ARVN_HMG"],
	[c_marksman,"uns_men_ARVN_MRK"],
	[c_medic,"uns_men_ARVN_MED"]
];


////////////////////////
///Weapon management////
////////////////////////
//newFaction
rifleList_ColdWar_ARVN = [		
"uns_m16"
];	

launcherList_ColdWar_ARVN = [		
"uns_m72",
"uns_m79"
];	

autorifleList_ColdWar_ARVN = [			
"uns_m60"
];	


marksmanrifleList_ColdWar_ARVN = [		
"uns_model70"
];

smgList_ColdWar_ARVN = [	
"uns_m1897",
"uns_38spec"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_ColdWar_ARVN	= [

];

attachmentLongList_ColdWar_ARVN	= [
"uns_o_Unertl8x_m70"
];

////////////////////////
////Items management////
////////////////////////
itemList_ColdWar_ARVN = [
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"Binocular",
	"Rangefinder",
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
	"ACE_RangeTable_82mm"
	];

itemEngineerList_ColdWar_ARVN = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"

	];
	
itemMedicList_ColdWar_ARVN = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
];

backPackList_ColdWar_ARVN = [
"Uns_M1941_82mm_Mortar_NVA_Bag",
"uns_Tripod_Bag",
"uns_men_ARVN_MED_Bag",
"UNS_Alice_F4"
];

uniformList_ColdWar_ARVN = [
"uns_u_simc_arvn_BDQ",
"UNS_M1_9A",
"UNS_M1_1V6"
];

magazineList_ColdWar_ARVN = [

];