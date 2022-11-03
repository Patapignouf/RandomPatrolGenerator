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
#include "object_db\ColdWar_ARVN.sqf"
#include "object_db\ColdWar_NVA.sqf"
#include "object_db\ColdWar_USA.sqf"
#include "object_db\2035_AAF.sqf"
#include "object_db\2035_NATO.sqf"
#include "object_db\USA_2000_DF.sqf"

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
c_ColdWar_ARVN = "_ColdWar_ARVN";
c_ColdWar_NVA = "_ColdWar_NVA";
c_ColdWar_USA = "_ColdWar_USA";
c_2035_AAF = "_2035_AAF";
c_2035_NATO = "_2035_NATO";
c_USA_2000_DF = "_USA_2000_DF";

factionInfos = [
	[c_USA,_USA],
	[c_Russian,_Ru],
	[c_Taki,_Taki],
	[c_Syndikat,_Syndikat],
	[c_French,_French],
	[c_USA_2000,_USA_2000],
	[c_WWII_UK,_WWII_UK],
	[c_WWII_URSS,_WWII_URSS],
	[c_WWII_Wehrmacht,_WWII_Wehrmacht],
	[c_WWII_USA,_WWII_USA],
	[c_ColdWar_ARVN,_ColdWar_ARVN],
	[c_ColdWar_NVA,_ColdWar_NVA],
	[c_ColdWar_USA,_ColdWar_USA],
	[c_2035_AAF,_2035_AAF],
	[c_2035_NATO,_2035_NATO],
	[c_USA_2000_DF,_USA_2000_DF]
];


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