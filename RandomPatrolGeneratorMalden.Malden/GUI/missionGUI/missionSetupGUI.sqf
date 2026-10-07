/*
    File: fn_selectMissionGui.sqf
    Author: Assistant
    Description: Opens a fully interactive GUI to select a value and a Yes/No choice, then triggers a custom process.
    
    Parameter(s):
        0: ARRAY - List of pairs: [["Label 1", "value1"], ["Label 2", "value2"], ...]
        
    Example:
        [
            ["Mission Alpha", "m_alpha"], 
            ["Mission Bravo", "m_bravo"], 
            ["Mission Charlie", "m_charlie"]
        ] call fnc_selectMissionGui;
*/

fnc_selectMissionGui = {
    
    if (!hasInterface) exitWith { displayNull };

    // The whole argument is the list of [label, value] pairs
    private _items = _this;

    if !(_items isEqualType [] && { count _items > 0 }) exitWith {
        hint "MISSION_fnc_selectMission: the input list is empty or invalid.";
        displayNull
    };

    // ---------------------------------------------------------------------------
    // Display creation
    // ---------------------------------------------------------------------------
    private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";
    if (isNull _display) exitWith { displayNull };

    private _w = 0.5;
    private _h = 0.6;
    private _posX = safezoneX + (safezoneW - _w) / 2;
    private _posY = safezoneY + (safezoneH - _h) / 2;
    private _pad = 0.02;
    private _ctrlH = 0.04;

    // Background
    private _background = _display ctrlCreate ["RscText", -1];
    _background ctrlSetPosition [_posX, _posY, _w, _h];
    _background ctrlSetBackgroundColor [0, 0, 0, 0.8];
    _background ctrlCommit 0;

    // Title
    private _title = _display ctrlCreate ["RscText", -1];
    _title ctrlSetPosition [_posX, _posY - _ctrlH - 0.005, _w, _ctrlH];
    _title ctrlSetText "Mission selection";
    _title ctrlSetBackgroundColor [0.15, 0.35, 0.15, 1];
    _title ctrlCommit 0;

    // Value list
    private _list = _display ctrlCreate ["RscListBox", -1];
    _list ctrlSetPosition [_posX + _pad, _posY + _pad, _w - 2 * _pad, _h - 5 * _ctrlH - 4 * _pad];
    _list ctrlSetBackgroundColor [0.1, 0.1, 0.1, 1];
    _list ctrlCommit 0;

    // One list entry per [label, value] pair
    {
        _x params [["_label", "", [""]], "_value"];
        private _index = _list lbAdd _label;
        _list lbSetValue [_index, _index]; // keeps the link with the item position
    } forEach _items;
    _list lbSetCurSel 0;

    // "Last mission?" question
    private _questionY = _posY + _h - 3 * _ctrlH - 2 * _pad;

    private _question = _display ctrlCreate ["RscText", -1];
    _question ctrlSetPosition [_posX + _pad, _questionY, (_w - 2 * _pad) * 0.65, _ctrlH];
    _question ctrlSetText "Is this the last mission?";
    _question ctrlCommit 0;

    private _combo = _display ctrlCreate ["RscCombo", -1];
    _combo ctrlSetPosition [_posX + _pad + (_w - 2 * _pad) * 0.7, _questionY, (_w - 2 * _pad) * 0.3, _ctrlH];
    _combo ctrlCommit 0;
    _combo lbAdd "No";  // index 0 = default value
    _combo lbAdd "Yes"; // index 1
    _combo lbSetCurSel 0;

    // Buttons
    private _buttonsY = _posY + _h - _ctrlH - _pad;
    private _buttonW = (_w - 3 * _pad) / 2;

    private _buttonOk = _display ctrlCreate ["RscButton", -1];
    _buttonOk ctrlSetPosition [_posX + _pad, _buttonsY, _buttonW, _ctrlH];
    _buttonOk ctrlSetText "Confirm";
    _buttonOk ctrlCommit 0;

    private _buttonCancel = _display ctrlCreate ["RscButton", -1];
    _buttonCancel ctrlSetPosition [_posX + 2 * _pad + _buttonW, _buttonsY, _buttonW, _ctrlH];
    _buttonCancel ctrlSetText "Cancel";
    _buttonCancel ctrlCommit 0;

    // Data needed by the event handlers
    _display setVariable ["MISSION_items", _items];
    _display setVariable ["MISSION_list", _list];
    _display setVariable ["MISSION_combo", _combo];

    // ---------------------------------------------------------------------------
    // "Cancel" button
    // ---------------------------------------------------------------------------
    _buttonCancel ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];
        (ctrlParent _control) closeDisplay 2;
    }];

    // ---------------------------------------------------------------------------
    // "Confirm" button
    // ---------------------------------------------------------------------------
    _buttonOk ctrlAddEventHandler ["ButtonClick", {
        params ["_control"];

        private _display = ctrlParent _control;
        private _items = _display getVariable ["MISSION_items", []];
        private _list = _display getVariable "MISSION_list";
        private _combo = _display getVariable "MISSION_combo";

        private _selected = lbCurSel _list;
        if (_selected < 0) exitWith { hint "Please select a value."; };

        private _itemIndex = _list lbValue _selected;
        private _value = (_items select _itemIndex) select 1;
        private _isLastMission = (lbCurSel _combo) == 1; // true = "Yes", false = "No" (default)

        _display closeDisplay 1;

        // =======================================================================
        // PROCESS TO BE DEFINED
        // -----------------------------------------------------------------------
        // _value         : value linked to the selected label
        // _isLastMission : true if the player answered "Yes"
        // =======================================================================
        [_value, _isLastMission] spawn {
            params ["_value", "_isLastMission"];

            // TODO: replace this block with the wanted process
            systemChat format ["Selected value: %1 | Last mission: %2", _value, _isLastMission];

            //Spawn mission on server side
            [[_value, _isLastMission], 
                {
                    params ["_objectiveType", "_isLastMission"];

                    _objectiveTypeArray = [_objectiveType];

                    if (_objectiveType == "random") then 
                    {
                        _objectiveTypeArray = (avalaibleTypeOfObjectives apply {_x#0});
                    };

                    //Get objective location
                    _locations = missionNameSpace getVariable ["RPG_missionLocationsCampaignExtended", [] call getAllBigLocationsWithBuildings];
                    _selectedLocation = (selectRandom _locations);
                    _selectedPosLocation = getPos _selectedLocation;
                    missionNameSpace setVariable ["RPG_missionLocationsCampaignExtended", _locations-[_selectedLocation], true];
                    _numberOfObjectivePerLocation = missionNameSpace getVariable ["objectivePerLocation", 1];

                    //Generate objective
                    [_objectiveTypeArray, [_selectedPosLocation], _numberOfObjectivePerLocation, false] call generateObjectives;

                    //Reveal objective
                    if (missionNamespace getVariable ["startIntel", 2] == 2) then 
                    {
					    [objNull, [], blufor] execVM 'engine\objectiveManagement\revealObjective.sqf';
                    };

                    //End mission after the generated one
                    if (_isLastMission) then 
                    {
                        _missionFailedObjectives = missionNamespace getVariable ["missionFailedObjectives",[]];
                        _completedObjectives = missionNamespace getVariable ["completedObjectives",[]];
                        _maxObjectivesGeneratedSetting = missionNamespace getVariable ["maxObjectivesGeneratedSetting",[]];
                        _totalOldObjectives = count _missionFailedObjectives+ count _completedObjectives;
                        _missingObjective = _maxObjectivesGeneratedSetting - _totalOldObjectives;
                        
                        //If there is at least one objective needed
                        if (0 < (_missingObjective-1)) then 
                        {
                            //Add fake mission until it misses only one
                            for "_i" from 1 to (_missingObjective-1) do 
                            {
                                _missionFailedObjectives pushBack [""];
                            }; 

                            //Add fake missions to namespace
                            missionNamespace setVariable ["missionFailedObjectives",_missionFailedObjectives, true];
                        };
                    };
                }
            ] remoteExec ["spawn", 2]; 

        };
    }];

    _display
};