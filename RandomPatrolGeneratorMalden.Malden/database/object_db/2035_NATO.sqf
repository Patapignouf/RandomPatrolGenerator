c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_grenadier = "grenadier";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Light civilian group
civilian_group_2035_NATO = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

//Heavy civilian group
civilian_big_group_2035_NATO = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

//Vehicle avalaible on civilian city
civilianTruck_2035_NATO = ["C_SUV_01_F","C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_2035_NATO = ["I_C_Soldier_Bandit_4_F", 
"I_C_Soldier_Bandit_3_F", 
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_5_F", 
"I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_1_F"];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_2035_NATO = ["I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_2_F",
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_8_F"];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_2035_NATO = ["I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F",
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_2035_NATO = ["I_G_Mortar_01_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_2035_NATO = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_2035_NATO = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_2035_NATO = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy chopper avalaible
baseChopperGroup_2035_NATO = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

//Basic enemy aircraft avalaible
baseFixedWingGroup_2035_NATO = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_NATO = [
	"B_MRAP_01_F",
	"B_Truck_01_transport_F",
	"B_LSV_01_unarmed_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_NATO = [
	"B_MRAP_01_gmg_F",
	"B_MRAP_01_hmg_F",
	"B_LSV_01_armed_F",
	"B_LSV_01_AT_F"
];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_NATO = [
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Light_01_F",
	"B_Heli_Transport_01_F"
];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_NATO = [
	"B_Heli_Attack_01_dynamicLoadout_F",
	"B_Heli_Light_01_dynamicLoadout_F"
	];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_NATO = [
	"B_APC_Wheeled_01_cannon_F",
	"B_APC_Tracked_01_CRV_F",
	"B_AFV_Wheeled_01_up_cannon_F"
];

//Drone vehicle avalaible for blufor
bluforDrone_2035_NATO = [
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F",
	"B_UGV_02_Science_F",
	"B_UAV_06_F",
	"B_UAV_01_F",
	"B_UAV_05_F",
	"B_UAV_02_dynamicLoadout_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_2035_NATO = [
	"B_Boat_Armed_01_minigun_F",
	"B_Boat_Transport_01_F"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_NATO = [
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_Stealth_F"
];

////////////////////////
//Loadout management////
////////////////////////

listOfRoles_2035_NATO = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic,c_grenadier];

//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_2035_NATO = [		
	[c_leader,[["arifle_MX_GL_F","","ACE_acc_pointer_green","optic_Arco",["30Rnd_65x39_caseless_mag",30],["3Rnd_Smoke_Grenade_shell",3],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["ACE_elasticBandage",10],["ACE_CableTie",5],["ACE_EarPlugs",1],["ACE_morphine",1],["ACE_splint",2],["ACE_tourniquet",3],["ACE_WaterBottle",1],["ACE_MapTools",1],["16Rnd_9x21_Mag",1,17],["SmokeShellBlue",1,1]]],["V_PlateCarrier1_rgr",[["muzzle_snds_H_snd_F",1],["30Rnd_65x39_caseless_mag_Tracer",1,30],["30Rnd_65x39_caseless_mag",6,30],["SmokeShell",1,1],["MiniGrenade",2,1],["3Rnd_Smoke_Grenade_shell",1,3],["HandGrenade",2,1]]],[],"H_HelmetB","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]], true],
	[c_at,[["arifle_MX_F","","ACE_acc_pointer_green","optic_Arco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_I_Titan_short_F","","","",["Titan_AT",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["ACE_Banana",1],["ACE_elasticBandage",10],["ACE_CableTie",5],["ACE_EarPlugs",1],["ACE_morphine",1],["ACE_splint",2],["ACE_tourniquet",3],["ACE_WaterBottle",1],["16Rnd_9x21_Mag",1,17],["SmokeShellBlue",1,1]]],["V_PlateCarrier1_rgr",[["muzzle_snds_H_snd_F",1],["MiniGrenade",2,1],["SmokeShell",1,1],["30Rnd_65x39_caseless_mag_Tracer",1,30],["30Rnd_65x39_caseless_mag",6,30],["HandGrenade",2,1]]],["B_TacticalPack_mcamo",[["Titan_AT",2,1]]],"H_HelmetB","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]], true],
	[c_rifleman,[["arifle_MX_F","","ACE_acc_pointer_green","optic_Arco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["ACE_Banana",1],["ACE_elasticBandage",10],["ACE_CableTie",5],["ACE_EarPlugs",1],["ACE_morphine",1],["ACE_splint",2],["ACE_tourniquet",3],["ACE_WaterBottle",1],["16Rnd_9x21_Mag",1,17],["SmokeShellBlue",1,1]]],["V_PlateCarrier1_rgr",[["muzzle_snds_H_snd_F",1],["MiniGrenade",2,1],["SmokeShell",1,1],["30Rnd_65x39_caseless_mag_Tracer",1,30],["30Rnd_65x39_caseless_mag",6,30],["HandGrenade",2,1]]],[],"H_HelmetB","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]], true],//Default stuff
	[c_grenadier,[["arifle_MX_GL_F","","ACE_acc_pointer_green","optic_Arco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["ACE_Banana",1],["ACE_elasticBandage",10],["ACE_CableTie",5],["ACE_EarPlugs",1],["ACE_morphine",1],["ACE_splint",2],["ACE_tourniquet",3],["ACE_WaterBottle",1],["16Rnd_9x21_Mag",1,17],["SmokeShellBlue",1,1]]],["V_PlateCarrierSpec_rgr",[["muzzle_snds_H_snd_F",1],["30Rnd_65x39_caseless_mag_Tracer",1,30],["30Rnd_65x39_caseless_mag",5,30],["SmokeShell",1,1],["HandGrenade",2,1]]],["B_AssaultPack_rgr",[["1Rnd_HE_Grenade_shell",15,1],["3Rnd_Smoke_Grenade_shell",4,3],["30Rnd_65x39_caseless_mag",1,30]]],"H_HelmetB","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]], true],
	[c_engineer,[["arifle_MX_F","","ACE_acc_pointer_green","optic_Arco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["ACE_Banana",1],["ACE_elasticBandage",10],["ACE_CableTie",5],["ACE_EarPlugs",1],["ACE_morphine",1],["ACE_splint",2],["ACE_tourniquet",3],["ACE_WaterBottle",1],["16Rnd_9x21_Mag",1,17],["SmokeShellBlue",1,1]]],["V_PlateCarrierGL_rgr",[["muzzle_snds_H_snd_F",1],["MiniGrenade",2,1],["SmokeShell",1,1],["30Rnd_65x39_caseless_mag_Tracer",1,30],["30Rnd_65x39_caseless_mag",6,30],["HandGrenade",2,1]]],["B_TacticalPack_mcamo",[["ACE_DefusalKit",1],["ACE_EntrenchingTool",1],["ACE_Fortify",1],["ACE_M26_Clacker",1],["MineDetector",1],["ACE_SpraypaintRed",1],["ToolKit",1],["ACE_wirecutter",1],["DemoCharge_Remote_Mag",2,1]]],"H_HelmetB","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]], true],
	[c_autorifleman,[["LMG_Mk200_F","","ACE_acc_pointer_green","optic_Arco",["200Rnd_65x39_cased_Box",200],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["ACE_Banana",1],["ACE_elasticBandage",10],["ACE_CableTie",5],["ACE_EarPlugs",1],["ACE_morphine",1],["ACE_splint",2],["ACE_tourniquet",3],["ACE_WaterBottle",1],["16Rnd_9x21_Mag",1,17],["SmokeShellBlue",1,1]]],["V_PlateCarrier1_rgr",[["muzzle_snds_H_snd_F",1],["MiniGrenade",2,1],["SmokeShell",1,1],["200Rnd_65x39_cased_Box_Tracer_Red",1,200],["HandGrenade",2,1]]],["B_AssaultPack_rgr",[["200Rnd_65x39_cased_Box",2,200]]],"H_HelmetB","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]], true],
	[c_marksman,[["arifle_MXM_F","","ACE_acc_pointer_green","optic_DMS_weathered_Kir_F",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["ACE_Banana",1],["ACE_elasticBandage",10],["ACE_CableTie",5],["ACE_EarPlugs",1],["ACE_morphine",1],["ACE_splint",2],["ACE_tourniquet",3],["ACE_WaterBottle",1],["16Rnd_9x21_Mag",1,17],["SmokeShellBlue",1,1]]],["V_PlateCarrier1_rgr",[["muzzle_snds_H_snd_F",1],["MiniGrenade",2,1],["SmokeShell",1,1],["30Rnd_65x39_caseless_mag_Tracer",2,30],["30Rnd_65x39_caseless_mag",5,30],["HandGrenade",2,1]]],[],"H_HelmetB","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]], true],
	[c_medic,[["arifle_MX_F","","ACE_acc_pointer_green","optic_Arco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["ACE_Banana",1],["ACE_elasticBandage",10],["ACE_CableTie",5],["ACE_EarPlugs",1],["ACE_morphine",1],["ACE_splint",2],["ACE_tourniquet",3],["ACE_WaterBottle",1],["16Rnd_9x21_Mag",1,17],["SmokeShellBlue",1,1]]],["V_PlateCarrier1_rgr",[["muzzle_snds_H_snd_F",1],["MiniGrenade",2,1],["30Rnd_65x39_caseless_mag_Tracer",1,30],["30Rnd_65x39_caseless_mag",6,30],["SmokeShell",6,1],["HandGrenade",2,1]]],["B_TacticalPack_mcamo",[["ACE_elasticBandage",40],["ACE_bloodIV",5],["ACE_bloodIV_500",4],["ACE_bloodIV_250",5],["ACE_epinephrine",10],["ACE_morphine",15],["ACE_splint",10],["ACE_tourniquet",10],["ACE_surgicalKit",1]]],"H_HelmetB","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]], true]
];

////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_2035_NATO = [		
	"arifle_MX_F",
	"arifle_MXC_F"
];	

//Launcher avalaible for AT
launcherList_2035_NATO = [
	"launch_I_Titan_short_F",
	"launch_NLAW_F",
	"launch_MRAWS_olive_F"
];	

//Autorifle avalaible for autorifleman
autorifleList_2035_NATO = [
	"LMG_Mk200_F",
	"MMG_02_camo_F"
];	

//Rifle avalaible for marksman
marksmanrifleList_2035_NATO = [
	"arifle_MXM_F",
	"srifle_EBR_F",
	"srifle_DMR_06_camo_F"
];

//Smg avalaible for all unit
smgList_2035_NATO = [
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_NATO	= [
	"optic_Arco",
	"ACE_optic_Arco_2D",
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
	"optic_erco_snd_f",
	"optic_mrco"
];

//Long range scope avalaible for marksman
attachmentLongList_2035_NATO	= [
	"optic_dms",
	"optic_ams_snd",
	"optic_sos",
	"optic_khs_tan",
	"optic_nvs"
];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_2035_NATO = [
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
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"muzzle_snds_H_snd_F",
	"HandGrenade",
	"MiniGrenade",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_RangeCard"
	];

//item avalaible for all engineer
itemEngineerList_2035_NATO = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch"
	];

//item avalaible for all medic
itemMedicList_2035_NATO = [
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
backPackList_2035_NATO = [
	"B_TacticalPack_mcamo",
	"B_AssaultPack_rgr",
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_NATO = [
	"G_Combat",
	"G_Combat_Goggles_tna_F"
	];

//Magazine avalaible for all unit
magazineList_2035_NATO = [
	];