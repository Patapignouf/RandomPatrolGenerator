#include "factionParameters.sqf"

//Import mission params
warEra = "WarEra" call BIS_fnc_getParamValue;

c_variableToInit = ["bluforUnarmedVehicle","bluforArmedVehicle","bluforUnarmedVehicleChopper","bluforDrone","bluforBoat","civilian_group",
"civilian_big_group","civilianTruck","baseEnemyGroup","baseEnemyATGroup","baseEnemyDemoGroup","baseEnemyMortarGroup","baseEnemyVehicleGroup",
"baseEnemyLightArmoredVehicleGroup","baseEnemyHeavyArmoredVehicleGroup","bluforFixedWing","bluforArmedChopper"];

//////////////////////////////
////Define objectives data////
//////////////////////////////
avalaibleAmmoBox = ["CUP_BOX_TK_MILITIA_Wps_F", 
"CUP_BOX_TK_MILITIA_Ammo_F"
];

avalaibleSupplyBox = [
	"ACE_medicalSupplyCrate_advanced", 
	"ACE_medicalSupplyCrate"
];

avalaibleHVT = ["CUP_O_TK_Officer",
	"CUP_O_RU_Officer_EMR", 
	"O_Officer_Parade_F", 
	"O_G_officer_F"
];

avalaibleVIP = [
	"CUP_C_TK_Man_03_Waist",
	"C_Driver_1_F",
	"CUP_C_R_Functionary_jacket_02"
];

avalaibleStealVehicle = [
	"O_G_Van_01_transport_F", 
	"O_G_Van_02_transport_F", 
	"O_G_Van_01_fuel_F"
];

avalaibleDestroyVehicle = [
	"CUP_O_Hilux_DSHKM_TK_INS"
];

avalaibleCollectIntel = ["Land_Suitcase_F"];

avalaibleTypeOfObj = [];
avalaibleAttackTypeOfObj = ["ammo","hvt","collectIntel","informant","clearArea"];
avalaibleSupportTypeOfObj = ["supply","vip","collectIntel","informant","steal"];

//avalaibleTypeOfObj = ["ammo"]; //Line use to debug a specific objective

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


initFactionDb = {
	params ["_currentVariable"];
	_currentTempVariable = [];
	{
		_currentFactionName = _x select 0;
		_currentFactionParameters = _x select 1;
		_currentFactionBuild = format ["%1%2", _currentVariable, _currentFactionName];
		_currentTempVariable pushBack [missionNamespace getVariable [_currentFactionBuild,[]], _currentFactionParameters];
	} foreach factionInfos;
	_currentVariableName = format ["%1%2", _currentVariable, c_db];
	missionNamespace setVariable [_currentVariableName, _currentTempVariable, true];
};

//////////
//InitDB//
//////////

{
	[_x] call initFactionDb;
}
foreach c_variableToInit;