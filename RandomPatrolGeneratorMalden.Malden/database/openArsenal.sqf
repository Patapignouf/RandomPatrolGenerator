#include "..\database\factionParameters.sqf"
#include "..\database\arsenalLibrary.sqf"

//Setup variable
bluFaction = missionNamespace getVariable "bluforFaction";
indFaction = missionNamespace getVariable "independentFaction";

//Open arsenal
["Open", [false, [player, player, player call getPlayerFaction] call setupArsenalToItem]] call BIS_fnc_arsenal;

waitUntil {!isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] )};
waitUntil {isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] )};


//Save default stuff when ironMan mode is disable
if (!ironMan) then 
{
	player setVariable ["spawnLoadout", getUnitLoadout player];
};


//Open setup loadout GUI
[[], 'GUI\loadoutGUI\initPlayerLoadoutSetup.sqf'] remoteExec ['BIS_fnc_execVM', player];

