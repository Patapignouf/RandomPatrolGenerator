#include "..\classConstant.sqf"

//Add specific UNSUNG factions
if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	factionInfos pushBack ["_ColdWar_USA", 10,"Cold War USA [UNSUNG]", true, true, false];
};

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

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//newFaction
//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_ColdWar_USA = ["uns_men_USMC_65_PL", 
"uns_men_USMC_65_SL", 
"uns_men_USMC_65_MED", 
"uns_men_USMC_65_RTO", 
"uns_men_USMC_65_ENG", 
"uns_men_USMC_65_HMG", 
"uns_men_USMC_65_MRK", 
"uns_men_USMC_68_AT"];

//Basic anti tank enemy group | 5 men (Leader, MG, AT)
baseEnemyATGroup_ColdWar_USA = ["uns_men_USMC_65_RF2", 
"uns_men_USMC_65_HMG", 
"uns_men_USMC_65_MED", 
"uns_men_USMC_65_RTO", 
"uns_men_USMC_65_TRI", 
"uns_men_USMC_65_MTSG", 
"uns_men_USMC_65_GL", 
"uns_men_USMC_65_RF4", 
"uns_men_USMC_65_MRK", 
"uns_men_USMC_65_AHMG", 
"uns_men_USMC_65_SCT", 
"uns_men_USMC_65_ENG"];

//Basic demolition enemy group | 8 men (Leader, Explosive)
baseEnemyDemoGroup_ColdWar_USA = ["uns_men_ROK_BD68_COM", 
"uns_men_ROK_BD68_RTO", 
"uns_men_ROK_BD68_RF5", 
"uns_men_ROK_BD68_HMG", 
"uns_men_ROK_BD68_AHMG", 
"uns_men_ROK_BD68_RF1", 
"uns_men_ROK_BD68_GL", 
"uns_men_ROK_BD68_AT", 
"uns_men_ROK_BD68_MRK", 
"uns_men_ROK_BD68_ENG"];

//Basic Mortar enemy group | 8 men (Mortar, Rifleman)
baseEnemyMortarGroup_ColdWar_USA = ["uns_M1_81mm_mortar",
"uns_men_ROK_BD68_RF1", 
"uns_men_ROK_BD68_GL"];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_ColdWar_USA = ["uns_willysmg50", 
"uns_xm706e2"];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_ColdWar_USA = ["uns_xm706e1","uns_M113_30cal", 
"uns_m48a3"];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_ColdWar_USA = ["uns_m48a3"];

//Basic enemy chopper avalaible
baseEnemyUnarmedChopperGroup_ColdWar_USA = ["UNS_AH1G", 
"uns_UH1H_m60"];

//Basic enemy aircraft avalaible
baseFixedWingGroup_ColdWar_USA = ["uns_F4B_AGM"];

////////////////////////
//Vehicle management////
////////////////////////
//newFaction
bluforUnarmedVehicle_ColdWar_USA = ["uns_willys_2", 
"uns_m37b1", 
"uns_M35A2", 
"uns_willys_2_usmc"];

bluforArmedVehicle_ColdWar_USA = ["uns_willysmg50", 
"uns_xm706e2"];

bluforUnarmedVehicleChopper_ColdWar_USA = [
	"uns_ch47_m60_usmc", 
	"uns_ch53d_m2_usmc", 
	"uns_UH1D_USMC_m60_light", 
	"uns_H13_transport_Army", 
	"uns_ch34_army", 
	"uns_h21c",
	"uns_oh6_transport"
];

bluforArmedChopper_ColdWar_USA = [
	"uns_H13_gunship_Army",
	"uns_H13_gunship_CAV",
	"uns_UH1C_M6_M200_M134",
	"UNS_AH1G",
	"uns_oh6_m27r"
];

bluforArmoredVehicle_ColdWar_USA = [
	"uns_xm706e1",
	"uns_M113_30cal", 
	"uns_m48a3",
	"uns_M113_transport"
];

bluforBoat_ColdWar_USA = [
	"uns_PBR_M10", 
	"UNS_Zodiac_W"
];

bluforFixedWing_ColdWar_USA = [
	"uns_F4B_AGM",
	"uns_f8e_USMC_BMB",
	"uns_A1J_CAS",
	"uns_A7_CAS",
	"uns_C130_H",
	"uns_a37_bmb"
];

bluforHQVehicle_ColdWar_USA = 
[
	"uns_willys_2_m60",
	"uns_M113_transport"
];

////////////////////////
//Loadout management////
////////////////////////

//newFaction
loadout_ColdWar_USA = [		
	[c_leader,"uns_men_USMC_68_PL"],
	[c_at,"uns_men_USMC_68_AT"],
	[c_rifleman,"uns_men_USMC_68_SL"],//Default stuff
	[c_engineer,"uns_men_USMC_68_ENG"],
	[c_grenadier,"uns_men_USMC_68_GL"],
	[c_autorifleman,"uns_men_USMC_68_HMG"],
	[c_marksman,"uns_men_USMC_68_MRK"],
	[c_medic,"uns_men_USMC_68_MED"],
	[c_pilot,"uns_pilot12"]
];


////////////////////////
///Weapon management////
////////////////////////
//newFaction
rifleList_ColdWar_USA = [		
	"uns_m16",
	"uns_MX991_g",
	"uns_m14",
	"uns_m3a1",
	"uns_m1garand",
	"uns_m1carbine_pouch",
	"uns_m2carbine"
];	

grenadeLauncherList = 
[
	"uns_m16a1_m203",
	"uns_m79",
	"uns_m16a1_xm148"
];


launcherList_ColdWar_USA = [		
	"uns_m72",
	"uns_m1a1_bazooka"
];	

autorifleList_ColdWar_USA = [			
	"uns_m60",
	"uns_m60shorty",
	"uns_m60support",
	"uns_m60grip",
	"uns_M16A1_HBAR"
];	

marksmanrifleList_ColdWar_USA = [		
	"uns_M21",
	"uns_model70",
	"uns_m3carbine"
];

smgList_ColdWar_USA = [		
	"uns_ithaca37",
	"uns_m1897"
];

//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_ColdWar_USA	= [
	"uns_b_m7"
];

attachmentLongList_ColdWar_USA	= [
	"uns_o_Unertl8x_m70",
	"uns_o_LeatherwoodART_m14",
	"uns_m1carbinemag_T"
];

////////////////////////
////Items management////
////////////////////////
backPackList_ColdWar_USA = [
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
	"uns_simc_USMCFLAK_M41_flat"
];

uniformList_ColdWar_USA = [
	"UNS_USMC_BDU_65",
	"UNS_USMC_BDU_65_S",
	"UNS_USMC_BDU_65_F",
	"UNS_USMC_BDU",
	"UNS_USMC_Flak_S",
	"UNS_USMC_BDU_S",
	"UNS_USMC_BDU_F",
	"uns_simc_m1_bitch_b7",
	"uns_simc_MC_M1_bitch_b9",
	"uns_simc_USMCFLAK_M68_flat_roll",
	"uns_simc_MC_M1_muggen",
	"uns_simc_MC_M1C_bitch_b8",
	"uns_simc_MC_M1C_bitch_b7",
	"uns_simc_MC_M1C_bitch_b6",
	"uns_simc_MC_M1C_bitch_b5",
	"uns_simc_MC_M1C_bitch_b4",
	"uns_simc_MC_M1C_bitch_b3",
	"uns_simc_MC_M1C_bitch_b2"
];

magazineList_ColdWar_USA = [
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