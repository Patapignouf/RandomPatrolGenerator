c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

////////////////////////
//Vehicle management////
////////////////////////
//newFaction
bluforUnarmedVehicle_newFaction = ["B_AMF_VAB_ULTIMA_X8_F"];

bluforArmedVehicle_newFaction = [
	"amf_pvp_01_CE_f",
	"B_AMF_VAB_ULTIMA_TOP_X8_F",
	"AMF_VBMR_L_CE_01"];

bluforUnarmedVehicleChopper_newFaction = ["ffaa_nh90_tth_transport",
"AMF_gazelle_afte_f",
"ffaa_famet_cougar"];


bluforDrone_newFaction = [
"B_UAV_02_dynamicLoadout_F"
];

bluforBoat_newFaction = [
"CUP_B_RHIB_HIL",
"CUP_B_Zodiac_USMC"
];

////////////////////////
//Loadout management////
////////////////////////

//newFaction
loadout_newFaction = [				
	[c_leader,""],
	[c_at,""],
	[c_rifleman,""],//Default stuff
	[c_engineer,""],
	[c_autorifleman,""],
	[c_marksman,""],
	[c_medic,""]
];

////////////////////////
///Weapon management////
////////////////////////
//newFaction
rifleList_newFaction = [		
	"CUP_arifle_mk18_black",
	"CUP_arifle_mk18_m203_black"
];	

launcherList_newFaction = [		
	"CUP_launch_Javelin",
	"CUP_launch_FIM92Stinger",
	"CUP_launch_MAAWS",
	"CUP_launch_MAAWS_Scope"
];	

autorifleList_newFaction = [			
	"CUP_lmg_Mk48"
];	


marksmanrifleList_newFaction = [		
	"CUP_srifle_Mk12SPR"
];

smgList_newFaction = [		
	"CUP_smg_MP7"
];


//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_newFaction	= [
	"CUP_optic_AC11704_Black",
	"CUP_optic_VortexRazor_UH1_Black",		
	"CUP_optic_artel_m14",
	"CUP_optic_artel_m14_pip",
	"CUP_optic_Aimpoint_5000",
	"CUP_optic_HoloBlack",
	"CUP_optic_Eotech553_Black",		
	"CUP_optic_CompM2_Black",			
	"CUP_optic_CompM2_low",			
	"CUP_optic_CompM4",
	"CUP_optic_MicroT1",			
	"CUP_optic_MicroT1_low",			
	"CUP_optic_MARS",
	"CUP_optic_MEPRO",
	"CUP_optic_MEPRO_openx_orange",
	"CUP_optic_MEPRO_moa_clear",
	"CUP_optic_MEPRO_tri_clear",
	"CUP_optic_SUSAT",
	"CUP_optic_SUSAT_PIP",
	"CUP_optic_SUSAT_3D",
	//"CUP_optic_ACOG",  //Remove too versatile optics to test players new choice
	"CUP_optic_ACOG_PIP",
	"CUP_optic_ACOG_3D",
	"CUP_optic_ACOG2",
	"CUP_optic_ACOG2_PIP",
	"CUP_optic_ACOG2_3D",
	"CUP_optic_RCO",
	"CUP_optic_ACOG_TA01NSN_Black_PIP",
	"CUP_optic_ACOG_TA01NSN_Black_3D",
	"CUP_optic_ACOG_TA01B_Black",
	"CUP_optic_ACOG_TA01B_Black_PIP",
	"CUP_optic_ACOG_TA01B_Black_3D",
	"CUP_optic_ZDDot",
	"CUP_optic_MRad",
	"CUP_optic_TrijiconRx01_black",
	"CUP_optic_TrijiconRx01_kf_black",
	"CUP_optic_ZeissZPoint",
	"CUP_optic_HensoldtZO",
	"CUP_acc_ANPEQ_15",
	"CUP_acc_ANPEQ_15_Black",
	"CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L",
	"CUP_acc_ANPEQ_2",
	"CUP_acc_ANPEQ_2_Black_Top",
	"CUP_acc_ANPEQ_2_desert",
	"CUP_acc_ANPEQ_2_grey",
	"CUP_bipod_Harris_1A2_L_BLK",
	"CUP_bipod_VLTOR_Modpod",
	"CUP_muzzle_PB6P9",
	"CUP_muzzle_Bizon",
	"CUP_muzzle_PBS4",
	"CUP_muzzle_TGPA",
	"CUP_muzzle_snds_KZRZP_Base",
	"CUP_muzzle_snds_KZRZP_SVD",
	"CUP_muzzle_snds_KZRZP_AK762",
	"CUP_muzzle_snds_KZRZP_AK545",
	"CUP_muzzle_snds_KZRZP_PK"
];


////////////////////////
////Items management////
////////////////////////
itemList_newFaction = [
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
	"ACE_RangeTable_82mm"
	];

itemEngineerList_newFaction = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter"
	];
	
itemMedicList_newFaction = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];