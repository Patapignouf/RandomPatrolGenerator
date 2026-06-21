params [["_minimumOPFORCounter", 0], ["_sideToDisplay", "ALL"]];

// Map coloration script (Diagonal hatching based on OPFOR/BLUFOR presence)
if (!isServer) exitWith {}; // Ensures the script only runs on the server

[_minimumOPFORCounter, _sideToDisplay] spawn {
    params ["_minimumOPFORCounter", "_sideToDisplay"];

    private _gridSize = 100; // Size of a map grid square in meters (default is 100m)
    private _mapWidth = worldSize; // Automatically retrieves the map size
    private _sideRelation = missionNameSpace getVariable ["sideRelations",0];
    
    while {true} do {
        // 1. Collect all alive units on the map
        private _allUnits = allUnits select {alive _x};
        private _allGroups = [];
        if (_sideToDisplay == "ALL") then 
        {
            _allGroups = allGroups select {alive leader _x};
        } else {
            _allGroups = allGroups select {alive leader _x && side _x == blufor};
        };
         
        // 2. Iterate through the map grid square by grid square
        // for "_xCoord" from 0 to _mapWidth step _gridSize do {
        //     for "_yCoord" from 0 to _mapWidth step _gridSize do {

        //         [_xCoord, _yCoord, _gridSize, _allUnits, _minimumOPFORCounter] spawn 
        //         {
        //             params ["_xCoord", "_yCoord", "_gridSize", "_allUnits", "_minimumOPFORCounter"];
        //            [_xCoord, _yCoord, _gridSize, _allUnits, _minimumOPFORCounter] call updateAreaMarker;
        //         };
        //     };
        // };

        {
            _tempGroupPos = getPos (leader _x);
            _tempGroupPosX = (floor ((_tempGroupPos#0)/_gridSize))*_gridSize;
            _tempGroupPosY = (floor ((_tempGroupPos#1)/_gridSize))*_gridSize;

            [_tempGroupPosX, _tempGroupPosY, _gridSize, _allUnits, _minimumOPFORCounter, _sideRelation] spawn 
            {
                params ["_xCoord", "_yCoord", "_gridSize", "_allUnits", "_minimumOPFORCounter", "_sideRelation"];
                [_xCoord, _yCoord, _gridSize, _allUnits, _minimumOPFORCounter, _sideRelation] call updateAreaMarker;
            };
        } foreach _allGroups;
        
        // Refresh rate (every 10 seconds to avoid overloading the server)
        sleep 10; 
    };
};


updateAreaMarker = {
    params ["_xCoord", "_yCoord", "_gridSize", "_allUnits", "_minimumOPFORCounter", "_sideRelation"];

    // Calculate the center of the current grid square
    private _centerX = _xCoord + (_gridSize / 2);
    private _centerY = _yCoord + (_gridSize / 2);
    private _posSquare = [_centerX, _centerY, 0];
    _posName = mapGridPosition _posSquare;

    // Unique name for this square's marker
    private _markerName = format ["grid_area_marker_%1%2", _posName, serverTime];

    // Filter units located INSIDE this specific grid square
    private _unitsInSquare = _allUnits select {
        (mapGridPosition _posSquare) == (mapGridPosition _x) 
    };

    // Count forces inside the square
    private _opforCount = {side (group _x) == east} count _unitsInSquare;
    private _bluforCount = {side (group _x) == west} count _unitsInSquare;

    // Determine the grid square color
    private _color = "";
    if (_opforCount > _minimumOPFORCounter) then {
        _color = "ColorOPFOR"; // Red if OPFOR count exceeds the threshold
    } else {
        if (_bluforCount > 0) then {
            _color = "ColorBLUFOR"; // Blue if ONLY BLUFOR are present (and OPFOR <= threshold)
        };
    };

    // 3. Map marker management
    if (_color != "") then {
        // If the marker does not exist yet, create it
        if (getMarkerColor _markerName == "") then {
            createMarker [_markerName, _posSquare];
            _markerName setMarkerShape "RECTANGLE";
            _markerName setMarkerSize [_gridSize / 2, _gridSize / 2];
            _markerName setMarkerPos _posSquare;
            _markerName setMarkerBrush "DiagGrid"; // Applies the diagonal hatching pattern
        };
        _markerName setMarkerColor _color;
        if (_sideRelation == 2 && _color == "ColorBLUFOR") then 
        {
            //Hide blufor marker for independent
            [_markerName, 0.6] remoteExec ["setMarkerAlphaLocal", blufor, true];
            [_markerName, 0] remoteExec ["setMarkerAlphaLocal", independent, true];
        } else 
        {
            _markerName setMarkerAlpha 0.6;
        };
    } else {
        // If the square is empty, delete the marker if it existed
        if (getMarkerColor _markerName != "") then {
            deleteMarker _markerName;
        };
    };

    //Clean marker
    [_markerName] spawn 
    {
        params ["_markerName"];
        sleep 15;
        deleteMarker _markerName;
    };
};