//New Event Manager hop this will handle more BIS_fnc_setCuratorAttributes
//First it will generate supply drop 

_isDropAllowed = missionNameSpace getVariable ["enableEventSupplyDrop", 1];
isDropCurrentlyActive = false;
_harassAvailable = missionNameSpace getVariable ["numberOfHarassAvailable", 0];
isHarassCurrentlyActive = false;

while {sleep 600; true} do  
{
	sleep (random 400);

	if (_isDropAllowed == 1 && !isDropCurrentlyActive) then 
	{
		isDropCurrentlyActive = true;

		//Spawn supply box async
		[] spawn 
		{
			sleep (random 360);

			//Generate drop box (si de objective)
			//_randomPositionOnLand = [nil, ["water"]] call BIS_fnc_randomPos; //Full random
			_playerPos = getPos (selectRandom allPlayers);
			_randomPositionOnLand = [[_playerPos, 4000], [[_playerPos, 1500], "water"]] call BIS_fnc_randomPos;
			[_randomPositionOnLand] spawn compile preprocessFileLineNumbers "enemyManagement\generationEngine\generateDropBox.sqf";

			//Reset supply objective
			sleep 3600;
			isDropCurrentlyActive = false;
		};
	};

	_harassAvailable = missionNameSpace getVariable ["numberOfHarassAvailable", 0];
	if (0 < _harassAvailable) then 
	{
		//Do harass if available 
		if (!isHarassCurrentlyActive) then 
		{
			[_harassAvailable] spawn 
			{
				params ["_harassAvailable"];
				
				//Begin harass
				private _missionFOBRegistry = missionNameSpace getVariable ["RPG_OPFORFobList",[]];
				private _closestResult = [_missionFOBRegistry] call fnc_findClosestPlayerPoint;
				private _distance = _closestResult#2;
				private _FOBLocation = _closestResult#0;
				private _positionToAttack = getPos (_closestResult#1);


				//Not distance too close or too long
				if (_distance == -1) exitWith {};
				if (_distance < 250) exitWith {};
				if (_distance > 3000) exitWith {};

				private _numberOfOpforInCombat = [_closestResult#1] call checkOpforUnitInCombatAround;
				if (_numberOfOpforInCombat < 3) exitWith {}; 

				//Have to generate enemy wave
				isHarassCurrentlyActive = true;
				missionNameSpace setVariable ["numberOfHarassAvailable", _harassAvailable-1, true]; //Reduce harass counter
				[_positionToAttack, _FOBLocation] call doGenerateHarassWithVehicleFromFOB;

				//Alert players 75% chance
				if (random 100>25) then 
				{
					[[_positionToAttack], {params ["_positionToAttack"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_ENEMY_REINFORCEMENT_FROM_FOB", mapGridPosition (_positionToAttack)] call doDialog}] remoteExec ["spawn", 0]; 
				};

				//Wait according to mission settings
				switch (missionNamespace getVariable ["opforReinforcement", 1])  do
				{
					//Few
					case 0:
					{
						sleep (1800+round (random 600));
					};
					//Normal
					case 1:
					{
						sleep (1200+round (random 600));
					};
					//Often
					case 2:
					{
						sleep (600+round (random 600));
					};
					default
					{
						//Bug ?
					};
				};
				isHarassCurrentlyActive = false;
			};
		};
	};
};