#include "..\classConstant.sqf"

//Add specific UNSUNG factions
if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	factionInfos pushBack ["_ColdWar_USA_SF",36,"Cold War USA Special forces [UNSUNG]", true, true, false];
};

////////////////////////
//Vehicle management////
////////////////////////
//newFaction
bluforUnarmedVehicle_ColdWar_USA_SF = [
	"uns_willys_2_usmc"
];

bluforArmedVehicle_ColdWar_USA_SF = [
	"uns_willys_2_m60",
	"uns_willys_2_m1919"
];

bluforUnarmedVehicleChopper_ColdWar_USA_SF = [
	"uns_ch47_m60_usmc", 
	"uns_ch53d_m2_usmc", 
	"uns_UH1D_USMC_m60_light", 
	"uns_H13_transport_Army", 
	"uns_ch34_army", 
	"uns_h21c"
];

bluforArmoredVehicle_ColdWar_USA_SF = [
	"uns_xm706e1",
	"uns_xm706e2"
];

bluforBoat_ColdWar_USA_SF = [
	"uns_PBR_M10", 
	"UNS_Zodiac_W"
];

bluforFixedWing_ColdWar_USA_SF = [
	"uns_F4B_AGM",
	"uns_f8e_USMC_BMB"
];

bluforHQVehicle_ColdWar_USA_SF = 
[
	"uns_m37b1",
	"uns_UH1D_USMC_m60_light",
	"uns_ch46d"
];

////////////////////////
//Loadout management////
////////////////////////

//newFaction
loadout_ColdWar_USA_SF = [		
	[c_leader,"uns_men_US_6SFG_COM"],
	[c_at,"uns_men_US_6SFG_AT"],
	[c_rifleman,"uns_men_US_6SFG_SP8"],//Default stuff
	[c_engineer,"uns_men_US_6SFG_SAP"],
	[c_grenadier,"uns_men_US_6SFG_GL4"],
	[c_autorifleman,"uns_men_US_6SFG_HMG"],
	[c_marksman,"uns_men_US_6SFG_MRK2"],
	[c_medic,"uns_men_US_6SFG_MED"],
	[c_pilot,"uns_pilot11"]
];

////////////////////////
///Weapon management////
////////////////////////
//newFaction
rifleList_ColdWar_USA_SF = [		
	"uns_m16",
	"uns_MX991_g",
	"uns_m14",
	"uns_m3a1",
	"uns_xm177e2_stock",
	"uns_m1911",
	"uns_m870",
	"uns_l1a1",
	"uns_Ruger",
	"uns_M16A1",
	"uns_m1garand",
	"uns_m1carbine_pouch",
	"uns_m2carbine"
];	

grenadeLauncherList = 
[
	"uns_m16a1_m203",
	"uns_m16a1_xm148",
	"uns_m79",
	"uns_l1a1gl",
	"uns_ex41",
	"uns_coltcmdr"
];

launcherList_ColdWar_USA_SF = [		
	"uns_m72",
	"uns_m1a1_bazooka"
];	

autorifleList_ColdWar_USA_SF = [			
	"uns_m60",
	"uns_m60shorty",
	"uns_m60support",
	"uns_m60grip",
	"uns_M16A1_HBAR"
];	

marksmanrifleList_ColdWar_USA_SF = [		
	"uns_M21",
	"uns_model70_iron",
	"uns_m3carbine",
	"uns_M40_base",
	"uns_M16A1mk_sd",
	"uns_m1carbine_pouch"
];


smgList_ColdWar_USA_SF = [		
	"uns_ithaca37",
	"uns_m1897",
	"uns_uzi",
	"uns_m3a1",
	"uns_thompson",
	"uns_m2carbine_shorty",
	"uns_m50",
	"uns_m50f"
];

//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_ColdWar_USA_SF	= [
	"uns_b_m7"
];

attachmentLongList_ColdWar_USA_SF	= [
	"uns_o_Unertl8x_m70",
	"uns_o_LeatherwoodART_m14",
	"uns_m1carbinemag_T",
	"uns_o_RedfieldART",
	"uns_o_colt4x",
	"uns_s_M16",
	"uns_o_M84"
];

////////////////////////
////Items management////
////////////////////////
backPackList_ColdWar_USA_SF = [
	"uns_simc_MC_rajio_base",
	"uns_simc_pack_frem_1",
	"uns_simc_pack_frem_2",
	"uns_simc_pack_frem_3",
	"uns_simc_pack_frem_4",
	"uns_simc_pack_frem_5",
	"uns_simc_pack_frem_6",
	"uns_simc_pack_frem_7",
	"uns_simc_pack_frem_8",
	"uns_simc_pack_frem_9",
	"uns_simc_US_asspack",
	"uns_simc_MC_rajio_flak_base",
	"uns_simc_USMCFLAK_M41_M43_roll",
	"uns_simc_USMCFLAK_M41_flat",
	"uns_men_US_6SFG_SP8_Bag"
];

uniformList_ColdWar_USA_SF = [
	"UNS_USMC_BDU_65",
	"UNS_USMC_BDU_65_S",
	"UNS_USMC_BDU_65_F",
	"UNS_USMC_BDU",
	"UNS_USMC_BDU_S",
	"UNS_USMC_BDU_F",

	//SF part
	"UNS_TIGER_BDU",
	"UNS_TIGER4_BDU",
	"UNS_TIGER3_BDU",
	"UNS_TIGER2_BDU",
	"UNS_Boonie_TIG",
	"UNS_Boonie_TIGF",
	"UNS_Scarf_OD",
	"UNS_Bandana_OD2",
	"UNS_Headband_OD2",
	"UNS_Towel",
	"uns_simc_pack_trop_6"
];

magazineList_ColdWar_USA_SF = [
	"uns_20Rnd_556x45_Stanag_T",
	"uns_40mm_mkv_Red",
	"uns_40mm_red",
	"uns_40mm_mkv_Yellow",
	"uns_40mm_yellow",
	"uns_40mm_mkv_Green",
	"uns_12gaugemag_6",
	"1Rnd_HE_Grenade_shell",
	"uns_40mm_white"
];