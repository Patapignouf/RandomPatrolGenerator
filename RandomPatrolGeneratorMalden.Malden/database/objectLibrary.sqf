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

avalaibleSupplyBox = [
	"Box_IND_Support_F"
];

if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	avalaibleSupplyBox pushBack "ACE_medicalSupplyCrate_advanced";
	avalaibleSupplyBox pushBack "ACE_medicalSupplyCrate";
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

avalaibleStealVehicle = [
	"C_Truck_02_box_F", 
	"C_Truck_02_fuel_F", 
	"C_Offroad_01_repair_F", 
	"C_Van_01_fuel_F"
];

avalaibleDestroyVehicle = [
	"CUP_O_Hilux_DSHKM_TK_INS"
];

avalaibleCollectIntel = [
	"Land_Suitcase_F",
	"Land_MultiScreenComputer_01_olive_F", 
	"Land_Laptop_unfolded_F", 
	"Land_FirstAidKit_01_open_F", 
	"Land_Defibrillator_F", 
	"MapBoard_altis_F"
];

avalaibleTypeOfObj = [];

//List of all avalaible objective
avalaibleTypeOfObjectives = [
	// [Technical Objective name, Display name, type of objective, enable]
	["ammo", "Ammo cache", "Attack", true],
	["hvt", "HVT", "Attack", true],
	["clearArea", "Clear Area", "Attack", true],
	["defendArea", "Defend Area", "Attack", true],
	["informant", "Informant", "Support", true],
	["collectIntel", "Collect Intel", "Support", true],
	["steal", "Steal vehicle", "Support", true],
	["captureFlag", "Capture city", "Attack", true]
];

//If ACE is enable on the server, specific objectives are avalaible
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	avalaibleTypeOfObjectives pushBack ["vip", "VIP", "Support", true];
	avalaibleTypeOfObjectives pushBack ["supply", "Supply box", "Support", true];
};


// avalaibleTypeOfObjectives = [
// 	// [Technical Objective name, Display name, type of objective]
// 	["hvt", "HVT", "Attack", true]
// ];

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