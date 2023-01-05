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
civilian_group_ColdWar_NVA = ["uns_civilian1", 
"uns_civilian4", 
"uns_civilian3", 
"uns_civilian2", 
"uns_civilian4_b1", 
"uns_civilian2_b2"];

civilian_big_group_ColdWar_NVA = ["uns_civilian1", 
"uns_civilian4", 
"uns_civilian3", 
"uns_civilian2", 
"uns_civilian4_b1", 
"uns_civilian2_b1", 
"uns_civilian1_b3", 
"uns_civilian4_b2", 
"uns_civilian3_b1", 
"uns_civilian2_b3"];

civilianTruck_ColdWar_NVA = ["CUP_C_Skoda_CR_CIV",
"CUP_C_LR_Transport_CTK", 
"CUP_C_UAZ_Open_TK_CIV"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//newFaction
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_ColdWar_NVA = ["uns_men_NVA_67_Roff", 
"uns_men_NVA_67_Ra1", 
"uns_men_NVA_67_RRTO", 
"uns_men_NVA_67_Rmed", 
"uns_men_NVA_67_Rmg", 
"uns_men_NVA_67_Rmrk", 
"uns_men_NVA_67_Ra2", 
"uns_men_NVA_67_RSAP"];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_ColdWar_NVA = ["uns_men_NVA_67_COM", 
"uns_men_NVA_67_nco", 
"uns_men_NVA_67_HMG", 
"uns_men_NVA_67_MRK", 
"uns_men_NVA_67_TRI", 
"uns_men_NVA_67_MTS", 
"uns_men_NVA_67_AA", 
"uns_men_NVA_67_AT",
"uns_men_NVA_67_AT",
"uns_men_NVA_67_AT"];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_ColdWar_NVA = ["uns_men_NVA_daccong_nco", 
"uns_men_NVA_daccong_SAP3", 
"uns_men_NVA_daccong_LMG", 
"uns_men_NVA_daccong_RTO", 
"uns_men_NVA_daccong_MED", 
"uns_men_NVA_daccong_AT3", 
"uns_men_NVA_daccong_MRK", 
"uns_men_NVA_daccong_SAP1"];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_ColdWar_NVA = ["uns_m1941_82mm_mortarVC",
"uns_men_NVA_daccong_RTO", 
"uns_men_NVA_daccong_MED"];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_ColdWar_NVA = ["uns_Type55", 
"uns_nvatruck", 
"uns_Type55_M40", 
"uns_Type55_MG"];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_ColdWar_NVA = ["uns_BTR152_DSHK"];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_ColdWar_NVA = ["uns_t34_76_vc"];

//Basic enemy chopper avalaible
baseChopperGroup_ColdWar_NVA = ["uns_Mi8T_VPAF"];

//Basic enemy aircraft avalaible
baseFixedWingGroup_ColdWar_NVA = ["uns_Mig21_BMB",
"uns_an2_transport",
"uns_an2_bmb"];

////////////////////////
//Vehicle management////
////////////////////////
//newFaction
bluforUnarmedVehicle_ColdWar_NVA = ["uns_Type55", 
"uns_nvatruck"];

bluforArmedVehicle_ColdWar_NVA = ["uns_Type55_MG"];

bluforUnarmedVehicleChopper_ColdWar_NVA = ["uns_Mi8T_VPAF"];

bluforArmoredVehicle_ColdWar_NVA = ["uns_BTR152_DSHK"];

bluforDrone_ColdWar_NVA = [];

bluforBoat_ColdWar_NVA = ["UNS_PATROL_BOAT_VC", 
"UNS_VC_sampan_cargo"];

bluforFixedWing_ColdWar_NVA = ["uns_Mig21_BMB", 
"uns_an2_transport", 
"uns_an2_bmb"];

////////////////////////
//Loadout management////
////////////////////////

//newFaction
loadout_ColdWar_NVA = [		
	[c_leader,"uns_men_NVA_67_COM"],
	[c_at,"uns_men_NVA_67_AT"],
	[c_rifleman,"uns_men_NVA_67_RF4"],//Default stuff
	[c_engineer,"uns_men_NVA_67_SAP"],
	[c_autorifleman,"uns_men_NVA_67_HMG"],
	[c_marksman,"uns_men_NVA_67_MRK"],
	[c_medic,"uns_men_NVA_67_MED"]
];


////////////////////////
///Weapon management////
////////////////////////
//newFaction
rifleList_ColdWar_NVA = [		
"uns_aks47",
"uns_akm",
"uns_sa58p",
"uns_sks"
];	

launcherList_ColdWar_NVA = [		
"uns_B40"
];	

autorifleList_ColdWar_NVA = [			
"uns_PK"
];	


marksmanrifleList_ColdWar_NVA = [		
"uns_svd",
"uns_mosin"
];

smgList_ColdWar_NVA = [		
"uns_PPS43",
"uns_pm63"];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_ColdWar_NVA	= [
"uns_b_6H3"
];

attachmentLongList_ColdWar_NVA	= [
"uns_o_PSO1",
"uns_o_PU"
];

////////////////////////
////Items management////
////////////////////////
itemList_ColdWar_NVA = [
	"FirstAidKit",
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

itemEngineerList_ColdWar_NVA = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
	];
	
itemMedicList_ColdWar_NVA = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
];

backPackList_ColdWar_NVA = [
"Uns_M1941_82mm_Mortar_NVA_Bag",
"uns_Tripod_Bag",
"uns_men_NVA_68_MRK_Bag",
"uns_men_NVA_68_RTO_Bag"
];

uniformList_ColdWar_NVA = [
"uns_U_Simc_nva_1"
];

magazineList_ColdWar_NVA = [

];