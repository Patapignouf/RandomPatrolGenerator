#include "..\database\factionParameters.sqf"
#include "..\database\arsenalLibrary.sqf"

//Setup variable
bluFaction = missionNamespace getVariable "bluforFaction";
indFaction = missionNamespace getVariable "independentFaction";

//Open arsenal
if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
{
	//Create ACE event handler to detect arsenal closed
	if (isNull (player getVariable ["arsenalFirstOpen", objNull])) then 
	{
		player setVariable ["arsenalFirstOpen", player, true];
		
		//Add ACE arsenal closed eventHandler
		["ace_arsenal_displayClosed", {
			player setVariable [ "ACE_arsenalClosed", true, true];
		}] call CBA_fnc_addEventHandler;
	};
	
	//Setup ACE Arsenal 
	player setVariable [ "ACE_arsenalClosed", false, true];
	[[player, player, player call getPlayerFaction] call setupArsenalToItem, player getVariable "avalaibleItemsInArsenal"] call ace_arsenal_fnc_addVirtualItems;
	[player, player] call ace_arsenal_fnc_openBox;

	//Wait for arsenal closing
	waitUntil {player getVariable [ "ACE_arsenalClosed", false ]};
} else 
{
	//Setup regular arsenal
	["Open", [false, [player, player, player call getPlayerFaction] call setupArsenalToItem]] call BIS_fnc_arsenal;

	//Wait for arsenal closing
	waitUntil {!isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] )};
	waitUntil {isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] )};
};



//Save default stuff when ironMan mode is disable
if (!ironMan) then 
{
	player setVariable ["spawnLoadout", getUnitLoadout player];
};


//Open setup loadout GUI
[[], 'GUI\loadoutGUI\initPlayerLoadoutSetup.sqf'] remoteExec ['BIS_fnc_execVM', player];

