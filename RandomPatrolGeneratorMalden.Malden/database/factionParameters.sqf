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

#include "object_db\USA.sqf"
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
#include "object_db\2035_AAF.sqf"
#include "object_db\2035_NATO.sqf"
#include "object_db\2035_NATO_FS.sqf"
#include "object_db\2035_Spetsnaz.sqf"
#include "object_db\USA_2000_DF.sqf"
#include "object_db\Russian_Winter.sqf"
#include "object_db\PMC.sqf"
#include "object_db\2035_Rebels.sqf"
#include "object_db\Takistani_army.sqf"
#include "object_db\2035_FIA.sqf"
#include "object_db\HorizonIsland.sqf"
#include "object_db\HorizonIslandSF.sqf"
#include "object_db\2035_CSAT.sqf"

//Define faction prefix
c_db = "_db";
c_USA = "_USA";
c_USA_2000 = "_USA_2000";
c_Russian = "_Russian";
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
c_ColdWar_USA = "_ColdWar_USA";
c_2035_AAF = "_2035_AAF";
c_2035_NATO = "_2035_NATO";
c_2035_NATO_FS = "_2035_NATO_FS";
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


//Setup basic ArmA 3 Factions
factionInfos = [
	[c_Syndikat,_Syndikat,"Syndikat"],
	[c_2035_AAF,_2035_AAF,"2035 AAF"],
	[c_2035_NATO,_2035_NATO,"2035 NATO"],
	[c_2035_NATO_FS,_2035_NATO_FS,"2035 NATO Special Forces"],
	[c_2035_Spetsnaz,_2035_Spetsnaz,"2035 Spetsnaz"],
	[c_2035_FIA,_2035_FIA,"2035 FIA"],
	[c_2035_Rebels,_2035_Rebels,"2035 Rebels"],
	[c_2035_CSAT,_2035_CSAT,"2035 CSAT"]
];


//Add specific AMF factions
if (isClass (configFile >> "CfgPatches" >> "AMF_Patches")) then 
{
	factionInfos pushBack [c_French,_French,"French [AMF][ACE]"];
};


//Add specific CUP factions
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then 
{
	factionInfos pushBack [c_USA,_USA,"US Army [CUP]"];
	factionInfos pushBack [c_Taki,_Taki,"Takistani [CUP]"];
	factionInfos pushBack [c_Russian,_Ru,"Russian [CUP]"];
	factionInfos pushBack [c_USA_2000,_USA_2000,"2000 USA Marines [CUP]"];
	factionInfos pushBack [c_USA_2000_DF,_USA_2000_DF,"1993 USA Delta Force [CUP][ACE]"];	
	factionInfos pushBack [c_PMC, _PMC, "PMC Modern [CUP]"];	
	factionInfos pushBack [c_Russian_Winter, _Russian_Winter, "Russian Winter [CUP]"];	
	factionInfos pushBack [c_Taki_Army, _Taki_Army, "Takistani Army [CUP]"];
	factionInfos pushBack [c_HorizonIsland, _HorizonIsland, "Horizon Island [CUP]"];
	factionInfos pushBack [c_HorizonIslandSF, _HorizonIslandSF, "Horizon Island Special Forces [CUP]"];
};

//Add specific UNSUNG factions
if (isClass (configFile >> "CfgPatches" >> "uns_main")) then 
{
	factionInfos pushBack [c_ColdWar_ARVN,_ColdWar_ARVN,"Cold War ARVN [UNSUNG]"];
	factionInfos pushBack [c_ColdWar_NVA,_ColdWar_NVA,"Cold War NVA [UNSUNG]"];
	factionInfos pushBack [c_ColdWar_USA,_ColdWar_USA,"Cold War USA [UNSUNG]"];
};

//Add specific IFA3 factions
if (isClass (configFile >> "CfgPatches" >> "IFA3_Core")) then 
{
	factionInfos pushBack [c_WWII_UK,_WWII_UK,"WWII UK [IFA3]"];
	factionInfos pushBack [c_WWII_URSS,_WWII_URSS,"WWII URSS [IFA3]"];
	factionInfos pushBack [c_WWII_Wehrmacht,_WWII_Wehrmacht,"WWII Wehrmacht [IFA3]"];
	factionInfos pushBack [c_WWII_USA,_WWII_USA,"WWII USA [IFA3]"];
	factionInfos pushBack [c_WWII_FFI,_WWII_FFI,"WWII FFI [IFA3]"];
	
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