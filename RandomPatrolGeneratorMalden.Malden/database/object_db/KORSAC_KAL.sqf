//Add specific KORSAC factions
if (isClass (configFile >> "CfgPatches" >> "vtf_kf_main")) then 
{
	factionInfos pushBack ["_KORSAC_KAL",34,"KAL Locals [KORSAC]", false, true, false];	
};


//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_KORSAC_KAL = [
	"vtf_kf_I_Leader_AKM_F", 
	"vtf_kf_I_Rifleman_AKS_F", 
	"vtf_kf_I_Rifleman_AKM_F", 
	"vtf_kf_I_Marksman_F", 
	"vtf_kf_I_Leader_AKS_F", 
	"vtf_kf_I_Rifleman_Mk14_F", 
	"vtf_kf_I_Rifleman_SG_F", 
	"vtf_kf_I_Rifleman_SO_F"
];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_KORSAC_KAL = [
	"vtf_kf_I_Rifleman_SO_F",
	"vtf_kf_I_Rifleman_SO_F",
	"vtf_kf_I_Rifleman_SG_F", 
	"vtf_kf_I_Leader_AKM_F"
];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_KORSAC_KAL = [
	"vtf_kf_I_Rifleman_Mk14_F", 
	"vtf_kf_I_Marksman_F", 
	"vtf_kf_I_Rifleman_AKM_F", 
	"vtf_kf_I_Leader_AKS_F"
];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_KORSAC_KAL = [

];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_KORSAC_KAL = [
	"vtf_kf_I_Quadbike_01_F", 
	"vtf_kf_I_Offroad_01_F"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_KORSAC_KAL = [

];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_KORSAC_KAL = [

];

//Basic enemy aircraft avalaible
baseFixedWingGroup_KORSAC_KAL = [

];