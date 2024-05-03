#include "..\classConstant.sqf"

//Add specific UNSUNG factions
if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	factionInfos pushBack ["_ColdWar_VC",37,"Cold War VietCong [UNSUNG]", false, true, false];
};

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//newFaction
civilian_group_ColdWar_VC = [
	"uns_civilian1", 
	"uns_civilian4", 
	"uns_civilian3", 
	"uns_civilian2", 
	"uns_civilian4_b1", 
	"uns_civilian2_b2"
];

civilian_big_group_ColdWar_VC = [
	"uns_civilian1", 
	"uns_civilian4", 
	"uns_civilian3", 
	"uns_civilian2", 
	"uns_civilian4_b1", 
	"uns_civilian2_b1", 
	"uns_civilian1_b3", 
	"uns_civilian4_b2", 
	"uns_civilian3_b1", 
	"uns_civilian2_b3"
];

civilianTruck_ColdWar_VC = [
	"CUP_C_Skoda_CR_CIV",
	"CUP_C_LR_Transport_CTK", 
	"CUP_C_UAZ_Open_TK_CIV"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//newFaction
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_ColdWar_VC = [
	"uns_men_VC_recon_off",
	"uns_men_VC_recon_RF3",
	"uns_men_VC_recon_RTO",
	"uns_men_VC_recon_MED",
	"uns_men_VC_recon_LMG",
	"uns_men_VC_recon_AT",
	"uns_men_VC_recon_AS2",
	"uns_men_VC_recon_MRK",
	"uns_men_VC_recon_TRI",
	"uns_men_VC_recon_RF6"
];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_ColdWar_VC = [
	"uns_men_VC_regional_COM",
	"uns_men_VC_regional_AT2",
	"uns_men_VC_regional_MED",
	"uns_men_VC_regional_RF2",
	"uns_men_VC_regional_RF4",
	"uns_men_VC_regional_MGS",
	"uns_men_VC_regional_TRI",
	"uns_men_VC_regional_RF1",
	"uns_men_VC_regional_AS2"
];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_ColdWar_VC = [
	"uns_men_VC_mainforce_68_COM",
	"uns_men_VC_mainforce_67_SAP",
	"uns_men_VC_mainforce_67_Rmg",
	"uns_men_VC_mainforce_67_RF2",
	"uns_men_VC_mainforce_67_SAP",
	"uns_men_VC_mainforce_67_MED"
];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_ColdWar_VC = [
	"uns_m1941_82mm_mortarVC",
	"uns_men_VC_mainforce_67_MRK",
	"uns_men_VC_mainforce_67_MRK"
];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_ColdWar_VC = [
	"uns_dshk_twin_bunker_open_VC",
	"uns_pk_bunker_open_VC",
	"uns_pk_bunker_closed_VC",
	"uns_dshk_twin_bunker_closed_VC",
	"uns_spiderhole_VC",
	"uns_men_VC_recon_RF1",
	"uns_pk_bunker_low_VC",
	"uns_men_VC_regional_Rmg"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_ColdWar_VC = [
	"uns_S60_VC",
	"uns_Type74_VC"
];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_ColdWar_VC = [
	"uns_t34_76_vc"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_ColdWar_VC = [
	
];
