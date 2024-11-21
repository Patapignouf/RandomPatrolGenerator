#include "..\classConstant.sqf"

factionID = factionID+1;
factionInfos pushBack ["_2035_LDF", factionID,"2035 LDF", false, true, false];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

baseEnemyGroup_2035_LDF = [
	"I_E_Soldier_SL_F", 
	"I_E_RadioOperator_F", 
	"I_E_soldier_M_F", 
	"I_E_Soldier_TL_F",
	"I_E_Soldier_F", 
	"I_E_Soldier_AR_F", 
	"I_E_Soldier_A_F", 
	"I_E_Medic_F"
];

baseEnemyATGroup_2035_LDF = [
	"I_E_Soldier_SL_F", 
	"I_E_Soldier_LAT_F",
	"I_E_Soldier_LAT2_F",
	"I_E_RadioOperator_F"
];

baseEnemyDemoGroup_2035_LDF = [
	"I_E_Soldier_SL_F", 
	"I_E_RadioOperator_F", 
	"I_E_Soldier_Exp_F", 
	"I_E_Engineer_F",
	"I_E_Soldier_F"
];

baseEnemyMortarGroup_2035_LDF = [
	"I_E_Mortar_01_F",
	"I_E_soldier_UAV_06_F", 
	"I_E_soldier_UAV_06_medical_F"
];

baseEnemyVehicleGroup_2035_LDF = [
	"I_E_Offroad_01_F", 
	"I_E_Offroad_01_comms_F", 
	"I_E_Offroad_01_covered_F", 
	"I_E_Van_02_vehicle_F", 
	"I_E_Truck_02_F"
];

baseEnemyLightArmoredVehicleGroup_2035_LDF = [
	"I_E_APC_tracked_03_cannon_F"
];


baseEnemyTurretGroup_2035_LDF = [
	//Turrets 
	["I_E_HMG_02_high_F", "SMALLBUNKER"],
	["I_E_Static_AT_F", "SMALLBUNKER"],
	["I_E_GMG_01_high_F", "SMALLBUNKER"],
	["I_E_HMG_01_high_F", "SMALLBUNKER"]

];

baseEnemyUnarmedChopperGroup_2035_LDF = [
	"I_E_Heli_light_03_unarmed_F"
];

baseEnemyArmedChopperGroup_2035_LDF = [
	"I_E_Heli_light_03_dynamicLoadout_F"
];

