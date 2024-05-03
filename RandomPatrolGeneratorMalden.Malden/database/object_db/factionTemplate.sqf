#include "..\classConstant.sqf"

//Faction format :
// [ Number : Faction Code, String : Faction string Name , String : Faction Name to display, Enabled for Blufor/Independant, Enabled for Opfor, Enabled for Civilian],
//Add specific factions
//factionInfos pushBack ["_newFaction", 9999, "New Faction name", true, true, true];


//////////////////////////////
////Define civ group data/////
//////////////////////////////

//Small civilian group
civilian_group_newFaction = [
	
];

//Heavy civilian group
civilian_big_group_newFaction = [
	
];

//Vehicle avalaible on civilian city
civilianTruck_newFaction = [
	
];

//////////////////////////////
///Define enemy group data////
//////////////////////////////

//Basic enemy group | 8 men (Leader, Medic, MG, Sniper, Rifleman)
baseEnemyGroup_newFaction = [
	
];

//Basic anti tank enemy group | 5 men max (Leader, MG, AT)
baseEnemyATGroup_newFaction = [
	
];

//Basic demolition enemy group | 8 men max (Leader, Explosive)
baseEnemyDemoGroup_newFaction = [
	
];

//Basic Mortar enemy group | 8 men max (Mortar, Rifleman)
baseEnemyMortarGroup_newFaction = [
	
];

//Basic enemy vehicle avalaible (light) must be destroyed without AT (ex : jeep)
baseEnemyVehicleGroup_newFaction = [
	
];

//Basic enemy light armored vehicle avalaible must be destroyed without heavy AT (ex : BMP)
baseEnemyLightArmoredVehicleGroup_newFaction = [
	
];

//Basic enemy heavy armored vehicle avalaible must be destroyed with other vehicle or heavy AT (ex : tank)
baseEnemyHeavyArmoredVehicleGroup_newFaction = [
	
];

//Basic enemy chopper avalaible
baseEnemyUnarmedChopperGroup_newFaction = [
	
];

//Basic armed enemy chopper avalaible
baseEnemyArmedChopperGroup_newFaction = [
	
];

//Basic enemy aircraft avalaible
baseFixedWingGroup_newFaction = [
	
];


////////////////////////
//Vehicle management////
////////////////////////

//Light vehicle avalaible for blufor : Ex light hummvee, quad
bluforUnarmedVehicle_newFaction = [];

//Armed vehicle avalaible for blufor : Ex heavy hummvee
bluforArmedVehicle_newFaction = [];

//Chopper unarmed chopper avalaible for blufor : Ex CH47
bluforUnarmedVehicleChopper_newFaction = [];

//Chopper used to extract players by support shop
bluforExtractVehicleChopper_newFaction = [];

//Chopper armed choper avalaible for blufor : Ex AH-Z1
bluforArmedChopper_newFaction = [];

//Armored vehicle avalaible for blufor : Ex light tank
bluforArmoredVehicle_newFaction = [];

//Drone vehicle avalaible for blufor
bluforDrone_newFaction = [
];

//Boat vehicle avalaible for blufor
bluforBoat_newFaction = [
	
];

//FixedWing vehicle avalaible for blufor
bluforFixedWing_newFaction = [

];

//Vehicule able to do HQ features (Loadout management and more)
bluforHQVehicle_newFaction = [
	
];

////////////////////////
//Loadout management////
////////////////////////


//Two options : 
// - ACE Arsenal : [["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]
// - Game unit : "I_C_Soldier_Bandit_4_F"
loadout_newFaction = [		
	[c_leader,[["AMF_Samas_VALO_01_F","","","AMF_Aimpoint_CompM5",["25Rnd_samas_f1_mag",25],[],""],[],["AMF_Glock_17","","","",["16Rnd_9x21_Mag",17],[],""],["amf_uniform_02_CE",[["ACE_EarPlugs",1],["16Rnd_9x21_Mag",2,17]]],["amf_smb_tlb_famas_grn",[["ACE_MapTools",1],["ACE_CableTie",1],["25Rnd_samas_f1_mag",10,25],["CUP_HandGrenade_M67",2,1],["SmokeShellBlue",2,1],["SmokeShell",2,1]]],[],"AMF_FELIN_MOUNT_EARPROT_OD","",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","","ItemCompass","TFAR_microdagr",""]]],
	[c_at,"I_C_Soldier_Bandit_4_F"],
	[c_rifleman,""],//Default stuff
	[c_engineer,""],
	[c_autorifleman,""],
	[c_marksman,""],
	[c_medic,""],
	[c_grenadier,""]
];

////////////////////////
///Weapon management////
////////////////////////

//Rifle avalaible for all unit
rifleList_newFaction = [		

];	

//Grenade launcher or weapon with grenade launcher option
grenadeLauncherList_newFaction = [		

];


//Launcher avalaible for AT
launcherList_newFaction = [		

];	

//Autorifle avalaible for autorifleman
autorifleList_newFaction = [			

];	

//Rifle avalaible for marksman
marksmanrifleList_newFaction = [		

];

//Smg avalaible for all unit
smgList_newFaction = [		

];


//////////////////////////
//Attachement management//
//////////////////////////

//Short range scope for all unit
attachmentShortList_newFaction	= [

];

//Long range scope avalaible for marksman
attachmentLongList_newFaction	= [

];

////////////////////////
////Items management////
////////////////////////

//item avalaible for all unit
itemList_newFaction = [

	];

//item avalaible for all engineer
itemEngineerList_newFaction = [

	];

//item avalaible for all medic
itemMedicList_newFaction = [
	];

//backpack avalaible for all unit
backPackList_newFaction = [
	];


//Uniform, vest, headgear, avalaible for all unit
uniformList_newFaction = [
	];

//Magazine avalaible for all unit
magazineList_newFaction = [
	];

//Default radio for every rifleman
factionDefaultRadios_newFaction = [

];
