//basic items that will be included with all factions
//Include ACE items
basicItemsList = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"Binocular"
];

//ACE basic item
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	basicItemsList = basicItemsList +
	["ACE_MapTools",
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
	"ACE_RangeTable_82mm",
	"ACE_painkillers",
	"ACE_PlottingBoard",
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_RangeCard",
	"ACE_SpareBarrel",
	"ACE_artilleryTable",
	"ACE_Flashlight_MX991",
	"ACE_Kestrel4500",
	"ACE_Flashlight_KSF1",
	"ACE_Flashlight_XL50",
	"ace_flags_blue",
	"ace_marker_flags_red",
	"ace_flags_red",
	"ace_marker_flags_blue",
	"ACE_EHP",
	"ACE_Canteen",
	"ACE_Humanitarian_Ration",
	"ACE_bodyBag_white",
	"ACE_bodyBag_blue",
	"ACE_IR_Strobe_Item",
	"ACE_Chemlight_IR"
];
};



//basic medic items that will be included with all factions
//Include ACE items
basicMedicItems = [
	"Medikit"
];

//ACE Medic items
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	basicMedicItems = basicMedicItems +
	["ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture",
	"ACE_salineIV",
	"ACE_salineIV_500",
	"ACE_salineIV_250",
	"ACE_plasmaIV",
	"ACE_plasmaIV_500",
	"ACE_plasmaIV_250",
	"ACE_atropine",
	"ACE_adenosine",
	"ACE_bodyBag_blue",
	"ACE_bodyBag",
	"ACE_bodyBag_white"];
};


//basic engineer items that will be included with all factions
//Include ACE items
basicEngineerItems = [
	"SatchelCharge_Remote_Mag",
	"ToolKit",
	"MineDetector"
];

//ACE engineering items
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	basicEngineerItems = basicEngineerItems +
	["ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_Clacker",
	"ACE_M26_Clacker",
	"ace_marker_flags_white",
	"ace_marker_flags_yellow",
	"ace_marker_flags_purple",
	"ace_marker_flags_orange",
	"ace_marker_flags_red",
	"ACE_VMH3",
	"ACE_VMM3"];

};

//Radio basic items
basicDefaultRadio = [];

//Add TFAR Radio
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then 
{
	basicDefaultRadio = ["TFAR_anprc152"];
} else 
{
	basicDefaultRadio = ["ItemRadio"];
};

basicAmmunitions = [
	"HandGrenade",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellRed",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellYellow",
	"O_IR_Grenade",
	"Laserbatteries"
];

prestigeItem = [
	"H_EarProtectors_yellow_F",
	"H_Beret_gen_F",
	"H_Cap_Orange_IDAP_F",
	"H_WirelessEarpiece_F",
	"H_ParadeDressCap_01_US_F",
	"H_HeadBandage_bloody_F",
	"H_Cap_surfer",
	"H_Hat_blue",
	"H_Hat_brown",
	"H_Hat_Tinfoil_F"
];


// //2nd War
// case 0:

// //Cold War
// case 1:

// case 2
//Modern Warfare

// //Actual Warfare
// case 3:

// //Future Warfare
// case 4:
BMrifleList_db = [
	[0,["rhs_weap_MP44"]],
	[1,["sgun_HunterShotgun_01_F","srifle_DMR_06_hunter_F","rhs_weap_m1garand_sa43","rhs_weap_ak74_3","rhs_weap_m4a1_wd_mstock","rhs_weap_m4a1_d","rhs_weap_l1a1_wood","rhs_weap_m14_wd","rhs_weap_Izh18"]],
	[2,["sgun_Mp153_classic_F", "arifle_AUG_F","arifle_AUG_black_F","arifle_AUG_C_F","rhs_weap_SCARH_USA_STD","arifle_CTAR_hex_F","rhs_weap_vhsd2_ct15x","rhs_weap_m4a1_blockII_wd"]],
	[3,["KAR_XM7", "sgun_Mp153_classic_F","KAR_XM7_G"]],
	[4,["arifle_MSBS65_F"]]
];

BMsmgList_db = [
	[0,["rhs_weap_m3a1_specops"]],
	[1,["sgun_HunterShotgun_01_sawedoff_F","rhs_weap_scorpion","rhs_weap_pp2000"]],
	[2,["rhs_weap_pb_6p9","KA_PP19_MTK83","SMG_03C_black","SMG_03C_TR_black","SMG_03_TR_hex","SMG_01_F","sgun_Mp153_black_F","rhsusf_weap_MP7A2_winter","SMG_05_F","SMG_03C_khaki"]],
	[3,["KA_PP19", "hgun_Mk26_F", "hgun_Pistol_Signal_F"]],
	[4,[]]
];

BMsniperRifleList_db = [
	[0,["rhs_weap_kar98k"]],
	[1,["srifle_DMR_06_hunter_F","rhs_weap_m14_ris","rhs_weap_m14_ris_d","rhs_weap_mosin_sbr","rhs_weap_m38","rhs_weap_m24sws_wd","rhs_weap_m40a5_wd","rhs_weap_m38_rail","rhs_weap_svdp_wd"]],
	[2,["rhs_weap_SCARH_USA_LB","arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","arifle_SPAR_03_blk_F","rhs_weap_XM2010_sa","rhs_weap_sr25_ec_d","rhs_weap_sr25_wd"]],
	[3,["srifle_LRR_camo_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_05_tan_f","srifle_DMR_03_woodland_F"]],
	[4,["srifle_DMR_07_ghex_F","srifle_DMR_04_Tan_F"]]
];

BMautoRifleList_db = [
	[0,[]],
	[1,["rhs_weap_m240B","rhs_weap_m240G","rhs_weap_mg42"]],
	[2,["arifle_CTARS_blk_F"]],
	[3,["MMG_02_sand_F","LMG_03_snd_F"]],
	[4,["MMG_01_hex_F"]]
];

BMlauncherList_db = [
	[0,["rhs_weap_panzerfaust60"]],
	[1,["rhs_weap_m80","rhs_weap_rpg18"]],
	[2,["rhs_weap_m72a7","RPG29_Lorad"]],
	[3,["launch_MRAWS_black_F","FP_Atlas_Launch_Pzf3_F","rhs_weap_fgm148","Verba_9k333"]],
	[4,["launch_O_Vorona_brown_F"]]
];

BMgrenadeLauncherList_db = [
	[0,[]],
	[1,["KA_Model_733_M203","KA_M16A2_M203","rhs_weap_m79"]],
	[2,["rhs_weap_M320","rhs_weap_m32","rhs_weap_vhsd2_bg_ct15x","arifle_CTAR_GL_ghex_F"]],
	[3,[]],
	[4,[]]
];

BMshortAccessoriesList_db = [
	[0,[]],
	[1,["acc_flashlight","rhsusf_acc_M952V"]],
	[2,["optic_Yorris","KA_M2_Scope","rhsusf_acc_RM05","muzzle_snds_B","rhs_acc_perst1ik","ACE_muzzle_mzls_B","rhsusf_acc_anpeq15side","rhsusf_acc_anpeq15_wmx","rhsusf_acc_anpeq15_bk","rhsusf_acc_eotech_552_wd","rhsusf_acc_SFMB556","rhsusf_acc_nt4_black","rhsusf_acc_tacsac_blue","rhsusf_acc_grip2_tan","rhs_acc_tgpv","rhsusf_acc_ACOG_wd","rhsusf_acc_ACOG_d","rhsusf_acc_RX01_tan","rhsusf_acc_eotech_552_d","optic_Holosight_lush_F","rhsusf_acc_grip3_tan"]],
	[3,["optic_Arco_ghex_F","optic_Arco_lush_F","optic_ERCO_snd_F","rhsusf_acc_su230a_mrds","optic_Hamr_khk_F","rhsusf_acc_g33_T1","rhsusf_acc_mrds_c","rhsusf_acc_ACOG_RMR","rhsgref_acc_RX01_NoFilter_camo","optic_Arco_ghex_F"]],
	[4,["optic_tws_mg"]]
];

BMlongAccessoriesList_db = [
	[0,[]],
	[1,[]],
	[2,["rhsusf_acc_LEUPOLDMK4_2_d","bipod_02_F_blk","bipod_01_F_blk","bipod_02_F_blk","rhs_acc_tgpv"]],
	[3,["optic_DMS","rhsusf_acc_anpvs27","optic_KHS_blk","optic_KHS_tan","optic_KHS_hex","optic_LRPS_ghex_F","optic_Nightstalker","optic_AMS_snd","optic_LRPS_tna_F"]],
	[4,["optic_NVS"]]
];