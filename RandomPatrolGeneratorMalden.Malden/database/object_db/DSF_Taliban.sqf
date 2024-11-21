#include "..\classConstant.sqf"

//Add specific DSF Faction
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "DSF_core")) then 
{
	factionInfos pushBack ["_taliban_DSF", factionID,"Talibans [DSF]", false, true, true];
};



//Light civilian group
civilian_group_taliban_DSF = [
	"DSF_CIV_Man", 
	"DSF_CIV_ManRobes",
	"DSF_CIV_ManRobes"
];

//Heavy civilian group
civilian_big_group_taliban_DSF = [
	"DSF_CIV_Man", 
	"DSF_CIV_ManRobes",
	"DSF_CIV_ManRobes",
	"DSF_CIV_Man",
	"DSF_CIV_Man",
	"DSF_CIV_Man"
];

//Vehicle avalaible on civilian city
civilianTruck_taliban_DSF = [
	"C_Van_01_box_F", 
	"C_Offroad_01_F"
];



//////////////////////////////
///Define enemy group data////
//////////////////////////////
//Taliban DSF
baseEnemyGroup_taliban_DSF = [
	"DSF_TAL_SquadLeader", 
	"DSF_TAL_Rifleman", 
	"DSF_TAL_Rifleman",
	"DSF_TAL_Marksman", 
	"DSF_TAL_MachineGunner", 
	"DSF_TAL_Medic", 
	"DSF_TAL_AutomaticRifleman", 
	"DSF_TAL_Rifleman_Lite"
];

baseEnemyATGroup_taliban_DSF = [
	"DSF_TAL_RPG7Grenadier", 
	"DSF_TAL_AASoldier", 
	"DSF_TAL_TeamLeader", 
	"DSF_TAL_Rifleman",
	"DSF_TAL_Rifleman"
];

baseEnemyDemoGroup_taliban_DSF = [
	"DSF_TAL_TeamLeader", 
	"DSF_TAL_Repair", 
	"DSF_TAL_Engineer", 
	"DSF_TAL_Explosives", 
	"DSF_TAL_Marksman",
	"DSF_TAL_Rifleman"
];

baseEnemyMortarGroup_taliban_DSF = [

];

baseEnemyVehicleGroup_taliban_DSF = [
	"DSF_TAL_technical"
];

baseEnemyLightArmoredVehicleGroup_taliban_DSF = [
	"DSF_TAL_technical_AT"
];

baseEnemyHeavyArmoredVehicleGroup_taliban_DSF = [

];

baseEnemyUnarmedChopperGroup_taliban_DSF = [

];

baseEnemyArmedChopperGroup_taliban_DSF = [

];

baseFixedWingGroup_taliban_DSF = [

];