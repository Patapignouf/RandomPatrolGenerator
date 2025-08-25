disableSerialization;

// Ferme un ancien display
private _old = uiNamespace getVariable ["SPD_display", displayNull];
if !(isNull _old) then { _old closeDisplay 1; };

// Display vide
private _disp = findDisplay 46 createDisplay "RscDisplayEmpty";
uiNamespace setVariable ["SPD_display", _disp];

// Fond
private _bg = _disp ctrlCreate ["RscText", -1];
_bg ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
_bg ctrlSetBackgroundColor [0.05,0.05,0.06,0.95];
_bg ctrlCommit 0;

// Bouton Fermer
private _btn = _disp ctrlCreate ["RscButton", -1];
_btn ctrlSetText "Fermer";
_btn ctrlSetPosition [safeZoneX + safeZoneW - 0.16, safeZoneY + 0.02, 0.14, 0.05];
_btn ctrlAddEventHandler ["ButtonClick", { (ctrlParent (_this#0)) closeDisplay 1 }];
_btn ctrlCommit 0;

// Contrôle 3D
private _obj = _disp ctrlCreate ["RscObject", -1];

// Position 3D : [centreX, centreY, distance]
private _centerX = safeZoneX + safeZoneW/2;
private _centerY = safeZoneY + safeZoneH/2;
private _distance = 1.2;  // plus petit = zoomé
_obj ctrlSetPosition [_centerX, _centerY, _distance];

// Modèle du joueur (nu)
private _modelPath = getText (configFile >> "CfgVehicles" >> typeOf player >> "model");
_obj ctrlSetModel _modelPath;
_obj ctrlSetModelScale 1;
_obj ctrlSetModelDirAndUp [[0,0,1],[0,1,0]];
_obj ctrlSetAngle [0, 180, 0, true];

// Taille du rendu
_obj ctrlSetScale 1;

// Validation
_obj ctrlCommit 0;

// Animation de rotation
// [_obj] spawn {
//     params ["_ctrl"];
//     private _angle = 0;
//     while {!(isNull _ctrl) && {ctrlShown _ctrl}} do {
//         _ctrl ctrlSetAngle [0, _angle, 0, false];
//         _angle = (_angle + 0.5) % 360;
//         uiSleep 0.01;
//     };
// };