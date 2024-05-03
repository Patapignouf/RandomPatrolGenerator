//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack ["_Chernarussian_Winter", 29, "Chernarussian Winter [CUP]", false, true, false];
};



//////////////////////////////  
///Define enemy group data////
//////////////////////////////
//Russian Ratnik_Winter
baseEnemyGroup_Chernarussian_Winter  = [
	"CUP_B_CDF_Soldier_TL_SNW", 
	"CUP_B_CDF_Soldier_MG_SNW", 
	"CUP_B_CDF_Soldier_MG_SNW",
	"CUP_B_CDF_Soldier_LAT_SNW", 
	"CUP_B_CDF_Soldier_GL_SNW", 
	"CUP_B_CDF_Soldier_SNW", 
	"CUP_B_CDF_Soldier_SNW",
	"CUP_B_CDF_Medic_SNW"
	
];

baseEnemyATGroup_Chernarussian_Winter  = [
	"CUP_B_CDF_Soldier_TL_SNW", 
	"CUP_B_CDF_Soldier_LAT_SNW", 
	"CUP_B_CDF_Soldier_LAT_SNW",
	"CUP_B_CDF_Soldier_AR_SNW"
	
];

baseEnemyDemoGroup_Chernarussian_Winter  = [
	"CUP_B_CDF_Soldier_MG_SNW", 
	"CUP_B_CDF_Soldier_MG_SNW",
	"CUP_B_CDF_Soldier_AR_SNW", 
	"CUP_B_CDF_Soldier_LAT_SNW"
];

baseEnemyMortarGroup_Chernarussian_Winter  = [
	"CUP_B_2b14_82mm_CDF",
	"CUP_B_CDF_Sniper_SNW", 
	"CUP_B_CDF_Spotter_SNW",
	"CUP_B_CDF_Soldier_AA_SNW"
];

baseEnemyVehicleGroup_Chernarussian_Winter  = [ 
	"CUP_B_UAZ_Unarmed_CDF", 
	"CUP_B_UAZ_AGS30_CDF", 
	"CUP_B_UAZ_MG_CDF", 
	"CUP_B_UAZ_METIS_CDF", 
	"CUP_B_UAZ_Open_CDF"
];

baseEnemyLightArmoredVehicleGroup_Chernarussian_Winter = [
	"CUP_O_BTR60_Winter_RU", 
	"CUP_O_BTR80_WINTER_RU", 
	"CUP_O_BTR80A_WINTER_RU",
	"CUP_B_MTLB_pk_Winter_CDF"
];

baseEnemyHeavyArmoredVehicleGroup_Chernarussian_Winter = [
	"CUP_B_T72_CDF",
	"CUP_B_ZSU23_CDF"
];


baseEnemyUnarmedChopperGroup_Chernarussian_Winter = [
	"CUP_B_Mi17_CDF", 
	"CUP_B_MI6T_CDF"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_Chernarussian_Winter = [
	
];