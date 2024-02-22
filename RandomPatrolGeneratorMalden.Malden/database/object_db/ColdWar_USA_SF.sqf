#include "..\classConstant.sqf"

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//newFaction
civilian_group_USA_2000 = ["C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F"];

civilian_big_group_USA_2000 = ["C_Man_1_enoch_F", 
"C_Man_2_enoch_F", 
"C_Man_3_enoch_F", 
"C_Man_4_enoch_F", 
"C_Man_5_enoch_F", 
"C_Man_6_enoch_F", 
"C_Farmer_01_enoch_F" ];

civilianTruck_USA_2000 = ["CUP_C_Octavia_CIV", 
"C_Offroad_01_comms_F", 
"C_Hatchback_01_sport_F"];

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
listOfRoles_ColdWar_USA_SF = [c_leader,c_at,c_rifleman,c_engineer,c_grenadier,c_autorifleman,c_marksman,c_medic,c_pilot];

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
	"uns_M16A1"
];	

grenadeLauncherList = 
[
	"uns_m16a1_m203",
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
	"uns_m60grip"
];	

marksmanrifleList_ColdWar_USA_SF = [		
	"uns_M21",
	"uns_model70_iron",
	"uns_m3carbine",
	"uns_M40_base",
	"uns_M16A1mk_sd"
];

smgList_ColdWar_USA_SF = [		
	"uns_ithaca37",
	"uns_m1897",
	"uns_uzi",
	"uns_m3a1",
	"uns_thompson"
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
	"uns_s_M16"
];

////////////////////////
////Items management////
////////////////////////
itemList_ColdWar_USA_SF = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"Binocular",
	"ACE_MapTools",
	"ACE_SpraypaintRed",
	"ACE_CableTie",
	"ACE_WaterBottle",
	"ACE_EarPlugs",
	"ACE_fieldDressing",
	"ACE_packingBandage",
	"ACE_elasticBandage",
	"ACE_tourniquet",
	"ACE_splint",
	"ACE_morphine",
	"ACE_quikclot",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm"
	];

itemEngineerList_ColdWar_USA_SF = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_Clacker",
	"ACE_M26_Clacker",
	"ace_marker_flags_white",
	"ace_marker_flags_yellow",
	"ace_marker_flags_purple",
	"ace_marker_flags_orange",
	"ace_marker_flags_red"
	];
	
itemMedicList_ColdWar_USA_SF = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
	];

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
	"uns_40mm_white",
	"HandGrenade",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow"
	];