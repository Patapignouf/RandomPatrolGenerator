#include "..\classConstant.sqf"

//Add specific RHS factions
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	factionInfos pushBack ["_CHDSK_2020", factionID,"2020 Chernarussian Movement of the Red Star [RHS]", true, true, false];
};

//////////////////////////////
///Define enemy group data////
//////////////////////////////
baseEnemyGroup_CHDSK_2020 = [
	"rhsgref_ins_g_squadleader",
	"rhsgref_ins_g_machinegunner",
	"rhsgref_ins_g_medic",
	"rhsgref_ins_g_rifleman",
	"rhsgref_ins_g_rifleman",
	"rhsgref_ins_g_machinegunner",
	"rhsgref_ins_g_rifleman",
	"rhsgref_ins_g_rifleman_aks74"
];

baseEnemyATGroup_CHDSK_2020 = [
	"rhsgref_ins_g_squadleader",
	"rhsgref_ins_g_machinegunner",
	"rhsgref_ins_g_grenadier",
	"rhsgref_ins_g_grenadier_rpg",
	"rhsgref_ins_g_rifleman_RPG26",
	"rhsgref_ins_g_machinegunner",
	"rhsgref_ins_g_rifleman",
	"rhsgref_ins_g_rifleman_aks74"
];

baseEnemyDemoGroup_CHDSK_2020 = [
	"rhsgref_ins_g_rifleman",
	"rhsgref_ins_g_machinegunner",
	"rhsgref_ins_g_machinegunner",
	"rhsgref_ins_g_rifleman_RPG26"
];

baseEnemyMortarGroup_CHDSK_2020 = [
	"rhsgref_ins_g_2b14",
	"rhsgref_ins_g_rifleman",
	"rhsgref_ins_g_machinegunner",
	"rhsgref_ins_g_grenadier",
	"rhsgref_ins_g_rifleman",
	"rhsgref_ins_g_rifleman_aks74"

];

baseEnemyVehicleGroup_CHDSK_2020 = [
	"rhsgref_ins_g_gaz66",
	"rhsgref_ins_g_gaz66o",
	"rhsgref_BRDM2UM_ins_g",
	"rhsgref_BRDM2_HQ_ins_g",
	"rhsgref_ins_g_uaz_dshkm_chdkz"
];

baseEnemyLightArmoredVehicleGroup_CHDSK_2020 = [
	"rhsgref_ins_g_btr60",
	"rhsgref_ins_g_btr70",
	"rhsgref_BRDM2_ins_g",
	"rhsgref_ins_g_bmd1p"
];

baseEnemyHeavyArmoredVehicleGroup_CHDSK_2020 = [
	"rhsgref_ins_g_zsu234",
	"rhsgref_ins_g_bmp1k",
	"rhsgref_ins_g_t72ba",
	"rhsgref_ins_g_t72bc"
];

baseEnemyTurretGroup_CHDSK_2020 = [
	//Turrets 
	["rhsgref_ins_g_DSHKM", "SMALLBUNKER"],
	["rhsgref_ins_g_ZU23", "SMALLBUNKER"],
	["rhsgref_ins_g_Igla_AA_pod", "NOTHING"]
];


baseEnemyUnarmedChopperGroup_CHDSK_2020 = [
	"rhsgref_ins_g_Mi8amt"
];

baseEnemyArmedChopperGroup_CHDSK_2020 = [

];

baseFixedWingGroup_CHDSK_2020 = [

];


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_CHDSK_2020 = [
	"rhsgref_ins_g_gaz66",
	"rhsgref_ins_g_gaz66o",
	"rhsgref_BRDM2UM_ins_g",
	"rhsgref_ins_g_uaz_open"
];

bluforArmedVehicle_CHDSK_2020 = [
	"rhsgref_BRDM2_HQ_ins_g",
	"rhsgref_ins_g_uaz_dshkm_chdkz"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_CHDSK_2020 = [
	"rhsgref_ins_g_btr60",
	"rhsgref_ins_g_btr70",
	"rhsgref_BRDM2_ins_g",
	"rhsgref_ins_g_bmd1p",
	"rhsgref_ins_g_zsu234",
	"rhsgref_ins_g_bmp1k",
	"rhsgref_ins_g_t72ba",
	"rhsgref_ins_g_t72bc"
];

bluforUnarmedVehicleChopper_CHDSK_2020 = [
	"rhsgref_ins_g_Mi8amt"
];

bluforArmedChopper_CHDSK_2020 = [

];

bluforDrone_CHDSK_2020 = [

];

bluforBoat_CHDSK_2020 = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_CHDSK_2020 = [

];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_CHDSK_2020 = [
	"rhsgref_BRDM2UM_ins_g"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_CHDSK_2020 = [		
	[c_leader, "rhsgref_ins_g_squadleader", [], false],
	[c_at, "rhsgref_ins_g_rifleman_RPG26", ["rhsgref_ins_g_specialist_aa","rhsgref_ins_g_grenadier_rpg"], false],
	[c_rifleman, "rhsgref_ins_g_rifleman_akm", ["rhsgref_ins_g_rifleman","rhsgref_ins_g_rifleman_aks74","rhsgref_ins_g_rifleman_aksu"], false],//Default stuff
	[c_engineer,"rhsgref_ins_g_engineer", ["rhsgref_ins_g_saboteur"], false],
	[c_autorifleman, "rhsgref_ins_g_machinegunner", ["rhsgref_ins_g_arifleman_rpk"], false],
	[c_marksman, "rhsgref_ins_g_sniper", ["rhsgref_ins_g_militiaman_mosin","rhsgref_ins_g_spotter"], false],
	[c_medic,"rhsgref_ins_g_medic", [], false],
	[c_grenadier, "rhsgref_ins_g_grenadier", [], false],//Default stuff
	[c_pilot,"rhsgref_ins_g_pilot", [], false]
];


////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_CHDSK_2020 = [		

];	

grenadeLauncherList_CHDSK_2020 = [		

];


launcherList_CHDSK_2020 = [		

];	

autorifleList_CHDSK_2020 = [			


];	

marksmanrifleList_CHDSK_2020 = [		

];


smgList_CHDSK_2020 = [		

];

//////////////////////////
attachmentShortList_CHDSK_2020	= [


];

attachmentLongList_CHDSK_2020	= [

];


////////////////////////
itemList_CHDSK_2020 = [
	"B_UavTerminal",
	"ItemGPS",
	"rhs_pdu4",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard",
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP"
];

itemEngineerList_CHDSK_2020 = [
	"ACE_DeadManSwitch",
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_CHDSK_2020 = [

];

//backpack avalaible for all unit
backPackList_CHDSK_2020 = [

	"TFAR_anarc164"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_CHDSK_2020 = [

];


factionDefaultRadios_CHDSK_2020 = [
	"TFAR_anprc148jem"
];

//Magazine avalaible for all unit
magazineList_CHDSK_2020 = [

];