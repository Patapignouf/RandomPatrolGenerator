c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_grenadier = "grenadier";
c_pilot = "pilot";

///////////////////////////
/////Civilian Management///
///////////////////////////

//Taki
civilian_group_Taki_Army = ["CUP_C_TK_Man_06_Coat", 
"CUP_C_TK_Man_05_Coat", 
"CUP_C_TK_Man_08"];

civilian_big_group_Taki_Army = ["CUP_C_TK_Man_06_Coat", 
"CUP_C_TK_Man_05_Coat", 
"CUP_C_TK_Man_08", 
"CUP_C_TK_Man_04", 
"CUP_C_TK_Man_03_Jack", 
"CUP_C_TK_Man_02"
];

civilianTruck_Taki_Army = [
	"CUP_C_Lada_TK_CIV", 
	"CUP_C_V3S_Open_TKC", 
	"CUP_C_LR_Transport_CTK", 
	"CUP_C_S1203_CIV", 
	"CUP_C_Volha_Limo_TKCIV", 
	"CUP_C_Ural_Civ_01"
];



//////////////////////////////
///Define enemy group data////
//////////////////////////////
//Taki
baseEnemyGroup_Taki_Army = [
	"CUP_O_TK_Soldier_SL", 
	"CUP_O_TK_Soldier_MG", 
	"CUP_O_TK_Soldier_MG",
	"CUP_O_TK_Soldier_AT", 
	"CUP_O_TK_Soldier_GL", 
	"CUP_O_TK_Soldier_GL",
	"CUP_O_TK_Soldier_LAT", 
	"CUP_O_TK_Soldier_AAT", 
	"CUP_O_TK_Soldier_AMG"
];

baseEnemyATGroup_Taki_Army = [
	"CUP_O_TK_Soldier_HAT", 
	"CUP_O_TK_Soldier_AT", 
	"CUP_O_TK_Soldier_AAT",
	"CUP_O_TK_Soldier_AA"
];

baseEnemyDemoGroup_Taki_Army = [
	"CUP_O_TK_Sniper_KSVK", 
	"CUP_O_TK_Spotter",
	"CUP_O_TK_Soldier_MG", 
	"CUP_O_TK_Soldier_GL"
];

baseEnemyMortarGroup_Taki_Army = [
	"CUP_O_2b14_82mm_TK", 
	"CUP_O_TK_SpecOps", 
	"CUP_O_TK_SpecOps_TL", 
	"CUP_O_TK_SpecOps_MG"
];

baseEnemyVehicleGroup_Taki_Army = [
	"CUP_O_LR_MG_TKA", 
	"CUP_O_LR_SPG9_TKA", 
	"CUP_O_UAZ_AGS30_TKA", 
	"CUP_O_UAZ_MG_TKA"
];

baseEnemyLightArmoredVehicleGroup_Taki_Army = [
	"CUP_O_BMP1_TKA", 
	"CUP_O_BTR80_TK", 
	"CUP_O_MTLB_pk_TKA", 
	"CUP_O_BMP2_ZU_TKA", 
	"CUP_O_BRDM2_TKA", 
	"CUP_O_BMP2_TKA"
];

baseEnemyHeavyArmoredVehicleGroup_Taki_Army = [
	"CUP_O_T34_TKA", 
	"CUP_O_T55_TK", 
	"CUP_O_T72_TKA"
];

////////////////////////
//Vehicle management////
////////////////////////
//Takistani
bluforUnarmedVehicle_Taki_Army = [
	"CUP_O_V3S_Open_TKA", 
	"CUP_O_LR_Transport_TKA", 
	"CUP_O_UAZ_Unarmed_TKA"
];

bluforArmedVehicle_Taki_Army = [
	"CUP_O_LR_MG_TKA", 
	"CUP_O_LR_SPG9_TKA", 
	"CUP_O_UAZ_AGS30_TKA", 
	"CUP_O_UAZ_MG_TKA"
];

bluforUnarmedVehicleChopper_Taki_Army = [
	"CUP_O_Mi17_TK", 
	"CUP_O_MI6T_TKA", 
	"CUP_O_UH1H_TKA"
];

bluforDrone_Taki_Army = [

];

bluforBoat_Taki_Army = [

];

//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_Taki_Army = [
	"CUP_O_Mi24_D_Dynamic_TK"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_Taki_Army = [
	"CUP_O_BMP1_TKA", 
	"CUP_O_BTR80_TK", 
	"CUP_O_MTLB_pk_TKA", 
	"CUP_O_BMP2_ZU_TKA", 
	"CUP_O_BRDM2_TKA", 
	"CUP_O_BMP2_TKA"

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_Taki_Army = [
	"CUP_O_Su25_Dyn_TKA", 
	"CUP_O_L39_TK"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_Taki_Army = [
	"CUP_O_M113A3_HQ_TKA"
];

////////////////////////
//Loadout management////
////////////////////////

listOfRoles_Taki_Army = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_grenadier,c_medic,c_pilot];

//Takistani army
loadout_Taki_Army = [		
	[c_leader,"CUP_O_TK_Soldier_SL"],
	[c_at,"CUP_O_TK_Soldier_AT"],
	[c_rifleman,"CUP_O_TK_Soldier"],//Default stuff
	[c_engineer,"CUP_O_TK_Engineer"],
	[c_autorifleman,"CUP_O_TK_Soldier_MG"],
	[c_marksman,"CUP_O_TK_Soldier_M"],
	[c_medic,"CUP_O_TK_Medic"],
	[c_grenadier,"CUP_O_TK_Soldier_GL"],
	[c_pilot,"CUP_O_TK_Pilot"]
];
//Sample loadout

////////////////////////
///Weapon management////
////////////////////////
//Takistani army
rifleList_Taki_Army = [		
	"CUP_arifle_FNFAL"
];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_Taki_Army = [		
	"CUP_arifle_M16A2_GL"
];

launcherList_Taki_Army = [		
	"CUP_launch_RPG7V_PGO7V2"
];	

autorifleList_Taki_Army = [			
	"CUP_lmg_PKM"
];	


marksmanrifleList_Taki_Army = [		
	"CUP_srifle_SVD_pso",
	"CUP_srifle_ksvk_PSO3",
	"CUP_srifle_SVD_des_ghillie_pso"
];

smgList_Taki_Army = [	
	"CUP_arifle_AKS74U"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_Taki_Army	= [

];

attachmentLongList_Taki_Army	= [
	"CUP_optic_PSO_1",
	"CUP_optic_PSO_3",
	"CUP_SVD_camo_d"
];


////////////////////////
////Items management////
////////////////////////
itemList_Taki_Army = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"Binocular",
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
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard",
	"ACE_VMH3",
	"ACE_VMM3"
	];

itemEngineerList_Taki_Army = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", 
	"ACE_Fortify"
	];
	
itemMedicList_Taki_Army = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];


//backpack avalaible for all unit
backPackList_Taki_Army = [
	"CUP_B_AlicePack_OD"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_Taki_Army = [
	"CUP_V_O_TK_Vest_1",
	"CUP_H_TK_Helmet",
	"CUP_FR_NeckScarf",
	"CUP_U_O_TK_Green",
	"CUP_U_O_TK_MixedCamo"
	];

//Magazine avalaible for all unit
magazineList_Taki_Army = [
	"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",
	"CUP_20Rnd_762x51_FNFAL_M",
	"CUP_PG7VL_M",
	"CUP_30Rnd_556x45_Stanag",
	"CUP_1Rnd_HEDP_M203",
	"CUP_30Rnd_545x39_AK_M",
	"CUP_10Rnd_762x54_SVD_M",
	"CUP_5Rnd_127x108_KSVK_M"
	];


//Get magazine with following command
//getArray (configfile >> "CfgWeapons" >> weaponName >> "magazines");