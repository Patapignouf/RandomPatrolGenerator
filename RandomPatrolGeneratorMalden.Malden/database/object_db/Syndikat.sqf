c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Syndikat
civilian_group_Syndikat = ["C_Man_casual_8_F_tanoan", 
"C_Man_casual_6_v2_F_tanoan", 
"C_Man_casual_2_F_tanoan"];

civilian_big_group_Syndikat = ["C_man_sport_2_F_tanoan", 
"C_Man_casual_1_F_tanoan", 
"C_Man_casual_3_F_tanoan", 
"C_Man_casual_6_v2_F_tanoan", 
"C_Man_formal_4_F_tanoan", 
"C_Man_casual_5_F_tanoan" ];

civilianTruck_Syndikat = ["C_Truck_02_transport_F"];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//Syndikat
baseEnemyGroup_Syndikat = ["I_C_Soldier_Bandit_4_F", 
"I_C_Soldier_Bandit_3_F", 
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_5_F", 
"I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_1_F"];

baseEnemyATGroup_Syndikat = ["I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_2_F",
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_8_F"];

baseEnemyDemoGroup_Syndikat = ["I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F",
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyMortarGroup_Syndikat = ["I_G_Mortar_01_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyVehicleGroup_Syndikat = ["I_C_Offroad_02_LMG_F", 
"I_C_Offroad_02_AT_F", 
"CUP_I_M151_M2_SYND", 
"I_C_Offroad_02_unarmed_F"];

baseEnemyLightArmoredVehicleGroup_Syndikat = ["CUP_I_Hilux_zu23_IND_G_F", 
"CUP_I_Hilux_armored_DSHKM_IND_G_F"];

baseEnemyHeavyArmoredVehicleGroup_Syndikat = ["CUP_I_MTLB_pk_SYNDIKAT"];

////////////////////////
//Vehicle management////
////////////////////////
//Syndikat
bluforUnarmedVehicle_Syndikat = ["B_AMF_VAB_ULTIMA_X8_F"];

bluforArmedVehicle_Syndikat = ["amf_pvp_01_CE_f","B_AMF_VAB_ULTIMA_TOP_X8_F","AMF_VBMR_L_CE_01"];

bluforUnarmedVehicleChopper_Syndikat = ["ffaa_nh90_tth_transport","AMF_gazelle_afte_f","ffaa_famet_cougar"];


bluforDrone_Syndikat = ["B_UAV_02_dynamicLoadout_F"
];

bluforBoat_Syndikat = ["CUP_B_RHIB_HIL",
"CUP_B_Zodiac_USMC"
];

////////////////////////
//Loadout management////
////////////////////////

//Syndikat
loadout_Syndikat = [		
	[c_leader,"I_C_Soldier_Bandit_4_F"],
	[c_at,"I_C_Soldier_Bandit_2_F"],
	[c_rifleman,"I_C_Soldier_Bandit_5_F"],//Default stuff
	[c_engineer,"I_C_Soldier_Para_8_F"],
	[c_autorifleman,"I_C_Soldier_Bandit_3_F"],
	[c_marksman,"I_G_Sharpshooter_F"],
	[c_medic,"I_C_Soldier_Bandit_1_F"]
];

//Stuff sample
// [["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Bandit_1_F",[["FirstAidKit",1],["30Rnd_545x39_Mag_F",2,30]]],["V_BandollierB_rgr",[["30Rnd_545x39_Mag_F",3,30],["MiniGrenade",2,1]]],[],"","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Bandit_4_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30],["MiniGrenade",1,1]]],["V_BandollierB_blk",[["30Rnd_762x39_Mag_F",4,30],["MiniGrenade",1,1]]],[],"","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["LMG_03_F","","","",["200Rnd_556x45_Box_F",200],[],""],[],["hgun_Pistol_01_F","","","",["10Rnd_9x21_Mag",10],[],""],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_9x21_Mag",2,10]]],["V_Chestrig_blk",[["200Rnd_556x45_Box_F",2,200]]],[],"","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],["launch_RPG7_F","","","",["RPG7_F",1],[],""],[],["U_I_C_Soldier_Para_5_F",[["FirstAidKit",1],["30Rnd_545x39_Mag_F",1,30]]],[],["B_Kitbag_cbr_Para_5_F",[["30Rnd_545x39_Mag_F",4,30],["RPG7_F",3,1]]],"","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_3_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],[],["B_Kitbag_rgr_Para_3_F",[["Medikit",1],["FirstAidKit",4],["30Rnd_762x39_Mag_F",4,30]]],"","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
// [["srifle_DMR_06_camo_F","","","",["20Rnd_762x51_Mag",20],[],""],[],[],["U_I_C_Soldier_Para_3_F",[["FirstAidKit",1]]],[],["B_Kitbag_rgr_Para_3_F",[["Medikit",1],["FirstAidKit",4]]],"","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]

////////////////////////
///Weapon management////
////////////////////////
//Syndikat
rifleList_Syndikat = [		
	"arifle_AKS_F",
	"arifle_AKM_F"
];	

launcherList_Syndikat = [		
	"launch_RPG7_F"
];	

autorifleList_Syndikat = [			
	"LMG_03_F"
];	


marksmanrifleList_Syndikat = [		
	"srifle_DMR_06_camo_F"
];

smgList_Syndikat = [		
	
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_Syndikat	= [
	
];

attachmentLongList_Syndikat	= [
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_11_4x20_PM_pip",
	"CUP_optic_SB_3_12x50_PMII",
	"CUP_optic_SB_3_12x50_PMII_PIP",
	"CUP_optic_LeupoldMk4",
	"CUP_optic_CWS",
	"CUP_optic_CWS_NV",
	"CUP_optic_CWS_NV_RDS"
];

////////////////////////
////Items management////
////////////////////////
itemList_Syndikat = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"NVGoggles",
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
	"ACE_IR_Strobe_Item"
	];

itemEngineerList_Syndikat = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", "ACE_Fortify"
	];
	
itemMedicList_Syndikat = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];