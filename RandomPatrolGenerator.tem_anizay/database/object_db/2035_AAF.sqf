c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";

//////////////////////////////
////Define civ group data/////
//////////////////////////////


civilian_group_2035_AAF = ["C_Man_casual_9_F", 
"C_Man_casual_4_v2_F", 
"C_Man_casual_6_v2_F", 
"C_Man_casual_7_F", 
"C_Man_ConstructionWorker_01_Blue_F"];

civilian_big_group_2035_AAF = ["C_Man_casual_9_F", 
"C_Man_casual_4_v2_F", 
"C_Man_casual_6_v2_F", 
"C_Man_casual_7_F", 
"C_Man_ConstructionWorker_01_Blue_F", 
"C_man_w_worker_F", 
"C_Man_UtilityWorker_01_F", 
"C_man_polo_2_F" ];

civilianTruck_2035_AAF = ["C_Hatchback_01_sport_F", 
"C_Hatchback_01_F", 
"C_SUV_01_F", 
"C_Quadbike_01_F", 
"C_Van_01_box_F", 
"C_Van_01_fuel_F", 
"C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

baseEnemyGroup_2035_AAF = [
"I_soldier_F", 
"I_Soldier_AR_F", 
"I_Soldier_GL_F", 
"I_Soldier_M_F", 
"I_Soldier_LAT2_F", 
"I_soldier_F", 
"I_medic_F"];


baseEnemyATGroup_2035_AAF = [
"I_soldier_F", 
"I_Soldier_AT_F", 
"I_Soldier_LAT2_F"];

baseEnemyDemoGroup_2035_AAF = [
"I_soldier_F", 
"I_Soldier_AAT_F", 
"I_Soldier_GL_F", 
"I_soldier_mine_F"];

baseEnemyMortarGroup_2035_AAF = [
"I_Mortar_01_F",
"I_soldier_F", 
"I_Soldier_AR_F", 
"I_Soldier_GL_F"];

baseEnemyVehicleGroup_2035_AAF = [
"I_MRAP_03_F", 
"I_MRAP_03_hmg_F", 
"I_Truck_02_transport_F", 
"I_Truck_02_medical_F"];

baseEnemyLightArmoredVehicleGroup_2035_AAF = [
"I_LT_01_AT_F", 
"I_LT_01_scout_F", 
"I_LT_01_cannon_F"
 ];

baseEnemyHeavyArmoredVehicleGroup_2035_AAF = [
"I_MBT_03_cannon_F", 
"I_APC_Wheeled_03_cannon_F", 
"I_APC_tracked_03_cannon_F"];

////////////////////////
//Vehicle management////
////////////////////////
bluforUnarmedVehicle_2035_AAF = [
	"I_Truck_02_transport_F", 
	"I_Truck_02_covered_F", 
	"I_MRAP_03_F"
];

bluforArmedVehicle_2035_AAF = [
	"I_MRAP_03_hmg_F"
];

bluforUnarmedVehicleChopper_2035_AAF = [
	"I_Heli_Transport_02_F", 
	"I_Heli_light_03_unarmed_F"
];

bluforArmedChopper_2035_AAF = [
	"I_Heli_light_03_dynamicLoadout_F"
];


bluforDrone_2035_AAF = [
	"I_UAV_02_dynamicLoadout_F"
];

bluforBoat_2035_AAF = [
	
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_AAF = [
	"I_Plane_Fighter_03_dynamicLoadout_F", 
	"I_Plane_Fighter_04_F"
	];


////////////////////////
//Loadout management////
////////////////////////

listOfRoles_2035_AAF = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier];

loadout_2035_AAF = [		
	[c_leader,"I_Soldier_SL_F"],
	[c_at,"I_Soldier_AT_F"],
	[c_rifleman,"I_soldier_F"],//Default stuff
	[c_engineer,"I_engineer_F"],
	[c_autorifleman,"I_Soldier_AR_F"],
	[c_marksman,"I_Soldier_M_F"],
	[c_medic,"I_medic_F"],
	[c_grenadier,"I_Soldier_GL_F"]
];

////////////////////////
///Weapon management////
////////////////////////
rifleList_2035_AAF = [		
	"arifle_Mk20_F",
	"arifle_Mk20C_F"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_2035_AAF = [		
	"arifle_Mk20_GL_F"
];

launcherList_2035_AAF = [		
	"launch_I_Titan_short_F"
];	

autorifleList_2035_AAF = [			
	"LMG_Mk200_F"
];	


marksmanrifleList_2035_AAF = [		
	"srifle_EBR_F",
	"srifle_GM6_F"
];

smgList_2035_AAF = [		
	"hgun_ACPC2_F",
	"hgun_PDW2000_F"
];

           
//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_2035_AAF	= [
	"acc_pointer_IR",
	"optic_MRCO",
	"optic_ACO_grn"
];

attachmentLongList_2035_AAF	= [
	"optic_LRPS",
	"optic_tws"
];

////////////////////////
////Items management////
////////////////////////
itemList_2035_AAF = [
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"B_UavTerminal",
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

itemEngineerList_2035_AAF = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", 
	"ACE_Fortify"
	];
	
itemMedicList_2035_AAF = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
];


backPackList_2035_AAF = [
	"I_Fieldpack_oli_AT"
];

uniformList_2035_AAF = [
	"U_I_CombatUniform_shortsleeve"
];

magazineList_2035_AAF = [

];