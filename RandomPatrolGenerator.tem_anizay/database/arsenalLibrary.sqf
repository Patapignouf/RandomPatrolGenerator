_Taki = 0;
_USA = 1;
_Syndikat = 2;
_Ru = 3;
_French = 4;


//Define global constant
c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

c_listOfRoles = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic];

//////////////////////////////
//Define friendly group data//
//////////////////////////////
//USA


////////////////////////
//Loadout management////
////////////////////////

loadout_USA = [		
	[c_leader,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellGreen",1,1]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["CUP_1Rnd_HEDP_M203",1,1],["CUP_1Rnd_SmokeGreen_M203",1,1],["CUP_1Rnd_SmokeRed_M203",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops_TL",[["CUP_20Rnd_762x51_B_SCAR",2,20],["CUP_1Rnd_HEDP_M203",4,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_at,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],["CUP_launch_M136","","","",[],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_1Rnd_HEDP_M203",3,1],["CUP_15Rnd_9x19_M9",1,15],["B_IR_Grenade",1,1],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],["CUP_B_AssaultPack_Coyote_Specops_GL",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_1Rnd_HEDP_M203",6,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_HandGrenade_M67",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_rifleman,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],//Default stuff
	[c_engineer,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["B_Carryall_mcamo",[["ToolKit",1],["MineDetector",1],["ACE_EntrenchingTool",1],["ACE_DefusalKit",1]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_autorifleman,[["CUP_lmg_M249_ElcanM145_Laser","","CUP_acc_ANPEQ_15_Black","CUP_optic_ElcanM145",["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",100],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1]]],["CUP_V_CPC_tlbelt_mc",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",1,100],["CUP_HandGrenade_M67",2,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",3,15]]],["CUP_B_USArmy_AR_SpecOp",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",2,100]]],"CUP_H_OpsCore_Grey_SF","CUP_G_Grn_Scarf_GPS_Beard",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_marksman,[["CUP_arifle_Mk20_LeupoldMk4MRT","","","CUP_optic_LeupoldMk4_MRT_tan",["CUP_20Rnd_762x51_B_SCAR",20],[],"CUP_bipod_VLTOR_Modpod"],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_Tan_MC_US",[["FirstAidKit",1],["CUP_20Rnd_762x51_B_SCAR",2,20]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_20Rnd_762x51_B_SCAR",5,20],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_AssaultPack_Coyote_Specops_M",[["CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR",4,20],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_medic,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShell",1,1]]],["CUP_V_CPC_medicalbelt_mc",[["CUP_30Rnd_556x45_Stanag",3,30],["CUP_15Rnd_9x19_M9",1,15],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",2,1]]],["CUP_B_USArmy_Medic2",[["Medikit",1],["FirstAidKit",10]]],"CUP_H_OpsCore_Spray_US","CUP_G_Tan_Scarf_GPS_Beard_Blonde",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]]
];

//WIP
loadout_Taki = [		
	[c_leader,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellGreen",1,1]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["CUP_1Rnd_HEDP_M203",1,1],["CUP_1Rnd_SmokeGreen_M203",1,1],["CUP_1Rnd_SmokeRed_M203",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops_TL",[["CUP_20Rnd_762x51_B_SCAR",2,20],["CUP_1Rnd_HEDP_M203",4,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_at,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],["CUP_launch_M136","","","",[],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_1Rnd_HEDP_M203",3,1],["CUP_15Rnd_9x19_M9",1,15],["B_IR_Grenade",1,1],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],["CUP_B_AssaultPack_Coyote_Specops_GL",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_1Rnd_HEDP_M203",6,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_HandGrenade_M67",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_rifleman,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],//Default stuff
	[c_engineer,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["B_Carryall_mcamo",[["ToolKit",1],["MineDetector",1],["ACE_EntrenchingTool",1],["ACE_DefusalKit",1]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_autorifleman,[["CUP_lmg_M249_ElcanM145_Laser","","CUP_acc_ANPEQ_15_Black","CUP_optic_ElcanM145",["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",100],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1]]],["CUP_V_CPC_tlbelt_mc",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",1,100],["CUP_HandGrenade_M67",2,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",3,15]]],["CUP_B_USArmy_AR_SpecOp",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",2,100]]],"CUP_H_OpsCore_Grey_SF","CUP_G_Grn_Scarf_GPS_Beard",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_marksman,[["CUP_arifle_Mk20_LeupoldMk4MRT","","","CUP_optic_LeupoldMk4_MRT_tan",["CUP_20Rnd_762x51_B_SCAR",20],[],"CUP_bipod_VLTOR_Modpod"],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_Tan_MC_US",[["FirstAidKit",1],["CUP_20Rnd_762x51_B_SCAR",2,20]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_20Rnd_762x51_B_SCAR",5,20],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_AssaultPack_Coyote_Specops_M",[["CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR",4,20],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_medic,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShell",1,1]]],["CUP_V_CPCc_medicalbelt_mc",[["CUP_30Rnd_556x45_Stanag",3,30],["CUP_15Rnd_9x19_M9",1,15],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",2,1]]],["CUP_B_USArmyc_medic2",[["Medikit",1],["FirstAidKit",10]]],"CUP_H_OpsCore_Spray_US","CUP_G_Tan_Scarf_GPS_Beard_Blonde",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]]
];

//WIP
loadout_Syndikat = [		
	[c_leader,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellGreen",1,1]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["CUP_1Rnd_HEDP_M203",1,1],["CUP_1Rnd_SmokeGreen_M203",1,1],["CUP_1Rnd_SmokeRed_M203",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops_TL",[["CUP_20Rnd_762x51_B_SCAR",2,20],["CUP_1Rnd_HEDP_M203",4,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_at,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],["CUP_launch_M136","","","",[],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_1Rnd_HEDP_M203",3,1],["CUP_15Rnd_9x19_M9",1,15],["B_IR_Grenade",1,1],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],["CUP_B_AssaultPack_Coyote_Specops_GL",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_1Rnd_HEDP_M203",6,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_HandGrenade_M67",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_rifleman,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],//Default stuff
	[c_engineer,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["B_Carryall_mcamo",[["ToolKit",1],["MineDetector",1],["ACE_EntrenchingTool",1],["ACE_DefusalKit",1]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_autorifleman,[["CUP_lmg_M249_ElcanM145_Laser","","CUP_acc_ANPEQ_15_Black","CUP_optic_ElcanM145",["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",100],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1]]],["CUP_V_CPC_tlbelt_mc",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",1,100],["CUP_HandGrenade_M67",2,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",3,15]]],["CUP_B_USArmy_AR_SpecOp",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",2,100]]],"CUP_H_OpsCore_Grey_SF","CUP_G_Grn_Scarf_GPS_Beard",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_marksman,[["CUP_arifle_Mk20_LeupoldMk4MRT","","","CUP_optic_LeupoldMk4_MRT_tan",["CUP_20Rnd_762x51_B_SCAR",20],[],"CUP_bipod_VLTOR_Modpod"],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_Tan_MC_US",[["FirstAidKit",1],["CUP_20Rnd_762x51_B_SCAR",2,20]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_20Rnd_762x51_B_SCAR",5,20],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_AssaultPack_Coyote_Specops_M",[["CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR",4,20],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_medic,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShell",1,1]]],["CUP_V_CPCc_medicalbelt_mc",[["CUP_30Rnd_556x45_Stanag",3,30],["CUP_15Rnd_9x19_M9",1,15],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",2,1]]],["CUP_B_USArmyc_medic2",[["Medikit",1],["FirstAidKit",10]]],"CUP_H_OpsCore_Spray_US","CUP_G_Tan_Scarf_GPS_Beard_Blonde",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]]
];

//WIP
loadout_Ru = [		
	[c_leader,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellGreen",1,1]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["CUP_1Rnd_HEDP_M203",1,1],["CUP_1Rnd_SmokeGreen_M203",1,1],["CUP_1Rnd_SmokeRed_M203",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops_TL",[["CUP_20Rnd_762x51_B_SCAR",2,20],["CUP_1Rnd_HEDP_M203",4,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_at,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],["CUP_launch_M136","","","",[],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_1Rnd_HEDP_M203",3,1],["CUP_15Rnd_9x19_M9",1,15],["B_IR_Grenade",1,1],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],["CUP_B_AssaultPack_Coyote_Specops_GL",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_1Rnd_HEDP_M203",6,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_HandGrenade_M67",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_rifleman,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],//Default stuff
	[c_engineer,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["B_Carryall_mcamo",[["ToolKit",1],["MineDetector",1],["ACE_EntrenchingTool",1],["ACE_DefusalKit",1]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_autorifleman,[["CUP_lmg_M249_ElcanM145_Laser","","CUP_acc_ANPEQ_15_Black","CUP_optic_ElcanM145",["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",100],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1]]],["CUP_V_CPC_tlbelt_mc",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",1,100],["CUP_HandGrenade_M67",2,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",3,15]]],["CUP_B_USArmy_AR_SpecOp",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",2,100]]],"CUP_H_OpsCore_Grey_SF","CUP_G_Grn_Scarf_GPS_Beard",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_marksman,[["CUP_arifle_Mk20_LeupoldMk4MRT","","","CUP_optic_LeupoldMk4_MRT_tan",["CUP_20Rnd_762x51_B_SCAR",20],[],"CUP_bipod_VLTOR_Modpod"],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_Tan_MC_US",[["FirstAidKit",1],["CUP_20Rnd_762x51_B_SCAR",2,20]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_20Rnd_762x51_B_SCAR",5,20],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_AssaultPack_Coyote_Specops_M",[["CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR",4,20],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_medic,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShell",1,1]]],["CUP_V_CPCc_medicalbelt_mc",[["CUP_30Rnd_556x45_Stanag",3,30],["CUP_15Rnd_9x19_M9",1,15],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",2,1]]],["CUP_B_USArmyc_medic2",[["Medikit",1],["FirstAidKit",10]]],"CUP_H_OpsCore_Spray_US","CUP_G_Tan_Scarf_GPS_Beard_Blonde",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]]
];

//WIP
loadout_French = [		
	[c_leader,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellGreen",1,1]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellRed",1,1],["CUP_1Rnd_HEDP_M203",1,1],["CUP_1Rnd_SmokeGreen_M203",1,1],["CUP_1Rnd_SmokeRed_M203",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops_TL",[["CUP_20Rnd_762x51_B_SCAR",2,20],["CUP_1Rnd_HEDP_M203",4,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",2,1],["SmokeShellGreen",2,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_at,[["CUP_arifle_mk18_m203_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],["CUP_1Rnd_HEDP_M203",1],""],["CUP_launch_M136","","","",[],[],""],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30]]],["CUP_V_CPC_weaponsbelt_mc",[["CUP_30Rnd_556x45_Stanag",2,30],["CUP_1Rnd_HEDP_M203",3,1],["CUP_15Rnd_9x19_M9",1,15],["B_IR_Grenade",1,1],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1]]],["CUP_B_AssaultPack_Coyote_Specops_GL",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_1Rnd_HEDP_M203",6,1],["CUP_1Rnd_SmokeRed_M203",2,1],["CUP_1Rnd_SmokeGreen_M203",2,1],["CUP_HandGrenade_M67",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US","",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_rifleman,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_USPack_Coyote_Specops",[["CUP_20Rnd_762x51_B_SCAR",4,20],["CUP_PipeBomb_M",1,1],["CUP_HandGrenade_M67",2,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],//Default stuff
	[c_engineer,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShellRed",1,1]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_30Rnd_556x45_Stanag",4,30],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["B_Carryall_mcamo",[["ToolKit",1],["MineDetector",1],["ACE_EntrenchingTool",1],["ACE_DefusalKit",1]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_autorifleman,[["CUP_lmg_M249_ElcanM145_Laser","","CUP_acc_ANPEQ_15_Black","CUP_optic_ElcanM145",["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",100],[],""],[],["CUP_hgun_M9","","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_RGR_MC_US",[["FirstAidKit",1]]],["CUP_V_CPC_tlbelt_mc",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",1,100],["CUP_HandGrenade_M67",2,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",3,15]]],["CUP_B_USArmy_AR_SpecOp",[["CUP_100Rnd_TE4_Green_Tracer_556x45_M249",2,100]]],"CUP_H_OpsCore_Grey_SF","CUP_G_Grn_Scarf_GPS_Beard",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_marksman,[["CUP_arifle_Mk20_LeupoldMk4MRT","","","CUP_optic_LeupoldMk4_MRT_tan",["CUP_20Rnd_762x51_B_SCAR",20],[],"CUP_bipod_VLTOR_Modpod"],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_Tan_MC_US",[["FirstAidKit",1],["CUP_20Rnd_762x51_B_SCAR",2,20]]],["CUP_V_CPC_Fastbelt_mc",[["CUP_20Rnd_762x51_B_SCAR",5,20],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["CUP_15Rnd_9x19_M9",1,15]]],["CUP_B_AssaultPack_Coyote_Specops_M",[["CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR",4,20],["CUP_HandGrenade_M67",1,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["CUP_15Rnd_9x19_M9",2,15]]],"CUP_H_OpsCore_Covered_MCAM_US_SF","CUP_G_WatchGPSCombo",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]],
	[c_medic,[["CUP_arifle_mk18_tan_holo_laserflash","","CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L","optic_Holosight",["CUP_30Rnd_556x45_Stanag",30],[],""],[],["CUP_hgun_M9_snds","CUP_muzzle_snds_M9","","",["CUP_15Rnd_9x19_M9",15],[],""],["CUP_U_CRYE_G3C_MC_US",[["FirstAidKit",1],["CUP_30Rnd_556x45_Stanag",3,30],["SmokeShell",1,1]]],["CUP_V_CPCc_medicalbelt_mc",[["CUP_30Rnd_556x45_Stanag",3,30],["CUP_15Rnd_9x19_M9",1,15],["CUP_HandGrenade_M67",1,1],["B_IR_Grenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",2,1]]],["CUP_B_USArmyc_medic2",[["Medikit",1],["FirstAidKit",10]]],"CUP_H_OpsCore_Spray_US","CUP_G_Tan_Scarf_GPS_Beard_Blonde",["CUP_Vector21Nite","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","CUP_NVG_PVS15_Hide"]]]
];

////////////////////////
///Weapon management////
////////////////////////
rifleList_USA = [		
	"CUP_arifle_mk18_black",
	"CUP_arifle_mk18_m203_black"
];	

launcherList_USA = [		
	"CUP_launch_Javelin",
	"CUP_launch_FIM92Stinger",
	"CUP_launch_MAAWS",
	"CUP_launch_MAAWS_Scope"
];	

autorifleList_USA = [			
	"CUP_lmg_Mk48"
];	


marksmanrifleList_USA = [		
	"CUP_srifle_Mk12SPR"
];

smgList_USA = [		
	"CUP_smg_MP7"
];

//////////////////////////
//Attachement management//
//////////////////////////
attachmentShortList_USA	= [
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


attachmentLongList_USA	= [
	"CUP_optic_SB_11_4x20_PM",
	"CUP_optic_SB_11_4x20_PM_pip",
	"CUP_optic_SB_3_12x50_PMII",
	"CUP_optic_SB_3_12x50_PMII_PIP",
	"CUP_optic_LeupoldMk4",
	"CUP_optic_CWS",
	"CUP_optic_CWS_NV",
	"CUP_optic_CWS_NV_RDS"
];

//Join
loadout_db = [[loadout_USA,_USA],[loadout_Ru,_Ru],[loadout_Taki,_Taki],[loadout_Syndikat,_Syndikat],[loadout_French,_French]];
rifleList_db = [[rifleList_USA,_USA]];
attachmentLongList_db = [[attachmentLongList_USA,_USA]];
attachmentShortList_db = [[attachmentShortList_USA,_USA]];
smgList_db = [[smgList_USA,_USA]];
marksmanrifleList_db = [[marksmanrifleList_USA,_USA]];
autorifleList_db = [[autorifleList_USA,_USA]];
launcherList_db = [[launcherList_USA,_USA]];

////////////////////////
////Items management////
////////////////////////
itemList_USA = [
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
	"ACE_EntrenchingTool"
	];

itemEngineerList_USA = [
	"ToolKit",
	"MineDetector",
	"ACE_wirecutter"
	];
	
itemMedicList_USA = [
	"ACE_epinephrine",
	"ACE_bloodIV",
	"ACE_bloodIV_500",
	"ACE_bloodIV_250",
	"ACE_personalAidKit",
	"ACE_surgicalKit"
	];

itemList_db = [[itemList_USA,_USA]];
itemEngineerList_db = [[itemEngineerList_USA,_USA]];
itemMedicList_db = [[itemMedicList_USA,_USA]];

////////////////////////
//Backpack management///
////////////////////////
backpacksList = [

	"CUP_B_USPack_Coyote",
	"CUP_B_USPack_Black",
	"B_Kitbag_cbr",
	"B_Kitbag_rgr",
	"CUP_B_US_Assault_OCP",
	"CUP_B_US_IIID_OCP"
];


getLoadoutByRole = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	thisloadout = [];
	//Need to adapt a little thing to allow default loadout when there's no loadout found
	thisloadout = ((loadout_db select {_x select 1 == currentFaction}) select 0 select 0) select {_x select 0 == currentPlayerClass} select 0 select 1;
	diag_log format ["Player %1 with role %2 has loadout %3", name currentPlayer, currentPlayerClass,thisloadout ];
	thisloadout
};


getVirtualWeaponList = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualWeaponList = [];

	switch (currentPlayerClass) do
	{
		case c_leader:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_at:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (launcherList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_rifleman:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_engineer:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_autorifleman:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (autorifleList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_marksman:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (marksmanrifleList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_medic:
			{
				virtualWeaponList = virtualWeaponList + (rifleList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualWeaponList = virtualWeaponList + (smgList_db select {_x select 1  == currentFaction} select 0 select 0);
			};				
		default { hint "default" };
	};
	diag_log format ["Player %1 with role %2 has access to weapons %3", name currentPlayer, currentPlayerClass,virtualWeaponList ];
	virtualWeaponList
};

getVirtualBackPack = {
	currentPlayerClass = _this select 0;
};

getVirtualItemList = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualItemList = [];

	switch (currentPlayerClass) do
	{
		case c_leader;
		case c_at;
		case c_rifleman;
		case c_autorifleman;
		case c_marksman:
			{
				virtualItemList = virtualItemList + (itemList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_medic:
			{
				virtualItemList = virtualItemList + (itemList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualItemList = virtualItemList + (itemMedicList_db select {_x select 1  == currentFaction} select 0 select 0);
			};			
		case c_engineer:	
			{
				virtualItemList = virtualItemList + (itemList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualItemList = virtualItemList + (itemEngineerList_db select {_x select 1  == currentFaction} select 0 select 0);
			};		
		default { hint "default" };
	};
	diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass,virtualItemList ];
	virtualItemList
};



getVirtualAttachement = {
	currentPlayer = _this select 0;
	currentFaction = _this select 1;
	currentPlayerClass = currentPlayer getVariable "role";
	virtualAttachementList = [];

	switch (currentPlayerClass) do
	{
		case c_leader;
		case c_at;
		case c_rifleman;
		case c_autorifleman;
		case c_medic;
		case c_engineer:
			{
				virtualAttachementList = virtualAttachementList + (attachmentShortList_db select {_x select 1  == currentFaction} select 0 select 0);
			};
		case c_marksman:		
			{
				virtualAttachementList = virtualAttachementList + (attachmentShortList_db select {_x select 1  == currentFaction} select 0 select 0);
				virtualAttachementList = virtualAttachementList + (attachmentLongList_db select {_x select 1  == currentFaction} select 0 select 0);
			};		
		default { hint "default" };
	};
	diag_log format ["Player %1 with role %2 has access to items %3", name currentPlayer, currentPlayerClass,virtualAttachementList ];
	virtualAttachementList
};


setupArsenalToItem = {
	//InitParam
	itemToAttachArsenal = _this select 0;
	currentPlayer = _this select 1;
	currentFaction = _this select 2;

	//Process
	//["AmmoboxExit", itemToAttachArsenal] call BIS_fnc_arsenal;	
	[itemToAttachArsenal,[itemToAttachArsenal call BIS_fnc_getVirtualWeaponCargo],false] call BIS_fnc_removeVirtualWeaponCargo;
	[itemToAttachArsenal,[itemToAttachArsenal call BIS_fnc_getVirtualItemCargo],false] call BIS_fnc_removeVirtualItemCargo;
	[itemToAttachArsenal,[itemToAttachArsenal call BIS_fnc_getVirtualMagazineCargo],false] call BIS_fnc_removeVirtualMagazineCargo;
	[itemToAttachArsenal,[itemToAttachArsenal call BIS_fnc_getVirtualBackpackCargo],false] call BIS_fnc_removeVirtualBackpackCargo;
	[itemToAttachArsenal,([currentPlayer,currentFaction] call getVirtualWeaponList )] call BIS_fnc_addVirtualWeaponCargo;
	[itemToAttachArsenal,backpacksList] call BIS_fnc_addVirtualBackpackCargo;
	//[VA2,((itemCargo VA2) + _availableHeadgear + _availableUniforms + _availableVests)] call BIS_fnc_addVirtualItemCargo;
	//[VA2,((magazineCargo VA2) + _availablemagazinecargoindependent )] call BIS_fnc_addVirtualMagazineCargo;
	[itemToAttachArsenal,([currentPlayer,currentFaction] call getVirtualAttachement ) + ([currentPlayer,currentFaction] call getVirtualItemList ) ] call BIS_fnc_addVirtualItemCargo;
	//["AmmoboxInit",[VA2,false,{_this getVariable "role" == c_leader}]] call BIS_fnc_arsenal;
	["AmmoboxInit",[itemToAttachArsenal,false,{true}]] call BIS_fnc_arsenal;
};

setupRoleSwitchToItem = {
	//InitParam
	itemToAttachArsenal = _this select 0;
	currentPlayer = _this select 1;
	currentFaction = _this select 2;

	//Add action to change role
	{
		itemToAttachArsenal addAction 
			[format ["Switch to role %1", _x], 
			{
				//Define params
				params ["_target","_caller","_ID","_params"];
				diag_log format ["Player %1 has switch to role %2 in faction %3", name _caller, _params select 0, _params select 1];

				titleCut [format ["Switching to role %1",(_params select 1)], "BLACK FADED", 5];

				//Manage Unit trait
				_caller setUnitTrait ["Medic", false];
				_caller setUnitTrait ["Engineer", false];
				if ((_params select 0) == c_medic) then 
				{
					_caller setUnitTrait ["Medic", true];
				};
				if ((_params select 0) == c_engineer) then 
				{
					_caller setUnitTrait ["Engineer", true];
				};

				//Manage player's role
				_caller setVariable ["role", (_params select 0)];

				//Manage default stuff
				_caller setVariable ["spawnLoadout",[_caller,(_params select 1)] call getLoadoutByRole];
				_caller setUnitLoadout (_caller getVariable "spawnLoadout");

				//Manage arsenal stuff
				[_target, _caller, (_params select 1)] call setupArsenalToItem;
				[_caller] call adjustLoadout;
				titleCut ["", "BLACK IN", 5];
			},[_x,currentFaction]];
	} foreach c_listOfRoles;

	//Display player's current role
	itemToAttachArsenal addAction 
		[format ["Show team roles"], 
		{
			private _target = (_this select 0);
			private _caller = (_this select 1);
			private _params = (_this select 3);
			
			private _currentPlayersFaction = side _caller;
			private _globalRoles = "Your team's roles :";
			{
				if (alive _x && side _x == _currentPlayersFaction) then 
				{
					_globalRoles = _globalRoles + format ["\n Player %1 has role %2",name _x, _x getVariable "role"];
				};
			} foreach allPlayers;
			hint _globalRoles;
		},[currentFaction]];
};


adjustLoadout = {
	currentPlayer = _this select 0;
	if (currentPlayer getUnitTrait "Medic" == false) then 
	{
		for "_i" from 0 to 7 do { currentPlayer addItem "ACE_elasticBandage" };	
		for "_i" from 0 to 1 do { currentPlayer addItem "ACE_tourniquet" };
		for "_i" from 0 to 1 do { currentPlayer addItem "ACE_splint" };
	}
	else 
	{
		currentPlayer addItem "ACE_surgicalKit";
		for "_i" from 0 to 7 do { currentPlayer addItem "ACE_epinephrine" };
		for "_i" from 0 to 7 do { currentPlayer addItem "ACE_splint" };
		for "_i" from 0 to 29 do { currentPlayer addItem "ACE_elasticBandage" };
		for "_i" from 0 to 29 do { currentPlayer addItem "ACE_quikclot" };
		for "_i" from 0 to 9 do { currentPlayer addItem "ACE_morphine" };
		for "_i" from 0 to 5 do { currentPlayer addItem "ACE_bloodIV_500" };
		for "_i" from 0 to 2 do { currentPlayer addItem "ACE_bloodIV" };
		for "_i" from 0 to 5 do { currentPlayer addItem "ACE_tourniquet" };	
	};
	for "_i" from 0 to 1 do { currentPlayer addItem "ACE_CableTie" };
	currentPlayer addItem "ACE_MapTools";	
	currentPlayer addItem "ACE_morphine";	
	currentPlayer addItem "ACE_WaterBottle";
	currentPlayer addItem "ACE_EarPlugs";
	currentPlayer addItem "ACE_microDAGR";
	currentPlayer unassignItem "itemRadio";
	currentPlayer removeItem "itemRadio";
	currentPlayer setSpeaker "noVoice";

	//Define's TFAR Radio frequencie
	if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
		//player addItem "TFAR_anprc148jem";
		//player assignItem "TFAR_anprc148jem";
		currentPlayer addItem "TFAR_anprc152";
		currentPlayer assignItem "TFAR_anprc152";

		if (side currentPlayer == blufor) then
		{
			[(call TFAR_fnc_activeSwRadio), 1, format ["%1",bluforShortFrequencyTFAR]] call TFAR_fnc_setChannelFrequency;
			[(call TFAR_fnc_activeLrRadio), 1, format ["%1",bluforShortFrequencyTFAR]] call TFAR_fnc_SetChannelFrequency;
		};
	};
};