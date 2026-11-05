    /*
        Function : MISSION_fnc_selectMission
        File     : fn_selectMission.sqf

        Description:
            Displays a dynamically created GUI (no config needed in description.ext) that lets
            the player:
            - select one value among a list of [label, value] pairs,
            - answer "Is this the last mission?" (Yes/No, default = "No"),
            - answer "Select the location manually on the map?" (Yes/No, default = "No").
            Validating the dialog launches a process (to be defined in the marked block).
            If the player chose to select the location manually, the map opens and the
            player left-clicks the wanted position before the process is launched.

        Parameter (_this):
            ARRAY - List of [label (STRING), value (ANY)] pairs
            Example: [["Mission 1", "m01"], ["Mission 2", "m02"], ["Mission 3", "m03"]]

        Return:
            DISPLAY - The created display (displayNull on error)

        Usage:
            MISSION_fnc_selectMission = compile preprocessFileLineNumbers "fn_selectMission.sqf";
            [["Mission 1", "m01"], ["Mission 2", "m02"]] call MISSION_fnc_selectMission;
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
    private _h = 0.65;
    private _posX = safezoneX + (safezoneW - _w) / 2;
    private _posY = safezoneY + (safezoneH - _h) / 2;
    private _pad = 0.02;
    private _ctrlH = 0.04;
    private _labelW = (_w - 2 * _pad) * 0.65;
    private _comboW = (_w - 2 * _pad) * 0.3;
    private _comboX = _posX + _pad + (_w - 2 * _pad) * 0.7;

    // Vertical layout (computed from the bottom up)
    private _buttonsY = _posY + _h - _ctrlH - _pad;
    private _mapQuestionY = _buttonsY - _ctrlH - _pad;
    private _lastQuestionY = _mapQuestionY - _ctrlH - 0.01;
    private _listH = _lastQuestionY - _pad - (_posY + _pad);

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
    _list ctrlSetPosition [_posX + _pad, _posY + _pad, _w - 2 * _pad, _listH];
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
    private _lastQuestion = _display ctrlCreate ["RscText", -1];
    _lastQuestion ctrlSetPosition [_posX + _pad, _lastQuestionY, _labelW, _ctrlH];
    _lastQuestion ctrlSetText "Is this the last mission?";
    _lastQuestion ctrlCommit 0;

    private _lastCombo = _display ctrlCreate ["RscCombo", -1];
    _lastCombo ctrlSetPosition [_comboX, _lastQuestionY, _comboW, _ctrlH];
    _lastCombo ctrlCommit 0;
    _lastCombo lbAdd "No";  // index 0 = default value
    _lastCombo lbAdd "Yes"; // index 1
    _lastCombo lbSetCurSel 0;

    // "Select the location on the map?" question
    private _mapQuestion = _display ctrlCreate ["RscText", -1];
    _mapQuestion ctrlSetPosition [_posX + _pad, _mapQuestionY, _labelW, _ctrlH];
    _mapQuestion ctrlSetText "Select the location on the map?";
    _mapQuestion ctrlCommit 0;

    private _mapCombo = _display ctrlCreate ["RscCombo", -1];
    _mapCombo ctrlSetPosition [_comboX, _mapQuestionY, _comboW, _ctrlH];
    _mapCombo ctrlCommit 0;
    _mapCombo lbAdd "No";  // index 0 = default value
    _mapCombo lbAdd "Yes"; // index 1
    _mapCombo lbSetCurSel 0;

    // Buttons
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
    _display setVariable ["MISSION_lastCombo", _lastCombo];
    _display setVariable ["MISSION_mapCombo", _mapCombo];

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
        private _lastCombo = _display getVariable "MISSION_lastCombo";
        private _mapCombo = _display getVariable "MISSION_mapCombo";

        private _selected = lbCurSel _list;
        if (_selected < 0) exitWith { hint "Please select a value."; };

        private _itemIndex = _list lbValue _selected;
        private _value = (_items select _itemIndex) select 1;
        private _isLastMission = (lbCurSel _lastCombo) == 1; // true = "Yes", false = "No" (default)
        private _selectOnMap = (lbCurSel _mapCombo) == 1;    // true = "Yes", false = "No" (default)

        _display closeDisplay 1;

        [_value, _isLastMission, _selectOnMap] spawn {
            params ["_value", "_isLastMission", "_selectOnMap"];

            // Position chosen manually on the map ([] if the player did not ask for it)
            private _position = [];

            if (_selectOnMap) then {
                // Reset any previous result, then open the map and wait for a left click
                missionNamespace setVariable ["MISSION_mapClickPos", nil];

                openMap [true, false];
                hint "Left-click on the map to choose the location.\nClose the map to cancel.";

                private _ehId = addMissionEventHandler ["MapSingleClick", {
                    params ["_units", "_pos", "_alt", "_shift"];
                    missionNamespace setVariable ["MISSION_mapClickPos", _pos];
                }];

                waitUntil {
                    sleep 0.1;
                    !visibleMap || { !isNil { missionNamespace getVariable "MISSION_mapClickPos" } }
                };

                removeMissionEventHandler ["MapSingleClick", _ehId];

                _position = missionNamespace getVariable ["MISSION_mapClickPos", []];
                missionNamespace setVariable ["MISSION_mapClickPos", nil];

                openMap [false, false];
                hint "";
            };

            // Map closed without clicking: the whole operation is cancelled
            if (_selectOnMap && { _position isEqualTo [] }) exitWith {
                hint "Location selection cancelled.";
            };

            // =======================================================================
            // PROCESS TO BE DEFINED
            // -----------------------------------------------------------------------
            // _value         : value linked to the selected label
            // _isLastMission : true if the player answered "Yes" to "last mission?"
            // _position      : [x, y, z] chosen on the map, or [] if "No" was selected
            // =======================================================================

            // TODO: replace this block with the wanted process
            systemChat format [
                "Selected value: %1 | Last mission: %2 | Position: %3",
                _value, _isLastMission, _position
            ];

            [_value, _isLastMission, _position] spawn {
                params ["_value", "_isLastMission", "_position"];

                // TODO: replace this block with the wanted process
                systemChat format ["Selected value: %1 | Last mission: %2", _value, _isLastMission];

                //Spawn mission on server side
                [[_value, _isLastMission, _position], 
                    {
                        params ["_objectiveType", "_isLastMission", "_position"];

                        _objectiveTypeArray = [_objectiveType];

                        if (_objectiveType == "random") then 
                        {
                            _objectiveTypeArray = (avalaibleTypeOfObjectives apply {_x#0});
                        };

                        _selectedPosLocation = [];
                        if (count _position == 3) then 
                        {
                            _selectedPosLocation = _position;
                        } else 
                        {
                            //Get objective location
                            _locations = missionNameSpace getVariable ["RPG_missionLocationsCampaignExtended", [] call getAllBigLocationsWithBuildings];
                            _selectedLocation = (selectRandom _locations);
                            _selectedPosLocation = getPos _selectedLocation;
                            missionNameSpace setVariable ["RPG_missionLocationsCampaignExtended", _locations-[_selectedLocation], true];
                        };

                        //Generate objective
                        _numberOfObjectivePerLocation = missionNameSpace getVariable ["objectivePerLocation", 1];
                        [_objectiveTypeArray, [_selectedPosLocation], _numberOfObjectivePerLocation, false] call generateObjectives;

                        //Reveal objective
                        if (missionNamespace getVariable ["startIntel", 2] == 2) then 
                        {
                            [objNull, [], blufor] execVM 'engine\objectiveManagement\revealObjective.sqf';
                        };

                        //50% chance spawn FOB
                        if (random 100 < 50) then 
                        {
                            //Generate opfor FOB in campaign mode
                            [] call doGenerateFOBOrDestroyer;                       
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
        };
    }];

    _display

};