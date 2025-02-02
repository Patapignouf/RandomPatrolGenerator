params ["_customParam"];

getLoadoutPicture = {
	_loadoutDisplay = "";

	//display weapons
	{
		_currentWeapon = _x;
		_loadoutDisplay = [_loadoutDisplay, _currentWeapon] call bigConcatenateDisplay;
		{
			_loadoutDisplay = [_loadoutDisplay, _x] call smallConcatenateDisplay;
		} foreach (player weaponAccessories (_currentWeapon));
		_loadoutDisplay = [_loadoutDisplay] call addReturn;
	} foreach (weapons player);

	//Display items
	_loadoutDisplay = [_loadoutDisplay] call addReturn;
	_items = [];
	(vestitems player + uniformitems player + backpackitems player) apply {_items pushBackUnique _x}; //Filter unique item
	{
		_loadoutDisplay = [_loadoutDisplay, _x] call smallConcatenateDisplay;
	} foreach _items;

	_loadoutDisplay;
};

addReturn = {
		params ["_currentDisplay"];
	_tempLoadoutDisplay = format ["%1<br/>", _currentDisplay];
	_tempLoadoutDisplay;
};

bigConcatenateDisplay = {
	params ["_currentDisplay", "_itemToAdd"];
	_tempLoadoutDisplay = _currentDisplay;
	if (_itemToAdd != "") then 
	{
		_tempPic = format ["<img image='%1' size='3'/>", getText (configfile >> "CfgWeapons" >> _itemToAdd >> "picture")]; //Get picture from weapon
		_tempPic2 = format ["<img image='%1' size='3'/>", getText (configfile >> "CfgMagazines" >> _itemToAdd >> "picture")]; //get picture from magazine
		_tempLoadoutDisplay = format ["%3%1%2", _tempPic, _tempPic2, _currentDisplay];
	};
	_tempLoadoutDisplay;
};

smallConcatenateDisplay = {
	params ["_currentDisplay", "_itemToAdd"];
	_tempLoadoutDisplay = _currentDisplay;
	if (_itemToAdd != "") then 
	{
		_tempPic = format ["<img image='%1' size='2'/>", getText (configfile >> "CfgWeapons" >> _itemToAdd >> "picture")];
		_tempPic2 = format ["<img image='%1' size='2'/>", getText (configfile >> "CfgMagazines" >> _itemToAdd >> "picture")];
		_tempLoadoutDisplay = format ["%3%1%2", _tempPic, _tempPic2, _currentDisplay];
	};
	_tempLoadoutDisplay;
};


refreshCustomLoadoutDisplay = {
		params ["_mainDisplay"];
		_buttonLoad = (_mainDisplay) displayCtrl 12001;
		_loadoutDisplay = (_mainDisplay) displayCtrl 12002;
		_dropdown = (_mainDisplay) displayCtrl 12004;


		//refresh loadout display
		_loadoutDisplay ctrlSetStructuredText parseText ([] call getLoadoutPicture);

		//Refresh load loadout button
		_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, player call getPlayerFaction, player getVariable "role"], []];

		//Refresh dropDownlist custom 
		lbClear _dropdown; 
		_listOfAvalaibleRole = [player] call setupSimpleRoleSwitchWithToList;
		{
			_dropdown lbAdd format ["%1", format ["%1 (%2 %3)", [_x] call getClassInformation, [player, _x] call getNumberOfClassInSquad, localize "STR_RPG_LOADOUT_ROLE_NB_INSQUAD"]];
			_dropdown lbSetData [(lbSize _dropdown)-1, format ["%1",(lbSize _dropdown)-1]];
			_dropdown lbSetTooltip [(lbSize _dropdown)-1, [_x] call getDescClassInformation];
		} foreach _listOfAvalaibleRole;


		_dropdown lbSetCurSel (_listOfAvalaibleRole find (player getVariable "role")); //Actual Warfare

		if (count _loadableLoadout == 0) then 
		{
			_buttonLoad ctrlShow false;
		} else 
		{
			_buttonLoad ctrlShow true;
		};

};


//Create display too choose reporter player
_display = (findDisplay 46) createDisplay "RscDisplayEmpty";

_backGround = _display ctrlCreate[ "ctrlStaticPicture", -1 ];
_backGround ctrlSetPosition[ -0.1, -0.1, 1.2, 1.2 ];
_backGround ctrlSetText "#(argb,8,8,3)color(0.35,0.35,0.35,1)";
_backGround ctrlCommit 0;

_RcsTitleDialog = _display ctrlCreate ["RscStructuredText", -1];
_RcsTitleDialog ctrlSetStructuredText parseText format ["<t size='0.5'>&#160;</t><br/><t size='1' align='center'>%1 %2&#160;&#160;</t>", localize "STR_RPG_LOADOUT_TITLE", name player];
_RcsTitleDialog ctrlSetPosition [ -0.1, -0.1, 1.2, 0.07 ];
_RcsTitleDialog ctrlSetBackgroundColor [0.8,0.5,0,1];
_RcsTitleDialog ctrlSetTextColor [1, 1, 1, 1];
_RcsTitleDialog ctrlCommit 0;


//Create dropdownlist title on the left side
_RcsBodyLeftDialog = _display ctrlCreate ["RscStructuredText", -1];
_RcsBodyLeftDialog ctrlSetStructuredText parseText format ["<t size='0.5'>&#160;</t><br/><t size='1' align='center'>%1&#160;&#160;</t>", localize "STR_RPG_LOADOUT_ROLE"];
_RcsBodyLeftDialog ctrlSetPosition[-0.07, 0.10, 0.5, 0.07 ];
_RcsBodyLeftDialog ctrlSetTextColor [1, 1, 1, 1];
//_RcsBodyLeftDialog ctrlSetBackgroundColor [0,0,0,0.8];
_RcsBodyLeftDialog ctrlCommit 0;

//Create dropdownlist title on the left side
_RcsBodyLoadoutDisplayDialog = _display ctrlCreate ["RscStructuredText", 12002];
_RcsBodyLoadoutDisplayDialog ctrlSetStructuredText parseText ([] call getLoadoutPicture);
_RcsBodyLoadoutDisplayDialog ctrlSetPosition[-0.07, 0.20, 1.2, 0.6 ];
_RcsBodyLoadoutDisplayDialog ctrlSetTextColor [1, 1, 1, 1];
//_RcsBodyLeftDialog ctrlSetBackgroundColor [0,0,0,0.8];
_RcsBodyLoadoutDisplayDialog ctrlCommit 0;

//Create dropdownlist next to the param title on the right side
_dropdown = _display ctrlCreate ["RscCombo", 12004];
_dropdown ctrlSetPosition [0.5, 0.10, 0.4, 0.04];
_dropdown ctrlCommit 0;

//Remove custom voice 
player setSpeaker "noVoice";

//get list of avalaible role for player's faction
_listOfAvalaibleRole = [player] call setupSimpleRoleSwitchWithToList;


//Populate dropdownlist with role
_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, player call getPlayerFaction, player getVariable "role"], []];

//Load every class for current player's faction
//Define list of role in the combo box
{
	_dropdown lbAdd format ["%1", format ["%1 (%2 %3)", [_x] call getClassInformation, [player, _x] call getNumberOfClassInSquad, localize "STR_RPG_LOADOUT_ROLE_NB_INSQUAD"]];
	_dropdown lbSetData [(lbSize _dropdown)-1, format ["%1",(lbSize _dropdown)-1]];
	_dropdown lbSetTooltip [(lbSize _dropdown)-1, [_x] call getDescClassInformation];
} foreach _listOfAvalaibleRole;


_dropdown lbSetCurSel (_listOfAvalaibleRole find (player getVariable "role")); //Actual Warfare

_dropdown ctrlAddEventHandler[ "LBSelChanged", 
	{
		params ["_ctrl"];

		_mainDisplay = (ctrlParent _ctrl);
		_comboBoxClassSelection = _ctrl;

		//Setup arsenal loadout
		_listOfAvalaibleRole = [player call getPlayerFaction] call setupRoleSwitchToList;
		_role = (_listOfAvalaibleRole select parseNumber ((_comboBoxClassSelection lbData (lbCurSel _comboBoxClassSelection))));

		if (_role != player getVariable ["role", ""]) then 
		{
			[player, player, player call getPlayerFaction , _role, false, false] call switchToRole;
			[player, player, player call getPlayerFaction] call setupArsenalToItem;

			//Refresh load button
			[ctrlParent _ctrl] call refreshCustomLoadoutDisplay;
		};

		//Hint switch role
		//[[format ["%1 has switched to role %2", name player, player getVariable "role"], "arsenal"], 'engine\hintManagement\addCustomHint.sqf'] remoteExec ['BIS_fnc_execVM', -clientOwner]; 
	}];

//Loadout validated loadout (compared with spawn loadout)
//Validate loadout only if there is no restriction
if ((missionNameSpace getVariable "enableLoadoutRestriction") == 1) then 
{
	//async validate loadout
	[player] spawn {
		params ["_player"];
		[_player] call validateLoadout;
	};
};

//Button to go on the next setup
_ButtonArsenal = _display ctrlCreate ["RscButton", -1];
_ButtonArsenal ctrlSetPosition [(0.45 * safezoneW + safezoneX),(0.70 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonArsenal ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonArsenal ctrlCommit 0;
_ButtonArsenal ctrlEnable true;
_ButtonArsenal ctrlSetText "Arsenal";
_ButtonArsenal ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;
		if ((missionNameSpace getVariable "enableLoadoutRestriction") == 1) then 
		{
			//open restricted arsenal
			[true] execVM 'database\openArsenal.sqf';
			
		} else 
		{
			//open full arsenal
			if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then 
			{
				[player, player, true] call ace_arsenal_fnc_openBox;
			} else 
			{
				//Setup regular arsenal
				["Open", [true]] call BIS_fnc_arsenal;
			};
		};
	}];

_ButtonReset = _display ctrlCreate ["RscButton", -1];
_ButtonReset ctrlSetPosition [(0.45 * safezoneW + safezoneX),(0.65 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonReset ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonReset ctrlCommit 0;
_ButtonReset ctrlEnable true;
_ButtonReset ctrlSetText localize "RPG_GUI_GENERAL_RESET";
_ButtonReset ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];
		hint "Loadout reset";
		[player, player call getPlayerFaction, true] call doInitializeLoadout;
		player setVariable ["spawnLoadout", getUnitLoadout player];
		[ctrlParent _ctrl] call refreshCustomLoadoutDisplay;
	}];


//Button to go on the next setup
_ButtonClose = _display ctrlCreate ["RscButton", 12003];
_ButtonClose ctrlSetPosition [(0.45 * safezoneW + safezoneX),(0.75 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonClose ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonClose ctrlCommit 0;
ctrlSetFocus _ButtonClose;
_ButtonClose ctrlEnable true;
_ButtonClose ctrlSetText localize "RPG_GUI_GENERAL_CLOSE";
_ButtonClose ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];
		_display = ctrlParent _ctrl;
		_display closeDisplay 1;

	}];

_ButtonRank = _display ctrlCreate ["RscButton", -1];
_ButtonRank ctrlSetPosition [(0.45 * safezoneW + safezoneX),(0.23 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonRank ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonRank ctrlCommit 0;
_ButtonRank ctrlEnable true;
_ButtonRank ctrlSetText localize "STR_RPG_LOADOUT_SHOWRANK";
_ButtonRank ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];
		[[], 'GUI\rankGUI\rankGUI.sqf'] remoteExec ['BIS_fnc_execVM', player];
	}];


//Button to go on the next setup
_ButtonLoad = _display ctrlCreate ["RscButton", 12001];
_ButtonLoad ctrlSetPosition [(0.55 * safezoneW + safezoneX),(0.65 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonLoad ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonLoad ctrlCommit 0;
_ButtonLoad ctrlEnable true;
_ButtonLoad ctrlSetText localize "RPG_GUI_GENERAL_LOAD";
_ButtonLoad ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];

			//Save personnal loadout
			_loadableLoadout = profileNamespace getVariable [format [loadoutSaveName, name player, player call getPlayerFaction, player getVariable "role"], player getVariable "spawnLoadout"];
			player setUnitLoadout _loadableLoadout;

			//Fix TFAR link 
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then 
			{
				_currentRadios = player call TFAR_fnc_radiosList;

				if (count _currentRadios >= 1) then
				{
					//Remove previously added radio in case where there is already a member with the same radio ID
					_currentRadio = _currentRadios#0;
					player unassignItem _currentRadio;
					player removeItem _currentRadio;

					//Search default radio name (TFAR rename player's radio)
					_tempArray = (_currentRadio splitString "_");
					_tempArray resize (count _tempArray-1);
					_radioToAdd = (_tempArray joinString "_");

					//Add specific radio
					player addItem _radioToAdd;
					player assignItem _radioToAdd;
				};
			};
			

			//Prevent player from loosing his current configuration
			[] spawn {
				uiSleep 0.5;
				_newAvalaibleItems = player getVariable ["avalaibleItemsInArsenal", []];
				_potentialStuff = ((getUnitLoadout player) call getAllStringInArray);
				{
					if (typeName _x != "STRING") then 
					{
						_potentialStuff = _potentialStuff - [_x];
					};
				} foreach _potentialStuff;

				_newAvalaibleItems = _newAvalaibleItems + _potentialStuff;
				player setVariable ["avalaibleItemsInArsenal", _newAvalaibleItems];
			};

			//Save loadout on respawn
			player setVariable ["spawnLoadout", getUnitLoadout player];

			[ctrlParent _ctrl] call refreshCustomLoadoutDisplay;
			cutText ["Loadout loaded", "PLAIN", 0.3];
	}];

//Button to go on the next setup
_ButtonSave = _display ctrlCreate ["RscButton", -1];
_ButtonSave ctrlSetPosition [(0.35 * safezoneW + safezoneX),(0.65 * safezoneH + safezoneY),(0.09 * safezoneW),(0.025* safezoneH)];
_ButtonSave ctrlSetBackgroundColor [0,0,0,0.7];
_ButtonSave ctrlCommit 0;
_ButtonSave ctrlEnable true;
_ButtonSave ctrlSetText localize "RPG_GUI_GENERAL_SAVE";
_ButtonSave ctrlAddEventHandler ["ButtonClick",{
		params ["_ctrl"];
		//Save default stuff when ironMan mode is disable
		player setVariable ["spawnLoadout", getUnitLoadout player];

		//Save current loadout
		[player, "personal"] call saveCustomLoadout;
		hint "Loadout loaded";

		[ctrlParent _ctrl] call refreshCustomLoadoutDisplay;
	}];

[_display] call refreshCustomLoadoutDisplay;
