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
	"ACE_bodyBag_white",
	"ACE_bodyBag_blue",
	"ACE_IR_Strobe_Item",
	"ACE_Chemlight_IR",
	"ACE_ChalkBlack",
	"ACE_ChalkBlue",
	"ACE_ChalkGreen",
	"ACE_ChalkRed",
	"ACE_ChalkWhite",
	"ACE_ChalkYellow",
	"ACE_SpraypaintWhite",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintYellow",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintRed",
	"ACE_SpraypaintGreen",
	"ACE_MRE_ChickenHerbDumplings",
	"ACE_MRE_MeatballsPasta",
	"ACE_MRE_ChickenTikkaMasala",
	"ACE_MRE_BeefStew",
	"ACE_MRE_CreamChickenSoup",
	"ACE_MRE_CreamTomatoSoup",
	"ACE_MRE_SteakVegetables",
	"ACE_Humanitarian_Ration",
	"ACE_Can_Spirit",
	"ACE_Can_RedGull",
	"ACE_Can_Franta",
	"ACE_Canteen"
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
	"ace_flags_white",
	"ace_flags_blue",
	"ace_flags_yellow",
	"ace_flags_black",
	"ace_flags_orange",
	"ace_flags_red",
	"ace_flags_green",
	"ace_flags_purple",
	"ace_marker_flags_white",
	"ace_marker_flags_blue",
	"ace_marker_flags_yellow",
	"ace_marker_flags_black",
	"ace_marker_flags_orange",
	"ace_marker_flags_red",
	"ace_marker_flags_green",
	"ace_marker_flags_purple",
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

//Add Handflare from aegis
if (isClass (configFile >> "CfgPatches" >> "A3_Aegis_UI_F_Aegis")) then 
{
basicAmmunitions = basicAmmunitions + [
		"Aegis_HandFlare_Red",
		"Aegis_HandFlare_Green",
		"Aegis_SignalFlare_Green",
		"Aegis_SignalFlare_Red"
	];
};



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



//Black market database
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
	[1,["sgun_HunterShotgun_01_F","srifle_DMR_06_hunter_F","rhs_weap_m1garand_sa43","rhs_weap_ak74_3","rhs_weap_m4a1_wd_mstock","rhs_weap_m4a1_d","rhs_weap_l1a1_wood","rhs_weap_m14_wd","rhs_weap_Izh18", "hlc_rifle_C2A1", "hlc_wp_mod723", "hlc_wp_mod723_delta", "hlc_rifle_FAL5000", "hlc_rifle_FAL5061", "hlc_rifle_SLRchopmod", "hlc_wp_m16A2_Early", "hlc_wp_XM16E1", "hlc_wp_XM177E1", "hlc_wp_XM177E2", "hlc_rifle_g3a3", "hlc_rifle_g3a3v"]],
	[2,["sgun_Mp153_classic_F", "arifle_AUG_F","arifle_AUG_black_F","arifle_AUG_C_F","rhs_weap_SCARH_USA_STD","arifle_CTAR_hex_F","rhs_weap_vhsd2_ct15x","rhs_weap_m4a1_blockII_wd","rhs_weap_hk416d145_d_2","AK74M_B30_B31C_CTR_RVG_camoB","AK105_B30_B31C_CTR_RVG_camoB","rhs_weap_m4a1_blockII_d","rhs_weap_mk18_wd","bcb_weap_ak104_zenitco01_tan", "hlc_rifle_honeybase", "hlc_rifle_vendimus", "hlc_rifle_RU5562", "hlc_rifle_RU556", "hlc_rifle_slr107u", "hlc_rifle_bcmblackjack", "hlc_rifle_bcmjack", "hlc_rifle_Bushmaster300", "hlc_rifle_c1A1", "hlc_rifle_M4", "hlc_rifle_M4a1carryhandle", "hlc_rifle_falosw", "hlc_WP_SCARH_CQC", "hlc_wp_SCARH_CQC_Blk", "hlc_wp_SCARH_CQC_camo", "hlc_wp_SCARH_CQC_SRX", "hlc_wp_SCARH_CQC_SRX_Blk", "hlc_wp_SCARH_CQC_SRX_camo", "hlc_rifle_g3sg1", "hlc_rifle_G36MLIC", "hlc_rifle_ACR68_Carb_black", "hlc_rifle_ACR68_Carb_tan", "hlc_rifle_ACR68_SBR_black", "hlc_rifle_ACR68_full_tan", "hlc_rifle_ACR68_aron", "hlc_wp_SCARL_STD_300AAC_SRX_muddy", "hlc_rifle_416D10_geissele", "hlc_rifle_ak74", "hlc_rifle_ak74_dirty", "hlc_rifle_akm", "hlc_rifle_aks74_MTK", "hlc_rifle_aek971", "hlc_rifle_mk18mod0", "hlc_rifle_SG550_TAC", "hlc_rifle_SG551LB_RIS", "hlc_rifle_SG551SB_TAC", "hlc_rifle_SG553LB_TAC", "hlc_rifle_augsr_b", "hlc_rifle_aug", "hlc_rifle_auga1carb_B", "hlc_rifle_augpara", "hlc_rifle_auga2_b", "hlc_rifle_auga2carb", "hlc_rifle_auga3_b", "hlc_rifle_auga3", "hlc_rifle_STG58F", "hlc_rifle_RK62", "HLC_rifle_XM8_Carbine", "HLC_rifle_XM8_Proto_Carbine_Green", "HLC_rifle_XM8_Proto_Compact_Green", "HLC_rifle_XM8_Compact_Tan", "hlc_rifle_XM8_MWSF_Compact", "HLC_Rifle_XM8_MWSF_Compact_Green", "hlc_rifle_416D165_tan", "hlc_rifle_416D145C", "hlc_rifle_416D145_tan", "hlc_rifle_416D10_tan", "hlc_rifle_g3ka4", "hlc_wp_SCAR_PDW", "hlc_wp_SCAR_PDW_Blk", "hlc_wp_SCARL_STD_SRX_Blk", "hlc_wp_SCARL_STD_300AAC_SRX_Blk", "hlc_rifle_M27IAR"]],
	[3,["KAR_XM7", "KAR_XM7_G", "Aegis_arifle_AK74_gold_F", "hlc_rifle_g3sg1ris", "hlc_rifle_BAB"]],
	[4,["arifle_MSBS65_F", "arifle_NCAR15_F"]]
];

BMsmgList_db = [
	[0,["rhs_weap_m3a1_specops", "hlc_pistol_C96_Wartime", "hlc_pistol_C96_Prussian"]],
	[1,["sgun_HunterShotgun_01_sawedoff_F","rhs_weap_scorpion","rhs_weap_pp2000", "hlc_wp_C7", "hlc_smg_mp5sd5", "hlc_smg_mp5N_tac", "hlc_smg_mp5a4", "hlc_smg_mp510", "hlc_smg_mp5k", "hlc_Pistol_M11"]],
	[2,["rhs_weap_pb_6p9","KA_PP19_MTK83","SMG_03C_black","SMG_03C_TR_black","SMG_03_TR_hex","SMG_01_F","sgun_Mp153_black_F","rhsusf_weap_MP7A2_winter","SMG_05_F","SMG_03C_khaki","SMG_03_camo","SMG_02_F", "rhs_weap_cz99_etched", "hlc_rifle_CQBR", "hlc_mp510_tac", "hlc_pistol_P239_40", "hlc_pistol_P229R_Elite", "hlc_pistol_P226R_40Combat", "hlc_pistol_Mk25D", "hlc_pistol_Mk25TR"]],
	[3,["KA_PP19", "hgun_Mk26_F", "hgun_Pistol_Signal_F", "hlc_rifle_hk51"]],
	[4,[]]
];

BMsniperRifleList_db = [
	[0,["rhs_weap_kar98k", "hlc_rifle_M1903A1", "hlc_rifle_M1903A1_unertl"]],
	[1,["srifle_DMR_06_hunter_F","rhs_weap_m14_ris","rhs_weap_m14_ris_d","rhs_weap_mosin_sbr","rhs_weap_m38","rhs_weap_m24sws_wd","rhs_weap_m40a5_wd","rhs_weap_m38_rail","rhs_weap_svdp_wd", "hlc_rifle_psg1"]],
	[2,["rhs_weap_SCARH_USA_LB","arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","arifle_SPAR_03_blk_F","rhs_weap_XM2010_sa","rhs_weap_sr25_ec_d","rhs_weap_sr25_wd", "hlc_rifle_FN3011Modern", "hlc_rifle_M14", "hlc_rifle_M14_Bipod_Rail", "hlc_rifle_M14dmr_Rail", "hlc_rifle_M21", "hlc_rifle_M21_Rail", "hlc_rifle_aughbar", "hlc_rifle_m14sopmod"]],
	[3,["srifle_LRR_camo_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_05_tan_f","srifle_DMR_03_woodland_F", "hlc_rifle_FN3011Tactical_green", "hlc_rifle_FN3011_WDL", "hlc_rifle_FN3011Lynx", "hlc_rifle_SAMR", "hlc_rifle_awMagnum_FDE_ghillie", "hlc_rifle_awcovert", "hlc_WP_SSR", "hlc_wp_SSR_Blk", "hlc_rifle_XM8_DMAR", "hlc_rifle_XM8_Proto_DMAR", "hlc_rifle_XM8_MWSF_DMAR", "hlc_rifle_FN3011Modern_camo", "hlc_rifle_awcovert_BL", "hlc_rifle_awcovert", "hlc_rifle_M1903A1OMR", "hlc_rifle_416D20", "hlc_rifle_416D20_tan"]],
	[4,["srifle_DMR_07_ghex_F","srifle_DMR_04_Tan_F"]]
];

BMautoRifleList_db = [
	[0,[]],
	[1,["rhs_weap_m240B","rhs_weap_m240G","rhs_weap_mg42", "hlc_rifle_M1941LMG"]],
	[2,["arifle_CTARS_blk_F", "hlc_lmg_m60", "hlc_lmg_M60E4", "hlc_rifle_rpk"]],
	[3,["MMG_02_sand_F","LMG_03_snd_F", "hlc_lmg_minimi", "hlc_lmg_minimi_railed", "hlc_lmg_minimipara_long_railed", "HLC_wp_M134Painless", "hlc_lmg_MG3_optic", "hlc_lmg_MG3KWS_b", "hlc_lmg_MG42KWS_t", "hlc_rifle_L4A3", "hlc_rifle_RPK12"]],
	[4,["MMG_01_hex_F", "Atlas_LMG_Negev_black_F", "arifle_NCAR15_MG_F"]]
];

BMlauncherList_db = [
	[0,["rhs_weap_panzerfaust60"]],
	[1,["rhs_weap_m80","rhs_weap_rpg18"]],
	[2,["rhs_weap_m72a7","RPG29_Lorad", "hlc_smg_9mmar"]],
	[3,["launch_MRAWS_black_F","FP_Atlas_Launch_Pzf3_F","rhs_weap_fgm148","Verba_9k333"]],
	[4,["launch_O_Vorona_brown_F"]]
];

BMgrenadeLauncherList_db = [
	[0,[]],
	[1,["KA_Model_733_M203","KA_M16A2_M203","rhs_weap_m79", "hlc_rifle_aks74_GL", "hlc_rifle_ak74m_gl"]],
	[2,["rhs_weap_M320","rhs_weap_m32","rhs_weap_vhsd2_bg_ct15x","arifle_CTAR_GL_ghex_F", "hlc_wp_mod727_M203", "hlc_rifle_m4m203", "hlc_wp_C8_M203", "hlc_rifle_osw_GL", "hlc_wp_SCARH_cqc_EGLM", "hlc_wp_SCARH_CQC_EGLM_Blk", "hlc_wp_SCARH_CQC_EGLM_camo", "hlc_rifle_m203"]],
	[3,["hlc_rifle_G36MLIAG36", "hlc_rifle_G36E1AG36_Romi", "hlc_rifle_G36E1AG36", "hlc_rifle_hk33a2RIS_GL", "hlc_rifle_416D10_gl", "hlc_rifle_416D145_gl", "hlc_rifle_416D165_gl", "hlc_wp_MK17IUR_556_AGC", "hlc_wp_MK17IUR_556_AGC_camo", "hlc_rifle_ACR68_GL_SBR_black", "hlc_rifle_ACR68_GL_Carb_tan", "hlc_rifle_ACR68_GL_mid_black", "hlc_rifle_auga3_GL_B", "hlc_rifle_auga3_GL_BL", "HLC_rifle_XM8_Carbine_GL_OD", "HLC_Rifle_XM8_MWSF_Carbine_GL_Green", "hlc_rifle_ACR68_GL_Carb_black", "HLC_Rifle_g3ka4_GL", "hlc_wp_SCARL_STD_EGLM", "hlc_rifle_G36VAG36"]],
	[4,[]]
];

BMshortAccessoriesList_db = [
	[0,[]],
	[1,["acc_flashlight","rhsusf_acc_M952V"]],
	[2,["optic_Yorris","KA_M2_Scope","rhsusf_acc_RM05","muzzle_snds_B","rhs_acc_perst1ik","ACE_muzzle_mzls_B","rhsusf_acc_anpeq15side","rhsusf_acc_anpeq15_wmx","rhsusf_acc_anpeq15_bk","rhsusf_acc_eotech_552_wd","rhsusf_acc_SFMB556","rhsusf_acc_nt4_black","rhsusf_acc_tacsac_blue","rhsusf_acc_grip2_tan","rhs_acc_tgpv","rhsusf_acc_ACOG_wd","rhsusf_acc_ACOG_d","rhsusf_acc_RX01_tan","rhsusf_acc_eotech_552_d","optic_Holosight_lush_F","rhsusf_acc_grip3_tan", "optic_MRD", "optic_MRD_black", "HLC_optic_Aimpoint5000_Sunshade", "hlc_acc_SF660_Barrel"]],
	[3,["optic_Arco_ghex_F","optic_Arco_lush_F","optic_ERCO_snd_F","rhsusf_acc_su230a_mrds","optic_Hamr_khk_F","rhsusf_acc_g33_T1","rhsusf_acc_mrds_c","rhsusf_acc_ACOG_RMR","rhsgref_acc_RX01_NoFilter_camo","optic_Arco_ghex_F", "HLC_Optic_ZFSG1", "HLC_optic_DocterR", "hlc_optic_HensoldtZO_Lo", "hlc_optic_HensoldtZO_lo_Docter", "hlc_optic_HensoldtZO_Hi_Docter", "HLC_optic_Aimpoint5000", "HLC_Optic_G36Dualoptic15x2d", "HLC_Panel_Side_MP5TAC_2xXTME_Black", "HLC_Panel_Side_MP5TAC_FN10cm_RG", "hlc_acc_TLR1_Side", "hlc_acc_SF660", "HLC_Panel_Side_MP5TAC_MagpulXT_Pride", "HLC_Panel_Side_MP5TAC_Ladder_S_Pride", "HLC_Panel_Side_416_4xXTME_Desert", "hlc_muzzle_556NATO_rotexiiic_tan", "hlc_muzzle_KX3_comp", "hlc_grip_PMVFG_Black", "hlc_grip_AFG2", "HLC_bipod_UTGShooters", "HLC_optic_ISM_PCAP", "HLC_optic_RCO_PCAP", "hlc_optic_kobra", "HLC_Optic_1p29", "hlc_optic_HensoldtZO_Lo_2D", "hlc_optic_HensoldtZO_Lo", "HLC_Optic228_Docter_CADEX", "HLC_Optic228_Romeo1_RX", "hlc_acc_DBALPL_FL", "hlc_acc_TLR1", "HLC_Panel_Side_416_Ladder_L_Desert"]],
	[4,["optic_tws_mg"]]
];

BMlongAccessoriesList_db = [
	[0,[]],
	[1,[]],
	[2,["rhsusf_acc_LEUPOLDMK4_2_d","bipod_02_F_blk","bipod_01_F_blk","bipod_02_F_blk","rhs_acc_tgpv"]],
	[3,["optic_DMS","rhsusf_acc_anpvs27","optic_KHS_blk","optic_KHS_tan","optic_KHS_hex","optic_LRPS_ghex_F","optic_Nightstalker","optic_AMS_snd","optic_LRPS_tna_F", "hlc_rifle_M21", "hlc_optic_ATACR", "hlc_optic_ATACR_Offset"]],
	[4,["optic_NVS"]]
];