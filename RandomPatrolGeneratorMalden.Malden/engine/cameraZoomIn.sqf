/*
    Effet Transition "Ciel -> Yeux" (Version Sécurisée)
*/
if (!hasInterface) exitWith {};

// Attendre que le joueur soit prêt
waitUntil {!isNull player && {alive player}};

disableSerialization;

private _target = player;
private _targetPos = getPosATL _target;

// 1. CALCUL DE LA POSITION DE DÉPART (Indépendant de BIS_fnc)
private _angle = random 360;
private _dist = 400;
private _startX = (_targetPos select 0) + (sin _angle * _dist);
private _startY = (_targetPos select 1) + (cos _angle * _dist);
private _startPos = [_startX, _startY, 250]; // [X, Y, Altitude]

// 2. CRÉATION DE LA CAMÉRA (Syntaxe robuste)
// On utilise "camera" camCreate avec une position brute
private _cam = "camera" camCreate _startPos;

// Vérification de sécurité pour éviter le crash
if (isNull _cam) exitWith { hint "Erreur : La caméra n'a pas pu être créée."; };

_cam cameraEffect ["internal", "BACK"];
showHUD false;

// 3. CONFIGURATION INITIALE
_cam camSetTarget _target;
_cam camSetFov 1.0;
_cam camCommit 0;

// Effet de fondu entrant
cutText ["", "BLACK IN", 2];

// 4. TRANSITION VERS LA TÊTE
// On vise la tête précisément
private _headPos = _target modelToWorld (_target selectionPosition "head");
_cam camSetPos [(_headPos select 0), (_headPos select 1), (_headPos select 2) + 0.5];
_cam camSetTarget _headPos;
_cam camSetFov 0.7;

private _travelTime = 5;
_cam camCommit _travelTime;

// 5. FINALISATION (On attend la fin du mouvement)
sleep (_travelTime - 0.2);

// Fondu rapide pour cacher la transition
cutText ["", "BLACK OUT", 0.2];
sleep 0.2;

// Destruction et retour vue joueur
_cam cameraEffect ["terminate", "back"];
camDestroy _cam;

_target switchCamera "Internal";
showHUD true;

cutText ["", "BLACK IN", 1];