c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

////////////////////////
//Vehicle management////
////////////////////////
//French
bluforUnarmedVehicle_French = ["B_AMF_VAB_ULTIMA_X8_F"];

bluforArmedVehicle_French = ["amf_pvp_01_CE_f","B_AMF_VAB_ULTIMA_TOP_X8_F","AMF_VBMR_L_CE_01"];

bluforUnarmedVehicleChopper_French = ["ffaa_nh90_tth_transport","AMF_gazelle_afte_f","ffaa_famet_cougar"];


bluforDrone_French = ["B_UAV_02_dynamicLoadout_F"
];

bluforBoat_French = ["CUP_B_RHIB_HIL",
"CUP_B_Zodiac_USMC"
];

////////////////////////
//Loadout management////
////////////////////////

//French
loadout_French = [		
	[c_leader,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellGreen",1,1]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["CUP_1Rnd_HEDP_M203",1,1],["CUP_1Rnd_SmokeGreen_M203",1,1],["CUP_1Rnd_SmokeRed_M203",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops_TL",[["CUP_20Rnd_762x51_B_SCAR",2,20],["CUP_1Rnd_HEDP_M203",4,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_at,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],["CUP_launch_M136","","","",[],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_1Rnd_HEDP_M203",3,1],["CUP_15Rnd_9x19_M9",1,15],["B_IR_Grenade",1,1],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],["CUP_B_AssaultPack_Coyote_Specops_GL",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_1Rnd_HEDP_M203",6,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_HandGrenade_M67",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_rifleman,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],//Default stuff
	[c_engineer,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["B_Carryall_mcamo",[["ToolKit",1],["MineDetector",1],["ACE_EntrenchingTool",1],["ACE_DefusalKit",1]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_autorifleman,[["CUP_lmg_M249_ElcanM145_Laser","","CUP_acc_ANPEQ_15_Black","CUP_optic_ElcanM145",["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",100],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1]]],["CUP_V_CPC_tlbelt_mc",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",1,100],["CUP_HandGrenade_M67",2,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",3,15]]],["CUP_B_Frenchrmy_AR_SpecOp",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",2,100]]],"CUP_H_OpsCore_Grey_SF","CUP_G_Grn_Scarf_GPS_Beard",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_marksman,[["CUP_arifle_Mk20_LeupoldMk4MRT","","","CUP_optic_LeupoldMk4_MRT_tan",["CUP_20Rnd_762x51_B_SCAR",20],[],"CUP_bipod_VLTOR_Modpod"],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_Tan_MC_US",[["FirstAidKit",1],["CUP_20Rnd_762x51_B_SCAR",2,20]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_20Rnd_762x51_B_SCAR",5,20],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_AssaultPack_Coyote_Specops_M",[["CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR",4,20],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_medic,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShell",1,1]]],["CUP_V_CPC_medicalbelt_mc",[["CUP_30Rnd_556x45_Stanag",3,30],["CUP_15Rnd_9x19_M9",1,15],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",2,1]]],["CUP_B_Frenchrmy_Medic2",[["Medikit",1],["FirstAidKit",10]]],"CUP_H_OpsCore_Spray_US","CUP_G_Tan_Scarf_GPS_Beard_Blonde",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]]
];

////////////////////////
///Weapon management////
////////////////////////
//French
rifleList_French = [		
	"CUP_arifle_mk18_black",
	"CUP_arifle_mk18_m203_black"
];	

launcherList_French = [		
	"CUP_launch_Javelin",
	"CUP_launch_FIM92Stinger",
	"CUP_launch_MAAWS",
	"CUP_launch_MAAWS_Scope"
];	

autorifleList_French = [			
	"CUP_lmg_Mk48"
];	


marksmanrifleList_French = [		
	"CUP_srifle_Mk12SPR"
];

smgList_French = [		
	"CUP_smg_MP7"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_French	= [
	"CUP_optic_AC11704_Black",
	"CUP_optic_VortexRazor_UH1_Black",		
	"CUP_optic_artel_m14",
	"CUP_optic_artel_m14_pip",
	"CUP_optic_Aimpoint_5000",
	"CUP_optic_HoloBlack",
	"CUP_optic_Eotech553_Black",		
	"CUP_optic_CompM2_Black",			
	"CUP_optic_CompM2_low",			
	"CUP_optic_CompM4",
	"CUP_optic_MicroT1",			
	"CUP_optic_MicroT1_low",			
	"CUP_optic_MARS",
	"CUP_optic_MEPRO",
	"CUP_optic_MEPRO_openx_orange",
	"CUP_optic_MEPRO_moa_clear",
	"CUP_optic_MEPRO_tri_clear",
	"CUP_optic_SUSAT",
	"CUP_optic_SUSAT_PIP",
	"CUP_optic_SUSAT_3D",
	//"CUP_optic_ACOG",  //Remove too versatile optics to test players new choice
	"CUP_optic_ACOG_PIP",
	"CUP_optic_ACOG_3D",
	"CUP_optic_ACOG2",
	"CUP_optic_ACOG2_PIP",
	"CUP_optic_ACOG2_3D",
	"CUP_optic_RCO",
	"CUP_optic_ACOG_TA01NSN_Black_PIP",
	"CUP_optic_ACOG_TA01NSN_Black_3D",
	"CUP_optic_ACOG_TA01B_Black",
	"CUP_optic_ACOG_TA01B_Black_PIP",
	"CUP_optic_ACOG_TA01B_Black_3D",
	"CUP_optic_ZDDot",
	"CUP_optic_MRad",
	"CUP_optic_TrijiconRx01_black",
	"CUP_optic_TrijiconRx01_kf_black",
	"CUP_optic_ZeissZPoint",
	"CUP_optic_HensoldtZO",
	"CUP_acc_ANPEQ_15",
	"CUP_acc_ANPEQ_15_Black",
	"CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L",
	"CUP_acc_ANPEQ_2",
	"CUP_acc_ANPEQ_2_Black_Top",
	"CUP_acc_ANPEQ_2_desert",
	"CUP_acc_ANPEQ_2_grey",
	"CUP_bipod_Harris_1A2_L_BLK",
	"CUP_bipod_VLTOR_Modpod",
	"CUP_muzzle_PB6P9",
	"CUP_muzzle_Bizon",
	"CUP_muzzle_PBS4",
	"CUP_muzzle_TGPA",
	"CUP_muzzle_snds_KZRZP_Base",
	"CUP_muzzle_snds_KZRZP_SVD",
	"CUP_muzzle_snds_KZRZP_AK762",
	"CUP_muzzle_snds_KZRZP_AK545",
	"CUP_muzzle_snds_KZRZP_PK"
];


////////////////////////
////Items management////
////////////////////////
itemList_French = [
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
	"B_UavTerminal",
	"Binocular",
	"Rangefinder",
	"ACE_MapTools",
	"ACE_microDAGR",
	"ACE_SpraypaintRed",
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
	"ACE_EntrenchingTool"
	];

itemEngineerList_French = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter"
	];
	
itemMedicList_French = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];