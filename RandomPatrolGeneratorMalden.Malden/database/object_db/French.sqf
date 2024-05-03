//Add specific AMF factions
if (isClass (configFile >> "CfgPatches" >> "AMF_Patches")) then 
{
	factionInfos pushBack ["_French", 4,"French [AMF][ACE]", true, false, false];
};


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
	"B_AMF_VAB_ULTIMA_TOP_X8_F"
	
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
	"AMF_RAFALE_M_01_F",
	"AMF_RAFALE_C_01_F",
	"AMF_RAFALE_B_01_F",
	"B_AMF_PLANE_FIGHTER_02_F",
	"B_AMF_PLANE_TRANSPORT_01_F"
];

bluforHQVehicle_French = [
	"AMF_VBMR_COMMANDEMENT_CE",
	"AMF_GBC180_PERS_01"
];

bluforArmoredVehicle_French = [
	"AMF_VBMR_HMG_TDF", 
	"AMF_VBCI_TDF_01_F", 
	"AMF_VBCI_CE_01_F", 
	"AMF_EBRC_CE_01", 
	"AMF_EBRC_TDF_01", 
	"AMF_VBMR_L_CE_01",
	"B_AMF_AMX10_RCR_SEPAR_02_F", 
	"B_AMF_AMX10_RCR_01_F", 
	"B_AMF_TANK_01", 
	"B_AMF_TANK_TDF_01_F"
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


//French
loadout_French = [		
	[c_leader,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["ACE_splint",2],["ACE_morphine",2],["ACE_Fortify",1],["ACE_MapTools",1],["ACE_wirecutter",1],["SmokeShell",2,1],["SmokeShellGreen",3,1],["SmokeShellRed",3,1],["CUP_HandGrenade_M67",3,1],["DemoCharge_Remote_Mag",1,1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_Medic,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1],["ACE_epinephrine",6]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",40],["ACE_tourniquet",4],["ACE_epinephrine",15],["ACE_morphine",15],["ACE_splint",10],["ACE_bloodIV",9],["ACE_bloodIV_500",18],["ACE_surgicalKit",1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_at,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],["AMF_AT4CS_F","","","",[],[],""],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_blk",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_rifleman,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_engineer,[["AMF_614_long_FS5_TAN","","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_xps3_magnifier_side_tan",["30Rnd_556x45_Stanag",30],[],"amf_acc_614_grip12"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["30Rnd_556x45_Stanag_green",9,30],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["MineDetector",1],["ACE_DefusalKit",1],["ToolKit",1],["ACE_wirecutter",1],["CUP_PipeBomb_M",2,1]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_autorifleman,[["amf_mini_mg_tactical_mk3","","","AMF_specter",["150Rnd_MINI_MG_mag_Tracer_red",150],[],""],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["150Rnd_MINI_MG_mag_Tracer_red",2,150]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["150Rnd_MINI_MG_mag_Tracer_red",3,150],["150Rnd_MINI_MG_mag_Tracer_green",3,150],["150Rnd_MINI_MG_mag_tracer_yellow",2,150]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_mitrailleuseLourd762,[["CUP_lmg_FNMAG_RIS_modern","","","AMF_specter",["150Rnd_762x51_Box_Tracer",150],[],""],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["150Rnd_762x51_Box_Tracer",1,150]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["150Rnd_762x51_Box_Tracer",5,150]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ACE_Altimeter",""]], true],
	[c_marksman,[["CUP_arifle_Mk17_STD","muzzle_snds_B","CUP_acc_ANPEQ_15_Flashlight_Tan_L","AMF_schmidt_benderx4_tan",["CUP_20Rnd_762x51_B_SCAR",20],[],"bipod_02_F_tan"],[],["AMF_Glock_17_TAN","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE_OD",[["ACE_tourniquet",4],["ACE_microDAGR",1],["ACE_CableTie",5],["ACE_morphine",4],["ACE_splint",4],["ACE_EarPlugs",1]]],["amf_SMB_GRE_FAMAS_TDF",[["16Rnd_9x21_Mag",3,17],["CUP_HandGrenade_M67",2,1],["SmokeShell",2,1],["SmokeShellGreen",2,1],["20Rnd_762x51_Mag",6,20],["CUP_20Rnd_762x51_B_SCAR",1,20]]],["AMF_rush24_01_TDF",[["ACE_elasticBandage",25],["ACE_EntrenchingTool",1],["ACE_Tripod",1],["ACE_SpottingScope",1],["ACE_Flashlight_XL50",1],["ACE_wirecutter",1],["ACE_Flashlight_KSF1",1],["ACE_Kestrel4500",1],["ACE_ATragMX",1],["ACE_RangeCard",1],["20Rnd_762x51_Mag",9,20],["CUP_20Rnd_762x51_B_SCAR",5,20]]],"AMF_OPSCORE_TAN2","amf_balaclava_sording_rangerod",["Laserdesignator_02","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","ACE_Altimeter",""]], true],
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
	"AMF_614_long_FS5_BLK",
	"AMF_614_short_FS5_BLK",
	"amf_sig552",
	"AMF_614_short_FS4_TAN",
	"arifle_SPAR_01_snd_F",
	"arifle_SPAR_01_blk_F",
	"arifle_SPAR_01_khk_F",
	"AMF_Glock_17",
	"AMF_Glock_17_BLK",
	"AMF_Glock_17_TAN",
	"arifle_SPAR_01_snd_F",
	"arifle_SPAR_01_blk_F",
	"arifle_SPAR_01_khk_F",
	"CUP_arifle_HK416_Desert",
	"CUP_arifle_HK416_CQB_Desert",
	"AMF_Pamas"
];	

grenadeLauncherList_French =  [		
	//CUP 
	"CUP_arifle_HK416_AGL_Desert",
	"CUP_arifle_HK416_AGL_Wood",
	"CUP_arifle_HK416_CQB_AG36",
	"CUP_arifle_HK416_CQB_M203_Desert",
	"CUP_arifle_HK416_CQB_AG36_Wood",
	"CUP_arifle_HK_M27_AG36",

	//Vanilla
	"arifle_SPAR_01_GL_snd_F",
	"arifle_SPAR_01_GL_blk_F",
	"arifle_SPAR_01_GL_khk_F"	
];	

launcherList_French = [		
	"AMF_AT4CS_F",
	"AMF_LRAC89_F",
	"AMF_Eryx"
];	

autorifleList_French = [			
	"amf_mini_mg_01_f",
	"amf_mini_mg_tactical_mk3",
	"CUP_lmg_FNMAG_RIS_modern",
	"LMG_03_F"
];	


marksmanrifleList_French = [		
	//AMF 
	"AMF_PGM_ULTIMA_RATIO_01_F",
	"AMF_Perseis_II_01_F",
	"AMF_Perseis_II_02_F",
	"AMF_RFF2_01_F",
	"AMF_714_long_tan_f",
	"amf_perseis_ii_poly_02_F",

	//CUP variant
	"CUP_arifle_Mk17_STD",
	"CUP_arifle_Mk20",
	"CUP_arifle_HK417_20",
	"CUP_arifle_HK417_20_Desert",

	//Vanilla variant
	"arifle_SPAR_03_snd_F",
	"arifle_SPAR_03_blk_F",
	"arifle_SPAR_03_khk_F"
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
	//AMF optics
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
	"amf_xps3_magnifier_up",
	"amf_specter",
	"AMF_EOTECH_553",
	"AMF_EOTECH_553_painted",
	"AMF_xps3",
	"AMF_exps3_magnifier_side",
	"AMF_exps3_magnifier_up",

	//Vanilla optics
	"optic_Holosight",
	"optic_Holosight",
	"optic_Holosight_arid_F",
	"optic_Holosight_blk_F",
	"optic_Holosight_khk_F",
	"optic_Holosight_lush_F",
	"optic_Holosight_smg",
	"optic_Holosight_smg_blk_F",
	"optic_Holosight_smg_khk_F",
	"optic_MRCO" // ACOG basic style
];

//Items avalaible only for marksman
attachmentLongList_French	= [
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
itemList_French = [
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
itemEngineerList_French = [
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

//item avalaible only for medics
itemMedicList_French = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
	];


//backpack avalaible for all unit
backPackList_French = [
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"CUP_B_USMC_MOLLE_MG",
	"AMF_TVMMP_weapon",
	"AMF_WiredMMP_weapon",
	"AMF_MMP_support",
	"CUP_B_M2_Gun_Bag",
	"CUP_B_M2_Tripod_Bag",
	"AMF_rush24_01_TDF",
	"amf_tecpack_30L",
	"TFAR_rt1523g",
	"TFAR_rt1523g_sage",
	"AMF_FELIN_BACKPACK_BME",
	"AMF_FELIN_BACKPACK_MEDIC_BME",
	"AMF_FELIN_BACKPACK_TDF",
	"AMF_FELIN_BACKPACK_MEDIC_TDF",
	"AMF_FELIN_BACKPACK_TAN",
	"AMF_FELIN_BACKPACK_MEDIC_TAN"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_French = [
	"amf_DCS_05_MTP",
	"amf_uniform_05_MTP",
	"amf_uniform_02_DA",
	"amf_jpc_01_TAN",
	"amf_jpc_01_MTP",
	"amf_jpc_01_BME",
	"amf_jpc_02_TAN",
	"amf_jpc_02_MTP",
	"amf_jpc_02_BME",
	"amf_jpc_03_TAN",
	"amf_jpc_03_MTP",
	"amf_jpc_03_BME",
	"amf_uniform_03_TUNDRA",
	"amf_uniform_01_CE_HS",
	"AMF_OPSCORE2_GREY_2",
	"AMF_OPSCORE2_OD1",
	"AMF_OPSCORE2_OD1_2",
	"AMF_OPSCORE2_TAN1",
	"AMF_OPSCORE2_TAN1_2",
	"AMF_OPSCORE3_TAN2_2_2",
	"AMF_OPSCORE2_BLACK",
	"AMF_OPSCORE2_BLACK_2",
	"AMF_OPSCORE_TAN2_2",
	"AMF_OPSCORE_TAN2",
	"amf_uniform_01_RE_NG_CE_HS",
	"amf_uniform_01_CE_MD",
	"amf_uniform_01_BM_HS",
	"amf_uniform_01_RE_BM_HX",
	"amf_DCS_01_MTP",
	"amf_JPC_01_MTP",
	"amf_SMB_AUXSAN_FAMAS_TDF",
	"amf_SMB_FUS_TDF",
	"amf_SMB_FUS_TAN",
	"amf_SMB_FUS_BME",
	"amf_DCS_04_RG",
	"amf_balaclava_tan",

	//desert 
	"AMF_Casque_F1_DA",
	"AMF_SPECTRA_2_DA",
	"amf_balaclava_sordin_tantan",
	"amf_uniform_01_RE_NG_DA_HS",
	"amf_uniform_01_NG_DA_HX",
	"amf_uniform_01_RE_DA_HX",
	"amf_uniform_03_NG_DA_HS",
	"amf_uniform_03_NG_SE_HS",



	"U_B_CombatUniform_mcam_tshirt", //vanilla
	"V_Chestrig_khk",//vanilla
	"H_HelmetB_grass", //vanilla

	//Uniform winter 
	"amf_uniform_01_TU_HX",
	"amf_uniform_01_RE_TU_HX",
	"amf_uniform_01_TU_MD",
	"amf_uniform_01_TC_HS",
	"amf_uniform_02_TU_HS",
	"amf_uniform_02_TC_HS"
	];

//Magazine avalaible for all unit
magazineList_French = [
	"30Rnd_556x45_Stanag_Tracer_Green",
	"CUP_1Rnd_HEDP_M203",
	"CUP_1Rnd_HE_M203",
	"CUP_FlareWhite_M203",
	"CUP_HandGrenade_M67",
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"Laserbatteries"
	];