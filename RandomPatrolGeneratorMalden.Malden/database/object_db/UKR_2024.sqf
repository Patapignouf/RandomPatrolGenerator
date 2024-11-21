#include "..\classConstant.sqf"

//Specific faction to Ukrainian with some French stuff from AMF 

//Add specific RHS factions
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	factionInfos pushBack ["_UKR_2024", factionID,"2024 Ukrainian [RHS]", true, false, false];
};


////////////////////////
//Vehicle management////
////////////////////////
//UKR
bluforUnarmedVehicle_UKR_2024 = [
	//RHS RU
	"rhs_gaz66_vdv",
	"rhs_kamaz5350_vdv",
	"RHS_Ural_Open_VDV_01",
	"rhs_tigr_vdv",
	"rhs_tigr_3camo_vdv",
	"rhs_uaz_vdv",
	"rhs_uaz_open_vdv",
	"rhs_tigr_m_vdv",

	//Add USA Stuff 
	"rhsusf_m1151_usarmy_d", 
	"rhsusf_m998_d_2dr_fulltop",
	"rhsusf_M1078A1P2_B_D_flatbed_fmtv_usarmy", 
	"rhsusf_M977A4_BKIT_usarmy_d"
];

//Add french stuff
if (isClass (configFile >> "CfgPatches" >> "AMF_Patches")) then 
{
	bluforUnarmedVehicle_UKR_2024 = bluforUnarmedVehicle_UKR_2024 + 
	[
		"B_AMF_VAB_ULTIMA_X8_F",
		"AMF_GBC180_PERS_01",
		"B_AMF_VAB_ULTIMA_X8_TDF_F"
	];
};

bluforArmedVehicle_UKR_2024 = [
	"rhs_tigr_sts_3camo_vdv",
	"rhs_tigr_sts_vdv",

	//Add USA stuff 
	"rhsusf_m1025_d_m2", 
	"rhsusf_m1151_m2crows_usarmy_d", 
	"rhsusf_m1151_m240_v1_usarmy_d", 
	"rhsusf_m1151_m240_v2_usarmy_d"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_UKR_2024 = [
	"rhs_bmd1",
	"rhs_bmp1_vv", 
	"rhs_prp3_vv", 
	"rhs_bmp2d_vv",
	"rhs_bmp3mera_msv",
	"rhs_bmp3mera_msv", 
	"rhs_t80", 
	"rhs_t90_tv", 
	"rhs_t72be_tv", 
	"rhs_t72ba_tv",

	//Add USA stuff 
	"RHS_M2A3", 
	"RHS_M2A2", 
	"RHS_M6", 
	"rhsusf_stryker_m1126_m2_d",
	"rhsusf_m1a1aimd_usarmy",
	"rhsusf_M1117_D", 
	"rhsusf_M1220_M153_M2_usarmy_d", 
	"rhsusf_M1232_M2_usarmy_d", 
	"rhsusf_m1240a1_m2_uik_usarmy_d",
	"rhsusf_m113d_usarmy_M240"
];

//Add french stuff
if (isClass (configFile >> "CfgPatches" >> "AMF_Patches")) then 
{
	bluforArmoredVehicle_UKR_2024 = bluforArmoredVehicle_UKR_2024 + 
	[
		"B_AMF_AMX10_RCR_SEPAR_02_F", 
		"B_AMF_AMX10_RCR_01_F"
	];
};


bluforUnarmedVehicleChopper_UKR_2024 = [
	"RHS_Mi8mt_vdv",
	"RHS_Mi8mt_Cargo_vdv",
	"rhs_ka60_c"
];

bluforArmedChopper_UKR_2024 = [
	"RHS_Mi24P_vvs",
	"RHS_Mi8AMTSh_vvs",
	"RHS_Mi24P_vdv",
	"RHS_Mi8MTV3_vdv"
];

bluforDrone_UKR_2024 = [
	"rhs_pchela1t_vvs", 
	"rhs_pchela1t_vvsc"
];

bluforBoat_UKR_2024 = [

];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_UKR_2024 = [
	"rhs_mig29s_vvs",
	"RHS_Su25SM_vvs"
];

if (isClass (configFile >> "CfgPatches" >> "AMF_Patches")) then 
{
	bluforFixedWing_UKR_2024 = bluforFixedWing_UKR_2024 + 
	[
		"B_AMF_PLANE_FIGHTER_02_F"
	];
};

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_UKR_2024 = [
	"rhs_typhoon_vdv", 
	"rhs_tigr_vdv",
	"RHS_Mi8T_vdv"
];	


////////////////////////
//Loadout management////
////////////////////////

//UKR
loadout_UKR_2024 = [		
	[c_leader, [["rhs_weap_ak74m_zenitco01_b33","rhs_acc_uuk","rhsusf_acc_anpeq15side","rhsusf_acc_eotech_552",["rhs_30Rnd_545x39_7N22_AK",30],[],""],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["rhs_uniform_acu_oefcp",[["FirstAidKit",1],["rhs_1PN138",1],["rhs_30Rnd_545x39_7N22_AK",1,30]]],["rhsusf_iotv_ocp_Grenadier",[["FirstAidKit",1],["rhs_mag_9x18_8_57N181S",1,8],["rhs_mag_rdg2_white",1,1],["rhs_30Rnd_545x39_7N22_AK",7,30]]],[],"rhsusf_ach_helmet_ESS_ocp","rhs_facewear_6m2_1",["Binocular","","","",[],[],""],["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]]],
	[c_at, [["rhs_weap_m4a1_carryhandle","","","rhsusf_acc_compm4",["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],[],""],["rhs_weap_fgm148","","","",["rhs_fgm148_magazine_AT",1],[],""],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["rhs_uniform_acu_oefcp",[["FirstAidKit",1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",3,30]]],["rhsusf_iotv_ocp_Grenadier",[["FirstAidKit",1],["rhs_mag_9x18_8_57N181S",1,8],["rhs_mag_rdg2_white",1,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",4,30]]],[],"rhsusf_ach_helmet_ESS_ocp","rhs_facewear_6m2_1",["Binocular","","","",[],[],""],["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]]],
	[c_rifleman, [["rhs_weap_ak74m_zenitco01_b33","rhs_acc_uuk","rhsusf_acc_anpeq15side","rhsusf_acc_eotech_552",["rhs_30Rnd_545x39_7N22_AK",30],[],""],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["rhs_uniform_acu_oefcp",[["FirstAidKit",1],["rhs_1PN138",1],["rhs_30Rnd_545x39_7N22_AK",1,30]]],["rhsusf_iotv_ocp_Grenadier",[["FirstAidKit",1],["rhs_mag_9x18_8_57N181S",1,8],["rhs_mag_rdg2_white",1,1],["rhs_30Rnd_545x39_7N22_AK",7,30]]],[],"rhsusf_ach_helmet_ESS_ocp","rhs_facewear_6m2_1",["Binocular","","","",[],[],""],["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]]],//Default stuff
	[c_engineer, [["rhs_weap_ak74m_zenitco01_b33","rhs_acc_uuk","rhsusf_acc_anpeq15side","rhsusf_acc_eotech_552",["rhs_30Rnd_545x39_7N22_AK",30],[],""],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["rhs_uniform_acu_oefcp",[["FirstAidKit",1],["rhs_30Rnd_545x39_7N22_AK",1,30]]],["rhsusf_iotv_ocp_Grenadier",[["FirstAidKit",1],["rhs_mag_9x18_8_57N181S",1,8],["rhs_mag_rdg2_white",1,1],["rhs_30Rnd_545x39_7N22_AK",7,30]]],["rhsusf_assault_eagleaiii_ocp",[["ToolKit",1],["MineDetector",1]]],"rhsusf_ach_helmet_ESS_ocp","rhs_facewear_6m2_1",["Binocular","","","",[],[],""],["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]]],
	[c_autorifleman, [["rhs_weap_m249","","","",["rhsusf_200Rnd_556x45_box",200],[],""],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["rhs_uniform_acu_oefcp",[["FirstAidKit",1]]],["rhsusf_iotv_ocp_Grenadier",[["FirstAidKit",1],["rhs_mag_9x18_8_57N181S",1,8],["rhs_mag_rdg2_white",1,1],["rhsusf_200Rnd_556x45_box",2,200]]],["rhsusf_falconii",[["rhsusf_200rnd_556x45_mixed_box",3,200]]],"rhsusf_ach_helmet_ESS_ocp","rhs_facewear_6m2_1",["Binocular","","","",[],[],""],["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]]],
	[c_marksman, [["srifle_LRR_F","","","rhsusf_acc_LEUPOLDMK4",["7Rnd_408_Mag",7],[],""],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["rhs_uniform_acu_oefcp",[["FirstAidKit",1],["7Rnd_408_Mag",1,7]]],["rhsusf_iotv_ocp_Grenadier",[["FirstAidKit",1],["rhs_mag_9x18_8_57N181S",1,8],["rhs_mag_rdg2_white",1,1],["7Rnd_408_Mag",8,7]]],[],"rhsusf_ach_helmet_camo_ocp","rhs_facewear_6m2_1",["Binocular","","","",[],[],""],["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]]],
	[c_medic,[["rhs_weap_ak74m_zenitco01_b33","rhs_acc_uuk","rhsusf_acc_anpeq15side","rhsusf_acc_eotech_552",["rhs_30Rnd_545x39_7N22_AK",30],[],""],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["rhs_uniform_acu_oefcp",[["FirstAidKit",1],["rhs_30Rnd_545x39_7N22_AK",1,30]]],["rhsusf_iotv_ocp_Grenadier",[["FirstAidKit",1],["rhs_mag_9x18_8_57N181S",1,8],["rhs_mag_rdg2_white",1,1],["rhs_30Rnd_545x39_7N22_AK",7,30]]],["rhsusf_falconii_mc",[["Medikit",1],["FirstAidKit",5]]],"rhsusf_ach_helmet_ESS_ocp","rhs_facewear_6m2_1",["Binocular","","","",[],[],""],["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]]],
	[c_grenadier, [["rhs_weap_ak74mr_gp25","rhs_acc_uuk","","rhsusf_acc_eotech_552",["rhs_30Rnd_545x39_7N10_AK",30],["rhs_VOG25",1],""],[],["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""],["rhs_uniform_acu_oefcp",[["FirstAidKit",1],["rhs_30Rnd_545x39_7N10_AK",1,30],["rhs_VOG25",1,1]]],["rhsusf_iotv_ocp_Grenadier",[["FirstAidKit",1],["rhs_mag_9x18_8_57N181S",1,8],["rhs_mag_rdg2_white",1,1],["rhs_30Rnd_545x39_7N10_AK",7,30],["rhs_VOG25",12,1]]],[],"rhsusf_ach_helmet_ESS_ocp","rhs_facewear_6m2_1",["Binocular","","","",[],[],""],["ItemMap","","TFAR_anprc152","ItemCompass","ItemWatch",""]]],//Default stuff
	[c_pilot,"rhs_pilot_combat_heli"]
];


////////////////////////
///Weapon management////
////////////////////////
//UKR
rifleList_UKR_2024 = [		
	//Vanilla
	"arifle_AK12_lush_F",
	"arifle_AK12U_lush_F",

	//RHS
	"rhs_weap_ak74m",
	"rhs_weap_makarov_pm",
	"rhs_weap_ak74mr",
	"rhs_weap_ak74m_fullplum",
	"rhs_weap_ak74m_fullplum_npz",
	"rhs_weap_ak74m_zenitco01_b33",
	"rhs_weap_aks74n_npz",
	"rhs_weap_aks74n_2",
	"rhs_weap_ak103",
	"rhs_weap_ak103_npz",
	"rhs_weap_ak103_zenitco01",
	"rhs_weap_ak103_zenitco01_b33",
	"rhs_weap_ak103_1",
	"rhs_weap_ak104",
	"rhs_weap_ak104_npz",
	"rhs_weap_ak105",
	"rhs_weap_ak105_npz",
	"rhs_weap_ak105_zenitco01",
	"rhs_weap_ak105_zenitco01_b33",
	"rhs_weap_ak74mr_grip1",
	"rhs_weap_ak74m_fullplum_grip1",
	"rhs_weap_ak74m_fullplum_npz_grip1",
	"rhs_weap_ak74m_zenitco01_b33_grip1",
	"rhs_weap_aks74n_npz_grip1",
	"rhs_weap_ak103_npz_grip1",
	"rhs_weap_ak103_zenitco01_grip1",
	"rhs_weap_ak103_zenitco01_b33_grip1",
	"rhs_weap_ak104_npz_grip1",
	"rhs_weap_ak105_npz_grip1",
	"rhs_weap_ak105_zenitco01_grip1",
	"rhs_weap_ak105_zenitco01_b33_grip1",
	"rhs_weap_45th_akms",
	"rhs_weap_akms",

	"rhs_weap_pya",
	"rhs_weap_6p53",

	//Periscope
	"rhs_weap_tr8",


	//Add USA Stuff
	//M4A1
	"rhs_weap_m4",
	"rhs_weap_m4a1",
	"rhs_weap_m4a1_mstock_grip3",
	"rhs_weap_m4a1_grip3",
	"rhs_weap_m4a1_mstock",
	"rhs_weap_m4a1_blockII_KAC_bk",
	"rhs_weap_m4a1_blockII_grip_KAC_bk",
	"rhs_weap_m4a1_blockII_grip",
	"rhs_weap_m4a1_blockII",
	"rhs_weap_m4a1_blockII_bk",
	"rhs_weap_m4a1_carryhandle",
	"rhs_weap_m4_grip3",

	//M16A4
	"rhs_weap_m16a4",
	"rhs_weap_m16a4_imod",
	"rhs_weap_m16a4_carryhandle",
	"rhs_weap_m16a4_grip2",
	"rhs_weap_m16a4_imod_grip2",
	"rhs_weap_m16a4_imod_grip3",
	"rhs_weap_m16a4_carryhandle_grip2",

	//M14
	"rhs_weap_m14ebrri",
	
	//Pistols
	"rhsusf_weap_glock17g4",
	"rhsusf_weap_m9"
];	

if (isClass (configFile >> "CfgPatches" >> "AMF_Patches")) then 
{
	rifleList_UKR_2024 = rifleList_UKR_2024 + 
	[
		"AMF_Samas_F1_01_F",
		"AMF_Samas_G2_01_F",
		"AMF_Pamas"
	];
};


grenadeLauncherList_UKR_2024 = [	
	//Vanilla 
	"arifle_AK12_GL_lush_F",

	//RHS RU
	"rhs_weap_ak74m_gp25",
	"rhs_weap_ak74mr_gp25",
	"rhs_weap_ak74m_fullplum_gp25_npz",
	"rhs_weap_ak74n_gp25",
	"rhs_weap_ak74m_gp25_grip1",
	"rhs_weap_ak74mr_gp25_grip1",
	"rhs_weap_ak74m_fullplum_gp25_npz_grip1",
	"rhs_weap_ak74n_gp25",

	//Add USA Stuff 
	"rhs_weap_m4a1_blockII_M203",
	"rhs_weap_m4a1_m203",
	"rhs_weap_m4a1_m203s",
	"rhs_m4_m203",
	"rhs_weap_m32",
	"rhs_weap_M320"
];


launcherList_UKR_2024 = [		
	"rhs_weap_rpg26",
	"rhs_weap_rpg7",
	"rhs_weap_igla",

	//add USA Stuff 
	"rhs_weap_M136_hedp",
	"rhs_weap_fgm148",
	"rhs_weap_fim92",
	"rhs_weap_smaw",
	"rhs_weap_maaws"
];	

autorifleList_UKR_2024 = [			
	"rhs_weap_pkm",
	"rhs_weap_pkp",
	"rhs_weap_rpk74m",
	"rhs_weap_rpk74m_npz",
	 
	 //add USA Stuff 
	"rhs_weap_m249_light_L",
	"rhs_weap_m249_pip",
	"rhs_weap_m249",
	"rhs_weap_m249_S",
	"rhs_weap_m249_light_S",
	"rhs_weap_m249_pip_S",
	"rhs_weap_m240B"
];	

marksmanrifleList_UKR_2024 = [		
	"rhs_asval",
	"rhs_weap_svds",
	"rhs_weap_vss",
	"rhs_weap_vss_grip1",
	"rhs_weap_t5000",
	"rhs_weap_svds_npz",
	"rhs_weap_vss_grip_npz",
	"rhs_weap_vss_grip_npz_grip1",
	"rhs_weap_svdp",

	//Add USA stuff 
	"rhs_weap_mk17_LB",
	"rhs_weap_M107",
	"rhs_weap_m24sws",
	"rhs_weap_m40a5_d",
	"rhs_weap_m14_socom_rail",
	"rhs_weap_XM2010",
	"rhs_weap_XM2010_d",
	"srifle_LRR_F",
	"rhs_weap_sr25",
	"rhs_weap_sr25_ec"
];



smgList_UKR_2024 = [		
	"rhs_weap_aks74u",
	"rhs_weap_ak74m_folded",
	"rhs_weap_pp2000_folded",
	"rhs_weap_pp2000"
];

//////////////////////////
attachmentShortList_UKR_2024	= [
	//Vanilla 
	"optic_Arco",
	"optic_Hamr",
	"optic_Holosight",
	"optic_Holosight_arid_F",
	"optic_Holosight_blk_F",
	"optic_Holosight_khk_F",
	"optic_Holosight_lush_F",
	"optic_Holosight_smg",
	"optic_Holosight_smg_blk_F",
	"optic_Holosight_smg_khk_F",

	//RHS RU
	"rhs_acc_dtk",
	"rhs_acc_pkas",
	"rhs_acc_pgo7v3",
	"rhs_acc_1p78",
	"rhs_acc_uuk",
	"rhs_acc_1p87",
	"rhs_acc_rakursPM",
	"rhs_acc_pgs64",
	"rhs_acc_2dpZenit",
	"rhs_acc_okp7_picatinny",
	"rhs_acc_perst1ik_ris",
	"rhs_acc_perst1ik",
	"rhs_acc_pkas_pkp",
	"rhs_acc_pgo7v3_pkp",
	"rhs_acc_pgo7v3_ak",
	"rhs_acc_grip_ffg2",
	"rhs_acc_grip_rk2",
	"rhs_acc_grip_rk6",
	"rhs_acc_ekp8_18",

	//Add USA stuff 
	"rhsusf_acc_anpeq15",
	"rhsusf_acc_anpeq15_wmx",
	"rhsusf_acc_eotech_xps3",
	"rhsusf_acc_ACOG_USMC",
	"rhsusf_acc_SF3P556",
	"rhsusf_acc_anpeq15_top",
	"rhsusf_acc_g33_xps3_tan",
	"rhsusf_acc_anpeq15_wmx_sc",
	"rhsusf_acc_ACOG3",
	"rhsusf_acc_ACOG2",
	"rhsusf_acc_ACOG",
	"rhsusf_acc_eotech_552_d",
	"rhsusf_acc_eotech_552",
	"rhsusf_acc_ELCAN",
	"rhsusf_acc_compm4",
	"rhsusf_acc_M2A1",
	"rhsusf_acc_mrds",
	"rhsusf_acc_anpeq15side",
	"rhsusf_acc_kac_grip",
	"rhsusf_acc_T1_low",
	"rhsusf_acc_T1_high",
	"rhsusf_acc_anpeq15A",
	"rhsusf_acc_M952V",

	//Launcher optics
	"rhs_weap_optic_smaw",
	"rhs_optic_maaws"

];

attachmentLongList_UKR_2024	= [
	//Vanilla 
	"optic_dms",
	"optic_sos",
	"optic_khs_tan",
	"optic_nvs",
	"muzzle_snds_B_snd_F",
	"optic_AMS_snd",

	//RHS RU 
	"rhs_acc_pso1m21",
	"rhs_acc_pso1m2",
	"rhs_acc_dh520x56",
	"rhs_acc_pgo7v3_asval",
	"rhs_acc_pkas_asval",

	//Add USA stuff
	"rhsusf_acc_M8541_mrds",
	"rhsusf_acc_anpeq15side",
	"rhsusf_acc_premier",
	"rhsusf_acc_LEUPOLDMK4",
	"rhsusf_acc_premier_mrds",
	"rhsusf_acc_LEUPOLDMK4_2",
	"rhsusf_acc_harris_bipod"
];


////////////////////////
itemList_UKR_2024 = [
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

itemEngineerList_UKR_2024 = [
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_UKR_2024 = [

];

//backpack avalaible for all unit
backPackList_UKR_2024 = [
	"rhs_rk_sht_30_emr",
	"rhs_tortila_olive",
	"rhs_assault_umbts",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green",

	//Add USA stuff 
	"B_rhsusf_B_BACKPACK",
	"rhsusf_falconii",
	"rhsusf_falconii_mc",
	"rhsusf_assault_eagleaiii_ocp",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green"
];




//Uniform, vest, headgear, avalaible for all unit
uniformList_UKR_2024 = [
	"rhs_uniform_vkpo_gloves",
	"rhs_6b47_emr_1",
	"rhs_facewear_6m2_1",
	"rhs_6b45_light",
	"rhs_6b45_holster",
	"rhs_6b45_rifleman",
	"rhs_6b45_rifleman_2",
	"rhs_6b45_off",
	"rhs_6b45_mg",
	"rhs_uniform_6sh122_v1",
	"rhs_6b23_digi_medic",
	"rhs_balaclava",
	"rhs_balaclava_olive",
	"rhs_scarf",
	"rhs_uniform_mvd_izlom",
	"rhs_6b23_6sh92_radio",
	"rhs_6b27m",
	"rhs_6b23_6sh92_vog",
	"rhs_6b27m_green",
	"rhs_weap_pya",
	"rhs_uniform_mvd_izlom",
	"rhs_6b23_6sh92_headset_mapcase",
	"rhs_6b27m_green_ess",
	"rhs_uniform_6sh122_gloves_v2",

	//Add USA Stuff 
	"rhs_uniform_acu_oefcp",
	"rhsusf_ach_helmet_ocp",
	"rhsusf_ach_helmet_camo_ocp",
	"rhsusf_ach_helmet_headset_ess_ocp",
	"rhsusf_ach_helmet_headset_ocp",
	"rhsusf_ach_helmet_ESS_ocp",
	"rhsusf_ach_bare_des",
	"rhsusf_iotv_ocp_Rifleman",
	"rhsusf_iotv_ocp_Medic",
	"rhsusf_iotv_ocp_Repair",
	"rhsusf_iotv_ocp_Grenadier",

	//Plateframe
	"rhsusf_plateframe_light",
	"rhsusf_plateframe_machinegunner",
	"rhsusf_plateframe_marksman",
	"rhsusf_plateframe_medic",
	"rhsusf_plateframe_rifleman",
	"rhsusf_plateframe_teamleader",

	//Shemag 
	"rhsusf_shemagh_gogg_tan",
	"rhsusf_shemagh2_gogg_tan",
	"rhsusf_shemagh_gogg_od",
	"rhsusf_shemagh2_gogg_od",
	"rhsusf_oakley_goggles_blk",
	"rhsusf_oakley_goggles_clr",
	"rhsusf_oakley_goggles_ylw"
];


factionDefaultRadios_UKR_2024 = [
	"TFAR_anprc152"
];

//Magazine avalaible for all unit
magazineList_UKR_2024 = 	[
];