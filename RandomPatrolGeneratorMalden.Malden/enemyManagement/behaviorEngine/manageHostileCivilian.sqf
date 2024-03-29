//Get parameters
params ["_thisUnit"];

//Loop on the unit until it become hostile
while {alive _thisUnit && (side _thisUnit == civilian)} do {
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
		//10% chance to become hostile
		if (random 100 < 10) then 
		{
			//Randomize time before becoming hostile	
			sleep (10 + random (120));

			//RemoveAll specific stuff from this civilian
			[_thisUnit] remoteExec ["removeAllEventHandlers", 0, true];
			_thisUnit removeAllMPEventHandlers "mpkilled"; 
			_thisUnit removeAllEventHandlers "Killed";
			[_thisUnit] remoteExec ["removeAllActions", 0, true];
			_thisUnit switchMove "";
			
			//Join enemy group
			_tempGroup = createGroup east;
			[_thisUnit] joinSilent _tempGroup;

			//If lambs is enabled, disable unit task
			if (isClass (configFile >> "CfgPatches" >> "lambs_danger")) then 
			{
				[_tempGroup] call lambs_wp_fnc_taskReset; //reset current task
			};
			
			//Manage loadout
			_thisUnit addVest "V_BandollierB_rgr";
			_thisUnit addWeapon "hgun_Rook40_F"; //Inspire by DRO waiting for RPG version ;)
			_thisUnit addMagazines ["16Rnd_9x21_Mag", 3];
		};
	};
};