//////////////////////////////
////Define objectives data////
//////////////////////////////
avalaibleAmmoBox = [
	"Box_IDAP_Uniforms_F", 
	"Box_NATO_AmmoOrd_F",  
	"Box_NATO_WpsLaunch_F", 
	"Box_IND_Support_F",
	"Box_FIA_Wps_F"
];

if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	avalaibleAmmoBox pushBack "rhs_mags_crate";
	avalaibleAmmoBox pushBack "rhsusf_mags_crate";
};

avalaibleSupplyBox = [
	"Box_IND_Support_F"
];

if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	avalaibleSupplyBox pushBack "ACE_medicalSupplyCrate_advanced";
	avalaibleSupplyBox pushBack "ACE_medicalSupplyCrate";
};

if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	avalaibleSupplyBox pushBack "rhs_7ya37_1_single";
};

avalaibleHVT = [
	"O_Officer_Parade_F", 
	"O_G_officer_F",
	"B_Officer_Parade_F", 
	"I_E_Officer_Parade_Veteran_F"
];

if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	avalaibleHVT pushBack "CUP_O_TK_Officer";
	avalaibleHVT pushBack "CUP_O_RU_Officer_EMR";
};

if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	avalaibleHVT pushBack "rhs_vdv_mflora_officer";
};


avalaibleIED = [
	"IEDLandBig_F", 
	"IEDUrbanSmall_F", 
	"IEDLandSmall_F"
];

if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	avalaibleIED pushBack "ACE_IEDUrbanBig_Range";
};

avalaibleVIP = [
	"C_Driver_1_F",
	"C_Man_ConstructionWorker_01_Black_F", 
	"C_man_pilot_F", 
	"C_Man_UAV_06_medical_F", 
	"C_scientist_02_formal_F", 
	"C_Man_smart_casual_2_F_tanoan", 
	"C_IDAP_Man_EOD_01_F", 
	"C_IDAP_Man_AidWorker_09_F", 
	"C_scientist_01_formal_F"
];

if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	avalaibleVIP pushBack "CUP_C_R_Priest_01";
	avalaibleVIP pushBack "CUP_C_R_Fireman_01";
	avalaibleVIP pushBack "CUP_C_R_Doctor_01";
};

if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	avalaibleVIP pushBack "rhs_pilot";
	//avalaibleVIP pushBack "rhsusf_airforce_jetpilot";
};

if (isClass (configFile >> "CfgPatches" >> "DSF_core")) then 
{
	avalaibleVIP pushBack "DSF_COP_VIP";
	avalaibleVIP pushBack "DSF_COP_VIP2";
	//avalaibleVIP pushBack "DSF_COP_Fed";
};


avalaibleStealVehicle = [
	"C_Truck_02_box_F", 
	"C_Truck_02_fuel_F", 
	"C_Offroad_01_repair_F", 
	"C_Van_01_fuel_F"
];

if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	avalaibleStealVehicle pushBack "rhs_typhoon_vdv";
};

avalaibleCollectIntel = [
	"Land_Suitcase_F",
	"Land_MultiScreenComputer_01_olive_F", 
	"Land_Laptop_unfolded_F", 
	"Land_FirstAidKit_01_open_F", 
	"Land_Defibrillator_F", 
	"MapBoard_altis_F",
	"Land_FlatTV_01_F", 
	"Land_TripodScreen_01_dual_v1_sand_F", 
	"Land_MultiScreenComputer_01_sand_F", 
	"SatelliteAntenna_01_Olive_F"
];


avalaibleTypeOfObj = [];

//List of all avalaible objective
avalaibleTypeOfObjectives = [
	// [Technical Objective name, Display name, type of objective, enable]
	["ammo", "Ammo cache", "Attack", true],
	["hvt", "HVT", "Attack", true],
	["clearArea", "Clear Area", "Attack", true],
	["defendArea", "Defend Area", "Attack", true],
	["takeAndHold", "Take and hold", "Attack", true],
	["informant", "Informant", "Support", true],
	["collectIntel", "Collect Intel", "Support", true],
	["steal", "Steal vehicle", "Support", true],
	["captureFlag", "Capture city", "Attack", true],
	["hostage", "Hostage rescue", "Attack", true]
];

//If ACE is enable on the server, specific objectives are avalaible
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	avalaibleTypeOfObjectives pushBack ["vip", "VIP", "Support", true];
	avalaibleTypeOfObjectives pushBack ["supply", "Supply box", "Support", true];
};

//FOB description from DRO
//Waiting for a PANY FOB
fob1 = [
["Land_HBarrier_5_F",[-7.33789,7.19934,0],270.094,1,0,[0,0],"","",true,false], 
	["Land_Pallets_F",[-9.05835,12.902,0],264.398,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[17.9697,-0.935638,0],90.2135,1,0,[0,-0],"","",true,false], 
	["Land_HBarrierBig_F",[-7.67224,16.7066,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[-14.4656,-12.1106,0],184.122,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[4.32324,-18.77,0],270.353,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-14.2883,-10.0949,0],179.713,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[17.7296,7.38129,0],269.965,1,0,[0,0],"","",true,false], 
	["Land_WaterTank_F",[7.76477,-18.7261,-5.72205e-006],268.373,1,0,[0.000581058,1.90213e-005],"","",true,false], 
	["Land_Pallets_stack_F",[-16.3892,-12.2328,0],270.353,1,0,[-2.43987e-005,-1.25789e-006],"","",true,false], 
	["Land_ToiletBox_F",[-11.4088,17.4513,5.24521e-006],359.815,1,0,[-0.000641798,-0.000366751],"","",true,false], 
	["Land_Tyres_F",[-11.0228,-18.2807,0.00659704],162.138,1,0,[0,-0],"","",true,false], 
	["Land_WaterTank_F",[10.9957,-18.7661,5.24521e-006],268.373,1,0,[0.00207411,-0.00155132],"","",true,false], 
	["Land_Cargo20_military_green_F",[13.434,17.4225,4.76837e-007],106.796,1,0,[-3.53963e-005,4.12904e-006],"","",true,false], 
	["Land_ToiletBox_F",[-13.5955,17.3864,4.76837e-006],359.815,1,0,[-0.000176553,0.000250982],"","",true,false], 
	["Land_HBarrier_5_F",[23.7905,-5.4263,0],181.584,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_open_empty_F",[-9.6665,-20.1551,0],76.4729,1,0,[0,0],"","",true,false], 
	["Land_Cargo20_military_green_F",[7.94397,20.9161,0],96.2963,1,0,[-4.60749e-005,5.49738e-006],"","",true,false], 
	["Land_PaperBox_closed_F",[-17.4805,-14.2681,0],35.8529,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[16.6414,-15.8525,0],150.973,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-20.0004,-14.385,0],270.529,1,0,[0,0],"","",true,false], 
	["Land_Cargo20_military_green_F",[10.7101,20.8058,4.76837e-007],278.791,1,0,[1.26151e-005,2.08784e-006],"","",true,false], 
	["Land_PaperBox_closed_F",[-11.6792,-20.4561,0],3.4345,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[3.71948,25.879,0],90.9567,1,0,[0,-0],"","",true,false], 
	["Land_HBarrierBig_F",[17.6447,16.5574,0],270.353,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-11.0516,21.7983,0],359.745,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-26.6294,2.63609,0],359.441,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[7.50696,-23.9942,0],181.888,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[14.7341,-20.4855,0],127.108,1,0,[0,-0],"","",true,false], 
	["Land_HBarrierBig_F",[-18.1364,18.019,0],304.968,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[25.1033,-9.72986,0],270.353,1,0,[0,0],"","",true,false], 
	["Land_Cargo_Patrol_V3_F",[24.8461,-10.9578,0],269.639,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-19.6694,-19.1063,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[21.6969,-16.8302,0],181.888,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[-26.5153,7.80341,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[14.5088,24.3171,0],228.036,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[25.0844,-15.2732,0],270.353,1,0,[0,0],"","",true,false], 
	["Land_Cargo_Patrol_V3_F",[-27.9869,8.15738,0],88.4909,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-28.1226,6.88979,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[6.9021,27.7117,0],182.276,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-24.9733,14.1209,0],359.745,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[-14.6956,-25.3488,0],224.401,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[0.325562,-29.9501,0],182.48,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[10.9374,-25.7316,0],93.3079,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-28.2957,12.4295,0],88.2119,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[5.98071,-30.0578,0],180.916,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-9.01318,-29.685,0],0.132941,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[-16.2528,-26.7327,0],45.8939,1,0,[0,0],"","",true,false]
];

fob2 = 
[
	["Land_HBarrier_5_F",[2.9397,0.0893555,0],357.498,1,0,[0,0],"","",true,false], 
	["Land_BarrelSand_grey_F",[6.16431,2.52295,1.90735e-006],200.404,1,0,[-0.000783283,-0.000760757],"","",true,false], 
	["Land_BarrelEmpty_F",[6.73267,3.30225,1.90735e-006],143.949,1,0,[1.32386e-006,0.00107249],"","",true,false], 
	["Land_HBarrier_5_F",[-0.757568,-9.92822,0],324.922,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[1.88892,8.87451,0],357.007,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[8.60181,-7.18018,0],179.263,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-5.68726,-8.51807,0],21.7148,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-11.9119,3.06787,0],36.5702,1,0,[0,0],"","",true,false], 
	["Land_WaterTank_F",[8.47095,5.96045,4.57764e-005],270.438,1,0,[-0.00135466,-0.00115514],"","",true,false], 
	["Land_HBarrier_5_F",[8.39868,0.587402,0],329.047,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-11.1033,-8.97119,0],354.618,1,0,[0,0],"","",true,false], 
	["Land_GarbageBags_F",[3.7522,13.1382,0],158.176,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-12.2595,7.96045,0],88.7307,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[12.6096,3.70264,0],273.522,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[9.42603,-7.33252,0],23.8596,1,0,[0,0],"","",true,false], 
	["Land_Cargo_HQ_V3_F",[-5.21069,14.4663,0],267.333,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-14.8943,-5.12549,0],48.1373,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[12.7249,8.92334,0],242.879,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_3_F",[-15.3416,-4.95752,0],180.593,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-15.2634,12.0112,0],50.8217,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_open_empty_F",[17.0647,-3.51416,0],166.944,1,0,[0,-0],"","",true,false], 
	["Land_PortableLight_double_F",[-10.3748,14.5796,0],88.5717,1,0,[0,0],"","",true,false], 
	["Land_ToiletBox_F",[6.33228,17.2534,2.52724e-005],359.154,1,0,[-0.00134887,-0.000250746],"","",true,false], 
	["Land_HBarrier_5_F",[-18.8494,0.415527,0],271.273,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-18.8923,-5.04736,0],270.843,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_closed_F",[18.9631,-2.36963,0],20.4457,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[10.5979,13.8706,0],271.403,1,0,[0,0],"","",true,false], 
	["Land_ToiletBox_F",[8.85181,17.2749,1.90735e-006],359.221,1,0,[-0.000103693,-3.12736e-005],"","",true,false], 
	["Land_HBarrier_5_F",[14.5569,-9.67822,0],43.2557,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[3.03931,19.644,0],228.261,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[10.8362,19.6694,0],180.593,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-18.8982,5.45654,0],231.211,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-15.74,17.4917,0],88.1428,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[5.35376,19.9409,0],230.768,1,0,[0,0],"","",true,false], 
	["Land_Tyres_F",[13.4436,17.8198,0.00659704],202.603,1,0,[0,0],"","",true,false], 
	["Land_Cargo_Patrol_V3_F",[22.7268,-8.30322,0],314.038,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[1.8147,24.0034,0],177.693,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-3.62671,23.7163,0],177.693,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-16.8728,15.6558,0],177.704,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[18.6663,-13.145,0],1.98476,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-14.3396,22.9272,0],108.365,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-9.22241,23.4917,0],177.693,1,0,[0,-0],"","",true,false], 
	["Land_PortableLight_double_F",[24.342,-9.96533,0],311.55,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[27.8772,1.18701,0],91.2719,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[27.0803,-9.75244,0],133.912,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[27.76,-4.45752,0],93.7194,1,0,[0,-0],"","",true,false], 
	["Land_Pallet_F",[22.7952,17.9448,0],168.535,1,0,[8.16427e-006,5.00791e-006],"","",true,false], 
	["Land_HBarrier_5_F",[29.7014,6.43506,0],109.927,1,0,[0,-0],"","",true,false], 
	["Land_Pallets_stack_F",[22.6956,19.8843,-9.53674e-007],107.837,1,0,[6.25528e-005,4.95734e-005],"","",true,false], 
	["Land_HBarrier_5_F",[29.8674,7.51514,0],240.934,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[27.4944,12.3647,0],270.637,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[27.2971,17.9644,0],231.635,1,0,[0,0],"","",true,false]
];


fob3 = 
[
	["Land_Cargo_House_V1_F",[-8.05518,-1.60547,0],267.76,1,0,[0,0],"","",true,false], 
	["Land_Cargo_House_V1_F",[5.61865,5.74219,0],87.6723,1,0,[0,0],"","",true,false], 
	["Land_GarbageBarrel_01_F",[7.60815,-2.98975,-0.00605106],164.039,1,0,[0.318863,0.946913],"","",true,false], 
	["Land_ToiletBox_F",[8.05225,0.945801,1.66893e-005],88.4192,1,0,[-0.00100089,-2.5922e-006],"","",true,false], 
	["Land_ToiletBox_F",[8.13623,-1.62158,9.05991e-006],88.4178,1,0,[-0.000308197,0.000523215],"","",true,false], 
	["Land_PortableLight_double_F",[-5.01416,-8.41406,0],340.729,1,0,[0,0],"","",true,false], 
	["Land_TTowerSmall_2_F",[4.72217,2.41992,0],358.802,1,0,[0,0],"","",true,false], 
	["Land_WaterTank_F",[-7.4751,-6.78516,2.00272e-005],358.416,1,0,[0.0014093,-0.000315156],"","",true,false], 
	["Land_PaperBox_closed_F",[-8.63916,5.75977,0],69.6406,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[10.1245,4.11328,0],87.7722,1,0,[0,0],"","",true,false], 
	["Land_PortableLight_double_F",[7.91748,-6.92383,0],136.662,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[6.55225,-9.58203,0],178.557,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[10.5874,-5.98242,0],267.546,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[10.3921,-6.23242,0],135.892,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-4.45361,-9.86914,0],178.557,1,0,[0,-0],"","",true,false], 
	["Land_PaperBox_closed_F",[-10.5767,6.43555,0],312.011,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[9.86865,9.68945,0],87.9017,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-12.8618,4.07422,0],87.9017,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-12.5278,-6.0293,0],268.147,1,0,[0,0],"","",true,false], 
	["Land_Cargo_Patrol_V1_F",[-1.38135,13.416,0],178.651,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[-9.22119,-9.96289,0],227.148,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[0.790527,13.623,0],178.557,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[6.30029,13.8125,0],178.557,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_5_F",[6.55811,13.6094,0],46.9021,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-13.1509,9.60938,0],87.3005,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-9.25635,13.2324,0],356.646,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[-10.022,13.0449,0],48.1634,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[-13.0044,10.2676,0],42.7515,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_3_F",[2.17334,-16.375,0],358.802,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[17.2983,0.794922,-2.38419e-006],265.407,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_3_F",[-6.44971,-16.6719,0],358.802,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[17.7944,-2.40625,0],173.384,1,0,[0,-0],"","",true,false], 
	["Land_Razorwire_F",[11.9097,-13.4355,-2.38419e-006],314.574,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[9.73975,-15.7734,0],224.613,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[17.019,7.38281,0],173.384,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_1_F",[16.5093,-8.88086,0],224.613,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[-19.2466,-2.69922,0],355.469,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[-19.6665,0.337891,-2.38419e-006],265.407,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[-13.9712,-14.1777,-2.38419e-006],226.555,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[-11.52,-16.5078,0],318.366,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[-18.2837,-9.22852,0],318.366,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_3_F",[-17.686,11.5039,0],305.431,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[-20.1235,6.72461,0],355.469,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[16.2222,13.7539,0],137.661,1,0,[0,-0],"","",true,false], 
	["Land_Razorwire_F",[13.8101,15.8281,-2.38419e-006],226.447,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_3_F",[-13.186,16.7402,0],324.789,1,0,[0,0],"","",true,false], 
	["Land_Razorwire_F",[-0.197754,21.3652,-2.38419e-006],177.222,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_1_F",[3.00732,21.6992,0],86.9207,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[-6.63135,21.1523,0],86.9207,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_1_F",[9.47217,20.5898,0],137.661,1,0,[0,-0],"","",true,false]
];

fob4 = 
[
	["Land_HBarrier_5_F",[-2.26855,1.64307,0],306.67,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-3.04199,0.768066,0],127.37,1,0,[0,-0],"","",true,false], 
	["Land_Loudspeakers_F",[2.07324,3.59033,0],307.287,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_5_F",[-1.18457,-6.31006,0],218.506,1,0,[0,0],"","",true,false], 
	["Land_HBarrierBig_F",[4.03613,4.59424,0],216.67,1,0,[0,0],"","",true,false], 
	["Land_Cargo_House_V1_F",[5.1416,-3.32959,0],37.6699,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-0.811523,6.75439,-0.000999928],35.3246,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-5.26855,4.39502,-0.000999928],32.0698,1,0,[0,0],"","",true,false], 
	["Land_BagFence_End_F",[-7.98926,-0.13623,-0.000999928],32.6901,1,0,[0,0],"","",true,false], 
	["CamoNet_BLUFOR_open_Curator_F",[-1.64551,-8.86084,0],37.6699,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-10.1006,1.1665,-0.000999928],213.69,1,0,[0,0],"","",true,false], 
	["Land_Pallet_MilBoxes_F",[-10.1221,-2.99561,0],37.6699,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_Big_F",[10.5713,-0.503418,0],40.6699,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[-5.01465,9.58057,-0.000999928],32.2847,1,0,[0,0],"","",true,false], 
	["Land_PaperBox_open_full_F",[-10.8135,-0.247559,0],37.6699,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_Big_F",[-8.56738,7.20752,0],126.67,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[-6.87402,-8.9292,-0.000999928],218.67,1,0,[0,0],"","",true,false], 
	["Land_BagFence_End_F",[-5.02637,-10.4526,-0.000999928],37.6699,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_Big_F",[9.81152,-6.05029,0],128.67,1,0,[0,-0],"","",true,false], 
	["Land_PaperBox_open_empty_F",[-11.9717,-1.86279,0],37.6699,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_Big_F",[-11.2803,-5.36865,0],218.67,1,0,[0,0],"","",true,false], 
	["Land_BagFence_End_F",[-1.68262,-12.7925,-0.000999928],216.67,1,0,[0,0],"","",true,false], 
	["Land_HBarrier_Big_F",[-13.4482,0.432129,0],124.67,1,0,[0,-0],"","",true,false], 
	["Land_HBarrier_Big_F",[4.55957,-12.6694,0],128.67,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[0.235352,-14.2358,-0.000999928],214.67,1,0,[0,0],"","",true,false]
];

//Dismounted FOB
deployableFOB = "B_supplyCrate_F";

//Mounted FOB layout
deployableFOBMounted = [
	["Land_WoodenLog_F",[-0.642578,2.15625,0.000108242],77.2508,1,0,[0.0235584,0.0294471],"","",true,false], 
	["Land_Camping_Light_F",[-0.699219,2.07568,-0.00328207],76.2841,1,0,[-0.0513781,0.185873],"","",true,false], 
	["Land_TinContainer_F",[-0.279297,2.54102,0.00121117],237.702,1,0,[6.93485,2.27968],"","",true,false], 
	["Land_Canteen_F",[2.63281,0.191406,-0.0127125],17.1706,1,0,[0.0702205,-0.000630909],"","",true,false], 
	["Land_Basket_F",[3.3125,-1.20703,4.76837e-007],161.78,1,0,[-9.77839e-005,0.0005047],"","",true,false], 
	["Land_CanisterFuel_F",[-4.06055,0.265625,1.14441e-005],35.8411,1,0,[-0.00644743,0.00231369],"","",true,false], 
	["Land_Campfire_F",[-0.570313,4.0918,0.0299988],26.9091,1,0,[0,0],"","",true,false], 
	["Land_Axe_F",[-4.00586,1.35742,-0.00336075],248.022,1,0,[2.88914e-006,9.72829e-007],"","",true,false], 
	["Land_TentA_F",[4.33984,0.363281,0],118.2,1,0,[0,-0],"","",true,false], 
	["Land_Sack_F",[4.31641,-1.00586,-1.28746e-005],18.1445,1,0,[-0.122723,-0.182936],"","",true,false], 
	["Land_WoodPile_F",[-4.91797,1.03125,0],1.20355,1,0,[0,0],"","",true,false], 
	["Land_WoodenBox_F",[-2.28174,5.78467,0],135.19,1,0,[-3.59806e-006,9.88488e-006],"","",true,false], 
	["Land_TentA_F",[4.80664,4.20898,0],87.3948,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Short_F",[5.60547,-5.74219,-0.000999928],179.445,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Short_F",[7.57227,-3.53906,-0.000999928],259.241,1,0,[0,0],"","",true,false], 
	["Land_TentA_F",[3.81641,7.79297,0],57.6576,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Short_F",[7.13672,-4.97852,-0.000999928],131.627,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Round_F",[-11.0703,-5.4707,-0.00130129],4.48306,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-12.7324,-3.45117,-0.00130129],93.854,1,0,[0,-0],"","",true,false], 
	["Land_GasCooker_F",[0.972656,12.8945,9.53674e-007],130.558,1,0,[-0.00147465,-0.00040957],"","",true,false], 
	["Land_CerealsBox_F",[-0.587891,13.2266,2.38419e-006],92.0058,1,0,[0.00552748,-0.00152713],"","",true,false], 
	["Land_RiceBox_F",[-1.34961,13.2188,1.4782e-005],352.651,1,0,[-0.0141857,0.0144473],"","",true,false], 
	["Land_BakedBeans_F",[-1.56055,13.2109,2.38419e-006],37.784,1,0,[0.00467912,-0.000742864],"","",true,false], 
	["Land_CerealsBox_F",[-0.771484,13.3359,2.38419e-006],67.7626,1,0,[0.00557595,-0.00145385],"","",true,false], 
	["Land_Canteen_F",[0.285156,13.4063,1.7643e-005],340.47,1,0,[-0.0214264,-0.0151263],"","",true,false], 
	["Land_BottlePlastic_V2_F",[-1.28809,13.4438,0.132537],73.6349,1,0,[-0.582437,-0.0322353],"","",true,false], 
	["Land_RiceBox_F",[-1.53711,13.457,1.38283e-005],50.8693,1,0,[-0.0124999,0.0146155],"","",true,false], 
	["Land_DuctTape_F",[-4.33398,12.8828,0],99.5802,1,0,[3.0318e-005,-0.000274382],"","",true,false], 
	["Land_CanisterPlastic_F",[-4.96289,12.6953,-4.76837e-007],196.449,1,0,[-0.00226508,-0.000741863],"","",true,false], 
	["Land_Shovel_F",[-3.76221,13.2056,0.0243149],36.6754,1,0,[-6.20996,0.0597852],"","",true,false], 
	["Land_Sacks_heap_F",[1.49023,13.6602,0],22.6568,1,0,[0,0],"","",true,false], 
	["Land_CanisterPlastic_F",[-4.49609,13.5879,0],243.839,1,0,[-0.0020916,-0.000570904],"","",true,false], 
	["Land_BagFence_Round_F",[3.28711,14.2129,-0.00130129],222.772,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Long_F",[0.541016,14.6035,-0.000999928],358.245,1,0,[0,0],"","",true,false], 
	["Land_BagFence_Round_F",[-5.19141,14.0684,-0.00130129],136.002,1,0,[0,-0],"","",true,false], 
	["Land_BagFence_Long_F",[-2.37695,14.5195,-0.000999928],358.245,1,0,[0,0],"","",true,false]
]; 

deployableFOBMountedFortified = 
[
	["Campfire_burning_F",[-0.779541,-6.0293,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_SignM_WarningMilitaryArea_english_F",[-7.43506,-1.80273,-0.00143862],92.28,1,0,[0,-0],"","",true,false],
	["Item_ItemGPS",[1.92749,-0.436035,0.814159],0,1,0,[0,0],"","",true,false],
	["Item_FirstAidKit",[1.92896,-0.813965,0.814159],0,1,0,[0,0],"","",true,false],
	["Item_ToolKit",[2.16333,-0.627441,0.814159],0,1,0,[0,0],"","",true,false],
	["Item_Medikit",[2.16089,-0.782715,0.814159],0,1,0,[0,0],"","",true,false],
	["Item_FlashDisk",[0.338867,1.6123,0.814159],0,1,0,[0,0],"","",true,false],
	["Item_B_UavTerminal",[2.35425,-0.35791,0.814159],0,1,0,[0,0],"","",true,false],
	["Item_SatPhone",[0.647949,1.67676,0.814159],177.084,1,0,[0,-0],"","",true,false],
	["Land_MapBoard_Enoch_F",[-0.0671387,-1.56738,-0.003654],179.992,1,0,[-0.328382,-0.000183386],"","",true,false],
	["CamoNet_INDP_open_F",[-0.476074,1.7002,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Weapon_hgun_ACPC2_F",[-0.453857,1.6709,0.814159],337.557,1,0,[0,0],"","",true,false],
	["Item_Rangefinder",[-0.863281,2.01709,0.814159],0,1,0,[0,0],"","",true,false],
	["Land_Map_Malden_F",[-0.127686,1.83789,0.809566],268.406,1,0,[0.000247993,-0.000623003],"","",true,false],
	["Land_Laptop_02_unfolded_F",[2.07764,0.366211,0.809027],91.6358,1,0,[0.0263889,-0.00688397],"","",true,false],
	["Land_Canteen_F",[2.1084,-0.413574,0.809604],359.987,1,0,[0.0553273,-0.0238527],"","",true,false],
	["Land_Creditcard_01_F",[2.00537,0.120605,0.809556],359.983,1,0,[-0.00311555,-0.00273354],"","",true,false],
	["Land_PainKillers_F",[-2.13794,-0.151855,0.809669],0.122074,1,0,[0.0019327,-0.00224933],"","",true,false],
	["Weapon_hgun_Pistol_heavy_01_F",[2.13721,-0.0322266,0.814159],52.9912,1,0,[0,0],"","",true,false],
	["Land_TentSolar_01_folded_olive_F",[-2.39624,0.110352,0.814159],0,1,0,[0,0],"","",true,false],
	["Land_TentSolar_01_folded_redwhite_F",[-2.37622,0.504395,0.814159],0,1,0,[0,0],"","",true,false],
	["Intel_File1_F",[2.09229,0.75,0.814159],0,1,0,[0,0],"","",true,false],
	["Land_FirstAidKit_01_closed_F",[2.43042,-0.728516,0.809586],91.503,1,0,[0.00331141,-0.00124691],"","",true,false],
	["Land_Can_V3_F",[2.25195,0.618652,0.809573],359.947,1,0,[0.0206368,-0.0708589],"","",true,false],
	["Land_Wallet_01_F",[2.28149,0.0722656,0.809567],359.995,1,0,[-0.000640482,-0.00185455],"","",true,false],
	["Land_Antibiotic_F",[-2.32886,-0.135254,0.809639],359.855,1,0,[0.00125932,-0.00790619],"","",true,false],
	["Weapon_hgun_Pistol_heavy_02_F",[-2.28076,-0.368652,0.814159],243.564,1,0,[0,0],"","",true,false],
	["Land_Orange_01_F",[2.26367,0.730957,0.808179],359.738,1,0,[-3.29646,10.9191],"","",true,false],
	["Land_Map_unfolded_Malden_F",[-2.19556,0.809082,0.809781],359.929,1,0,[0.0114861,-0.010256],"","",true,false],
	["Weapon_srifle_DMR_06_olive_F",[-2.35986,-0.605469,0.814159],237.431,1,0,[0,0],"","",true,false],
	["Intel_File2_F",[2.45483,0.27002,0.814159],0,1,0,[0,0],"","",true,false],
	["Land_Bandage_F",[-2.50195,-0.134277,0.809621],0.117144,1,0,[-0.00944482,0.00173861],"","",true,false],
	["Intel_Photos_F",[2.45337,0.669922,0.814159],95.3767,1,0,[0,-0],"","",true,false],
	["Land_Defibrillator_F",[-2.54565,0.79248,0.809728],0.0363347,1,0,[0.00596005,-0.00611481],"","",true,false],
	["Land_Stethoscope_01_F",[-2.21362,-1.29883,0.759623],0.025153,1,0,[-0.00280693,0.00334116],"","",true,false],
	["Land_BarrelWater_F",[-0.406494,-1.77686,-0.00143671],5.47055e-005,1,0,[0.00108868,-0.000294669],"","",true,false],
	["Land_CampingTable_F",[-0.097168,1.83301,-0.0040307],9.79895e-005,1,0,[0.000386593,0.00012035],"","",true,false],
	["Land_TinContainer_F",[-2.70776,-0.70752,0.811514],0.229639,1,0,[6.92975,2.33325],"","",true,false],
	["Land_BottlePlastic_V2_F",[-2.72119,-0.867676,0.809416],0.0148513,1,0,[-0.634955,-0.191452],"","",true,false],
	["Land_Rope_01_F",[-2.70093,-0.456543,0.809543],241.587,1,0,[-0.0209909,-0.00259183],"","",true,false],
	["Land_MetalCase_01_medium_F",[0.469971,-1.65137,-0.00143909],360,1,0,[-5.48164e-005,-2.94562e-005],"","",true,false],
	["Land_CampingTable_F",[2.23242,-0.0449219,-0.0040288],272.829,1,0,[-0.00237382,0.000926937],"","",true,false],
	["Land_CampingTable_F",[-2.40356,-0.00976563,-0.0040307],271.976,1,0,[-0.00426323,-0.00337985],"","",true,false],
	["Land_PlasticCase_01_small_gray_F",[-1.1958,1.83496,-0.00143862],360,1,0,[-0.00011737,0.000114889],"","",true,false],
	["Land_Suitcase_F",[-2.2085,1.01221,-0.00136948],358.892,1,0,[-0.0394301,0.0265318],"","",true,false],
	["Land_PlasticCase_01_large_F",[-2.37671,-1.33594,-0.00143576],90.3688,1,0,[6.47521e-005,-0.00103517],"","",true,false],
	["Box_C_IDAP_UAV_06_medical_F",[2.26099,-0.600586,-0.00282907],0.00266316,1,0,[0.000185861,-6.6603e-005],"","",true,false],
	["Land_Ground_sheet_folded_khaki_F",[2.27563,0.32373,0.0941267],180.092,1,0,[71.9968,-179.999],"","",true,false],
	["Land_Ground_sheet_folded_khaki_F",[2.28101,0.619629,-0.00141525],359.928,1,0,[-0.0624297,-0.000428494],"","",true,false],
	["Land_Ground_sheet_folded_khaki_F",[2.29834,0.772461,-0.00141525],359.958,1,0,[-0.0623836,-0.000421262],"","",true,false],
	["Land_Ground_sheet_folded_khaki_F",[2.30249,1.05371,0.0855947],180.366,1,0,[-81.7461,179.991],"","",true,false],
	["Land_PlasticCase_01_large_black_CBRN_F",[-3.17798,0.0615234,-0.00143909],359.999,1,0,[-0.000220827,0.0003182],"","",true,false],
	["GroundWeaponHolder",[2.51953,-2.61475,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_CampingChair_V1_F",[2.33667,2.72021,0.00166512],58.1402,1,0,[-0.00179759,-0.00196862],"","",true,false],
	["Land_CampingChair_V1_F",[0.651367,3.60986,0.00165033],9.18301,1,0,[-0.000586461,0.000931366],"","",true,false],
	["Land_CampingChair_V1_F",[-0.634033,3.67383,0.00165224],350.558,1,0,[0.000182428,0.00013775],"","",true,false],
	["Land_TentA_F",[-2.01465,-3.2583,-0.00143862],332.185,1,0,[0,0],"","",true,false],
	["Land_CampingChair_V1_F",[1.67871,3.37109,0.00165033],31.2896,1,0,[-0.000707963,0.000890091],"","",true,false],
	["Land_CampingChair_V1_F",[-2.43726,2.91504,0.00165176],321.059,1,0,[-0.000239488,0.000127659],"","",true,false],
	["Land_CampingChair_V1_F",[-1.65674,3.42773,0.00165701],336.442,1,0,[-0.000143811,0.00195642],"","",true,false],
	["Land_TentSolar_01_folded_sand_F",[-0.740479,-3.54248,0.00934267],246.301,1,0,[-0.0986165,0.192966],"","",true,false],
	["Land_TentA_F",[1.97046,-3.7041,-0.00143862],39.2534,1,0,[0,0],"","",true,false],
	["Land_GasCooker_F",[0.651123,-4.26465,-0.00143862],0.00600821,1,0,[0.000856483,-0.000140594],"","",true,false],
	["Land_TacticalBacon_F",[0.825684,-4.30664,-0.00143385],0.0470191,1,0,[0.00687739,-0.0153322],"","",true,false],
	["Land_Can_V3_F",[0.906982,-4.33789,-0.00143576],359.957,1,0,[0.00537002,0.0134048],"","",true,false],
	["Land_Stretcher_01_olive_F",[-3.07031,-3.81836,-0.00143814],153.276,1,0,[6.17193e-007,-8.20002e-005],"","",true,false],
	["ShootingMat_01_OPFOR_F",[-1.2356,-4.53467,0.00994253],61.8847,1,0,[0.63715,-0.62677],"","",true,false],
	["Land_BottlePlastic_V1_F",[-1.86694,-4.5835,-0.00138474],359.816,1,0,[-0.0890039,0.131497],"","",true,false],
	["Land_BagFence_End_F",[5.88428,0.0268555,0.831355],270.541,1,0,[0,0],"","",true,false],
	["Land_BagFence_End_F",[5.91553,0.494629,0.831355],270.541,1,0,[0,0],"","",true,false],
	["ShootingMat_01_OPFOR_F",[1.17358,-4.76172,0.00764132],301.563,1,0,[-0.550803,0.70386],"","",true,false],
	["BloodSplatter_01_Large_New_F",[-3.03296,-3.85449,-0.00143862],243.686,1,0,[0,0],"","",true,false],
	["Land_Can_V1_F",[-1.93579,-4.5874,-0.00143528],359.917,1,0,[-0.0109666,0.0104841],"","",true,false],
	["Land_TentSolar_01_folded_redwhite_F",[2.18359,-4.91064,0.00908518],134.428,1,0,[0.103525,-0.190372],"","",true,false],
	["Land_BagFence_Long_F",[5.77734,-2.18115,0.79048],272.735,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[5.97437,1.62207,0.764582],270.71,1,0,[0,0],"","",true,false],
	["Banner_01_IDAP_F",[-0.831299,6.3042,0.661768],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_End_F",[0.288574,6.41895,0.831355],179.626,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[5.86743,-1.02197,-0.00143862],272.7,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-0.938721,6.57666,0.79048],0,1,0,[0,0],"","",true,false],
	["Banner_01_EAF_F",[-6.67236,-1.75488,1.32232],95.0592,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[6.04688,1.61279,-0.00143862],272.7,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[2.71509,6.27148,0.79048],0,1,0,[0,0],"","",true,false],
	["Land_CanisterFuel_F",[1.93433,-5.92773,-0.00139761],179.517,1,0,[-0.0273451,-0.00191767],"","",true,false],
	["Land_BagFence_Short_F",[-6.98633,-2.03809,1.61577],271.794,1,0,[0,0],"","",true,false],
	["Land_FoodSacks_01_cargo_brown_idap_F",[-6.24341,-1.63086,-0.00243902],350.548,1,0,[5.32552e-005,-1.81387e-005],"","",true,false],
	["Land_BagFence_End_F",[5.7605,-3.43896,0.831355],270.541,1,0,[0,0],"","",true,false],
	["CamoNet_INDP_open_F",[-0.394531,-7.54785,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[0.736816,6.5166,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_End_F",[-3.35059,6.49805,0.831355],176.257,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-7.10278,1.18555,0.801282],269.915,1,0,[0,0],"","",true,false],
	["Land_TentSolar_01_folded_sand_F",[2.18994,-6.16895,0.00548744],0,1,0,[0.654595,0.0948812],"","",true,false],
	["Land_BagFence_Long_F",[-1.75684,6.55713,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_FoodContainer_01_White_F",[-3.32959,-5.72656,0.171659],53.3448,1,0,[-44.9958,-89.9992],"","",true,false],
	["Land_BagFence_Long_F",[-7.13843,-1.40479,0.79048],94.1599,1,0,[0,-0],"","",true,false],
	["Land_BagFence_End_F",[5.78735,-3.93701,0.831355],270.541,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[5.71143,-3.90479,-0.00143862],272.7,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[2.84741,6.33398,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_Bucket_F",[1.58374,-6.73633,0.0845704],323.884,1,0,[47.4222,-82.7315],"","",true,false],
	["Land_BagFence_Long_F",[-7.13599,1.25537,-0.00143862],272.7,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[-7.30493,-3.9209,1.92616],272.586,1,0,[0,0],"","",true,false],
	["ShootingMat_01_OPFOR_F",[1.42285,-7.0083,0.00918007],187.96,1,0,[0.627884,-0.636018],"","",true,false],
	["Land_Razorwire_F",[7.44653,-0.422363,-0.00143862],92.3337,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-7.28638,-1.35547,-0.00143862],91.3201,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-4.64038,6.34912,0.75642],354.335,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[6.50146,5.28906,-0.00143862],238.974,1,0,[0,0],"","",true,false],
	["Banner_01_NATO_F",[-7.39722,-3.02637,0.781155],0,1,0,[0,0],"","",true,false],
	["ShootingMat_01_OPFOR_F",[-2.05176,-7.1416,-0.00143862],319.641,1,0,[0,0],"","",true,false],
	["Land_Shoot_House_Tunnel_Stand_F",[-7.3147,-3.98633,-0.00143862],271.079,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-3.07422,7.98096,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[5.61084,-6.1333,0.785248],95.0428,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-4.60474,6.46777,-0.00143862],349.27,1,0,[0,0],"","",true,false],
	["Weapon_LMG_Zafir_F",[1.323,-7.59229,0.0370531],200.868,1,0,[0.754077,-0.479701],"","",true,false],
	["Land_Graffiti_01_F",[-6.6897,-4.96045,1.13979],178.36,1,0,[0,-0],"","",true,false],
	["Land_TentA_F",[2.89233,-7.20801,-0.00144005],99.0917,1,1,[0,-0],"","",true,false],
	["Land_LiquidDispenser_01_F",[1.74023,-8.11133,-0.00140381],271.051,1,0,[0.00432572,0.00255795],"","",true,false],
	["Land_TentSolar_01_folded_redwhite_F",[-1.91357,-7.99854,0.0197492],325.58,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[-7.97852,4.82422,-0.00143862],110.731,1,0,[0,-0],"","",true,false],
	["Land_TentA_F",[-3.06006,-7.81592,-0.00144005],232.868,1,1,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[5.5481,-6.6626,-0.00143862],272.7,1,0,[0,0],"","",true,false],
	["Land_BagFence_Short_F",[-7.34375,-5.90576,1.61577],267.553,1,0,[0,0],"","",true,false],
	["Land_Sign_WarningNoWeapon_F",[-6.74048,-6.11328,-0.00143862],275.825,1,0,[0,0],"","",true,false],
	["Land_Stretcher_01_folded_olive_F",[-6.99023,-5.65576,-0.00243855],0.167785,1,0,[1.22079e-006,-2.29552e-005],"","",true,false],
	["Land_Graffiti_04_F",[-8.29932,-4.9541,1.35486],183.365,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-7.43677,-6.50244,0.83819],277.386,1,0,[0,0],"","",true,false],
	["Land_Bollard_01_F",[-9.61182,0.363281,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_Bollard_01_F",[-9.60864,-0.79248,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_Bollard_01_F",[-9.57178,1.47021,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_Bollard_01_F",[-9.58325,-2.0459,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-7.34937,-6.46338,-0.00143862],91.0304,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-0.718994,-11.0688,0.79048],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_End_F",[1.83154,-11.0469,0.831355],353.121,1,0,[0,0],"","",true,false],
	["Land_BagFence_End_F",[-1.95386,-11.1611,0.831355],2.26616,1,0,[0,0],"","",true,false],
	["Land_Bollard_01_F",[-9.54785,-5.77588,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[6.4917,-9.7915,-0.00143862],284.237,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[3.07983,-11.123,0.871538],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-1.74341,-11.0894,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[0.949951,-11.2588,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-4.37964,-10.9976,0.784603],191.89,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-4.48706,-10.8096,-0.00143862],7.29268,1,0,[0,0],"","",true,false],
	["Land_Bollard_01_F",[-9.55566,-6.90771,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[3.83228,-11.1548,-0.00143862],0,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[-8.11108,-9.93457,-0.00143862],61.4817,1,0,[0,0],"","",true,false],
	["Land_Razorwire_F",[-1.92627,-12.3936,-0.00143862],0,1,0,[0,0],"","",true,false]
];

avalaibleFOB = [ 
	fob1,
	fob2,
	fob3,
	fob4
];

enemyFOB1 = /*
Grab data:
Mission: tempMissionSP
World: VR
Anchor position: [514.459, 3105.75]
Area size: 100
Using orientation of objects: no
Sign_Arrow_Large_F are normal opfor
Sign_Arrow_Large_Yellow_F are opfor turret
*/
[["Land_Cargo_HQ_V1_F",[-8.16159,-1.84863,-0.00143862],89.112,1,0,[0,0],"","",true,false],["Land_Cargo_House_V1_F",[8.6778,-12.7593,-0.00143909],180.445,1,0,[0,0],"","",true,false],["Land_Tank_rust_F",[-6.67087,-17.1284,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_Cargo_Patrol_V1_F",[8.81061,21.6318,-0.00143862],180.641,1,0,[0,0],"","",true,false],["Land_cargo_addon02_V1_F",[-15.259,-17.3047,-0.00143909],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[1.5401,-2.63354,-0.00143909],357.506,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-3.56216,1.78589,-0.00143909],50.2514,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-1.53027,-4.19385,-0.00143909],0.48668,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-5.64795,1.60132,0.600235],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[-4.80838,-5.35059,3.27925],91.3984,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-4.74808,-5.44409,0.600235],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[6.5401,2.36646,-0.00143909],305.22,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-7.4599,-1.63354,0.600235],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-8.4599,-2.63354,3.12508],0,1,0,[0,0],"","",true,false],["CamoNet_INDP_open_Curator_F",[8.42609,5.13525,-0.00143909],271.571,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[0.5401,10.3665,-0.00143909],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[4.81982,-9.73364,-0.00143909],266.936,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[9.5401,7.36646,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-3.67429,12.0249,-0.00143909],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[-12.8837,0.729248,3.27442],269.565,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[-10.351,-7.92285,3.25522],179.149,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[1.59259,12.0054,-0.00143909],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-10.4599,-7.63354,0.600235],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-13.4599,-3.63354,3.20024],0,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[13.3948,2.50439,-0.00143909],271.209,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[4.65411,-15.5127,-0.00143909],270.531,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-14.4599,-1.63354,0.72065],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[10.6263,-9.71606,-0.00143909],304.416,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[13.4116,-5.87695,-0.00143909],271.209,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-9.4599,-11.6335,-0.00143909],90.057,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-14.7661,-3.90894,-0.00143909],326.432,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-7.12033,-13.7573,-0.00143909],180.796,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[1.5401,-15.6335,-0.00143909],159.97,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-3.92276,15.8799,-0.00143909],80.6931,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[9.5401,-13.6335,0.998561],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-10.8768,12.7925,-0.00143909],80.2045,1,0,[0,0],"","",true,false],["CamoNet_INDP_open_Curator_F",[-12.1255,12.7085,-0.00143909],178.49,1,0,[0,-0],"","",true,false],["Land_HBarrierBig_F",[-1.67987,-17.0522,-0.00143909],270.094,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[13.325,11.0029,-0.00143909],271.209,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-6.6445,17.4507,-0.00143909],0.851427,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[7.90802,-17.3545,-0.00143909],181.513,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-16.4599,-9.63354,-0.00143909],3.77149,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-19.2707,-0.820801,-0.00143909],271.207,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-10.9134,-15.9717,-0.00143909],202.232,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[13.3936,-14.2271,-0.00143909],271.209,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[9.37897,17.3682,-0.00143909],250.365,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-3.4599,-19.6335,-0.00143909],265.093,1,0,[0,0],"","",true,false],["Land_CratesShabby_F",[-12.9475,-15.8311,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_StallWater_F",[-4.79343,-20.0845,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-19.3069,7.81104,-0.00143909],270.269,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-15.6426,-13.9614,-0.00143909],179.946,1,0,[0,-0],"","",true,false],["Land_HBarrierBig_F",[-19.1526,-8.9375,-0.00143909],270.269,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[4.81036,21.2783,-0.00143909],270.888,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-2.15741,-22.0635,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_Sack_F",[-15.1213,-16.1978,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-7.80344,-22.0635,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[3.48975,-22.0679,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-15.0551,17.3501,-0.00143909],0.851427,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[9.5401,21.3665,4.46718],0.83532,1,0,[0,0],"","",true,false],["Land_CratesWooden_F",[-16.7859,-16.1519,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[13.3394,19.4253,-0.00143909],271.209,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[8.5401,22.3665,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_HBarrier_3_F",[-10.9509,-22.1426,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_BagBunker_Small_F",[-20.1565,14.2734,-0.00143909],88.7408,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-20.1987,14.3467,-0.00143909],270.555,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-18.9951,-20.0928,-0.00143909],269.452,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[9.9126,24.5962,-0.00143909],0.585755,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[-18.9594,-21.377,-0.00143909],0,1,0,[0,0],"","",true,false]];


enemyFOB2 =
[["Land_Cargo_House_V1_F",[11.6612,10.0127,-0.00143909],90.4975,1,0,[0,-0],"","",true,false],["Land_Cargo_House_V1_F",[-16.4538,11.8159,-0.00143909],267.76,1,0,[0,0],"","",true,false],["Land_PortableLight_double_F",[-13.8407,-18.4907,-0.00143909],241.444,1,0,[0,0],"","",true,false],["Land_Cargo_Patrol_V1_F",[10.6476,23.0269,-0.00143862],178.764,1,0,[0,-0],"","",true,false],["Land_Cargo_Patrol_V1_F",[-8.95987,-23.9478,-0.00143862],0.104889,1,0,[0,0],"","",true,false],["Land_PortableLight_double_F",[-23.079,12.9233,-0.00143909],314.869,1,0,[0,0],"","",true,false],["Land_PortableLight_double_F",[10.1691,24.4702,-0.00143909],178.683,1,0,[0,-0],"","",true,false],["Land_PortableLight_double_F",[-8.64734,-25.5591,-0.00143909],0.823011,1,0,[0,0],"","",true,false],["Land_PaperBox_closed_F",[-2.88837,4.37158,-0.00143909],126.324,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-5.45004,1.12109,-0.00143909],166.056,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-2.63538,6.59448,-0.00143909],126.251,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[-4.88193,6.72241,-0.00143909],252.434,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[-8.05035,4.9646,-0.00143909],67.2099,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-1.24304,7.4292,-0.00143909],228.766,1,0,[0,0],"","",true,false],["Land_Pallets_F",[9.40033,1.29834,-0.00143909],354.869,1,0,[0,0],"","",true,false],["Land_WaterBarrel_F",[-7.21179,-7.66846,-0.00243855],189.652,1,0,[-5.9563e-006,-1.53125e-005],"","",true,false],["Land_HBarrier_5_F",[-11.6337,-6.17822,-0.00143909],0.823011,1,0,[0,0],"","",true,false],["Land_MetalBarrel_F",[-7.06921,-8.74658,-0.00143766],297.44,1,0.00494793,[-0.000568344,-0.000525692],"","",true,false],["Land_HBarrier_5_F",[5.92493,-12.1978,-0.00143909],224.276,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-8.25824,-8.28589,-0.00143909],147.157,1,0,[0,-0],"","",true,false],["Land_BarrelTrash_grey_F",[-7.50281,-9.3501,-0.00143719],6.93759,1,0,[0.000764179,-0.000755036],"","",true,false],["Land_BarrelEmpty_grey_F",[-8.23328,-9.18018,-0.00143719],0.825762,1,0,[-3.36814e-005,-0.00111109],"","",true,false],["Sign_Arrow_Large_F",[6.55432,-10.7473,-0.00143909],315.497,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[-1.66367,12.6123,-0.00143909],357.794,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[9.40735,5.29834,-0.00143909],0.564758,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[2.328,-13.0955,-0.00143909],181.836,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[13.3829,-0.343506,-0.00143909],90.9959,1,0,[0,-0],"","",true,false],["Land_Cargo20_military_green_F",[14.2198,1.80811,-0.00143909],180.656,1,0,[1.49814e-005,3.05525e-006],"","",true,false],["Sign_Arrow_Large_F",[-11.2208,9.42871,-0.00143909],248.483,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[14.4414,3.41602,-0.00143909],94.3419,1,0,[0,-0],"","",true,false],["Land_BagFence_Round_F",[-1.31876,15.0229,-0.00143909],182.785,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-4.17468,12.0503,-0.00143909],270.174,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[2.3172,-16.0359,-0.00143909],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-5.93527,14.8459,-0.00143909],166.063,1,0,[0,-0],"","",true,false],["Land_Cargo20_military_green_F",[14.8175,-6.73877,-0.00143862],133.028,1,0,[9.09414e-006,7.49265e-007],"","",true,false],["Sign_Arrow_Large_Yellow_F",[-12.2511,-11.0081,-0.00143909],133.1,1,0,[0,-0],"","",true,false],["Land_BagFence_Round_F",[-9.38834,-13.6262,-0.00143909],303.906,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[5.77063,-17.9321,-0.00143909],272.053,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-16.6571,-6.14893,-0.00143909],0.823011,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[13.9157,11.5071,0.727409],215.079,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[3.60461,-17.5901,-0.00143909],182.03,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[5.18573,17.8489,-0.00143909],332.116,1,0,[0,0],"","",true,false],["Land_PaperBox_closed_F",[3.14612,18.4287,-0.00143909],126.324,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[17.8271,-6.39844,-0.00143909],47.1026,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[17.3013,8.09619,-0.00143909],1.80178,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-18.8041,-3.47144,-0.00143909],262.01,1,0,[0,0],"","",true,false],["Land_WaterTank_F",[-16.6415,-9.59033,-0.00139332],358.843,1,0,[0.00321567,-0.000756155],"","",true,false],["Sign_Arrow_Large_F",[15.929,-11.0283,-0.00143909],42.1157,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-19.5057,1.26611,-0.00143909],218.744,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[18.9171,5.5542,-0.00143909],178.683,1,0,[0,-0],"","",true,false],["Land_PaperBox_closed_F",[-20.3993,-1.15869,-0.00143909],126.324,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-14.23,14.9414,-0.00143909],143.182,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[11.4955,-17.4255,-0.00143909],317.36,1,0,[0,0],"","",true,false],["Land_PaperBox_closed_F",[3.29755,-20.6541,-0.00143909],126.324,1,0,[0,-0],"","",true,false],["Land_WaterTank_F",[-16.7079,-12.8208,-0.00139236],358.843,1,0,[-0.000119698,-0.00152597],"","",true,false],["Sign_Arrow_Large_F",[-11.358,18.1387,0.176901],95.1497,1,0,[0,-0],"","",true,false],["Land_Pallets_stack_F",[-21.4462,0.728027,-0.00143909],0.8233,1,0,[5.60522e-005,1.33701e-005],"","",true,false],["Sign_Arrow_Large_F",[-18.8758,10.7759,0.696272],65.2922,1,0,[0,0],"","",true,false],["Land_ToiletBox_F",[19.6925,9.28467,-0.00143385],90.2851,1,0,[-0.000144354,-0.00025612],"","",true,false],["Sign_Arrow_Large_F",[-19.3377,-10.0479,-0.00143909],91.3573,1,0,[0,-0],"","",true,false],["Land_PaperBox_closed_F",[-21.4735,-3.90869,-0.00143909],274.591,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-4.62732,-21.6501,-0.00143909],354.94,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[19.5257,-10.4763,-0.00143909],25.3084,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[20.9832,-7.42847,-0.00143909],204.957,1,0,[0,0],"","",true,false],["Land_BagBunker_Large_F",[-8.07898,21.6733,-0.00143909],178.683,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[6.49597,-21.7415,0.176901],260.762,1,0,[0,0],"","",true,false],["Land_ToiletBox_F",[19.6456,11.4722,-0.00143766],90.2846,1,0,[0.000438242,0.000225891],"","",true,false],["Land_HBarrier_5_F",[5.00305,24.6265,-0.00143909],89.912,1,0,[0,0],"","",true,false],["Land_Cargo20_military_green_F",[18.7823,-13.606,-0.00143909],20.639,1,0,[-7.94068e-006,7.50831e-007],"","",true,false],["Sign_Arrow_Large_F",[-19.4819,-13.4712,-0.00143909],93.6812,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[-3.47351,-25.7251,-0.00143909],272.053,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-21.9071,-9.28955,-0.00143909],272.357,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[12.8552,-20.1111,0.176901],172.768,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[10.2918,22.2778,4.3426],359.967,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-16.7958,17.8452,-0.00143909],178.683,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-7.34509,-23.6599,4.3426],169.025,1,0,[0,-0],"","",true,false],["Land_BagBunker_Large_F",[9.71985,-23.2603,-0.00143909],0.823011,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-6.45187,23.8499,0.176901],356.09,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-18.4579,-16.5454,-0.00143909],217.579,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-20.7303,13.7107,-0.00143909],201.44,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[6.62683,24.0552,-0.00143909],178.302,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[17.9998,-17.666,-0.00143909],295.617,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[12.197,22.5818,4.3426],30.4722,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[24.0363,8.89209,-0.00143909],90.216,1,0,[0,-0],"","",true,false],["Land_HBarrierBig_F",[20.3156,16.0073,-0.00143909],35.438,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-10.6605,23.6599,0.176901],359.439,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[7.44617,-24.9514,0.176901],204.186,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[12.2925,-23.1392,0.176901],180.171,1,0,[0,0],"","",true,false],["Land_Cargo20_military_green_F",[26.3644,-5.10986,-0.00143957],89.579,1,0,[-1.79854e-005,-7.23406e-007],"","",true,false],["Land_HBarrier_5_F",[9.26868,26.0854,-0.00143909],178.683,1,0,[0,-0],"","",true,false],["Land_HBarrierBig_F",[18.5597,-19.7603,-0.00143909],0.823011,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-7.78796,-27.0024,-0.00143909],0.823011,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-27.8036,-2.05908,-0.00143909],272.949,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[-14.8603,-23.5376,-0.00143909],272.357,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-12.9832,-24.8962,-0.00143909],0.54371,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[16.4737,22.8765,-0.00143909],90.216,1,0,[0,-0],"","",true,false],["Land_HBarrierBig_F",[-27.4618,7.27686,-0.00143909],90.604,1,0,[0,-0],"","",true,false],["Land_HBarrierBig_F",[-24.4501,14.4917,-0.00143909],136.365,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[-27.9579,-7.71338,-0.00143909],271.385,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[14.6215,24.5178,-0.00143909],178.302,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[-23.6728,-12.7056,-0.00143909],183.779,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[28.3323,5.40405,-0.00143909],178.302,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[14.8098,26.2124,-0.00143909],178.683,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[-13.331,-26.938,-0.00143909],0.823011,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[29.7569,0.435059,-0.00143909],90.808,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[28.052,-10.8325,-0.00143909],178.302,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[29.88,6.07178,-0.00143909],90.808,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[25.7628,12.0562,-0.00143909],1.63802,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[29.8019,-9.10986,-0.00143909],272.745,1,0,[0,0],"","",true,false],["Land_HBarrierBig_F",[26.3448,-16.688,-0.00143909],318.505,1,0,[0,0],"","",true,false]];


enemyFOB3 = 
[["Land_TTowerSmall_2_F",[5.97043,0.343018,-0.00143909],358.802,1,0,[0,0],"","",true,false],["Land_Cargo_House_V1_F",[-6.80692,-3.68237,-0.00143909],267.76,1,0,[0,0],"","",true,false],["Land_Cargo_House_V1_F",[6.86691,3.66528,-0.00143909],87.6723,1,0,[0,0],"","",true,false],["Land_Cargo_Patrol_V1_F",[-0.133087,11.3391,-0.00143862],178.651,1,0,[0,-0],"","",true,false],["Land_PortableLight_double_F",[-3.7659,-10.491,-0.00143909],340.729,1,0,[0,0],"","",true,false],["Land_PortableLight_double_F",[9.16574,-9.00073,-0.00143909],136.662,1,0,[0,-0],"","",true,false],["Land_HBarrier_3_F",[3.16281,-6.71265,-0.00143909],267.871,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-6.17215,1.67358,-0.00143909],330.284,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[5.56976,-3.625,-0.00143909],321.304,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-0.167358,7.42212,-0.00143909],280.878,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[4.72919,-5.94507,-0.00143909],337.331,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[2.01382,8.84204,4.13861],177.649,1,0,[0,-0],"","",true,false],["Land_PaperBox_closed_F",[-7.3909,3.68286,-0.00143909],69.6406,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[8.98306,1.8252,0.727409],274.209,1,0,[0,0],"","",true,false],["Land_ToiletBox_F",[9.30051,-1.13159,-0.00143671],88.4158,1,0,[0.000426992,0.000307324],"","",true,false],["Sign_Arrow_Large_F",[-8.98892,2.01318,-0.00143909],351.394,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-9.22577,-2.36523,0.727409],97.8397,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[9.3157,0.100586,-0.00143909],251.886,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[4.9574,-8.19043,-0.00143909],228.327,1,0,[0,0],"","",true,false],["Land_ToiletBox_F",[9.38449,-3.698,-0.00144577],88.4189,1,0,[0.0006271,0.000314325],"","",true,false],["Sign_Arrow_Large_F",[9.12112,5.03735,0.727409],226.742,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[1.18494,10.9592,4.3426],45.9978,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-8.94202,-5.54272,0.727409],52.1613,1,0,[0,0],"","",true,false],["Land_GarbageBarrel_01_F",[8.85632,-5.06616,-0.0073905],164.039,1,0,[0.333374,0.933515],"","",true,false],["Land_PaperBox_closed_F",[-9.3284,4.35864,-0.00143909],312.011,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-1.47659,11.5286,4.3426],328.176,1,0,[0,0],"","",true,false],["Land_WaterTank_F",[-6.22684,-8.86206,-0.00141907],358.416,1,0,[0.00140833,-0.000314846],"","",true,false],["Sign_Arrow_Large_F",[10.0793,-4.76343,-0.00143909],307.442,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[11.3728,2.03638,-0.00143909],87.7722,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[2.03879,11.5461,-0.00143909],178.557,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[-11.6136,1.99731,-0.00143909],87.9017,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-7.15628,9.05737,-0.00143909],290.746,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-8.75342,-7.65186,-0.00143909],89.9933,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[7.35736,9.3291,-0.00143909],243.081,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[11.1169,7.61255,-0.00143909],87.9017,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-8.00809,11.1555,-0.00143909],356.646,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-11.2796,-8.1062,-0.00143909],268.147,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[7.54855,11.7356,-0.00143909],178.557,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[-11.9026,7.53247,-0.00143909],87.3005,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[7.80051,-11.6589,-0.00143909],178.557,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[11.8357,-8.05933,-0.00143909],267.546,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-3.20535,-11.946,-0.00143909],178.557,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[7.80637,11.5325,-0.00143909],46.9021,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[-8.77371,10.968,-0.00143909],48.1634,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[11.6403,-8.30933,-0.00143909],135.892,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[-7.97293,-12.0398,-0.00143909],227.148,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[-11.7561,8.19067,-0.00143909],42.7515,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[14.3737,6.67456,-0.00143909],46.5745,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-0.75354,-15.9478,-0.00143909],178.747,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-13.9749,9.53687,-0.00143909],264.363,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-16.4223,-4.68188,-0.00143909],311.514,1,0,[0,0],"","",true,false],["Land_HBarrier_3_F",[-2.33505,-16.0627,-0.00143909],90.0603,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-9.98138,14.3657,-0.00143909],12.3945,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[5.1687,-16.7432,-0.00143909],60.8173,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[17.116,-4.66284,-0.00143909],109.276,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-4.52081,-17.1985,-0.00143909],32.6548,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[5.49612,17.0662,-0.00143909],348.278,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[-13.0859,12.4666,-0.00143909],252.434,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[9.5369,15.7305,-0.00143909],54.24,1,0,[0,0],"","",true,false],["Land_Razorwire_F",[-18.4183,-1.73901,-0.00143909],265.407,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[-16.729,-7.97803,-0.00143909],260.122,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[-17.9983,-4.77612,-0.00143909],355.469,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[15.7469,10.2275,-0.00143909],6.42716,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-15.4209,-10.7473,-0.00143909],197.48,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-7.06705,17.2778,-0.00143909],336.713,1,0,[0,0],"","",true,false],["Land_HBarrier_3_F",[-11.9378,14.6633,-0.00143909],324.789,1,0,[0,0],"","",true,false],["Land_HBarrier_3_F",[-16.4378,9.427,-0.00143909],305.431,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[18.5432,3.72656,-0.00143909],173.384,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[18.8306,1.41284,-0.00143909],87.7722,1,0,[0,0],"","",true,false],["Land_HBarrier_3_F",[3.4216,-18.4519,-0.00143909],358.802,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[18.2673,5.30591,-0.00143909],173.384,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[17.1232,8.31006,-0.00143909],81.6581,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-9.66342,-16.4397,-0.00143909],162.542,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[9.96078,-16.302,-0.00143909],91.5382,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[16.5814,-9.60522,-0.00143909],101.966,1,0,[0,-0],"","",true,false],["Land_HBarrier_5_F",[-19.1677,4.60474,-0.00143909],298.812,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-1.60818,19.2051,-0.00143909],355.454,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[19.2252,-4.39893,-0.00143909],173.384,1,0,[0,-0],"","",true,false],["Land_HBarrier_1_F",[4.25558,19.6223,-0.00143909],86.9207,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[7.46042,18.7197,-0.00143909],16.6953,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-13.0405,-15.5947,-0.00143909],225.667,1,0,[0,0],"","",true,false],["Land_Razorwire_F",[13.1579,-15.5125,-0.00143909],314.574,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[-17.0354,-11.3054,-0.00143909],318.366,1,0,[0,0],"","",true,false],["Land_Razorwire_F",[15.0583,13.7512,-0.00143909],226.447,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[-20.4824,-0.607422,-0.00143909],355.469,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-2.9935,-19.7427,-0.00143909],177.547,1,0,[0,-0],"","",true,false],["Land_BagBunker_Small_F",[-15.4089,14.5747,-0.00143909],128.23,1,0,[0,-0],"","",true,false],["Land_HBarrier_3_F",[19.2985,-6.65698,-0.00143909],97.6726,1,0,[0,-0],"","",true,false],["Land_HBarrier_1_F",[17.7575,-10.9578,-0.00143909],224.613,1,0,[0,0],"","",true,false],["Land_HBarrier_5_F",[-9.00021,-19.7854,-0.00143909],229.089,1,0,[0,0],"","",true,false],["Land_BagBunker_Small_F",[-19.8256,-8.32349,-0.00143909],80.1684,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[10.988,-17.8503,-0.00143909],224.613,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[17.4704,11.677,-0.00143909],137.661,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[4.18521,-20.7227,-0.00143909],144.708,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[7.81686,-19.7893,-0.00143909],38.6708,1,0,[0,0],"","",true,false],["Land_HBarrier_1_F",[10.7204,18.5129,-0.00143909],137.661,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_Yellow_F",[9.37866,-19.2361,-0.00143909],117.142,1,0,[0,-0],"","",true,false],["Land_HBarrier_1_F",[5.02112,20.8794,-0.00143909],86.9207,1,0,[0,0],"","",true,false],["Land_BagBunker_Small_F",[20.607,8.91113,-0.00143909],260.335,1,0,[0,0],"","",true,false],["Land_BagBunker_Small_F",[8.23334,22.0066,-0.00143909],199.282,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[1.76947,-22.9519,-0.00143909],163.145,1,0,[0,-0],"","",true,false],["Land_HBarrier_3_F",[9.09308,-21.3579,-0.00143909],147.765,1,0,[0,-0],"","",true,false],["Land_BagBunker_Small_F",[12.3656,-20.9294,-0.00143909],298.995,1,0,[0,0],"","",true,false],["Land_HBarrier_3_F",[5.36917,-23.9749,-0.00143909],146.472,1,0,[0,-0],"","",true,false],["Land_HBarrier_3_F",[-1.09045,-25.7034,-0.00143909],358.802,1,0,[0,0],"","",true,false]];

avalaibleEnemyFOB = [
	enemyFOB1,
	enemyFOB2,
	enemyFOB3
];


RoadBlock1 =
[["RoadBarrier_F",[-1.43652,-2.53369,0.02],359.988,1,0.0274806,[-0.325301,0.000479228],"","",true,false],["RoadBarrier_F",[1.6626,-2.5249,0.02],0.0534334,1,0.00559183,[-0.422764,0.602272],"","",true,false],["RoadCone_F",[3.26709,-2.5752,-0.00143242],359.995,1,0.00498072,[-0.0032119,-0.000835667],"","",true,false],["RoadCone_F",[-3.70703,-2.55225,-0.00143433],359.996,1,0.00497474,[-0.00240255,-0.000752728],"","",true,false],["RoadCone_F",[3.97852,-2.67334,-0.00143909],0.000419099,1,0.0049627,[4.9872e-005,-4.58972e-005],"","",true,false],["RoadCone_F",[-4.25439,-2.521,-0.00143909],0.000419344,1,0.00495979,[4.98568e-005,-5.0732e-005],"","",true,false],["Land_BagFence_Round_F",[5.46777,-1.24805,-0.00143909],184.799,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[-5.55273,-0.587402,-0.00143909],184.799,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-5.92773,-2.64063,-0.00143909],0,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[5.72021,-3.21143,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[-5.90234,-3.77686,-0.00143909],0,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[5.48193,-4.51904,-0.00143909],0,1,0,[0,0],"","",true,false]];

RoadBlock2 =
[["Land_Razorwire_F",[1.57416,3.03564,-0.00143909],177.877,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-5.38538,1.04102,-0.00143909],92.2266,1,0,[0,-0],"","",true,false],["Land_BagFence_Round_F",[-5.5484,0.0581055,-0.00143909],356.278,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[-5.79468,3.41162,-0.00143909],92.2266,1,0,[0,-0],"","",true,false],["Land_BagBunker_Small_F",[6.7345,2.46924,-0.00143909],358.847,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[6.72345,3.02441,-0.00143909],272.507,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[-5.91339,5.30029,-0.00143909],182.08,1,0,[0,0],"","",true,false],["Land_BagFence_Short_F",[-7.59882,3.02148,-0.00143909],268.936,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[6.70898,6.34375,-0.00143909],181.722,1,0,[0,0],"","",true,false]];

RoadBlock3 =
[["Sign_Arrow_Large_F",[1.95935,2.22021,-0.00143909],272.507,1,0,[0,0],"","",true,false],["RoadBarrier_F",[-1.638,2.51318,0.02],359.997,1,0.0158775,[-0.317067,0.000386121],"","",true,false],["Sign_Arrow_Large_F",[-1.62347,3.89307,-0.00143909],272.507,1,0,[0,0],"","",true,false],["RoadBarrier_F",[1.93707,3.66992,0.02],0.0012663,1,0.0149544,[-0.321683,0.000148849],"","",true,false],["Land_BagFence_Round_F",[-6.47693,-0.268555,-0.00143909],1.92371,1,0,[0,0],"","",true,false],["Land_BagBunker_Small_F",[6.33643,2.36621,-0.00143909],358.847,1,0,[0,0],"","",true,false],["Sign_Arrow_Large_F",[6.32538,2.92139,-0.00143909],272.507,1,0,[0,0],"","",true,false],["Land_BagBunker_Small_F",[-6.48883,3.60596,-0.00143909],179.049,1,0,[0,-0],"","",true,false],["Sign_Arrow_Large_F",[-6.47974,3.05029,-0.00143909],92.7083,1,0,[0,-0],"","",true,false],["Land_BagFence_Round_F",[6.31091,6.24072,-0.00143909],181.722,1,0,[0,0],"","",true,false]];

avalaibleRoadBlock = [
	RoadBlock1,
	RoadBlock2,
	RoadBlock3
];

TurretBunker1 = [["Sign_Arrow_Large_F",[-0.150879,0.385742,-0.00143909],1.7425,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[1.58545,-1.10754,-0.00143909],302.86,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[-2.45605,-0.71814,-0.00143909],65.5576,1,0,[0,0],"","",true,false],["Land_BagFence_Round_F",[0.0288086,3.08667,-0.00143909],182.881,1,0,[0,0],"","",true,false]];

avalaibleTurretBunker = [
	TurretBunker1
];

MineField1 = 
[["Land_Sign_MinesTall_F",[2.60706,-4.48071,-0.00143909],247.275,1,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[2.97339,5.7605,-0.0243235],0,0,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-8.4165,6.65894,-0.0243235],0,0,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[-11.01,0.510254,-0.0895429],0,0,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[13.1555,4.4939,-0.0895429],0,0,0,[0,0],"","",true,false],["Land_Sign_MinesTall_F",[-14.6516,-3.56201,-0.00143909],116.195,1,0,[0,-0],"","",true,false],["APERSMine_Range_Ammo",[-11.9653,-11.1782,-0.0243235],0,0,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[4.79382,-16.4299,-0.0895429],0,0,0,[0,0],"","",true,false],["Land_Sign_Mines_F",[-3.70459,17.9524,-0.00143909],229.074,1,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[-6.96094,-18.6804,-0.0895429],0,0,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[15.9874,-14.1992,-0.0895429],0,0,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[19.2009,9.42798,-0.0895429],0,0,0,[0,0],"","",true,false],["Land_Sign_Mines_F",[8.65344,-20.542,-0.00143909],0,1,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-25.2982,9.55908,-0.0243235],0,0,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[8.50366,25.9482,-0.0895429],0,0,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[27.8556,-1.55493,-0.0243235],0,0,0,[0,0],"","",true,false],["Land_Sign_MinesTall_F",[29.1173,-2.02026,-0.00143909],212.517,1,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[4.8877,-28.7891,-0.0243235],0,0,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-22.5498,-20.6921,-0.0243235],0,0,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-30.171,-5.88599,-0.0243235],0,0,0,[0,0],"","",true,false],["Land_Sign_MinesTall_F",[-14.7567,-29.4446,-0.00143909],23.9111,1,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[16.1252,-28.8884,-0.0895429],0,0,0,[0,0],"","",true,false],["Land_Sign_Mines_F",[-29.1547,-17.3125,-0.00143909],40.4167,1,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[-19.7467,29.0825,-0.0895429],0,0,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-1.15601,-36.9021,-0.0243235],0,0,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-9.03003,36.2053,-0.0243235],0,0,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[29.6077,-24.0015,-0.0243235],0,0,0,[0,0],"","",true,false],["Land_Sign_MinesTall_F",[-28.7363,26.7258,-0.00143909],133.621,1,0,[0,-0],"","",true,false],["Land_Sign_MinesTall_F",[-39.0922,11.2024,-0.00143909],247.275,1,0,[0,0],"","",true,false],["Land_Sign_MinesTall_F",[36.2255,-26.2844,-0.00143909],307.663,1,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[9.26794,-45.6338,-0.0243235],0,0,0,[0,0],"","",true,false],["ATMine_Range_Ammo",[3.45093,47.218,-0.0895429],0,0,0,[0,0],"","",true,false],["Land_Sign_MinesTall_F",[9.02185,-47.5356,-0.00143909],2.86756,1,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-41.9222,24.9702,-0.0243235],0,0,0,[0,0],"","",true,false],["Land_Sign_MinesTall_F",[-1.70752,52.9905,-0.00143909],223.343,1,0,[0,0],"","",true,false],["Land_Sign_Mines_F",[-42.5483,39.0137,-0.00143909],238.3,1,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-29.3917,56.0637,-0.0243235],0,0,0,[0,0],"","",true,false],["APERSMine_Range_Ammo",[-12.2014,67.5745,-0.0243235],0,0,0,[0,0],"","",true,false],["Land_Sign_MinesTall_F",[-25.5245,70.2356,-0.00143909],152.441,1,0,[0,-0],"","",true,false]];

avalaibleMineFields = 
[
	MineField1
];