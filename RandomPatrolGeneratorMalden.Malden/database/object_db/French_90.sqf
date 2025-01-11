#include "..\classConstant.sqf"

//Add specific AMF factions
factionID = factionID+1;
if (isClass (configFile >> "CfgPatches" >> "AMF_Patches")) then 
{
	factionInfos pushBack ["_French_90", factionID,"French 1990 [AMF]", true, false, false];
};


////////////////////////
//Vehicle management////
////////////////////////
//French
bluforUnarmedVehicle_French_90 = [
	"B_AMF_VAB_ULTIMA_X8_F",
	"AMF_GBC180_PERS_01",
	"B_AMF_VAB_ULTIMA_X8_TDF_F"
	];

bluforArmedVehicle_French_90 = [
	"amf_pvp_01_top_CE_f",
	"amf_pvp_01_mag_CE_f",
	"B_AMF_VAB_ULTIMA_TOP_X8_F",
	"AMF_VB2L_DA_762_01_F", 
	"AMF_VBL_DA_762_01_F"
];

bluforUnarmedVehicleChopper_French_90 = [
	"amf_cougar", 
	"AMF_panther_FRA", 
	"AMF_gazelle_afte_f", 
	"B_AMF_Heli_Transport_01_F"
];

bluforArmedChopper_French_90 = [
	"AMF_TIGRE_01",
	"AMF_gazelle_minigun_da_f"
];

bluforDrone_French_90 = [
];

bluforBoat_French_90 = [

];

bluforFixedWing_French_90 = [
	"B_AMF_PLANE_FIGHTER_02_F",
	"B_AMF_PLANE_TRANSPORT_01_F"
];

bluforHQVehicle_French_90 = [
	"AMF_GBC180_PERS_01"
];

bluforArmoredVehicle_French_90 = [
	"B_AMF_AMX10_RCR_03_F", 
	"B_AMF_AMX10_RCR_01_F", 
	"B_AMF_TANK_01", 
	"B_AMF_TANK_DA_01_F"
];

////////////////////////
//Loadout management////
////////////////////////


//French
loadout_French_90 = [		
	[c_leader,[["AMF_Samas_G2_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["30Rnd_556x45_Stanag",3,30],["Chemlight_red",1,1]]],["amf_S3_01_CE",[["30Rnd_556x45_Stanag_Tracer_Green",11,30]]],["AMF_rush24_01",[["FirstAidKit",1],["30Rnd_556x45_Stanag_Tracer_Green",2,30],["SmokeShell",1,1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1]]],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","",""]]],
	[c_at,[["AMF_Samas_G2_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],[],""],["AMF_AT4CS_F","","","",["AMF_84mm_AT4CS",1],[],""],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["30Rnd_556x45_Stanag",3,30],["Chemlight_red",1,1]]],["amf_S3_01_CE",[["30Rnd_556x45_Stanag_Tracer_Green",11,30]]],["AMF_rush24_01",[["FirstAidKit",1],["30Rnd_556x45_Stanag_Tracer_Green",2,30],["SmokeShell",1,1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1]]],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","",""]]],
	[c_medic,[["AMF_Samas_G2_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["30Rnd_556x45_Stanag",3,30],["Chemlight_red",1,1]]],["amf_S3_01_CE",[["30Rnd_556x45_Stanag_Tracer_Green",11,30]]],["AMF_rush24_01",[["FirstAidKit",10],["Medikit",1],["30Rnd_556x45_Stanag_Tracer_Green",2,30],["SmokeShell",1,1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1]]],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","",""]]],
	[c_grenadier,[["AMF_Samas_G2_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],["AMF_RFG_AC58",1],""],[],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["30Rnd_556x45_Stanag",3,30],["Chemlight_red",1,1]]],["amf_S3_01_CE",[["30Rnd_556x45_Stanag_Tracer_Green",11,30],["AMF_RFG_APAV40",5,1],["AMF_RFG_AC58",5,1]]],["AMF_rush24_01",[["FirstAidKit",1],["30Rnd_556x45_Stanag_Tracer_Green",2,30],["SmokeShell",1,1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1]]],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","",""]]],
	[c_rifleman,[["AMF_Samas_G2_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["30Rnd_556x45_Stanag",3,30],["Chemlight_red",1,1]]],["amf_S3_01_CE",[["30Rnd_556x45_Stanag_Tracer_Green",11,30]]],["AMF_rush24_01",[["FirstAidKit",1],["30Rnd_556x45_Stanag_Tracer_Green",2,30],["SmokeShell",1,1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1]]],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","",""]]],
	[c_engineer,[["AMF_Samas_G2_01_F","","","AMF_Eotech_552",["30Rnd_556x45_Stanag",30],[],""],[],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["30Rnd_556x45_Stanag",3,30],["Chemlight_red",1,1]]],["amf_S3_01_CE",[["30Rnd_556x45_Stanag_Tracer_Green",11,30]]],["AMF_rush24_01",[["ToolKit",1],["MineDetector",1],["30Rnd_556x45_Stanag_Tracer_Green",2,30],["SmokeShell",1,1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1],["DemoCharge_Remote_Mag",1,1]]],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","",""]]],
	[c_autorifleman,[["amf_mini_mg_tactical_mk3","","","AMF_EOTECH_553",["150Rnd_MINI_MG_mag",150],[],""],[],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["Chemlight_red",1,1],["15Rnd_9x21_Mag",3,15]]],["amf_S3_01_CE",[["150Rnd_MINI_MG_mag_Tracer_red",4,150]]],[],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","",""]]],
	[c_marksman,[["AMF_RFF2_01_F","","","optic_LRPS",["10Rnd_762x51_Mag",10],[],""],[],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["Chemlight_red",1,1],["10Rnd_762x51_Mag",3,10]]],["amf_S3_01_CE",[["10Rnd_762x51_Mag",12,10],["15Rnd_9x21_Mag",2,15]]],[],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","",""]]],
	[c_Pilot,[[],[],["AMF_Pamas","","acc_flashlight_pistol","",["15Rnd_9x21_Mag",15],[],""],["amf_uniform_01_RE_OD_HX",[["Chemlight_red",1,1],["15Rnd_9x21_Mag",3,15]]],["amf_DCS_03_OD",[["15Rnd_9x21_Mag",4,15]]],[],"AMF_FELIN_L06_CE","G_Balaclava_oli",["AMF_APX_M241","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","",""]]]
];

////////////////////////
///Weapon management////
////////////////////////
//French
rifleList_French_90 = [		
	"AMF_Samas_F1_01_F",
	"AMF_Samas_G2_01_F",
	"AMF_Pamas"
];	

grenadeLauncherList_French_90 =  [		
];	

launcherList_French_90 = [		
	"AMF_AT4CS_F",
	"AMF_LRAC89_F",
	"AMF_Eryx"
];	

autorifleList_French_90 = [			
	"amf_mini_mg_01_f",
	"amf_mini_mg_tactical_mk3",
	"LMG_03_F"
];	


marksmanrifleList_French_90 = [		
	//AMF 
	"AMF_PGM_ULTIMA_RATIO_01_F",
	"AMF_Perseis_II_01_F",
	"AMF_Perseis_II_02_F",
	"AMF_RFF2_01_F",
	"amf_perseis_ii_poly_02_F"
];

smgList_French_90 = [		
	"amf_hk_mp5_01_f",
	"amf_hk_mp5_02_f"
];


//////////////////////////
//Attachement management//
//////////////////////////

//items avalaible for everyone (optics)
attachmentShortList_French_90	= [
	//AMF optics
	"AMF_Aimpoint_CompM5",
	"AMF_AIMPOINT_MICRO_T1",
	"AMF_AIMPOINT_MICRO_T2",
	"AMF_Aimpoint_Pro_Patrol",
	"AMF_AN_PEQ_15_black",
	"AMF_AN_PEQ_15_green",
	"AMF_AN_PEQ_15_painted",
	"AMF_AN_PEQ_15_tan",
	"amf_red_dot_sight",
	"AMF_EOTECH_553",
	"AMF_EOTECH_553_painted",
	"AMF_xps3",
	"amf_scrome_j4_02"
];

//Items avalaible only for marksman
attachmentLongList_French_90	= [
	//AMF optics
	"amf_scrome_j4",
	"amf_scrome_j8",
	"amf_schmidt_benderx4",
	"AMF_schmidt_benderx4_tan",

	//Vanilla optics
	"optic_lrps"
];


////////////////////////
////Items management////
////////////////////////

//Items avalaible for everyone
itemList_French_90 = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"amf_balaclava_sordin_tantan",
	"AMF_BINYX_BLK_NVG",
	"B_UavTerminal",
	"ItemGPS",
	"Binocular",
	"Rangefinder",
	"ACE_MapTools",
	"ACE_microDAGR",
	"ACE_CableTie",
	"ACE_DAGR",
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
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard",
	"AMF_APX_M241",
	"ACE_NVG_Wide_Black_WP",
	"ACE_NVG_Wide_WP",
	"ACE_NVG_Wide_Green_WP"
	];

//items avalaible only for engineer
itemEngineerList_French_90 = [
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
	"ace_marker_flags_red",
	"DemoCharge_Remote_Mag"
	];



//backpack avalaible for all unit
backPackList_French_90 = [
	//Mounted tools backpack
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"AMF_TVMMP_weapon",
	"AMF_WiredMMP_weapon",
	"AMF_MMP_support",

	//Classic backpack
	"AMF_rush24_01_TDF",
	"AMF_rush24_01_TAN",
	"TFAR_rt1523g",
	"TFAR_rt1523g_sage",
	"AMF_Bergen_F2_DA",
	"AMF_Bergen_F2"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_French_90 = [
	//Basic uniform CE
	"AMF_FELIN_04_CE",
	"amf_uniform_01_CE_OD",
	"amf_uniform_01_RE_NG_OD_HX",
	"amf_uniform_01_RE_OD_HS",
	"AMF_SPECTRA_CE",

	//TU 
	"AMF_FELIN_04_TU",
	"amf_uniform_01_TU_HS",
	"amf_uniform_01_RE_TU_HS",

	//DA
	"AMF_FELIN_04_DA",
	"amf_uniform_01_DA_HX",
	"amf_uniform_01_RE_DA_HX",
	"amf_uniform_01_RE_DA_MD",
	"AMF_SPECTRA_2_DA",

	//Helmet
	"AMF_FELIN_L03_CE",
	"AMF_FELIN_L06_CE",
	"AMF_FELIN_L03_TAN",
	"AMF_FELIN_L06_TAN",

	//Vest
	"amf_DCS_01_OD",
	"amf_DCS_01_TDF",
	"amf_S3_01_CE",
	"amf_S3_01_DA",

	//
	"amf_balaclava_tan"
	];