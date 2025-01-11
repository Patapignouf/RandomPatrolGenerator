#include "..\classConstant.sqf"

//Add specific RHS factions
factionID = factionID+1;

if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	factionInfos pushBack ["_CDF_2020", factionID,"2020 Chernarussian Defense Forces [RHS]", true, true, false];
};

//////////////////////////////
///Define enemy group data////
//////////////////////////////
baseEnemyGroup_CDF_2020 = [
	"rhsgref_cdf_reg_squadleader",
	"rhsgref_cdf_reg_machinegunner",
	"rhsgref_cdf_reg_machinegunner",
	"rhsgref_cdf_reg_machinegunner",
	"rhsgref_cdf_reg_medic",
	"rhsgref_cdf_reg_rifleman_aks74",
	"rhsgref_cdf_reg_engineer",
	"rhsgref_cdf_reg_rifleman"
];

baseEnemyATGroup_CDF_2020 = [
	"rhsgref_cdf_reg_squadleader",
	"rhsgref_cdf_reg_machinegunner",
	"rhsgref_cdf_reg_machinegunner",
	"rhsgref_cdf_reg_grenadier_rpg",
	"rhsgref_cdf_reg_grenadier",
	"rhsgref_cdf_reg_rifleman"
];

baseEnemyDemoGroup_CDF_2020 = [
	"rhsgref_cdf_para_squadleader",
	"rhsgref_cdf_para_machinegunner",
	"rhsgref_cdf_para_machinegunner",
	"rhsgref_cdf_para_engineer",
	"rhsgref_cdf_para_rifleman",
	"rhsgref_cdf_para_rifleman"
];

baseEnemyMortarGroup_CDF_2020 = [
	"rhsgref_cdf_reg_M252",
	"rhsgref_cdf_para_marksman",
	"rhsgref_cdf_para_marksman"
];

baseEnemyVehicleGroup_CDF_2020 = [
	"rhsgref_BRDM2_HQ",
	"rhsgref_BRDM2UM",
	"rhsgref_cdf_zil131_flatbed_cover",
	"rhsgref_cdf_gaz66o",
	"rhsgref_cdf_reg_uaz",
	"rhsgref_cdf_reg_uaz_dshkm"
];

baseEnemyLightArmoredVehicleGroup_CDF_2020 = [
	"rhsgref_cdf_bmd1",
	"rhsgref_cdf_bmd2",
	"rhsgref_cdf_bmp2",
	"rhsgref_cdf_btr60",
	"rhsgref_cdf_btr80"
];

baseEnemyHeavyArmoredVehicleGroup_CDF_2020 = [
	"rhsgref_cdf_t80uk_tv",
	"rhsgref_cdf_t80u_tv",
	"rhsgref_cdf_t72ba_tv"
];

baseEnemyTurretGroup_CDF_2020 = [
	//Turrets 
	["rhsgref_cdf_SPG9", "SMALLBUNKER"],
	["rhsgref_cdf_DSHKM", "SMALLBUNKER"],
	["rhsgref_cdf_Igla_AA_pod", "NOTHING"],
	["RHSgref_cdf_ZU23", "NOTHING"]

];

baseEnemyUnarmedChopperGroup_CDF_2020 = [
	"rhsgref_cdf_reg_Mi8amt"
];

baseEnemyArmedChopperGroup_CDF_2020 = [
	"rhsgref_cdf_reg_Mi17Sh",
	"rhsgref_cdf_Mi35",
	"rhsgref_cdf_Mi24D"
];

baseFixedWingGroup_CDF_2020 = [
	"rhsgref_cdf_su25",
	"rhsgref_cdf_mig29s",
	"rhs_l39_cdf",
	"rhs_l159_CDF",
	"RHS_AN2"
];


////////////////////////
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_CDF_2020 = [
	"rhsgref_BRDM2UM",
	"rhsgref_cdf_zil131_flatbed_cover",
	"rhsgref_cdf_gaz66o",
	"rhsgref_cdf_reg_uaz"
];

bluforArmedVehicle_CDF_2020 = [
	"rhsgref_BRDM2_HQ",
	"rhsgref_cdf_reg_uaz_dshkm"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_CDF_2020 = [
	"rhsgref_cdf_t80uk_tv",
	"rhsgref_cdf_t80u_tv",
	"rhsgref_cdf_t72ba_tv",
	"rhsgref_cdf_bmd1",
	"rhsgref_cdf_bmd2",
	"rhsgref_cdf_bmp2"
];

bluforUnarmedVehicleChopper_CDF_2020 = [
	"rhsgref_cdf_reg_Mi8amt"
];

bluforArmedChopper_CDF_2020 = [
	"rhsgref_cdf_reg_Mi17Sh",
	"rhsgref_cdf_Mi35",
	"rhsgref_cdf_Mi24D"
];

bluforDrone_CDF_2020 = [

];

bluforBoat_CDF_2020 = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_CDF_2020 = [
	"rhsgref_cdf_su25",
	"rhsgref_cdf_mig29s",
	"rhs_l39_cdf",
	"rhs_l159_CDF",
	"RHS_AN2"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_CDF_2020 = [
	"rhsgref_BRDM2_HQ"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_CDF_2020 = [		
	[c_leader, "rhsgref_cdf_reg_squadleader", ["rhsgref_cdf_para_squadleader"], false],
	[c_at, "rhsgref_cdf_reg_grenadier_rpg", ["rhsgref_cdf_reg_specialist_aa","rhsgref_cdf_reg_rifleman_rpg75","rhsgref_cdf_para_grenadier_rpg","rhsgref_cdf_para_specialist_aa"], false],
	[c_rifleman, "rhsgref_cdf_reg_rifleman", ["rhsgref_cdf_reg_rifleman_akm","rhsgref_cdf_reg_rifleman_aks74","rhsgref_cdf_reg_rifleman_lite","rhsgref_cdf_para_rifleman","rhsgref_cdf_para_rifleman_lite","rhsgref_cdf_para_squadleader"], false],//Default stuff
	[c_engineer,"rhsgref_cdf_reg_engineer", ["rhsgref_cdf_para_engineer"], false],
	[c_autorifleman, "rhsgref_cdf_reg_arifleman_rpk", ["rhsgref_cdf_reg_machinegunner","rhsgref_cdf_para_autorifleman","rhsgref_cdf_para_machinegunner"], false],
	[c_marksman, "rhsgref_cdf_reg_marksman", ["rhsgref_cdf_para_marksman"], false],
	[c_medic,"rhsgref_cdf_reg_medic", ["rhsgref_cdf_para_medic"], false],
	[c_grenadier, "rhsgref_cdf_reg_grenadier", ["rhsgref_cdf_para_grenadier"], false],//Default stuff
	[c_pilot,"rhsgref_cdf_air_pilot", [], false]
];


////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_CDF_2020 = [		

];	

grenadeLauncherList_CDF_2020 = [		

];


launcherList_CDF_2020 = [		

];	

autorifleList_CDF_2020 = [			


];	

marksmanrifleList_CDF_2020 = [		

];


smgList_CDF_2020 = [		

];

//////////////////////////
attachmentShortList_CDF_2020	= [


];

attachmentLongList_CDF_2020	= [

];


////////////////////////
itemList_CDF_2020 = [
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

itemEngineerList_CDF_2020 = [
	"ACE_DeadManSwitch",
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_CDF_2020 = [

];

//backpack avalaible for all unit
backPackList_CDF_2020 = [

	"TFAR_anarc164"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_CDF_2020 = [

];


factionDefaultRadios_CDF_2020 = [
	"TFAR_anprc148jem"
];

//Magazine avalaible for all unit
magazineList_CDF_2020 = [

];