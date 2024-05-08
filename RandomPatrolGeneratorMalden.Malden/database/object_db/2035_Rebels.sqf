c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_grenadier = "grenadier";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

factionInfos pushBack ["_2035_Rebels", 18,"2035 Rebels", true, true, true];

//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Light civilian group
civilian_group_2035_Rebels = [
	"C_Man_1_enoch_F", 
	"C_Man_4_enoch_F", 
	"C_Man_2_enoch_F"
];

//Heavy civilian group
civilian_big_group_2035_Rebels = [
	"C_Farmer_01_enoch_F", 
	"C_Man_1_enoch_F", 
	"C_Man_6_enoch_F", 
	"C_Man_5_enoch_F", 
	"C_Man_4_enoch_F", 
	"C_Man_3_enoch_F", 
	"C_Man_2_enoch_F"
];

//Vehicle avalaible on civilian city
civilianTruck_2035_Rebels = [
	"C_Van_01_fuel_F", 
	"C_Tractor_01_F", 
	"C_Offroad_01_comms_F", 
	"C_Offroad_01_covered_F", 
	"C_Truck_02_transport_F", 
	"C_SUV_01_F"
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_2035_Rebels = [
	"I_L_Looter_Pistol_F", 
	"I_L_Looter_SG_F", 
	"I_L_Looter_Rifle_F", 
	"I_L_Looter_SMG_F", 
	"I_L_Criminal_SG_F", 
	"I_L_Criminal_SMG_F",
	"I_L_Criminal_SMG_F",
	"I_L_Criminal_SMG_F"
];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_2035_Rebels = [
	"I_L_Looter_Pistol_F", 
	"I_L_Looter_SG_F", 
	"I_L_Looter_Rifle_F", 
	"I_L_Hunter_F",
	"I_C_Soldier_Para_5_F",
	"I_C_Soldier_Para_5_F",
	"I_L_Hunter_F"
];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_2035_Rebels = [
	"I_C_Soldier_Bandit_2_F", 
	"I_C_Soldier_Bandit_8_F",
	"I_C_Soldier_Bandit_8_F", 
	"I_C_Soldier_Bandit_6_F"
];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_2035_Rebels = [
];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_2035_Rebels = [
	"I_G_Offroad_01_AT_F", 
	"I_G_Offroad_01_armed_F", 
	"I_G_Offroad_01_F", 
	"I_G_Van_01_transport_F"
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_2035_Rebels = [

];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_2035_Rebels = [

];



//Basic enemy aircraft avalaible
baseFixedWingGroup_2035_Rebels = [

];

////////////////////////
//Vehicle management////
////////////////////////


//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_2035_Rebels = [
	"C_Van_01_transport_F", 
	"C_Offroad_01_F", 
	"C_Truck_02_transport_F"
];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_2035_Rebels = [

];

//Chopper unarmed vehicle avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_2035_Rebels = [

];


//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_2035_Rebels = [

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_Rebels = [

];

//Drone vehicle avalaible for blufor
bluforDrone_2035_Rebels = [
	"C_UAV_06_medical_F", 
	"C_UAV_06_F"
];

//Boat vehicle avalaible for blufor
bluforBoat_2035_Rebels = [
	"C_Boat_Civil_01_F", 
	"C_Scooter_Transport_01_F", 
	"C_Boat_Transport_02_F"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_Rebels = [
	"C_Plane_Civil_01_F"
];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_2035_Rebels = [		
	[c_leader,"C_man_polo_1_F_euro"],
	[c_at,"C_man_polo_2_F_euro"],
	[c_rifleman,"C_man_polo_3_F_euro"],//Default stuff
	[c_grenadier,"C_man_polo_4_F_euro"],
	[c_engineer,"C_man_polo_5_F_euro"],
	[c_autorifleman,"C_man_polo_6_F_euro"],
	[c_marksman,"C_man_shorts_2_F_euro"],
	[c_medic,"C_man_shorts_4_F_euro"]
];


////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_2035_Rebels = [		
	"sgun_HunterShotgun_01_F",
	"sgun_HunterShotgun_01_sawedoff_F",
	"CUP_sgun_slamfire",
	"CUP_srifle_LeeEnfield"
];	

grenadeLauncherList_2035_Rebels = [

];

//Launcher avalaible for AT
launcherList_2035_Rebels = [

];	

//Autorifle avalaible for autorifleman
autorifleList_2035_Rebels = [

];	

//Rifle avalaible for marksman
marksmanrifleList_2035_Rebels = [
	"CUP_srifle_Remington700",
	"CUP_hgun_Colt1911"
];

//Smg avalaible for all unit
smgList_2035_Rebels = [
	"hgun_Pistol_heavy_02_F"
];

//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_2035_Rebels	= [

];

//Long range scope avalaible for marksman
attachmentLongList_2035_Rebels	= [

];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_2035_Rebels = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"Binocular",
	"ACE_MapTools",
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
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed"
	];

//item avalaible for all engineer
itemEngineerList_2035_Rebels = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter",
	"ACE_Fortify",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch"
	];

//item avalaible for all medic
itemMedicList_2035_Rebels = [
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
	"ACE_suture",
	"ACE_bodyBag"
	];


//backpack avalaible for all unit
backPackList_2035_Rebels = [
	"B_CivilianBackpack_01_Sport_Blue_F",
	"B_FieldPack_blk",
	"B_FieldPack_cbr"
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_Rebels = [
	"U_C_HunterBody_grn",
	"U_Marshal",
	"U_C_Journalist",
	"U_C_HunterBody_brn"
	];

//Magazine avalaible for all unit
magazineList_2035_Rebels = [
	"2Rnd_12Gauge_Pellets",
	"2Rnd_12Gauge_Slug",
	"6Rnd_45ACP_Cylinder",
	"CUP_10x_303_M",
	"CUP_1Rnd_12Gauge_Pellets_No00_Buck",
	"CUP_7Rnd_45ACP_1911"
	];