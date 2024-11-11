#include "..\classConstant.sqf"

factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "fow_main")) then 
{
	factionInfos pushBack ["_FOW_JAP", factionID,"Japanese [FOW]", false, true, false];
};
//////////////////////////////
///Define enemy group data////
//////////////////////////////

baseEnemyGroup_FOW_JAP = [
	"fow_s_ija_nco",
	"fow_s_ija_type99_gunner",
	"fow_s_ija_type99_asst",
	"fow_s_ija_type99_asst",
	"fow_s_ija_type99_asst",
	"fow_s_ija_rifleman",
	"fow_s_ija_rifleman",
	"fow_s_ija_rifleman",
	"fow_s_ija_medic"
];

baseEnemyATGroup_FOW_JAP = [
	"fow_s_ija_f_rifleman_at",
	"fow_s_ija_f_rifleman_at",
	"fow_s_ija_f_rifleman_at",
	"fow_s_ija_f_nco",
	"fow_s_ija_f_type99_asst",
	"fow_s_ija_f_medic"
];

baseEnemyDemoGroup_FOW_JAP = [
	"fow_s_ija_officer",
	"fow_s_ija_radio_operator",
	"fow_s_ija_medic",
	"fow_s_ija_type99_gunner",
	"fow_s_ija_rifleman",
	"fow_s_ija_rifleman",
	"fow_s_ija_rifleman"
];

baseEnemyMortarGroup_FOW_JAP = [
	"fow_w_type97_mortar_ija",
	"fow_s_ija_f_rifleman",
	"fow_s_ija_f_radio_operator"
];

baseEnemyVehicleGroup_FOW_JAP = [
	"fow_v_type97_truck_ija",
	"fow_v_type97_truck_open_ija"
];

baseEnemyLightArmoredVehicleGroup_FOW_JAP = [

];

baseEnemyHeavyArmoredVehicleGroup_FOW_JAP = [
	"fow_ija_type95_HaGo_1_ija",
	"fow_ija_type95_HaGo_2_ija",
	"fow_ija_type95_HaGo_3_ija"
];


baseEnemyTurretGroup_FOW_JAP = [
	//Turrets 
	["fow_w_type92_tripod_ija", "SMALLBUNKER"],
	["fow_w_type92_tripod_middle_ija", "SMALLBUNKER"],
	["fow_w_6Pounder_ija", "SMALLBUNKER"],
	["fow_w_type92_tripod_low_s_ija", "NOTHING"]
];


//Basic enemy aircraft avalaible
baseFixedWingGroup_FOW_JAP = [
	"fow_va_a6m_green",
	"fow_va_a6m_white"
];