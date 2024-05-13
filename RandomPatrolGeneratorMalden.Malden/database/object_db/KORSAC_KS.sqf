//Add specific KORSAC factions
if (isClass (configFile >> "CfgPatches" >> "vtf_kf_main")) then 
{
	factionInfos pushBack ["_KORSAC_KS",32,"KS Separatists [KORSAC]", false, true, false];
};

//////////////////////////////  
///Define enemy group data////
//////////////////////////////
//Russian Ratnik_Winter
baseEnemyGroup_KORSAC_KS  = [
	"vtf_kf_O_SquadLeader_F",
	"vtf_kf_O_Medic_F",
	"vtf_kf_O_Rifleman_AT_F",
	"vtf_kf_O_Marksman_F",
	"vtf_kf_O_Grenadier_F",
	"vtf_kf_O_Rifleman_F",
	"vtf_kf_O_Autorifleman_F",
	"vtf_kf_O_Engineer_F"
	
];

baseEnemyATGroup_KORSAC_KS  = [
	"vtf_kf_O_SquadLeader_F",
	"vtf_kf_O_Rifleman_AT_F",
	"vtf_kf_O_Rifleman_AT_F",
	"vtf_kf_O_Rifleman_AA_F",
	"vtf_kf_O_Autorifleman_F"
];

baseEnemyDemoGroup_KORSAC_KS  = [
	"vtf_kf_O_recon_TL_F",
	"vtf_kf_O_recon_medic_F",
	"vtf_kf_O_recon_M_F",
	"vtf_kf_O_recon_E_F"
];	

baseEnemyMortarGroup_KORSAC_KS  = [
	"vtf_kf_O_Mortar_01_F",
	"vtf_kf_O_Marksman_F",
	"vtf_kf_O_Marksman_F"
];

baseEnemyVehicleGroup_KORSAC_KS  = [ 
	"vtf_kf_O_Offroad_01_HMG_F",
	"vtf_kf_O_Offroad_01_covered_F",
	"vtf_kf_O_Offroad_01_AT_F",
	"vtf_kf_O_LSV_02_unarmed_F",
	"vtf_kf_O_Van_02_transport_F",

	//Turrets 
	"vtf_kf_O_HMG_02_high_F", 
	"vtf_kf_O_Rifleman_F", 
	"vtf_kf_O_static_AA_F", 
	"vtf_kf_O_static_AT_F"
];

baseEnemyLightArmoredVehicleGroup_KORSAC_KS = [

];

baseEnemyHeavyArmoredVehicleGroup_KORSAC_KS = [
	"vtf_kf_O_MBT_02_cannon_F"
];


baseEnemyUnarmedChopperGroup_KORSAC_KS = [
	"vtf_kf_O_Heli_Light_02_unarmed_F"
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_KORSAC_KS = [
	
];