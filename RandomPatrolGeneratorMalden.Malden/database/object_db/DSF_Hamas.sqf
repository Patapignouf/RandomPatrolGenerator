#include "..\classConstant.sqf"

//Add specific DSF Faction
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "DSF_core")) then 
{
	factionInfos pushBack ["_Hamas_DSF", factionID,"Hamas [DSF]", false, true, false];
};




//////////////////////////////
///Define enemy group data////
//////////////////////////////
//Taliban DSF
baseEnemyGroup_Hamas_DSF = [
	"DSF_HAMAS_SquadLeader", 
	"DSF_HAMAS_Rifleman", 
	"DSF_HAMAS_AutomaticRifleman", 
	"DSF_HAMAS_Rifleman", 
	"DSF_HAMAS_Engineer", 
	"DSF_HAMAS_Rifleman", 
	"DSF_HAMAS_Medic", 
	"DSF_HAMAS_Marksman"
];

baseEnemyATGroup_Hamas_DSF = [
	"DSF_HAMAS_SquadLeader", 
	"DSF_HAMAS_Grenadier", 
	"DSF_HAMAS_AutomaticRifleman", 
	"DSF_HAMAS_RPG7Soldier", 
	"DSF_HAMAS_Engineer", 
	"DSF_HAMAS_RPG7Grenadier", 
	"DSF_HAMAS_Medic", 
	"DSF_HAMAS_Marksman"
];

baseEnemyDemoGroup_Hamas_DSF = [
	"DSF_HAMAS_SquadLeader",
	"DSF_HAMAS_Engineer", 
	"DSF_HAMAS_Repair", 
	"DSF_HAMAS_Explosives",
	"DSF_HAMAS_Rifleman"
];

baseEnemyMortarGroup_Hamas_DSF = [

];

baseEnemyVehicleGroup_Hamas_DSF = [
	"DSF_TAL_technical"
];

baseEnemyLightArmoredVehicleGroup_Hamas_DSF = [
];

baseEnemyHeavyArmoredVehicleGroup_Hamas_DSF = [

];

baseEnemyUnarmedChopperGroup_Hamas_DSF = [

];

baseEnemyArmedChopperGroup_Hamas_DSF = [

];

baseFixedWingGroup_Hamas_DSF = [

];