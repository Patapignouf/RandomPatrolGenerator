#include "..\classConstant.sqf"

//Add specific DSF factions
factionID = factionID+1;
if (isClass (configFile >> "CfgWeapons" >> "FP_MPC_Car")) then 
{
	factionInfos pushBack ["_FP_GIGN", factionID,"[F+] GIGN", true, false, false];
};



////////////////////////f
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_FP_GIGN = [
	"B_GEN_Offroad_01_gen_F",
	"B_GEN_Van_02_vehicle_F",
	"B_GEN_Offroad_01_comms_F",
	"B_GEN_Offroad_01_covered_F",
	"B_GEN_Van_02_transport_F"
];

bluforArmedVehicle_FP_GIGN = [

];


bluforStaticWeapon_FP_GIGN = 
[

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_FP_GIGN = [

];

bluforUnarmedVehicleChopper_FP_GIGN = [
"I_Heli_Transport_02_F"
];

bluforArmedChopper_FP_GIGN = [

];

bluforDrone_FP_GIGN = [
	"C_IDAP_UAV_01_F",
	"C_IDAP_UAV_06_antimine_F"
]; 

bluforBoat_FP_GIGN = [
	"C_Boat_Civil_01_F",
	"FP_PMC_OG_G_RHIB"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_FP_GIGN = [
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_FP_GIGN = [
	"B_GEN_Offroad_01_comms_F"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_FP_GIGN = [		
	[c_leader, [["arifle_SPAR_01_blk_F","muzzle_snds_M","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_556x45_Stanag",30],[],""],[],["rhsusf_weap_glock17g4","rhsusf_acc_omega9k","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_g3_blk",[["rhsusf_mag_17Rnd_9x19_JHP",2,17],["30Rnd_556x45_Stanag_Tracer_Red",3,30]]],["V_PlateCarrier2_blk",[["FirstAidKit",2],["rhsusf_mag_17Rnd_9x19_JHP",5,17],["30Rnd_556x45_Stanag_Tracer_Red",5,30],["rhs_grenade_mkiiia1_mag",1,1]]],["B_AssaultPack_blk",[]],"FAST_COVER_BLACK_FULL","G_Balaclava_TI_G_blk_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	["shield", [[],[],["KA_SR2M","KA_SR2M_Suppressor","KA_VANT_VM_Laser_Black_Dipped","KA_KP_SR2",["KA_30Rnd_9x21_SP10_AP_Mag",30],[],""],["rhs_uniform_g3_blk",[["KA_30Rnd_9x21_SP10_AP_Mag",4,30]]],["V_PlateCarrier2_blk",[["FirstAidKit",2],["rhs_grenade_mkiiia1_mag",1,1],["KA_30Rnd_9x21_SP10_AP_Mag",9,30]]],["B_AssaultPack_blk",[]],"FAST_COVER_BLACK_FULL","G_Balaclava_TI_G_blk_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],//Default stuff
	[c_rifleman, [["arifle_SPAR_01_blk_F","muzzle_snds_M","acc_pointer_IR","optic_Yorris",["30Rnd_556x45_Stanag",30],[],""],[],["rhsusf_weap_glock17g4","rhsusf_acc_omega9k","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_g3_blk",[["rhsusf_mag_17Rnd_9x19_JHP",2,17],["30Rnd_556x45_Stanag_Tracer_Red",3,30]]],["V_PlateCarrier2_blk",[["FirstAidKit",2],["rhsusf_mag_17Rnd_9x19_JHP",5,17],["30Rnd_556x45_Stanag_Tracer_Red",5,30],["rhs_grenade_mkiiia1_mag",1,1]]],["B_AssaultPack_blk",[]],"FAST_COVER_BLACK_FULL","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],//Default stuff
	[c_drone, [["arifle_SPAR_01_blk_F","muzzle_snds_M","acc_pointer_IR","optic_Yorris",["30Rnd_556x45_Stanag",30],[],""],[],["rhsusf_weap_glock17g4","rhsusf_acc_omega9k","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_g3_blk",[["rhsusf_mag_17Rnd_9x19_JHP",2,17],["30Rnd_556x45_Stanag_Tracer_Red",3,30]]],["V_PlateCarrier2_blk",[["FirstAidKit",2],["rhsusf_mag_17Rnd_9x19_JHP",5,17],["30Rnd_556x45_Stanag_Tracer_Red",5,30],["rhs_grenade_mkiiia1_mag",1,1]]],["B_UAV_06_backpack_F",[]],"FAST_COVER_BLACK_FULL","G_Balaclava_TI_G_blk_F",[],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch",""]]],//Default stuff	
	[c_engineer, [["arifle_SPAR_01_blk_F","muzzle_snds_M","acc_pointer_IR","optic_Yorris",["30Rnd_556x45_Stanag",30],[],""],[],["rhsusf_weap_glock17g4","rhsusf_acc_omega9k","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_g3_blk",[["rhsusf_mag_17Rnd_9x19_JHP",2,17],["30Rnd_556x45_Stanag_Tracer_Red",3,30]]],["V_PlateCarrier2_blk",[["FirstAidKit",2],["rhsusf_mag_17Rnd_9x19_JHP",5,17],["30Rnd_556x45_Stanag_Tracer_Red",5,30],["rhs_grenade_mkiiia1_mag",1,1]]],["B_AssaultPack_blk",[["ToolKit",1],["MineDetector",1],["FirstAidKit",2],["DemoCharge_Remote_Mag",2,1]]],"FAST_COVER_BLACK_FULL","G_Balaclava_TI_G_blk_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_autorifleman, [["FP_M249_v1","rhsusf_acc_SF3P556","acc_pointer_IR","optic_Holosight_smg_blk_F",["rhsusf_200Rnd_556x45_box",200],[],"rhsusf_acc_saw_bipod"],[],["rhsusf_weap_glock17g4","rhsusf_acc_omega9k","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_g3_blk",[["rhsusf_mag_17Rnd_9x19_JHP",5,17]]],["V_PlateCarrier2_blk",[["FirstAidKit",2],["rhs_grenade_mkiiia1_mag",1,1],["rhsusf_200rnd_556x45_M855_mixed_box",2,200]]],["B_AssaultPack_blk",[["rhsusf_200rnd_556x45_M855_mixed_box",3,200]]],"FAST_COVER_BLACK_FULL","G_Balaclava_TI_G_blk_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_medic, [["arifle_SPAR_01_blk_F","muzzle_snds_M","acc_pointer_IR","optic_Yorris",["30Rnd_556x45_Stanag",30],[],""],[],["rhsusf_weap_glock17g4","rhsusf_acc_omega9k","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_g3_blk",[["rhsusf_mag_17Rnd_9x19_JHP",2,17],["30Rnd_556x45_Stanag_Tracer_Red",3,30]]],["V_PlateCarrier2_blk",[["FirstAidKit",2],["rhsusf_mag_17Rnd_9x19_JHP",5,17],["30Rnd_556x45_Stanag_Tracer_Red",5,30],["rhs_grenade_mkiiia1_mag",1,1]]],["B_AssaultPack_blk",[["Medikit",1],["FirstAidKit",5]]],"FAST_COVER_BLACK_FULL","G_Balaclava_TI_G_blk_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]], //Taken from Navy (No medic in USMC)
	[c_pilot,"B_Fighter_Pilot_F"],
	[c_marksman, [["arifle_SPAR_03_blk_F","muzzle_snds_B","acc_pointer_IR","optic_DMS",["20Rnd_762x51_Mag",20],[],"bipod_01_F_blk"],[],["rhsusf_weap_glock17g4","rhsusf_acc_omega9k","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_g3_blk",[["rhsusf_mag_17Rnd_9x19_JHP",2,17],["20Rnd_762x51_Mag",2,20]]],["V_PlateCarrier2_blk",[["FirstAidKit",2],["rhsusf_mag_17Rnd_9x19_JHP",5,17],["rhs_grenade_mkiiia1_mag",1,1],["20Rnd_762x51_Mag",5,20]]],["B_AssaultPack_blk",[]],"FAST_COVER_BLACK_FULL","G_Balaclava_TI_G_blk_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_FP_GIGN = [
	"arifle_SPAR_01_blk_F",
	"hgun_P07_F"
];	



//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_FP_GIGN = [		

];



launcherList_FP_GIGN = [		

];	



autorifleList_FP_GIGN = [	
	"LMG_03_F",
	"MMG_02_black_F",
	"arifle_SPAR_02_blk_F",
	"FP_M249_v1",
	"FP_M249_v2",
	"FP_M249_v3"
];	

marksmanrifleList_FP_GIGN = [		
	"arifle_SPAR_03_blk_F",
	"srifle_LRR_F",
	"rhs_weap_SCARH_LB",
	"ACE_Tripod"
];


smgList_FP_GIGN = [		
	"SMG_05_F",
	"SMG_03_black",
	"SMG_03_TR_black",
	"SMG_03C_black",
	"SMG_03C_TR_black",
	"SMG_02_F",
	"sgun_M4_F",
	"rhs_weap_M590_5RD",
	"rhsusf_weap_MP7A2"
];




//////////////////////////
attachmentShortList_FP_GIGN	= [
	"acc_pointer_IR",
	"optic_ERCO_blk_F",
	"optic_Holosight_blk_F",
	"optic_Yorris",
	"muzzle_snds_M"
];

attachmentLongList_FP_GIGN	= [
	"bipod_01_F_blk",
	"muzzle_snds_B",
	"optic_AMS",
	"optic_SOS",
	"optic_KHS_blk",
	"optic_LRPS",
	"optic_Nightstalker"
];

////////////////////////
////Items management////
////////////////////////
itemList_FP_GIGN = [
	"Binocular",
	"JAM_NV_Gloves_Wool_blk",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard",
	"Laserdesignator",
	"NVGoggles_OPFOR",
	"avs9_nvg",
	"Xj_PVS31_wide",
	"ESS_V1_NVG"
];

itemEngineerList_FP_GIGN = [
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_FP_GIGN = [

];

//backpack avalaible for all unit
backPackList_FP_GIGN = [
	"B_AssaultPack_blk",
	"B_Carryall_blk",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green",
	"B_parachute",
	"ace_gunbag_Tan"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_FP_GIGN = [
	//Uniform
	"U_B_GEN_Commander_F",
	"U_O_R_Gorka_01_black_F",
	"6sh122_RUSSIA_BLACK",
	"rhs_uniform_g3_blk",

	//Vest 
	"V_TacVest_gen_F",
	"6sh117_Police_v2",
	"6sh117_Police_v3",
	"6sh117_Police",
	"V_PlateCarrier1_blk",
	"V_PlateCarrier2_blk",

	//Head 
	"H_Beret_gen_F",
	"H_MilCap_gen_F",
	"FP_Altyn_Black_VisorV1",
	"FP_Altyn_Black_VisorV2",
	"FAST_COVER_BLACK_FULL",
	"G_Bandanna_blk",
	"G_Balaclava_blk",
	"G_Balaclava_TI_G_blk_F"
];

//Magazine avalaible for all unit
magazineList_FP_GIGN = 	[
	"HandGrenade"
];




