_Taki = 0;
_USA = 1;
_Syndikat = 2;
_Ru = 3;
_French = 4;
_USA_2000 = 5;
_WWII_UK = 6;
_WWII_Wehrmacht = 7;
_WWII_URSS = 8;
_WWII_USA = 9;
_ColdWar_USA = 10;
_ColdWar_NVA = 11;
_ColdWar_ARVN = 12;
_2035_AAF = 13;
_2035_NATO = 14;
_USA_2000_DF = 15;
_Russian_Winter = 16;
_PMC = 17;
_2035_Rebels = 18;
_2035_NATO_FS = 19;
_Taki_Army = 20;
_2035_FIA = 21;
_2035_Spetsnaz = 22;
_HorizonIsland = 23;
_HorizonIslandSF = 24;
_2035_CSAT = 25;
_WWII_FFI = 26;
_ColdWar_OTAN = 27;
_ColdWar_USSR = 28;
_Chernarussian_Winter = 29;
_USA_Winter = 30;
_KORSAC_KDF = 31;
_KORSAC_KS = 32;
_KORSAC_KFL = 33;
_KORSAC_KAL = 34;
_2035_NATO_Recon = 35;
_ColdWar_USA_SF = 36;
_ColdWar_VC = 37;
_USA_SOCOM_2020 = 38;
_RU_2020 = 39;

#include "object_db\USA.sqf"
#include "object_db\USA_Winter.sqf"
#include "object_db\French.sqf"
#include "object_db\Russian.sqf"
#include "object_db\Syndikat.sqf"
#include "object_db\Takistani.sqf"
#include "object_db\USA_2000.sqf"
#include "object_db\WWII_Wehrmacht.sqf"
#include "object_db\WWII_URSS.sqf"
#include "object_db\WWII_UK.sqf"
#include "object_db\WWII_USA.sqf"
#include "object_db\WWII_FFI.sqf"
#include "object_db\ColdWar_ARVN.sqf"
#include "object_db\ColdWar_NVA.sqf"
#include "object_db\ColdWar_USA.sqf"
#include "object_db\ColdWar_VC.sqf"
#include "object_db\ColdWar_USA_SF.sqf"
#include "object_db\2035_AAF.sqf"
#include "object_db\2035_NATO.sqf"
#include "object_db\2035_NATO_FS.sqf"
#include "object_db\2035_NATO_Recon.sqf"
#include "object_db\2035_Spetsnaz.sqf"
#include "object_db\USA_2000_DF.sqf"
#include "object_db\Russian_Winter.sqf"
#include "object_db\Chernarussian_Winter.sqf"
#include "object_db\PMC.sqf"
#include "object_db\2035_Rebels.sqf"
#include "object_db\Takistani_army.sqf"
#include "object_db\2035_FIA.sqf"
#include "object_db\HorizonIsland.sqf"
#include "object_db\HorizonIslandSF.sqf"
#include "object_db\2035_CSAT.sqf"
#include "object_db\ColdWar_OTAN.sqf"
#include "object_db\ColdWar_USSR.sqf"
#include "object_db\KORSAC_KDF.sqf"
#include "object_db\KORSAC_KS.sqf"
#include "object_db\KORSAC_KFL.sqf"
#include "object_db\KORSAC_KAL.sqf"
#include "object_db\USA_SOCOM_2020.sqf"
#include "object_db\RU_2020.sqf"

//Define faction prefix
c_db = "_db";
c_USA = "_USA";
c_USA_Winter = "_USA_Winter";
c_USA_2000 = "_USA_2000";
c_USA_SOCOM_2020 = "_USA_SOCOM_2020";
c_Russian = "_Russian";
c_RU_2020 = "_RU_2020";
c_Taki = "_Taki";
c_Syndikat = "_Syndikat";
c_French = "_French";
c_WWII_UK = "_WWII_UK";
c_WWII_URSS = "_WWII_URSS";
c_WWII_Wehrmacht = "_WWII_Wehrmacht";
c_WWII_USA = "_WWII_USA";
c_WWII_FFI = "_WWII_FFI";
c_ColdWar_ARVN = "_ColdWar_ARVN";
c_ColdWar_NVA = "_ColdWar_NVA";
c_ColdWar_VC = "_ColdWar_VC";
c_ColdWar_USA_SF = "_ColdWar_USA_SF";
c_ColdWar_USA = "_ColdWar_USA";
c_2035_AAF = "_2035_AAF";
c_2035_NATO = "_2035_NATO";
c_2035_NATO_FS = "_2035_NATO_FS";
c_2035_NATO_Recon = "_2035_NATO_Recon";
c_2035_FIA = "_2035_FIA";
c_USA_2000_DF = "_USA_2000_DF";
c_Russian_Winter = "_Russian_Winter";
c_PMC = "_PMC";
c_2035_Rebels = "_2035_Rebels";
c_Taki_Army = "_Taki_Army";
c_2035_Spetsnaz = "_2035_Spetsnaz";
c_HorizonIsland = "_HorizonIsland";
c_HorizonIslandSF =  "_HorizonIslandSF";
c_2035_CSAT ="_2035_CSAT";
c_ColdWar_OTAN ="_ColdWar_OTAN";
c_ColdWar_USSR ="_ColdWar_USSR";
c_Chernarussian_Winter = "_Chernarussian_Winter";
c_KORSAC_KDF = "_KORSAC_KDF";
c_KORSAC_KS = "_KORSAC_KS";
c_KORSAC_KFL = "_KORSAC_KFL";
c_KORSAC_KAL = "_KORSAC_KAL";

//Faction format :
// [ Number : Faction Code, String : Faction string Name , String : Faction Name to display, Enabled for Blufor/Independant, Enabled for Opfor, Enabled for Civilian],

//Setup basic ArmA 3 Factions
factionInfos = [
	[c_Syndikat,_Syndikat,"2035 Syndikat", true, true, true],
	[c_2035_AAF,_2035_AAF,"2035 AAF", true, true, false],
	[c_2035_NATO,_2035_NATO,"2035 NATO", true, true, false],
	[c_2035_NATO_Recon,_2035_NATO_Recon,"2035 NATO Recon", true, false, false],
	[c_2035_NATO_FS,_2035_NATO_FS,"2035 NATO Special Forces", true, true, false],
	[c_2035_Spetsnaz,_2035_Spetsnaz,"2035 Spetsnaz", true, true, false],
	[c_2035_FIA,_2035_FIA,"2035 FIA", true, true, true],
	[c_2035_Rebels,_2035_Rebels,"2035 Rebels", true, true, true],
	[c_2035_CSAT,_2035_CSAT,"2035 CSAT", true, true, true]
];


//Add specific AMF factions
if (isClass (configFile >> "CfgPatches" >> "AMF_Patches")) then 
{
	factionInfos pushBack [c_French,_French,"French [AMF][ACE]", true, false, false];
};


//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack [c_USA_Winter,_USA_Winter,"US Army Winter [CUP]", true, false, false];
	factionInfos pushBack [c_USA,_USA,"US Army [CUP]", true, true, true];
	factionInfos pushBack [c_Taki,_Taki,"Takistani [CUP]", true, true, true];
	factionInfos pushBack [c_Russian,_Ru,"Russian [CUP]", true, true, true];
	factionInfos pushBack [c_USA_2000,_USA_2000,"2000 USA Marines [CUP]", true, true, false];
	factionInfos pushBack [c_USA_2000_DF,_USA_2000_DF,"1993 USA Delta Force [CUP][ACE]", true, true, false];	
	factionInfos pushBack [c_PMC, _PMC, "PMC Modern [CUP]", true, true, false];	
	factionInfos pushBack [c_Russian_Winter, _Russian_Winter, "Russian Winter [CUP]", true, true, true];	
	factionInfos pushBack [c_Chernarussian_Winter, _Chernarussian_Winter, "Chernarussian Winter [CUP]", false, true, false];
	factionInfos pushBack [c_Taki_Army, _Taki_Army, "Takistani Army [CUP]", true, true, false];
	factionInfos pushBack [c_HorizonIsland, _HorizonIsland, "Horizon Island [CUP]", true, true, true];
	factionInfos pushBack [c_HorizonIslandSF, _HorizonIslandSF, "Horizon Island SF [CUP]", true, true, true];
	factionInfos pushBack [c_ColdWar_OTAN, _ColdWar_OTAN, "Cold War OTAN [CUP]", true, false, false];
	factionInfos pushBack [c_ColdWar_USSR, _ColdWar_USSR, "Cold War USSR [CUP]", false, true, false];
};

//Add specific UNSUNG factions
if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	factionInfos pushBack [c_ColdWar_ARVN,_ColdWar_ARVN,"Cold War ARVN [UNSUNG]", true, true, true];
	factionInfos pushBack [c_ColdWar_NVA,_ColdWar_NVA,"Cold War NVA [UNSUNG]", true, true, true];
	factionInfos pushBack [c_ColdWar_USA,_ColdWar_USA,"Cold War USA [UNSUNG]", true, true, false];
	factionInfos pushBack [c_ColdWar_USA_SF,_ColdWar_USA_SF,"Cold War USA Special forces [UNSUNG]", true, true, false];
	factionInfos pushBack [c_ColdWar_VC,_ColdWar_VC,"Cold War VietCong [UNSUNG]", false, true, false];
};

//Add specific IFA3 factions
if (isClass (configFile >> "CfgPatches" >> "IFA3_Core")) then 
{
	factionInfos pushBack [c_WWII_UK,_WWII_UK,"WWII UK [IFA3]", true, true, false];
	factionInfos pushBack [c_WWII_URSS,_WWII_URSS,"WWII URSS [IFA3]", true, true, false];
	factionInfos pushBack [c_WWII_Wehrmacht,_WWII_Wehrmacht,"WWII Wehrmacht [IFA3]", true, true, false];
	factionInfos pushBack [c_WWII_USA,_WWII_USA,"WWII USA [IFA3]", true, true, false];
	factionInfos pushBack [c_WWII_FFI,_WWII_FFI,"WWII FFI [IFA3]", true, true, true];
	
};

//Add specific IFA3 factions
if (isClass (configFile >> "CfgPatches" >> "vtf_kf_main")) then 
{
	factionInfos pushBack [c_KORSAC_KDF,_KORSAC_KDF,"KDF Army [KORSAC]", true, false, false];
	factionInfos pushBack [c_KORSAC_KS,_KORSAC_KS,"KS Separatists [KORSAC]", false, true, false];
	factionInfos pushBack [c_KORSAC_KAL,_KORSAC_KAL,"KAL Locals [KORSAC]", false, true, false];	
	factionInfos pushBack [c_KORSAC_KFL,_KORSAC_KFL,"KFL Foreign legion [KORSAC]", true, false, false];	
};

//Add specific RHS factions
if (isClass (configFile >> "CfgPatches" >> "rhs_main")) then 
{
	factionInfos pushBack [c_USA_SOCOM_2020,_USA_SOCOM_2020,"2020 USA SOCOM [RHS]", true, true, false];
	factionInfos pushBack [c_RU_2020,_RU_2020,"2020 Russian [RHS]", true, true, false];
};


//Define global constant
c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";
c_radioman = "radioman";
c_grenadier = "grenadier";
c_ammobearer = "ammobearer";