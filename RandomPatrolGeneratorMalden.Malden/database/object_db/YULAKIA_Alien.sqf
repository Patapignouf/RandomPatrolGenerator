#include "..\classConstant.sqf"

//Add specific DSF factions
factionID = factionID+1;

if (isClass (configFile >> "CfgVehicles" >> "IBV_Vampire2")) then 
{
	factionInfos pushBack ["_YULAKIA_Alien", factionID,"YULAKIA Fun", false, true, false];
};

baseEnemyGroup_YULAKIA_Alien = [
	"icebreakr_VoivodeVurdalak",
	"icebreakr_Vurdalak",
	"icebreakr_VoivodeVurdalak",
	"icebreakr_Vurdalak",
	"icebreakr_VoivodeVurdalak",
	"icebreakr_Vurdalak",
	"icebreakr_VoivodeVurdalak",
	"icebreakr_Vurdalak"
];


// icebreakr_VoivodeVurdalak,
// icebreakr_Vurdalak
	// "IBV_Vampire",
	// "IBV_Vampire2",

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_YULAKIA_Alien = [
	"icebreakr_Vurdalak",
	"icebreakr_Vurdalak",
	"icebreakr_Vurdalak",
	"icebreakr_Vurdalak",
	"icebreakr_Vurdalak",
	"icebreakr_Vurdalak"

];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_YULAKIA_Alien = [
	"IBV_VurdalakImpostor",
	"IBV_VurdalakImpostor",
	"IBV_VurdalakImpostor",
	"IBV_VurdalakImpostor",
	"IBV_VurdalakImpostor",
	"IBV_VurdalakImpostor"
];