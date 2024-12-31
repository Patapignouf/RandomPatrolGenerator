#include "..\classConstant.sqf"

factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "JMSLLTE_empire_mod")) then 
{
	factionInfos pushBack ["_JM_Empire", factionID,"Empire [JM] ", false, true, false];
};
//////////////////////////////
///Define enemy group data////
//////////////////////////////

baseEnemyGroup_JM_Empire = [
	"JMSLLTE_emp_storm_serg",
	"JMSLLTE_emp_storm_trooper",
	"JMSLLTE_emp_storm_trooper",
	"JMSLLTE_emp_storm_trooperH",
	"JMSLLTE_emp_storm_trooper",
	"JMSLLTE_emp_storm_trooper",
	"JMSLLTE_emp_storm_trooperH",
	"JMSLLTE_emp_storm_trooper",
	"JMSLLTE_emp_storm_trooperL"
];

baseEnemyATGroup_JM_Empire = [
	"JMSLLTE_emp_storm_rtrooperS",
	"JMSLLTE_emp_storm_rtrooper",
	"JMSLLTE_emp_storm_rtrooper",
	"JMSLLTE_emp_storm_rtrooper"
];

baseEnemyDemoGroup_JM_Empire = [
	"JMSLLTE_emp_storm_shock",
	"JMSLLTE_emp_storm_shock",
	"JMSLLTE_emp_storm_shock",
	"JMSLLTE_emp_storm_shockH"
];

baseEnemyMortarGroup_JM_Empire = [

];

baseEnemyVehicleGroup_JM_Empire = [
	"JMSLLTE_B_veh_74z_imp_ST_F",
	"JMSLLTE_B_veh_LIUSt_imp_F",
	"JMSLLTE_B_veh_LIUSeweb_imp_F"
];

baseEnemyLightArmoredVehicleGroup_JM_Empire = [
	"JMSLLTE_vehgr_ATST_F"
];

baseEnemyHeavyArmoredVehicleGroup_JM_Empire = [
	"JMSLLTE_B_veh_ITT_imp_F"
];

baseEnemyUnarmedChopperGroup_JM_Empire = [
	"JMSLLTE_veh_IDT_inf_empire",
	"JMSLLTE_veh_ZetaClass_inf_emp"

];

baseEnemyArmedChopperGroup_JM_Empire = [

];


baseEnemyTurretGroup_JM_Empire = [
	//Turrets 
	["JMSLLTE_B_vehgr_eweb_imp_ST_F", "SMALLBUNKER"],
	["JMSLLTE_B_vehgr_DF9cannon_imp_F", "NOTHING"],
	["JMSLLTE_B_vehgr_14FDcannon_imp_F", "NOTHING"]

];



//Basic enemy aircraft avalaible
baseFixedWingGroup_JM_Empire = [
	"JMSLLTE_TIEag_emp_F",
	"JMSLLTE_TIEbomber_veh_F",
	"JMSLLTE_TIEstriker_emp_F",
	"JMSLLTE_TIEinterceptor_veh_F",
	"JMSLLTE_TIEfighter_veh_F"
];