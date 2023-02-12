#include "..\database\factionParameters.sqf"
#include "..\database\arsenalLibrary.sqf"

//Setup variable
bluFaction = missionNamespace getVariable "bluforFaction";
indFaction = missionNamespace getVariable "independentFaction";

//Open arsenal
if (player getVariable "sideBeforeDeath" == "independent") then 
{
	//Independent
	["Open", [false, [VA1, player, indFaction] call setupArsenalToItem]] call BIS_fnc_arsenal;
} else 
{
	//Blufor
	["Open", [false, [VA2, player, bluFaction] call setupArsenalToItem]] call BIS_fnc_arsenal;
};

waitUntil {!isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] )};
waitUntil {isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] )};




//Save default stuff when ironMan mode is disable
if (!ironMan) then 
{
	player setVariable ["spawnLoadout", getUnitLoadout player];
};


//Open setup loadout GUI
[[], 'GUI\loadoutGUI\initPlayerLoadoutSetup.sqf'] remoteExec ['BIS_fnc_execVM', player];

