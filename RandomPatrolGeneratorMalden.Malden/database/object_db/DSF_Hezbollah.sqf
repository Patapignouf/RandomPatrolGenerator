#include "..\classConstant.sqf"

//Add specific DSF Faction
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "DSF_core")) then 
{
	factionInfos pushBack ["_Hezbollah_DSF", factionID,"Hezbollah [DSF]", false, true, false];
};




//////////////////////////////
///Define enemy group data////
//////////////////////////////
//Taliban DSF
baseEnemyGroup_Hezbollah_DSF = [
	"DSF_HEZB_SquadLeader", 
	"DSF_HEZB_Grenadier", 
	"DSF_HEZB_AutomaticRifleman", 
	"DSF_HEZB_Medic", 
	"DSF_HEZB_Marksman", 
	"DSF_HEZB_Rifleman",
	"DSF_HEZB_Rifleman",
	"DSF_HEZB_Rifleman",
	"DSF_HEZB_Rifleman"
];

baseEnemyATGroup_Hezbollah_DSF = [
	"DSF_HEZB_SquadLeader", 
	"DSF_HEZB_AutomaticRifleman", 
	"DSF_HEZB_RPG7Grenadier", 
	"DSF_HEZB_AASoldier",
	"DSF_HEZB_Rifleman",
	"DSF_HEZB_Rifleman"
];

baseEnemyDemoGroup_Hezbollah_DSF = [
	"DSF_HEZB_SquadLeader",
	"DSF_HEZB_Engineer", 
	"DSF_HEZB_Repair", 
	"DSF_HEZB_Explosives",
	"DSF_HEZB_Rifleman"
];

baseEnemyMortarGroup_Hezbollah_DSF = [

];

baseEnemyVehicleGroup_Hezbollah_DSF = [
	"DSF_TAL_technical"
];

baseEnemyLightArmoredVehicleGroup_Hezbollah_DSF = [
];

baseEnemyHeavyArmoredVehicleGroup_Hezbollah_DSF = [

];

baseEnemyUnarmedChopperGroup_Hezbollah_DSF = [

];

baseEnemyArmedChopperGroup_Hezbollah_DSF = [

];

baseFixedWingGroup_Hezbollah_DSF = [

];