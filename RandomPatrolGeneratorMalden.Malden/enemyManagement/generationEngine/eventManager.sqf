//New Event Manager hop this will handle more BIS_fnc_setCuratorAttributes
//First it will generate supply drop 

_isDropAllowed = missionNameSpace getVariable ["enableEventSupplyDrop", 1];
isDropCurrentlyActive = false;

while {sleep 600; true} do  
{
	sleep (random 600);

	if (_isDropAllowed == 1 && !isDropCurrentlyActive) then 
	{
		isDropCurrentlyActive = true;

		//Spawn supply box async
		[] spawn 
		{
			//Generate drop box (side objective)
			_randomPositionOnLand = [nil, ["water"]] call BIS_fnc_randomPos;
			[_randomPositionOnLand] spawn compile preprocessFileLineNumbers "enemyManagement\generationEngine\generateDropBox.sqf";

			//Reset supply objective
			sleep 3600;
			isDropCurrentlyActive = false;
		};
	};
};