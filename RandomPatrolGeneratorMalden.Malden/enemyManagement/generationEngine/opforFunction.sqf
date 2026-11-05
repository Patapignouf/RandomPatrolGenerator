doGenerateFOBOrDestroyer = {
	//50% chance to generate destroyer or FOB
	if (random 100 <50) then 
	{
		_destroyerProb = 100;
		if (missionNameSpace getVariable ["enableDestroyerFOB", 1] == 1) then 
		{
			_destroyerProb = 50; 
		};
		if (missionNameSpace getVariable ["enableDestroyerFOB", 1] == 2) then 
		{
			_destroyerProb = 0; 
		};

		if (random 100 < (0+_destroyerProb)) then 
		{
			[] execVM 'enemyManagement\generationEngine\generateOpforFOB.sqf';

		} else 
		{
			//Add opfor destroyer
			_resultSearchLoc =  [] call searchLocationWithWaterDepth;
			if (_resultSearchLoc#1) then 
			{
				_pos = _resultSearchLoc#0;
				if (400 < initBlueforLocation distance _pos) then //Spawn at least at 400m from blufor
				{
					[_pos] execVM 'enemyManagement\generationEngine\generateDestroyer.sqf';
				};
			};
		};	
	};
};