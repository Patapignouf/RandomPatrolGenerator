

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//French
civilian_group_French = ["C_Man_casual_7_F_euro", 
"C_Man_smart_casual_1_F_euro", 
"C_Man_smart_casual_2_F_euro"];

civilian_big_group_French = ["C_man_p_beggar_F_euro", 
"C_man_polo_4_F_euro", 
"C_man_shorts_1_F_euro", 
"C_man_shorts_2_F_euro", 
"C_scientist_02_formal_F", 
"C_scientist_01_formal_F", 
"C_scientist_02_informal_F"];

civilianTruck_French = ["C_SUV_01_F","C_Offroad_01_repair_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//French
baseEnemyGroup_French = ["I_C_Soldier_Bandit_4_F", 
"I_C_Soldier_Bandit_3_F", 
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_5_F", 
"I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_1_F"];

baseEnemyATGroup_French = ["I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_2_F",
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_8_F"];

baseEnemyDemoGroup_French = ["I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F",
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyMortarGroup_French = ["I_G_Mortar_01_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyVehicleGroup_French = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

baseEnemyLightArmoredVehicleGroup_French = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

baseEnemyHeavyArmoredVehicleGroup_French = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F"];

////////////////////////
//Vehicle management////
////////////////////////
//French
bluforUnarmedVehicle_French = [
	"B_AMF_VAB_ULTIMA_X8_F",
	"AMF_GBC180_PERS_01",
	"B_AMF_VAB_ULTIMA_X8_TDF_F"
	];

bluforArmedVehicle_French = [
	"amf_pvp_01_top_CE_f",
	"amf_pvp_01_mag_CE_f",
	"B_AMF_VAB_ULTIMA_TOP_X8_F",
	"AMF_VBMR_L_CE_01"
];

bluforUnarmedVehicleChopper_French = [
	"amf_cougar", 
	"AMF_panther_FRA", 
	"AMF_gazelle_afte_f", 
	"B_AMF_Heli_Transport_01_F", 
	"amf_nh90_tth_transport"
];

bluforArmedChopper_French = [
	"AMF_TIGRE_01",
	"AMF_gazelle_minigun_da_f"
	];

bluforDrone_French = [
	"B_AMF_REAPER_dynamicLoadout_F"
];

bluforBoat_French = [
	"CUP_B_RHIB_HIL",
	"CUP_B_Zodiac_USMC"
];

bluforFixedWing_French = [
	"AMF_RAFALE_B_01_F", 
	"B_AMF_PLANE_FIGHTER_02_F"
];

bluforHQVehicle_French = [
	"AMF_VBMR_COMMANDEMENT_CE",
	"AMF_GBC180_PERS_01"
];

////////////////////////
//Loadout management////
////////////////////////

c_leader = "leader";
c_Medic = "medic";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_mitrailleuseLourd762 = "mitrailleuse lourd 7.62 MAG ";
c_marksman = "marksman";
c_TireurdeprecisionHK417556 = "tireur de precision HK 417 5.56";
c_Tireurdelite50 = "tireur d'élite .50";
c_127ARME = "12.7 ARME";
c_127trepied = "12.7 trepied";
c_Mortier = "mortier";
c_Trepiedmortier = "trepied mortier";
c_TireurMMP = "tireur MMP";
c_TrepiedMMP = "trepied MMP";
c_Grenadier = "grenadier";
c_Radio = "radio";
c_Drone = "opérateur drone";
c_Pilot = "pilot";

listOfRoles_French = [c_leader,c_Medic,c_at,c_rifleman,c_engineer,c_autorifleman,c_mitrailleuseLourd762,c_marksman,c_TireurdeprecisionHK417556,c_Tireurdelite50,c_127ARME,c_127trepied,c_Mortier,c_Trepiedmortier,c_TireurMMP,c_TrepiedMMP,c_Grenadier,c_Radio,c_Drone,c_Pilot];

//French
loadout_French = [		
	[c_leader,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["ACE_splint",2],["ACE_morphine",2],["ACE_Fortify",1],["ACE_MapTools",1],["ACE_wirecutter",1],["SmokeShell",2,1],["SmokeShellGreen",3,1],["SmokeShellRed",3,1],["CUP_HandGrenade_M67",3,1],["DemoCharge_Remote_Mag",1,1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Medic,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_epinephrine",6]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",40],["ACE_tourniquet",4],["ACE_epinephrine",15],["ACE_morphine",15],["ACE_splint",10],["ACE_bloodIV",9],["ACE_bloodIV_500",18],["ACE_surgicalKit",1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_at,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],["CUP_launch_M136","","","",[],[],""],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_blk",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_rifleman,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_engineer,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["MineDetector",1],["ACE_DefusalKit",1],["ToolKit",1],["ACE_wirecutter",1],["CUP_PipeBomb_M",2,1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_autorifleman,[["amf_mini_mg_tactical_mk3","","","AMF_specter",["150Rnd_MINI_MG_mag_Tracer_red",150],[],""],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["150Rnd_MINI_MG_mag_Tracer_red",2,150]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["150Rnd_MINI_MG_mag_Tracer_red",3,150],["150Rnd_MINI_MG_mag_Tracer_green",3,150],["150Rnd_MINI_MG_mag_tracer_yellow",2,150]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_mitrailleuseLourd762,[["CUP_lmg_FNMAG_RIS_modern","","","AMF_specter",["150Rnd_762x51_Box_Tracer",150],[],""],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["150Rnd_762x51_Box_Tracer",1,150]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["150Rnd_762x51_Box_Tracer",5,150]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_marksman,[["CUP_arifle_Mk17_STD","muzzle_snds_B","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_schmidt_benderx4_tan",["20Rnd_762x51_Mag",20],[],"bipod_02_F_tan"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",5,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["20Rnd_762x51_Mag",6,20]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["ACE_Tripod",1],["ACE_SpottingScope",1],["ACE_Flashlight_XL50",1],["ACE_wirecutter",1],["ACE_Flashlight_KSF1",1],["ACE_Kestrel4500",1],["ACE_ATragMX",1],["ACE_RangeCard",1],["20Rnd_762x51_Mag",9,20]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Laserdesignator_02","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Tireurdeprecisionhk417556,[["AMF_714_long_tan_f","muzzle_snds_B_arid_F","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_schmidt_benderx4_tan",["20Rnd_762x51_HK417_mag",20],[],"bipod_02_F_tan"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",5,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["20Rnd_762x51_HK417_mag",8,20]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["ACE_Tripod",1],["ACE_SpottingScope",1],["ACE_Flashlight_XL50",1],["ACE_wirecutter",1],["ACE_Flashlight_KSF1",1],["ACE_Kestrel4500",1],["ACE_ATragMX",1],["ACE_RangeCard",1],["20Rnd_762x51_HK417_Tracer_red_mag",8,20]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_TireurDelite50,[["amf_perseis_ii_poly_02_F","","","optic_AMS",["7Rnd_Perseis_II_mag",7],[],""],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF_grn",[["16Rnd_9x21_Mag",7,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",4,1],["SmokeShellGreen",3,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["ACE_Tripod",1],["ACE_SpottingScope",1],["ACE_Flashlight_XL50",1],["ACE_wirecutter",1],["ACE_Flashlight_KSF1",1],["ACE_Kestrel4500",1],["ACE_ATragMX",1],["ACE_RangeCard",1],["7Rnd_Perseis_II_mag",21,7]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_127ARME,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_elasticBandage",6]]],["amf_SMB_GRE_FAMAS_TDF",[["ACE_elasticBandage",14],["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["CUP_B_M2_Gun_Bag",[]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_127trepied,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_elasticBandage",6]]],["amf_SMB_GRE_FAMAS_TDF",[["ACE_elasticBandage",14],["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["CUP_B_M2_Tripod_Bag",[]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Mortier,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_elasticBandage",6]]],["amf_SMB_GRE_FAMAS_TDF",[["ACE_elasticBandage",14],["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["B_Mortar_01_weapon_F",[]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Trepiedmortier,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_elasticBandage",6]]],["amf_SMB_GRE_FAMAS_TDF",[["ACE_elasticBandage",14],["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["B_Mortar_01_support_F",[]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_TireurMMP,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_elasticBandage",6]]],["amf_SMB_GRE_FAMAS_TDF",[["ACE_elasticBandage",14],["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_TVMMP_weapon",[]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_TrepiedMMP,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_elasticBandage",6]]],["amf_SMB_GRE_FAMAS_TDF",[["ACE_elasticBandage",14],["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_MMP_support",[]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Grenadier,[["CUP_arifle_HK416_AGL_Desert","","acc_pointer_IR","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],["CUP_1Rnd_HE_M203",1],""],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["30Rnd_556x45_Stanag_green",9,30]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["ACE_splint",2],["ACE_morphine",2],["ACE_MapTools",1],["ACE_HuntIR_monitor",1],["SmokeShell",2,1],["SmokeShellGreen",3,1],["SmokeShellRed",3,1],["CUP_HandGrenade_M67",3,1],["CUP_1Rnd_HE_M203",16,1],["ACE_HuntIR_M203",5,1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Radio,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["TFAR_anarc164",[["ACE_elasticBandage",20]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Drone,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_elasticBandage",6]]],["amf_SMB_GRE_FAMAS_TDF",[["ACE_elasticBandage",14],["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["B_UAV_01_backpack_F",[]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Laserdesignator_02","","","",["Laserbatteries",1],[],""],["ItemMap","B_UavTerminal","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Pilot,[["amf_hk_mp5_01_f","","","",["30Rnd_9x19_mag",30],[],""],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_pilot_01_f",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["ACE_elasticBandage",20],["ACE_morphine",3],["ACE_splint",4],["16Rnd_9x21_Mag",3,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["30Rnd_9x19_mag_red_Tracer",6,30]]],["B_Parachute",[]],"AMF_ALPHA900_02","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true]
];

////////////////////////
///Weapon management////
////////////////////////
//French
rifleList_French = [		
	"AMF_614_short_01_F",
	"AMF_614_long_01_F",
	"amf_hk_mp5_01_f",
	"AMF_614_long_FS5_TAN",
	"AMF_Samas_F1_01_F",
	"AMF_Samas_FELIN_01_F",
	"AMF_Samas_G2_01_F",
	"AMF_Samas_VALO_01_F",
	"amf_sig552"
];	

grenadeLauncherList_French =  [		
	"CUP_arifle_HK416_AGL_Desert"
];	

launcherList_French = [		
	"AMF_AT4CS_F",
	"AMF_LRAC89_F",
	"AMF_Eryx"
];	

autorifleList_French = [			
	"amf_mini_mg_01_f",
	"amf_mini_mg_tactical_mk3",
	"CUP_lmg_FNMAG_RIS_modern"
];	


marksmanrifleList_French = [		
	"CUP_arifle_Mk17_STD",
	"AMF_PGM_ULTIMA_RATIO_01_F",
	"AMF_Perseis_II_01_F",
	"AMF_Perseis_II_02_F",
	"AMF_RFF2_01_F",
	"AMF_714_long_tan_f",
	"CUP_arifle_Mk17_STD",
	"amf_perseis_ii_poly_02_F"
];

smgList_French = [		
	"amf_hk_mp5_01_f",
	"amf_hk_mp5_02_f"
];


//////////////////////////
//Attachement management//
//////////////////////////

//items avalaible for everyone (optics)
attachmentShortList_French	= [
	"AMF_Aimpoint_CompM5",
	"AMF_AIMPOINT_MICRO_T1",
	"AMF_AIMPOINT_MICRO_T2",
	"AMF_Aimpoint_Pro_Patrol",
	"AMF_ALPHA900",
	"AMF_AN_PEQ_15_black",
	"AMF_AN_PEQ_15_green",
	"AMF_AN_PEQ_15_painted",
	"AMF_AN_PEQ_15_tan",
	"amf_red_dot_sight",
	"amf_xps3_magnifier_side",
	"amf_specter",
	"AMF_EOTECH_553"
];

//Items avalaible only for marksman
attachmentLongList_French	= [
	"amf_scrome_j4",
	"amf_scrome_j8",
	"amf_schmidt_benderx4",
	"optic_lrps"
];


////////////////////////
////Items management////
////////////////////////

//Items avalaible for everyone
itemList_French = [
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
	"ACE_RangeCard"
	];

//items avalaible only for engineer
itemEngineerList_French = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
	];

//item avalaible only for medics
itemMedicList_French = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];


//backpack avalaible for all unit
backPackList_French = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"CUP_B_USMC_MOLLE_MG",
	"AMF_TVMMP_weapon",
	"AMF_MMP_support",
	"CUP_B_M2_Gun_Bag",
	"CUP_B_M2_Tripod_Bag",
	"AMF_rush24_01_TDF"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_French = [
	"amf_DCS_05_MTP",
	"amf_uniform_05_MTP",
	"amf_uniform_02_DA",
	"amf_jpc_02_TAN",
	"amf_uniform_03_TUNDRA"
	];

//Magazine avalaible for all unit
magazineList_French = [
	];