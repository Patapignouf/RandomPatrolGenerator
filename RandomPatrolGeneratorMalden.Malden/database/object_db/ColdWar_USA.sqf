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
civilian_group_USA_2000 = ["C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F"];

civilian_big_group_USA_2000 = ["C_Man_1_enoch_F", 
"C_Man_2_enoch_F", 
"C_Man_3_enoch_F", 
"C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F", 
"C_Farmer_01_enoch_F" ];

civilianTruck_USA_2000 = ["CUP_C_Octavia_CIV", 
"C_Offroad_01_comms_F", 
"C_Hatchback_01_sport_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//newFaction
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_ColdWar_USA = ["uns_men_USMC_65_PL", 
"uns_men_USMC_65_SL", 
"uns_men_USMC_65_MED", 
"uns_men_USMC_65_RTO", 
"uns_men_USMC_65_ENG", 
"uns_men_USMC_65_HMG", 
"uns_men_USMC_65_MRK", 
"uns_men_USMC_68_AT"];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_ColdWar_USA = ["uns_men_USMC_65_RF2", 
"uns_men_USMC_65_HMG", 
"uns_men_USMC_65_MED", 
"uns_men_USMC_65_RTO", 
"uns_men_USMC_65_TRI", 
"uns_men_USMC_65_MTSG", 
"uns_men_USMC_65_GL", 
"uns_men_USMC_65_RF4", 
"uns_men_USMC_65_MRK", 
"uns_men_USMC_65_AHMG", 
"uns_men_USMC_65_SCT", 
"uns_men_USMC_65_ENG"];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_ColdWar_USA = ["uns_men_ROK_BD68_COM", 
"uns_men_ROK_BD68_RTO", 
"uns_men_ROK_BD68_RF5", 
"uns_men_ROK_BD68_HMG", 
"uns_men_ROK_BD68_AHMG", 
"uns_men_ROK_BD68_RF1", 
"uns_men_ROK_BD68_GL", 
"uns_men_ROK_BD68_AT", 
"uns_men_ROK_BD68_MRK", 
"uns_men_ROK_BD68_ENG"];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_ColdWar_USA = ["uns_M1_81mm_mortar",
"uns_men_ROK_BD68_RF1", 
"uns_men_ROK_BD68_GL"];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_ColdWar_USA = ["uns_willysmg50", 
"uns_xm706e2"];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_ColdWar_USA = ["uns_xm706e1","uns_M113_30cal", 
"uns_m48a3"];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_ColdWar_USA = ["uns_m48a3"];

//Basic enemy chopper avalaible
baseChopperGroup_ColdWar_USA = ["UNS_AH1G", 
"uns_UH1H_m60"];

//Basic enemy aircraft avalaible
baseFixedWingGroup_ColdWar_USA = ["uns_F4B_AGM"];

////////////////////////
//Vehicle management////
////////////////////////
//newFaction
bluforUnarmedVehicle_ColdWar_USA = ["uns_willys_2", 
"uns_m37b1", 
"uns_M35A2", 
"uns_willys_2_usmc"];

bluforArmedVehicle_ColdWar_USA = ["uns_willysmg50", 
"uns_xm706e2"];

bluforUnarmedVehicleChopper_ColdWar_USA = ["uns_ch47_m60_usmc", 
"uns_ch53d_m2_usmc", 
"uns_UH1D_USMC_m60_light", 
"uns_H13_transport_Army", 
"uns_ch34_army", 
"uns_h21c"];

bluforArmoredVehicle_ColdWar_USA = ["uns_xm706e1","uns_M113_30cal", 
"uns_m48a3"];

bluforDrone_ColdWar_USA = [];

bluforBoat_ColdWar_USA = ["uns_PBR_M10", 
"UNS_Zodiac_W"];

bluforFixedWing_ColdWar_USA = ["uns_F4B_AGM"];

////////////////////////
//Loadout management////
////////////////////////

//newFaction
loadout_ColdWar_USA = [		
	[c_leader,"uns_men_USMC_68_PL"],
	[c_at,"uns_men_USMC_68_AT"],
	[c_rifleman,"uns_men_USMC_68_SL"],//Default stuff
	[c_engineer,"uns_men_USMC_68_ENG"],
	[c_autorifleman,"uns_men_USMC_68_HMG"],
	[c_marksman,"uns_men_USMC_68_MRK"],
	[c_medic,"uns_men_USMC_68_MED"]
];


////////////////////////
///Weapon management////
////////////////////////
//newFaction
rifleList_ColdWar_USA = [		
"uns_m16",
"uns_MX991_g",
"uns_m14",
"uns_m3a1"
];	

launcherList_ColdWar_USA = [		
"uns_m72",
"uns_m79"
];	

autorifleList_ColdWar_USA = [			
"uns_m60"
];	


marksmanrifleList_ColdWar_USA = [		
"uns_M21",
"uns_model70"
];

smgList_ColdWar_USA = [		
"uns_ithaca37"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_ColdWar_USA	= [

];

attachmentLongList_ColdWar_USA	= [
"uns_o_Unertl8x_m70",
"uns_o_LeatherwoodART_m14"
];

////////////////////////
////Items management////
////////////////////////
itemList_ColdWar_USA = [
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

itemEngineerList_ColdWar_USA = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
	];
	
itemMedicList_ColdWar_USA = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];

backPackList_ColdWar_USA = [
"uns_simc_MC_rajio_base"
	];

uniformList_ColdWar_USA = [
"UNS_USMC_BDU_65"
	];

magazineList_ColdWar_USA = [

	];