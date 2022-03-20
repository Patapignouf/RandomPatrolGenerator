_Taki = 0;
_USA = 1;
_Syndikat = 2;
_Ru = 3;

//////////////////////////////
//Define friendly group data//
//////////////////////////////
//USA
bluforUnarmedVehicle_USA = ["CUP_B_M1151_USA"];

bluforArmedVehicle_USA = ["CUP_B_M1151_Deploy_USA"];

bluforUnarmedVehicleChopper_USA = [];

bluforDrone_USA = [];

//Join
bluforUnarmedVehicle_db = [[bluforUnarmedVehicle_USA,_USA]];
bluforArmedVehicle_db = [[bluforArmedVehicle_USA,_USA]];

//////////////////////////////
////Define civ group data/////
//////////////////////////////
//Taki
civilian_group_taki = ["CUP_C_TK_Man_06_Coat", 
"CUP_C_TK_Man_05_Coat", 
"CUP_C_TK_Man_08"];

civilian_big_group_taki = ["CUP_C_TK_Man_06_Coat", 
"CUP_C_TK_Man_05_Coat", 
"CUP_C_TK_Man_08", 
"CUP_C_TK_Man_04", 
"CUP_C_TK_Man_03_Jack", 
"CUP_C_TK_Man_02"
];

civilianTruck_taki = ["CUP_I_V3S_Open_TKG"];

//Syndikat
civilian_group_Syndikat = ["C_Man_casual_8_F_tanoan", 
"C_Man_casual_6_v2_F_tanoan", 
"C_Man_casual_2_F_tanoan"];

civilian_big_group_Syndikat = ["C_man_sport_2_F_tanoan", 
"C_Man_casual_1_F_tanoan", 
"C_Man_casual_3_F_tanoan", 
"C_Man_casual_6_v2_F_tanoan", 
"C_Man_formal_4_F_tanoan", 
"C_Man_casual_5_F_tanoan" ];

civilianTruck_Syndikat = ["C_Truck_02_transport_F"];

//Join
civilian_group_db = [[civilian_group_taki,_Taki],[civilian_group_Syndikat,_Syndikat]];
civilian_big_group_db = [[civilian_big_group_taki,_Taki],[civilian_big_group_Syndikat,_Syndikat]];
civilianTruck_db = [[civilianTruck_taki,_Taki],[civilianTruck_Syndikat,_Syndikat]];

//////////////////////////////
///Define enemy group data////
//////////////////////////////
//Taki
baseEnemyGroup_taki = ["CUP_O_TK_INS_Soldier_TL", 
"CUP_O_TK_INS_Soldier_MG", 
"CUP_O_TK_INS_Soldier_GL", 
"CUP_O_TK_INS_Soldier_AT",  
"CUP_O_TK_INS_Soldier", 
"CUP_O_TK_INS_Soldier_AR", 
"CUP_O_TK_INS_Sniper", 
"CUP_O_TK_INS_Soldier_Enfield", 
"CUP_O_TK_INS_Soldier_FNFAL"];

baseEnemyATGroup_taki = ["CUP_O_TK_INS_Soldier_TL", 
"CUP_O_TK_INS_Soldier_AT", 
"CUP_O_TK_INS_Soldier_AT",
"CUP_O_TK_INS_Soldier_AT",
"CUP_O_TK_INS_Soldier"];

baseEnemyDemoGroup_taki = ["CUP_O_TK_INS_Mechanic", 
"CUP_O_TK_INS_Mechanic",
"CUP_O_TK_INS_Bomber",
"CUP_O_TK_INS_Bomber"];

baseEnemyMortarGroup_taki = ["CUP_O_TK_INS_Mechanic", 
"CUP_O_2b14_82mm_TK_INS",
"CUP_O_TK_INS_Bomber"];

baseEnemyVehicle_taki = [];

//Syndikat
baseEnemyGroup_Syndikat = ["I_C_Soldier_Bandit_4_F", 
"I_C_Soldier_Bandit_3_F", 
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_5_F", 
"I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_1_F"];

baseEnemyATGroup_Syndikat = ["I_C_Soldier_Bandit_6_F", 
"I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_2_F",
"I_C_Soldier_Bandit_7_F", 
"I_C_Soldier_Bandit_8_F"];

baseEnemyDemoGroup_Syndikat = ["I_C_Soldier_Bandit_2_F", 
"I_C_Soldier_Bandit_8_F",
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyMortarGroup_Syndikat = ["I_G_Mortar_01_F", 
"I_C_Soldier_Bandit_8_F", 
"I_C_Soldier_Bandit_6_F"];

baseEnemyVehicle_Syndikat = ["I_C_Soldier_Para_1_F"];

//Join
baseEnemyGroup_db = [[baseEnemyGroup_taki,_Taki],[baseEnemyGroup_Syndikat,_Syndikat]];
baseEnemyATGroup_db = [[baseEnemyATGroup_taki,_Taki],[baseEnemyATGroup_Syndikat,_Syndikat]];
baseEnemyDemoGroup_db = [[baseEnemyDemoGroup_taki,_Taki],[baseEnemyDemoGroup_Syndikat,_Syndikat]];
baseEnemyMortarGroup_db = [[baseEnemyMortarGroup_taki,_Taki],[baseEnemyMortarGroup_Syndikat,_Syndikat]];

//////////////////////////////
////Define objectives data////
//////////////////////////////
avalaibleAmmoBox = ["CUP_BOX_TK_MILITIA_Wps_F", 
"CUP_BOX_TK_MILITIA_Ammo_F"
];

avalaibleSupplyBox = ["ACE_medicalSupplyCrate_advanced", 
"ACE_medicalSupplyCrate"
];

avalaibleHVT = ["CUP_O_TK_Officer"
];

avalaibleVIP = ["CUP_C_TK_Man_03_Waist"
];

avalaibleTypeOfObj = ["supply","ammo","vip","hvt"];

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

avalaibleFOB = [ fob1
];