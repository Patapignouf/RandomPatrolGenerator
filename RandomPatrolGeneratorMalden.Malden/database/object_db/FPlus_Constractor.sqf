#include "..\classConstant.sqf"

//Add specific DSF factions
if (isClass (configFile >> "CfgWeapons" >> "FP_MPC_Car")) then 
{
	factionInfos pushBack ["_FP_Contractor", factionID,"[F+] Contractors", true, false, false];
};


////////////////////////f
//Vehicle management////
////////////////////////
//USA
bluforUnarmedVehicle_FP_Contractor = [
	"rhsgref_cdf_b_gaz66",
	"UAZ_03_transport_F",
	"UAZ_pat",
	"B_G_Quadbike_01_F",
	"UAZ_02_transport_F",
	"UAZ_01_transport_F",
	"UAZ_04_transport_F"
];

bluforArmedVehicle_FP_Contractor = [
	"B_G_Offroad_01_armed_F"
];


bluforStaticWeapon_FP_Contractor = 
[

];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_FP_Contractor = [
	"rhsgref_BRDM2UM_msv",
	"rhs_bmp3m_msv"
];

bluforUnarmedVehicleChopper_FP_Contractor = [
	"B_Heli_Light_01_F",
	"C_IDAP_Heli_Transport_02_F"
];

bluforArmedChopper_FP_Contractor = [

];

bluforDrone_FP_Contractor = [
	"C_IDAP_UAV_01_F",
	"C_IDAP_UAV_06_antimine_F"
]; 

bluforBoat_FP_Contractor = [
	"C_Boat_Civil_01_F"
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_FP_Contractor = [
	"FP_UAF_L159_ALCA"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_FP_Contractor = [
	"rhsgref_cdf_b_gaz66",
	"rhsgref_BRDM2UM_msv"
];	


////////////////////////
//Loadout management////
////////////////////////

//USA
loadout_FP_Contractor = [		
	[c_leader, [["arifle_AUG_F","","JAS_ANPEQ15_Blk","",["30Rnd_556x45_AUG_Mag_F",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["30Rnd_556x45_AUG_Mag_F",4,30]]],["FP_TacVest_Coy",[["30Rnd_556x45_AUG_Mag_F",5,30]]],["B_AssaultPack_cbr",[]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]], [], false, []],
	[c_rifleman, [["arifle_AUG_F","","JAS_ANPEQ15_Blk","",["30Rnd_556x45_AUG_Mag_F",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["30Rnd_556x45_AUG_Mag_F",4,30]]],["FP_TacVest_Coy",[["30Rnd_556x45_AUG_Mag_F",5,30]]],["B_AssaultPack_cbr",[]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],//Default stuff
	[c_drone, [["arifle_AUG_F","","JAS_ANPEQ15_Blk","",["30Rnd_556x45_AUG_Mag_F",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["30Rnd_556x45_AUG_Mag_F",4,30]]],["FP_TacVest_Coy",[["30Rnd_556x45_AUG_Mag_F",5,30]]],["B_UAV_01_backpack_F",[]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch",""]]],//Default stuff	
	[c_engineer, [["arifle_AUG_F","","JAS_ANPEQ15_Blk","",["30Rnd_556x45_AUG_Mag_F",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["30Rnd_556x45_AUG_Mag_F",4,30]]],["FP_TacVest_Coy",[["30Rnd_556x45_AUG_Mag_F",5,30]]],["B_AssaultPack_cbr",[["MineDetector",1],["ToolKit",1]]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_autorifleman, [["rhs_weap_mg42","","","",["rhsgref_50Rnd_792x57_SmE_drum",50],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["rhsgref_50Rnd_792x57_SmE_drum",1,50]]],["FP_TacVest_Coy",[["rhsgref_50Rnd_792x57_SmE_drum",2,50],["rhsgref_50Rnd_792x57_SmK_alltracers_drum",3,50]]],["B_Kitbag_cbr",[["rhsgref_296Rnd_792x57_SmK_alltracers_belt",2,296],["rhsgref_50Rnd_792x57_SmK_alltracers_drum",3,50]]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
	[c_medic, [["arifle_AUG_F","","JAS_ANPEQ15_Blk","",["30Rnd_556x45_AUG_Mag_F",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["30Rnd_556x45_AUG_Mag_F",4,30]]],["FP_TacVest_Coy",[["30Rnd_556x45_AUG_Mag_F",5,30]]],["B_AssaultPack_cbr",[["Medikit",1],["FirstAidKit",2]]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]], //Taken from Navy (No medic in USMC)
	[c_pilot,"B_Fighter_Pilot_F"],
	[c_at, [["arifle_AUG_F","","JAS_ANPEQ15_Blk","",["30Rnd_556x45_AUG_Mag_F",30],[],""],["rhs_weap_M136_hedp","","","",[],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["30Rnd_556x45_AUG_Mag_F",4,30]]],["FP_TacVest_Coy",[["30Rnd_556x45_AUG_Mag_F",5,30]]],["B_AssaultPack_cbr",[]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]] ,[]],
	[c_marksman, [["rhs_weap_m24sws_d","","","optic_LRPS",["rhsusf_5Rnd_762x51_m118_special_Mag",5],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["rhsusf_5Rnd_762x51_m118_special_Mag",3,5],["rhsusf_5Rnd_762x51_m62_Mag",9,5]]],["FP_TacVest_Coy",[["rhsusf_5Rnd_762x51_m62_Mag",8,5]]],["B_Kitbag_cbr",[]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]] ,[]],
	[c_sniper, [["rhs_weap_m24sws_d","","","optic_LRPS",["rhsusf_5Rnd_762x51_m118_special_Mag",5],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_GhillieSuit",[["FirstAidKit",1],["rhsusf_5Rnd_762x51_m118_special_Mag",3,5],["rhsusf_5Rnd_762x51_m62_Mag",9,5]]],["FP_TacVest_Coy",[["rhsusf_5Rnd_762x51_m62_Mag",8,5]]],["B_Kitbag_cbr",[]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]] ,[]],
	[c_grenadier, [["arifle_AUG_GL_F","","JAS_ANPEQ15_Blk","",["30Rnd_556x45_AUG_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["AAF_PMC_SOLDIER",[["FirstAidKit",1],["30Rnd_556x45_AUG_Mag_F",3,30],["1Rnd_HE_Grenade_shell",2,1]]],["FP_TacVest_Coy",[["1Rnd_HE_Grenade_shell",1,1],["rhs_mag_M433_HEDP",10,1],["30Rnd_556x45_AUG_Mag_Tracer_Green_F",5,30]]],["B_AssaultPack_cbr",[]],"H_HelmetB_light_sand","ESS_01_FaceWear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]] ,[]]
];

////////////////////////
///Weapon management////
////////////////////////
//USA
rifleList_FP_Contractor = [	
	"arifle_AUG_F",
	"arifle_AUG_black_F",
	"arifle_AUG_C_F",
	"arifle_AUG_C_black_F",
	"hgun_Rook40_F"
];	



//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_FP_Contractor = [		
	"arifle_AUG_GL_F",
	"arifle_AUG_GL_black_F"
];



launcherList_FP_Contractor = [		
	"rhs_weap_M136_hedp"
];	



autorifleList_FP_Contractor = [	
	"rhs_weap_mg42"		
];	

marksmanrifleList_FP_Contractor = [		
	"rhs_weap_m24sws_d"
];


smgList_FP_Contractor = [		
];




//////////////////////////
attachmentShortList_FP_Contractor	= [
	"JAS_ANPEQ15_Blk"
];

attachmentLongList_FP_Contractor	= [
	"optic_LRPS"
];

////////////////////////
////Items management////
////////////////////////
itemList_FP_Contractor = [
	"Binocular",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_IR_Strobe_Item",
	"ACE_RangeCard"
];

itemEngineerList_FP_Contractor = [
	"DemoCharge_Remote_Mag"
];
	
itemMedicList_FP_Contractor = [

];

//backpack avalaible for all unit
backPackList_FP_Contractor = [
	"B_Kitbag_cbr",
	"B_AssaultPack_cbr",
	"TFAR_rt1523g",
	"TFAR_rt1523g_green",
	"B_parachute",
	"ace_gunbag_Tan",
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F"
];

//Uniform, vest, headgear, avalaible for all unit
uniformList_FP_Contractor = [
	//head
	"H_HelmetB_light_sand",
	"H_Cap_blk",
	"rhsusf_mich_bare_norotos_arc_alt",
	"rhsusf_mich_bare_norotos_arc_alt_tan",
	"FAST_BLACK_TAN",

	//Glasses 
	"FaceWear_Balaclava",
	"G_Bandanna_tan",
	"G_Bandanna_blk",
	"G_Shades_Blue",
	"rhsusf_shemagh_gogg_tan",
	"rhsusf_shemagh2_gogg_tan",
	"rhsusf_shemagh2_tan",

	//vest
	"FP_TacVest_Coy",
	"V_PlateCarrier1_blk",
	"V_PlateCarrier1_rgr_noflag_F",
	"rhsusf_plateframe_light",
	"rhsusf_plateframe_rifleman",
	"V_I_G_resistanceLeader_F",
	"6sh117_mg_BLACK",
	"6sh117_mg_COYOTE",

	//uniform
	"AAF_PMC_SOLDIER",
	"U_I_G_resistanceLeader_F",
	"U_B_CTRG_2",
	"rhs_uniform_g3_m81",
	"rhs_uniform_g3_blk",
	"rhs_uniform_FROG01_d"
];

uniformListSniper_FP_Contractor = [
	"U_B_GhillieSuit",
	"U_B_FullGhillie_ard",
	"Laserdesignator" //Add laser designator only for sniper
];

//Magazine avalaible for all unit
magazineList_FP_Contractor = 	[
	"HandGrenade"
];




