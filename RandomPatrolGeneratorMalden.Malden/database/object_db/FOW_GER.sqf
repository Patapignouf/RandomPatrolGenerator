#include "..\classConstant.sqf"

factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "fow_main")) then 
{
	factionInfos pushBack ["_FOW_GER", factionID,"German [FOW]", false, true, false];
};
//////////////////////////////
///Define enemy group data////
//////////////////////////////

baseEnemyGroup_FOW_GER = [
	"fow_s_ger_luft_tl_mp40", 
	"fow_s_ger_luft_rifleman_fg42", 
	"fow_s_ger_luft_mg42_asst", 
	"fow_s_ger_luft_radio_operator", 
	"fow_s_ger_luft_medic", 
	"fow_s_ger_luft_rifleman_g43", 
	"fow_s_ger_luft_rifleman_mp40", 
	"fow_s_ger_luft_rifleman"
];

baseEnemyATGroup_FOW_GER = [
	"fow_s_ger_luft_camo_nco_mp40", 
	"fow_s_ger_luft_camo_tl_mp40", 
	"fow_s_ger_luft_camo_mg42_gunner", 
	"fow_s_ger_luft_camo_mg42_asst", 
	"fow_s_ger_luft_camo_mg42_sparebarrel", 
	"fow_s_ger_luft_camo_rifleman",
	"fow_s_ger_heer_rifleman_mp40_pzf",
	"fow_s_ger_luft_camo_rifleman",
	"fow_s_ger_heer_medic"
];

baseEnemyDemoGroup_FOW_GER = [
	"fow_s_ger_ss_tl_stg", 
	"fow_s_ger_ss_radio_operator", 
	"fow_s_ger_ss_medic", 
	"fow_s_ger_ss_mg42_gunner", 
	"fow_s_ger_ss_mg42_sparebarrel", 
	"fow_s_ger_ss_rifleman"
];

baseEnemyMortarGroup_FOW_GER = [

];

baseEnemyVehicleGroup_FOW_GER = [
	"fow_v_sdkfz_251_camo_foliage_ger_heer"
];

baseEnemyLightArmoredVehicleGroup_FOW_GER = [
	"fow_v_sdkfz_250_camo_foliage_ger_heer", 
	"fow_v_sdkfz_250_ger_heer",
	"fow_v_sdkfz_222_ger_ss"
];

baseEnemyHeavyArmoredVehicleGroup_FOW_GER = [
	"fow_v_panther_ger_heer", 
	"fow_v_panther_camo_ger_heer"
];


baseEnemyTurretGroup_FOW_GER = [
	//Turrets 
	["fow_w_flak36_camo_ger_heer", "SMALLBUNKER"],
	["fow_w_pak40_gray_ger_heer", "NOTHING"],
	["fow_w_mg42_deployed_middle_ger_heer", "SMALLBUNKER"],
	["fow_w_mg42_deployed_s_ger_heer", "NOTHING"]
];


//Basic enemy aircraft avalaible
baseFixedWingGroup_FOW_GER = [

];