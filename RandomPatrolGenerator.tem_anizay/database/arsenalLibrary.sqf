_Taki = 0;
_USA = 1;
_Syndikat = 2;
_Ru = 3;
_French = 4;

#include "object_db\USA.sqf"
#include "object_db\French.sqf"
#include "object_db\Russian.sqf"
#include "object_db\Syndikat.sqf"
#include "object_db\Takistani.sqf"

//Define global constant
c_leader = "leader";
c_at = "at";
c_rifleman = "rifleman";
c_engineer = "engineer";
c_autorifleman = "autorifleman";
c_marksman = "marksman"; 
c_medic = "medic";

c_listOfRoles = [c_leader,c_at,c_rifleman,c_engineer,c_autorifleman,c_marksman,c_medic];


//Join
loadout_db = [[loadout_USA,_USA],[loadout_Russian,_Ru],[loadout_Taki,_Taki],[loadout_Syndikat,_Syndikat],[loadout_French,_French]];
rifleList_db = [[rifleList_USA,_USA],[rifleList_Russian,_Ru],[rifleList_Taki,_Taki],[rifleList_Syndikat,_Syndikat],[rifleList_French,_French]];
attachmentLongList_db = [[attachmentLongList_USA,_USA],[attachmentLongList_Russian,_Ru],[attachmentLongList_Taki,_Taki],[attachmentLongList_Syndikat,_Syndikat],[attachmentLongList_French,_French]];
attachmentShortList_db = [[attachmentShortList_USA,_USA],[attachmentShortList_Russian,_Ru],[attachmentShortList_Taki,_Taki],[attachmentShortList_Syndikat,_Syndikat],[attachmentShortList_French,_French]];
smgList_db = [[smgList_USA,_USA],[smgList_Russian,_Ru],[smgList_Taki,_Taki],[smgList_Syndikat,_Syndikat],[smgList_French,_French]];
marksmanrifleList_db = [[marksmanrifleList_USA,_USA],[marksmanrifleList_Russian,_Ru],[marksmanrifleList_Taki,_Taki],[marksmanrifleList_Syndikat,_Syndikat],[marksmanrifleList_French,_French]];
autorifleList_db = [[autorifleList_USA,_USA],[autorifleList_Russian,_Ru],[autorifleList_Taki,_Taki],[autorifleList_Syndikat,_Syndikat],[autorifleList_French,_French]];
launcherList_db = [[launcherList_USA,_USA],[launcherList_Russian,_Ru],[launcherList_Taki,_Taki],[launcherList_Syndikat,_Syndikat],[launcherList_French,_French]];


itemList_db = [[itemList_USA,_USA],[itemList_Russian,_Ru],[itemList_Taki,_Taki],[itemList_Syndikat,_Syndikat],[itemList_French,_French]];
itemEngineerList_db = [[itemEngineerList_USA,_USA],[itemEngineerList_Russian,_Ru],[itemEngineerList_Taki,_Taki],[itemEngineerList_Syndikat,_Syndikat],[itemEngineerList_French,_French]];
itemMedicList_db = [[itemMedicList_USA,_USA],[itemMedicList_Russian,_Ru],[itemMedicList_Taki,_Taki],[itemMedicList_Syndikat,_Syndikat],[itemMedicList_French,_French]];

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

//New line to manage backpack in a future update
//backpacksList_db = [[backpacksList_USA,_USA],[backpacksList_Russian,_Ru],[backpacksList_Taki,_Taki],[backpacksList_Syndikat,_Syndikat],[backpacksList_French,_French]];

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
	//Clean arsenal
	//["AmmoboxExit", itemToAttachArsenal] call BIS_fnc_arsenal;	
	[itemToAttachArsenal,itemToAttachArsenal call BIS_fnc_getVirtualWeaponCargo,false] call BIS_fnc_removeVirtualWeaponCargo;
	[itemToAttachArsenal,itemToAttachArsenal call BIS_fnc_getVirtualItemCargo,false] call BIS_fnc_removeVirtualItemCargo;
	[itemToAttachArsenal,itemToAttachArsenal call BIS_fnc_getVirtualMagazineCargo,false] call BIS_fnc_removeVirtualMagazineCargo;
	[itemToAttachArsenal,itemToAttachArsenal call BIS_fnc_getVirtualBackpackCargo,false] call BIS_fnc_removeVirtualBackpackCargo;


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