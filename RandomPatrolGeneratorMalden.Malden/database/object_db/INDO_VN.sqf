#include "..\classConstant.sqf"

//Add specific DSF factions
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "uns_main") && isClass (configFile >> "CfgPatches" >> "INDO_Mod")) then 
{
	factionInfos pushBack ["_INDO_VN", "_INDO_VN","Indochine VietMinh [UNSUNG/INDOCHINE]", false, true, true];
};

//newFaction
civilian_group_INDO_VN = [
	"uns_civilian1", 
	"uns_civilian4", 
	"uns_civilian3", 
	"uns_civilian2", 
	"uns_civilian4_b1", 
	"uns_civilian2_b2"
];

civilian_big_group_INDO_VN = [
	"uns_civilian1", 
	"uns_civilian4", 
	"uns_civilian3", 
	"uns_civilian2", 
	"uns_civilian2_b1", 
	"uns_civilian1_b3", 
	"uns_civilian4_b2", 
	"uns_civilian3_b1", 
	"uns_civilian2_b3"
];

civilianTruck_INDO_VN = [
	"CUP_C_Skoda_CR_CIV",
	"CUP_C_LR_Transport_CTK", 
	"CUP_C_UAZ_Open_TK_CIV"
];


////////////////////////
//Vehicle management////
////////////////////////

baseEnemyVehicleGroup_INDO_VN = [
	"uns_spiderhole_leanto_VC",
	"uns_spiderhole_VC",
	"uns_pk_bunker_closed_VC"
];

baseEnemyLightArmoredVehicleGroup_INDO_VN = [

];

baseEnemyHeavyArmoredVehicleGroup_INDO_VN = [

];

baseEnemyUnarmedChopperGroup_INDO_VN = [

];

//Basic enemy aircraft avalaible
baseFixedWingGroup_INDO_VN = [

];

baseEnemyTurretGroup_INDO_VN = [
	//Turrets 
	["uns_dshk_high_VC", "SMALLBUNKER"],
	["uns_pk_high_VC", "SMALLBUNKER"]
];

////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_INDO_VN = [		
	[c_leader, "INDO_DIV312_Teamleader_PPSh41", ["INDO_DIV312_Squadleader_PPSh41","INDO_DIV312_Platoonleader_P38"]],
	[c_at, "uns_men_VC_mainforce_67_AT2", []], //In reality VietMinh doesn't have RPG7 but UNSUNG give AK47 to RPG-2 units
	[c_rifleman, "INDO_DIV312_Rifleman_Kar98k",["INDO_DIV312_Rifleman_MAS36CR39","uns_men_VC_local_AS4","uns_men_VC_local_AS3","uns_men_VC_local_AS6","uns_men_VC_local_AS7","uns_men_VC_local_AS8"]],//Default stuff
	[c_engineer,"uns_men_VC_mainforce_68_SAP", []],
	[c_autorifleman, "uns_men_VC_local_LMG",[]],
	[c_marksman, "uns_men_VC_mainforce_68_MRK",["uns_men_VC_mainforce_68_TRI","uns_men_VC_local_MRK2","uns_men_VC_local_MRK","uns_men_VC_local_AS8"]],
	[c_medic,"uns_men_VC_mainforce_68_MED",["uns_men_VC_local_MED"]], //Taken from Navy (No medic in USMC)
	[c_grenadier, "uns_men_VC_local_RF7"]
];

