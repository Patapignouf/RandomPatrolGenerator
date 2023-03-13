c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_grenadier = "grenadier";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_pilot = "pilot";

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Light civilian group
civilian_group_2035_NATO_FS = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

//Heavy civilian group
civilian_big_group_2035_NATO_FS = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

//Vehicle avalaible on civilian city
civilianTruck_2035_NATO_FS = ["C_SUV_01_F","C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_2035_NATO_FS = ["B_W_Soldier_SL_F", 
"B_W_Soldier_AR_F", 
"B_W_Soldier_GL_F", 
"B_W_soldier_M_F", 
"B_W_Soldier_AT_F", 
"B_W_Soldier_AAT_F", 
"B_W_Soldier_A_F", 
"B_W_Medic_F"];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_2035_NATO_FS = ["B_W_Soldier_TL_F", 
"B_W_Soldier_AT_F", 
"B_W_Soldier_AT_F",
"B_W_Soldier_AAT_F"];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_2035_NATO_FS = ["B_CTRG_Soldier_TL_tna_F", 
"B_CTRG_Soldier_M_tna_F", 
"B_CTRG_Soldier_Medic_tna_F", 
"B_CTRG_Soldier_tna_F", 
"B_CTRG_Soldier_LAT_tna_F", 
"B_CTRG_Soldier_JTAC_tna_F", 
"B_CTRG_Soldier_Exp_tna_F", 
"B_CTRG_Soldier_AR_tna_F"];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_2035_NATO_FS = ["B_T_Mortar_01_F", 
"B_CTRG_Soldier_TL_tna_F", 
"B_CTRG_Soldier_M_tna_F", 
"B_CTRG_Soldier_Medic_tna_F"];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy chopper avalaible
baseChopperGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy aircraft avalaible
baseFixedWingGroup_2035_NATO_FS = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_NATO_FS = [
	"B_MRAP_01_F",
	"B_Truck_01_transport_F",
	"B_LSV_01_unarmed_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_NATO_FS = [
	"B_LSV_01_armed_F",
	"B_LSV_01_AT_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_NATO_FS = [
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Light_01_F"
];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_NATO_FS = [
	"B_Heli_Attack_01_dynamicLoadout_F",
	"B_Heli_Light_01_dynamicLoadout_F",
	"B_Heli_Transport_01_F"
];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_NATO_FS = [
	"B_APC_Wheeled_01_cannon_F",
	"B_APC_Tracked_01_CRV_F",
	"B_AFV_Wheeled_01_up_cannon_F"
];

//Drone vehicle avalaible for blufor
bluforDrone_2035_NATO_FS = [
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F",
	"B_UGV_02_Science_F",
	"B_UAV_06_F",
	"B_UAV_01_F",
	"B_UAV_05_F",
	"B_UAV_02_dynamicLoadout_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_2035_NATO_FS = [
	"B_Boat_Armed_01_minigun_F",
	"B_Boat_Transport_01_F"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_NATO_FS = [
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_Stealth_F"
];


//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_2035_NATO_FS = [
	"B_APC_Tracked_01_rcws_F"
];


////////////////////////
//Loadout management////
////////////////////////

listOfRoles_2035_NATO_FS = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier,c_pilot];

//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_2035_NATO_FS = [		
	[c_leader,[["arifle_SPAR_01_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],[],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",4,30]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",3,30],["11Rnd_45ACP_Mag",2,11]]],["B_AssaultPack_cbr",[]],"H_HelmetSpecB_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
	[c_at,[["arifle_SPAR_01_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",4,30]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",3,30],["11Rnd_45ACP_Mag",2,11]]],["B_AssaultPack_cbr",[["NLAW_F",2,1]]],"H_HelmetSpecB_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
	[c_rifleman,[["arifle_SPAR_01_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],[],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",4,30]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",3,30],["11Rnd_45ACP_Mag",2,11]]],["B_AssaultPack_cbr",[]],"H_HelmetSpecB_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],//Default stuff
	[c_engineer,[["arifle_SPAR_01_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],[],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",4,30]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",3,30],["11Rnd_45ACP_Mag",2,11]]],["B_AssaultPack_cbr",[["ToolKit",1],["MineDetector",1]]],"H_HelmetSpecB_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
	[c_autorifleman,[["MMG_02_sand_F","","acc_pointer_IR","optic_Arco",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["11Rnd_45ACP_Mag",4,11]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["130Rnd_338_Mag",1,130]]],["B_Kitbag_cbr",[["130Rnd_338_Mag",4,130]]],"H_HelmetSpecB_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
	[c_marksman,[["arifle_SPAR_03_snd_F","muzzle_snds_B_snd_F","acc_pointer_IR","optic_AMS_snd",["20Rnd_762x51_Mag",20],[],"bipod_01_F_snd"],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["20Rnd_762x51_Mag",3,20]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["11Rnd_45ACP_Mag",2,11],["20Rnd_762x51_Mag",7,20]]],["B_AssaultPack_cbr",[["20Rnd_762x51_Mag",6,20]]],"H_HelmetSpecB_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
	[c_medic,[["arifle_SPAR_01_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],[],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",4,30]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",3,30],["11Rnd_45ACP_Mag",2,11]]],["B_Kitbag_cbr",[["Medikit",1],["FirstAidKit",2],["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",7,30]]],"H_HelmetSpecB_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
	[c_grenadier,[["arifle_SPAR_01_GL_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["30Rnd_556x45_Stanag_Sand",3,30],["1Rnd_HE_Grenade_shell",3,1]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["11Rnd_45ACP_Mag",2,11],["30Rnd_556x45_Stanag_Sand_Tracer_Yellow",7,30]]],["B_AssaultPack_cbr",[["1Rnd_HE_Grenade_shell",11,1],["1Rnd_Smoke_Grenade_shell",3,1],["1Rnd_SmokeRed_Grenade_shell",3,1],["UGL_FlareYellow_F",5,1]]],"H_HelmetSpecB_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
	[c_pilot,[["SMG_02_F","muzzle_snds_L","acc_pointer_IR","optic_Aco",["30Rnd_9x21_Mag_SMG_02",30],[],""],[],["hgun_Pistol_heavy_01_F","muzzle_snds_acp","acc_flashlight_pistol","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_tshirt",[["30Rnd_9x21_Mag_SMG_02",3,30]]],["V_PlateCarrier1_rgr_noflag_F",[["FirstAidKit",1],["Chemlight_green",2,1],["SmokeShellBlue",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShell",1,1],["HandGrenade",1,1],["11Rnd_45ACP_Mag",2,11],["30Rnd_9x21_Mag_SMG_02",7,30]]],[],"H_HelmetB_light_sand","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
];

////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_2035_NATO_FS = [		
	"arifle_SPAR_01_snd_F",
	"arifle_SPAR_01_blk_F",
	"arifle_SPAR_01_khk_F",
	"CUP_arifle_HK416_Desert",
	"CUP_arifle_HK416_CQB_Desert"
];	

grenadeLauncherList_2035_NATO_FS = [
	"arifle_SPAR_01_GL_snd_F",
	"arifle_SPAR_01_GL_blk_F",
	"arifle_SPAR_01_GL_khk_F",
	"CUP_arifle_HK416_CQB_M203_Desert"
];


//Launcher avalaible for AT
launcherList_2035_NATO_FS = [
	"launch_I_Titan_short_F",
	"launch_NLAW_F",
	"launch_MRAWS_olive_F"
];	

//Autorifle avalaible for autorifleman
autorifleList_2035_NATO_FS = [
	"LMG_Mk200_F",
	"MMG_02_camo_F",
	"MMG_02_sand_F"
];	

//Rifle avalaible for marksman
marksmanrifleList_2035_NATO_FS = [
	"srifle_LRR_F",
	"arifle_SPAR_03_snd_F",
	"srifle_EBR_F",
	"CUP_arifle_HK417_20_Desert",
	"srifle_DMR_02_F"
];

//Smg avalaible for all unit
smgList_2035_NATO_FS = [
	"hgun_Pistol_heavy_01_F",
	"SMG_02_F"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_NATO_FS	= [
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
	"optic_Aco",
	"optic_Aco_smg",
	"optic_ACO_grn",
	"optic_ACO_grn_smg",
	"optic_mrco",
	"acc_pointer_IR",
	"optic_ERCO_snd_F",
	"muzzle_snds_m_snd_F"
];

//Long range scope avalaible for marksman
attachmentLongList_2035_NATO_FS	= [
	"optic_dms",
	"optic_sos",
	"optic_khs_tan",
	"optic_nvs",
	"muzzle_snds_B_snd_F",
	"optic_AMS_snd"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_2035_NATO_FS = [
	"FirstAidKit",
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
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"acc_flashlight",
	"ACE_Banana",
	"muzzle_snds_H_snd_F",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_RangeCard"
];

//item avalaible for all engineer
itemEngineerList_2035_NATO_FS = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch"
];

//item avalaible for all medic
itemMedicList_2035_NATO_FS = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_morphine",
	"ACE_splint",
	"ACE_tourniquet",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_bodyBag"
];


//backpack avalaible for all unit
backPackList_2035_NATO_FS = [
	"B_TacticalPack_mcamo",
	"B_Carryall_mcamo",
	"B_AssaultPack_rgr",
	"B_AssaultPack_cbr",
	"B_Kitbag_cbr"
];


//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_NATO_FS = [
	"U_B_CombatUniform_mcam_tshirt",
	"V_PlateCarrier1_rgr_noflag_F",
	"H_HelmetSpecB_sand",
	"U_BG_Guerilla2_1",
	"U_BG_Guerilla2_3",
	"U_I_G_resistanceLeader_F",
	"V_PlateCarrier2_rgr_noflag_F",
	"G_Bandanna_khk"
];

//Magazine avalaible for all unit
//Special note throwing items must be placed here too
magazineList_2035_NATO_FS = [
	"30Rnd_556x45_Stanag_Sand",
	"11Rnd_45ACP_Mag",
	"30Rnd_556x45_Stanag_Sand_Tracer_Green",
	"130Rnd_338_Mag",
	"200Rnd_65x39_cased_Box_Tracer",
	"20Rnd_762x51_Mag",
	"7Rnd_408_Mag",
	"20Rnd_762x51_Mag",
	"11Rnd_45ACP_Mag",
	"30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",
	"Titan_AT",
	"Titan_AP",
	"NLAW_F",
	"MRAWS_HEAT_F",
	"HandGrenade",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellRed",
	"10Rnd_338_Mag"
];

//Get magazine with following command
//getArray (configfile >> "CfgWeapons" >> weaponName >> "magazines");