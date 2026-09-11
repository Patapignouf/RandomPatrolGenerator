c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_pilot = "pilot";
c_radioman = "radioman";

factionID = factionID+1;

//Add specific IFA3 factions
if ((isClass (configFile >> "CfgPatches" >> "IFA3_Core")) && isClass (configFile >> "CfgPatches" >> "JMSSA_weapons")) then 
{
	factionInfos pushBack ["_WWII_PANY", factionID,"WWII PataCompany [IFA3/JMS]", true, false, false];
};


////////////////////////
//Vehicle management////
////////////////////////
//WWII_USA
bluforUnarmedVehicle_WWII_PANY = [
	"JMSSA_veh_citroen11cv_fra40_F",
	"JMSSA_veh_BSA_m20_F",
	"JMSSA_veh_willys_tent_des_F",
	"JMSSA_veh_bedfordMW_F_des",
	"JMSSA_veh_matador_des_F"
];

bluforArmedVehicle_WWII_PANY = [

];

bluforUnarmedVehicleChopper_WWII_PANY = [
	// nein
];

bluforArmoredVehicle_WWII_PANY = [
	"JMSSA_veh_amd35_vichyCol_F",
	"JMSSA_veh_H35_vichy40_F",
	"LIB_M4A3_75",
	"LIB_M4A3_75_w"
];

bluforDrone_WWII_PANY = [
	// ...
];

bluforBoat_WWII_PANY = [
	"LIB_LCA"
];

bluforFixedWing_WWII_PANY = [
	"LIB_RAF_P39"
];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_WWII_PANY = [
	"JMSSA_veh_citroen11cv_fra40_F"
];

bluforStaticWeapon_WWII_PANY = 
[
	"JMSSA_vehgr_hotchkiss14_fraNA_F",
	"JMSSA_vehgr_apx47_fraVNA_F",
	"JMSSA_vehgr_apx47_FRA_F"
];

////////////////////////
//Loadout management////
////////////////////////

//WWII_USA
loadout_WWII_PANY = [		
	[c_leader,"JMSSA_fraNA_tirCol_cpl", ["JMSSA_fra40_rifle_serg", "JMSSA_fra40_rifle40_serg"], false],
	[c_at,"JMSSA_fraNA_tirCol_rifle", ["JMSSA_fra40_rifle_rifle","JMSSA_fra40_rifle_lebel","JMSSA_fra40_rifle_mas36","JMSSA_fra40_rifle40_rifle","JMSSA_fra40_rifle40_rifle_bayonet","JMSSA_fra40_rifle40_lebel","JMSSA_fra40_rifle40_mas36"], false],
	[c_rifleman,"JMSSA_fraNA_tirCol_rifle", ["JMSSA_fra40_rifle_rifle","JMSSA_fra40_rifle_lebel","JMSSA_fra40_rifle_mas36","JMSSA_fra40_rifle40_rifle","JMSSA_fra40_rifle40_rifle_bayonet","JMSSA_fra40_rifle40_lebel","JMSSA_fra40_rifle40_mas36"], false],//Default stuff
	[c_engineer,"JMSSA_fraNA_tirCol_rifle", ["JMSSA_fra40_rifle_rifle","JMSSA_fra40_rifle_lebel","JMSSA_fra40_rifle_mas36","JMSSA_fra40_rifle40_rifle","JMSSA_fra40_rifle40_rifle_bayonet","JMSSA_fra40_rifle40_lebel","JMSSA_fra40_rifle40_mas36"], false],
	[c_autorifleman,"JMSSA_fraNA_tirCol_mg", ["JMSSA_fra40_rifle40_mg","JMSSA_fra40_rifle_mg"], false],
	[c_marksman,"JMSSA_fraNA_tirCol_lebel", ["JMSSA_fra40_rifle_sharpshoot", "JMSSA_fra40_rifle40_sharpshoot"], false],
	[c_medic,[["JMSSA_berthier_Rifle","","","",["JMSSA_3Rnd_8x50R_D",3],[],""],[],[],["JMSSA_fra_NA_bright_F_CombatUniform",[["FirstAidKit",1],["JMSSA_F1_HandGrenade",1,1]]],["JMSSA_fra_mle35rifle16_bag",[["JMSSA_3Rnd_8x50R_T",15,3]]],["JMSSA_fra_m1893_b",[["ACE_bloodIV",5],["ACE_bloodIV_500",5],["ACE_epinephrine",10],["ACE_morphine",5],["ACE_surgicalKit",1],["ACE_elasticBandage",61],["ACE_painkillers",5,10]]],"JMSSA_fra_chechia_khaki","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]], ["JMSSA_fra40_rifle_medic"], false],
	[c_pilot, "JMSSA_fra40_rifle_tanker"]
];


////////////////////////
///Weapon management////
////////////////////////
//WWII_USA
rifleList_WWII_PANY = [		
	"JMSSA_berthierCarbine_Rifle",
	"JMSSA_berthierM16_Rifle",
	"JMSSA_mas36_Rifle",
	"JMSSA_berthierCarbine_br_Rifle"
];	

launcherList_WWII_PANY = [	

];	

autorifleList_WWII_PANY = [	
	"JMSSA_mac2429_Rifle"
];	

marksmanrifleList_WWII_PANY = [		

];

smgList_WWII_PANY = [

];


//////////////////////////
//Attachement management//
//////////////////////////

// Nothing more than bayonets i think.
attachmentShortList_WWII_PANY	= [

];

attachmentLongList_WWII_PANY	= [
	// no optics, sorry...
];

////////////////////////
////Items management////
////////////////////////
itemList_WWII_PANY = [
	"FirstAidKit",
	"ItemMap",
	"ItemCompass",
	"ItemWatch",
	"JMSSA_w_bino_No2Mk2_strap",
	"JMSSA_w_bino_No2Mk2",
	"ACE_MapTools",
	"ACE_CableTie",
	"ACE_Canteen",
	"ACE_EarPlugs",
	"ACE_fieldDressing",
	"ACE_packingBandage",
	"ACE_elasticBandage",
	"ACE_tourniquet",
	"ACE_splint",
	"ACE_morphine",
	"ACE_quikclot",
	"ACE_EntrenchingTool",
	"ACE_RangeTable_82mm"
];

itemEngineerList_WWII_PANY = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter", 
	"ACE_Fortify"
];
	
itemMedicList_WWII_PANY = [
	"Medikit",
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit",
	"ACE_suture"
];

// Those lists might not be correct...
backPackList_WWII_PANY = [
	//Medium bags
	"JMSSA_fra_m1893_b",
	//Special bags
	"B_LIB_US_Radio",
	"JMSSA_B_back_p37_2inchAB_desert_F",
	//Parachute
	"B_LIB_US_Type5",
	"B_LIB_US_TypeA3"
];

uniformList_WWII_PANY = [
	//Head
	"G_JMSSA_fra_des_googles",
	"G_JMSSA_CIV_CigaretteR",
	"G_JMSSA_CIV_CigaretteL",
	"H_LIB_US_Helmet_w",
	"H_LIB_US_Helmet_Cover_w",
	"H_LIB_US_Helmet_Net_w",
	"H_LIB_US_Helmet_Med_w",

	//Vest 

	//Uniform 
	"U_LIB_US_Private_w" //Winter US Uniform
];

magazineList_WWII_PANY = [
	"SmokeShell",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow"
];