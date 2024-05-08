c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

factionInfos pushBack ["_Syndikat", 2,"2035 Syndikat", true, true, true];

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Syndikat
civilian_group_Syndikat = [
	"C_Man_casual_8_F_tanoan", 
	"C_Man_casual_6_v2_F_tanoan", 
	"C_Man_casual_2_F_tanoan"
];

civilian_big_group_Syndikat = [
	"C_man_sport_2_F_tanoan", 
	"C_Man_casual_1_F_tanoan", 
	"C_Man_casual_3_F_tanoan", 
	"C_Man_casual_6_v2_F_tanoan", 
	"C_Man_formal_4_F_tanoan", 
	"C_Man_casual_5_F_tanoan" 
];

civilianTruck_Syndikat = [
	"C_Truck_02_transport_F",
	"C_Offroad_01_F",
	"C_Quadbike_01_F",
	"C_Van_01_transport_F"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//Syndikat
baseEnemyGroup_Syndikat = [
	"I_C_Soldier_Bandit_4_F", 
	"I_C_Soldier_Bandit_3_F", 
	"I_C_Soldier_Bandit_7_F", 
	"I_C_Soldier_Bandit_5_F", 
	"I_C_Soldier_Bandit_2_F", 
	"I_C_Soldier_Bandit_1_F", 
	"I_C_Soldier_Bandit_1_F"
];

baseEnemyATGroup_Syndikat = [
	"I_C_Soldier_Bandit_6_F", 
	"I_C_Soldier_Bandit_2_F", 
	"I_C_Soldier_Bandit_2_F",
	"I_C_Soldier_Bandit_7_F", 
	"I_C_Soldier_Bandit_1_F"
];

baseEnemyDemoGroup_Syndikat = [
	"I_C_Soldier_Bandit_2_F", 
	"I_C_Soldier_Bandit_1_F",
	"I_C_Soldier_Bandit_8_F", 
	"I_C_Soldier_Bandit_6_F"
];

baseEnemyMortarGroup_Syndikat = [

];

baseEnemyVehicleGroup_Syndikat = [
	"I_C_Offroad_02_LMG_F", 
	"I_C_Offroad_02_AT_F", 
	"CUP_I_M151_M2_SYND", 
	"I_C_Offroad_02_unarmed_F"
];

baseEnemyLightArmoredVehicleGroup_Syndikat = [
	"CUP_I_Hilux_zu23_IND_G_F", 
	"CUP_I_Hilux_armored_DSHKM_IND_G_F"
];

baseEnemyUnarmedChopperGroup_Syndikat = [
	"I_C_Heli_Light_01_civil_F"
];

baseEnemyHeavyArmoredVehicleGroup_Syndikat = [
	"CUP_I_MTLB_pk_SYNDIKAT"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_Syndikat = [
	"I_C_Plane_Civil_01_F"
];

	

////////////////////////
//Vehicle management////
////////////////////////
//Syndikat
bluforUnarmedVehicle_Syndikat = [
	
];

bluforArmedVehicle_Syndikat = [
	
];

bluforUnarmedVehicleChopper_Syndikat = [
	
];


bluforDrone_Syndikat = [
	
];

bluforBoat_Syndikat = [
	
];

////////////////////////
//Loadout management////
////////////////////////

//Syndikat
loadout_Syndikat = [		
	[c_leader,"I_C_Soldier_Bandit_4_F"],
	[c_at,"I_C_Soldier_Bandit_2_F"],
	[c_rifleman,"I_C_Soldier_Bandit_5_F"],//Default stuff
	[c_engineer,"I_C_Soldier_Para_8_F"],
	[c_autorifleman,"I_C_Soldier_Bandit_3_F"],
	[c_marksman,"I_G_Sharpshooter_F"],
	[c_medic,"I_C_Soldier_Bandit_1_F"]
];

//Stuff sample

////////////////////////
///Weapon management////
////////////////////////
//Syndikat
rifleList_Syndikat = [		
	"arifle_AKS_F",
	"arifle_AKM_F"
];	

launcherList_Syndikat = [		
	"launch_RPG7_F"
];	

autorifleList_Syndikat = [			
	"LMG_03_F"
];	


marksmanrifleList_Syndikat = [		
	"srifle_DMR_06_camo_F"
];

smgList_Syndikat = [		
	
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_Syndikat	= [
	
];

attachmentLongList_Syndikat	= [
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_11_4x20_PM_pip",
	"CUP_optic_SB_3_12x50_PMII",
	"CUP_optic_SB_3_12x50_PMII_PIP",
	"CUP_optic_LeupoldMk4",
	"CUP_optic_CWS",
	"CUP_optic_CWS_NV",
	"CUP_optic_CWS_NV_RDS"
];

////////////////////////
////Items management////
////////////////////////
itemList_Syndikat = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"Binocular",
	"Rangefinder",
	"ACE_MapTools",
	"ACE_microDAGR",
	"ACE_CableTie",
	"ACE_DAGR",
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
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item"
	];

itemEngineerList_Syndikat = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
	];
	
itemMedicList_Syndikat = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
	];