#include "..\classConstant.sqf"

//Add specific DSF factions
factionID = factionID+1;

// if (isClass (configFile >> "CfgWeapons" >> "FP_MPC_Car")) then 
// {
	factionInfos pushBack ["_2035_PataCompany", factionID,"[MOD] PataCompany", true, false, false];
// };


////////////////////////f
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_2035_PataCompany = [
	"Atlas_B_L_Quadbike_01_F",
	"Atlas_B_L_LSV_01_unarmed_F",
	"Atlas_B_L_Truck_01_covered_F"
];

bluforArmedVehicle_2035_PataCompany = [

];


bluforStaticWeapon_2035_PataCompany = 
[

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_2035_PataCompany = [
	"Atlas_B_L_AFV_Wheeled_01_cannon_F"
];

bluforUnarmedVehicleChopper_2035_PataCompany = [
	"B_Heli_Light_01_F",
	"C_IDAP_Heli_Transport_02_F"
];

bluforArmedChopper_2035_PataCompany = [

];

bluforDrone_2035_PataCompany = [
	"Atlas_B_L_UAV_01_F",
	"Atlas_B_L_UAV_07_F"
]; 

bluforBoat_2035_PataCompany = [
	"C_Boat_Civil_01_F",
	"FP_PMC_OG_G_RHIB"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_2035_PataCompany = [
	"Atlas_O_T_Plane_Fighter_03_dynamicLoadout_F",
	"Atlas_B_A_Plane_Transport_01_infantry_F",
	"Atlas_B_A_Plane_Transport_01_vehicle_F"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_2035_PataCompany = [

];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_2035_PataCompany = [		
	[c_leader, [["atlas_arifle_famasF1_F","","","",["Atlas_25Rnd_556x45_Famas_red",25],["1Rnd_40mm_HE_lxWS",1],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Atlas_25Rnd_556x45_Famas_Tracer_Green",2,25]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Atlas_25Rnd_556x45_Famas_Tracer_Green",5,25]]],[],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]],
	[c_rifleman, [["atlas_arifle_famasF1_F","","","",["Atlas_25Rnd_556x45_Famas_red",25],["1Rnd_40mm_HE_lxWS",1],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Atlas_25Rnd_556x45_Famas_Tracer_Green",2,25]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Atlas_25Rnd_556x45_Famas_Tracer_Green",5,25]]],[],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]],//Default stuff
	//[c_drone, [[["atlas_arifle_famasF1_F","","","",["Atlas_25Rnd_556x45_Famas_red",25],["1Rnd_40mm_HE_lxWS",1],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Atlas_25Rnd_556x45_Famas_Tracer_Green",2,25]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Atlas_25Rnd_556x45_Famas_Tracer_Green",5,25]]],[],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]]],//Default stuff	
	[c_engineer, [["atlas_arifle_famasF1_F","","","",["Atlas_25Rnd_556x45_Famas_red",25],["1Rnd_40mm_HE_lxWS",1],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Atlas_25Rnd_556x45_Famas_Tracer_Green",2,25]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Atlas_25Rnd_556x45_Famas_Tracer_Green",5,25]]],["B_AssaultPack_khk",[["ACE_DefusalKit",1],["ACE_EntrenchingTool",1],["ACE_Fortify",1],["ACE_wirecutter",1],["ToolKit",1]]],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]],
	[c_autorifleman, [["LMG_03_khk_F","","","",["200Rnd_556x45_Box_F",200],[],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["200Rnd_556x45_Box_Tracer_Red_F",1,200]]],["B_AssaultPack_khk",[["200Rnd_556x45_Box_Tracer_Red_F",4,200]]],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]],
	[c_medic, [["atlas_arifle_famasF1_F","","","",["Atlas_25Rnd_556x45_Famas_red",25],["1Rnd_40mm_HE_lxWS",1],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Atlas_25Rnd_556x45_Famas_Tracer_Green",2,25]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Atlas_25Rnd_556x45_Famas_Tracer_Green",5,25]]],["B_AssaultPack_khk",[["ACE_bloodIV",5],["ACE_bloodIV_500",5],["ACE_tourniquet",5],["ACE_elasticBandage",40],["ACE_morphine",2],["ACE_epinephrine",5],["ACE_suture",40],["ACE_surgicalKit",1],["ACE_painkillers",1,10]]],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]], //Taken from Navy (No medic in USMC)
	[c_pilot,"B_Fighter_Pilot_F"],
	[c_at, [["atlas_arifle_famasF1_F","","","",["Atlas_25Rnd_556x45_Famas_red",25],["1Rnd_40mm_HE_lxWS",1],""],["ACE_launch_NLAW_ready_F","","","",["NLAW_F",1],[],""],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Atlas_25Rnd_556x45_Famas_Tracer_Green",2,25]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Atlas_25Rnd_556x45_Famas_Tracer_Green",5,25]]],[],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]],
	[c_marksman, [["Aegis_arifle_SR25_khk_F","","","optic_LRPS",["Aegis_20Rnd_762x51_SMAG",20],[],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Aegis_20Rnd_762x51_Tracer_Yellow_Sand_SMAG",3,20]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Aegis_20Rnd_762x51_Tracer_Yellow_Sand_SMAG",4,20]]],[],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]],
	[c_sniper, [["Aegis_arifle_SR25_khk_F","","","optic_LRPS",["Aegis_20Rnd_762x51_SMAG",20],[],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Aegis_20Rnd_762x51_Tracer_Yellow_Sand_SMAG",3,20]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Aegis_20Rnd_762x51_Tracer_Yellow_Sand_SMAG",4,20]]],[],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]],
	[c_grenadier, [["atlas_arifle_famasF1_F","","","",["Atlas_25Rnd_556x45_Famas_red",25],["1Rnd_40mm_HE_lxWS",1],""],[],["hgun_G17_F","","","",["17Rnd_9x21_Mag",17],[],""],["Atlas_U_B_CombatUniform_ffl_vest",[["FirstAidKit",1],["ACE_elasticBandage",10],["ACE_painkillers",1,10],["Atlas_25Rnd_556x45_Famas_Tracer_Green",2,25]]],["V_TacVest_oli",[["17Rnd_9x21_Mag",1,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Atlas_25Rnd_556x45_Famas_Tracer_Green",5,25]]],[],"H_HelmetSpecB_green","G_Tactical_Yellow",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],[]]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_2035_PataCompany = [	
	"atlas_arifle_famasF1_F",
	"atlas_arifle_famasF1_Grip_F",
	"hgun_G17_F"
];	



//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_2035_PataCompany = [		

];



launcherList_2035_PataCompany = [		
	"NLAW_F"
];	



autorifleList_2035_PataCompany = [	
	"LMG_03_khk_F"
];	

marksmanrifleList_2035_PataCompany = [		
	"Aegis_arifle_SR25_khk_F"
];


smgList_2035_PataCompany = [		
];




//////////////////////////
attachmentShortList_2035_PataCompany	= [

];

attachmentLongList_2035_PataCompany	= [
	"optic_LRPS"
];

////////////////////////
////Items management////
////////////////////////
itemList_2035_PataCompany = [
	"Binocular",
	"JAM_NV_Gloves_Wool_blk",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard"
];

itemEngineerList_2035_PataCompany = [
	"DemoCharge_Remote_Mag",
	"Laserdesignator"
];
	
itemMedicList_2035_PataCompany = [

];

//backpack avalaible for all unit
backPackList_2035_PataCompany = [
	"B_Kitbag_cbr",
	"B_AssaultPack_cbr",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green",
	"B_parachute",
	"ace_gunbag_Tan",
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"B_AssaultPack_khk",
	"B_AssaultPack_blk",
	"B_Carryall_blk"
];




//Uniform, vest, headgear, avalaible for all unit
uniformList_2035_PataCompany = [
	//head
	"H_HelmetSpecB_green",
	"H_EarProtectors_sand_F",
	"H_HelmetSpecB_light_grass",
	"H_HelmetSpecB_light_black",
	
	//Glasses 
	"G_Tactical_Yellow",
	"G_Bandanna_khk",
	"G_Bandanna_blk",
	"G_Balaclava_blk",

	//vest
	"V_TacVest_oli",
	"V_Chestrig_blk",
	"V_TacVest_blk",
	"V_TacVest_oli",
	"V_lxWS_TacVestIR_oli",
	"V_HarnessOSpec_blk",
	//"V_CarrierRigKBT_01_light_Black_F",


	//Holster 


	//Costume
	"U_lxWS_ION_Casual3",
	"U_lxWS_ION_Casual6",
	"U_lxWS_ION_Casual2",
	"U_lxWS_ION_Casual4",
	"U_C_ArtTShirt_01_v4_F",
	"U_I_C_Soldier_Bandit_3_F",
	"U_C_Man_casual_7_F",
	"U_B_ION_Uniform_01_poloshirt_blue_F",
	"U_B_ION_Uniform_01_poloshirt_wdl_F",
	"U_B_ION_Uniform_01_tshirt_black_F",
	"U_O_R_Gorka_01_black_F",

	//uniform
	"Atlas_U_B_CombatUniform_ffl_vest"
];


uniformListSniper_2035_PataCompany = [
	"U_B_GhillieSuit",
	"U_B_FullGhillie_ard",
	"Laserdesignator", //Add laser designator only for sniper
	"ACE_Tripod"
];

//Magazine avalaible for all unit
magazineList_2035_PataCompany = 	[
	"HandGrenade"
];




