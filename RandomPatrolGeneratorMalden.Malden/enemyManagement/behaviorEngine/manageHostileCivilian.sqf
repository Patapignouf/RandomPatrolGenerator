//Get parameters
params ["_thisUnit", "_hostileTransformProba"];

//Loop on the unit until it become hostile
while {alive _thisUnit && (side _thisUnit == civilian) && !(_thisUnit getVariable ["ace_isHandcuffed", false])} do {
	sleep (10 + (random 30));

	//Check for nearby player units
	_entities = _thisUnit nearEntities 30;
	_targets = [];
	{
		if (side _x == blufor || side _x == independent) then {
			_targets pushBack _x;
		};
	} forEach _entities;

	//Detect if at least one player is nearby
	if (count _targets > 0) then 
	{
		//parameters % chance to become hostile
		if (random 100 < _hostileTransformProba) then 
		{
			//Randomize time before becoming hostile	
			sleep (10 + random (120));

			//RemoveAll specific stuff from this civilian
			[_thisUnit] remoteExec ["removeAllEventHandlers", 0, true];
			_thisUnit removeAllMPEventHandlers "mpkilled"; 
			_thisUnit removeAllEventHandlers "Killed";
			[_thisUnit] remoteExec ["removeAllActions", 0, true];
			[_thisUnit, ""] remoteExec ["switchMove"];
			
			//Join enemy group
			_tempGroup = createGroup east;
			[_thisUnit] joinSilent _tempGroup;

			//If lambs is enabled, disable unit task
			if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
			{
				[_tempGroup] call lambs_wp_fnc_taskReset; //reset current task
			};
			
			//Manage loadout
			//Setup date
			switch (round (random 3)) do
			{
				case 0:
				{
					_thisUnit addVest "V_BandollierB_rgr";
					_thisUnit addWeapon "hgun_Rook40_F"; //Inspire by DRO waiting for RPG version ;)
					_thisUnit addMagazines ["16Rnd_9x21_Mag", 3];
				};
				case 1:
				{
					_thisUnit addVest "V_BandollierB_rgr";
					_thisUnit addWeapon "hgun_PDW2000_F"; //Inspire by DRO waiting for RPG version ;)
					_thisUnit addMagazines ["30Rnd_9x21_Mag", 3];
				};
				case 2:
				{
					_thisUnit addVest "V_BandollierB_rgr";
					_thisUnit addWeapon "sgun_HunterShotgun_01_F"; //Inspire by DRO waiting for RPG version ;)
					_thisUnit addMagazines ["2Rnd_12Gauge_Pellets", 10];
				};
				case 3:
				{
					_thisUnit addVest "V_BandollierB_rgr";
					_thisUnit addWeapon "sgun_HunterShotgun_01_sawedoff_F"; //Inspire by DRO waiting for RPG version ;)
					_thisUnit addMagazines ["2Rnd_12Gauge_Pellets", 10];
				};
				default
				{
					//No Stuff
				};
			};

			//Add eventhandler killed
			_thisUnit addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];

				if (isPlayer _instigator) then 
				{
					[[1, "RPG_ranking_infantry_kill"], 'engine\rankManagement\rankUpdater.sqf'] remoteExec ['BIS_fnc_execVM', _instigator];
				} else {
					//Debug IA killed log
					diag_log format ["The IA %1 has been killed by %2", name _unit, name _instigator];
				}; 
				
				//Garbage collect unit  
				[_unit] spawn 
				{
					params ["_unit"];
					//Fix ACE locking place in vehicle when an IA dies
					sleep 20;
					moveOut _unit;

					//Free some memory usage by cleaning the corpse
					sleep 300;
					deleteVehicle _unit;
				};
			}];


		};
	};
};