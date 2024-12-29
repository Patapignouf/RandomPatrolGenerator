if (isServer) then 
{
	_missionDifficulty = missionNamespace getVariable ["missionDifficultyParam", 1];

	while {sleep 300; true; missionNameSpace getVariable ["enableAmbiantWar", 0] == 1} do {
		_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];

		if (count  _missionUncompletedObjectives != 0 && count (allUnits select {side _x == blufor && isPlayer _x == false}) < (6*_missionDifficulty)) then 
		{
			//Spawn blufor unit
			_callers = [];
			if (missionNameSpace getVariable "sideRelations" == 0) then 
			{
				_callers = allPlayers;
			} else 
			{
				_callers = allPlayers select {side _x == blufor};
			};


			//Spawn attack squad
			if (count _callers != 0) then 
			{
				//Select a caller
				_callerForSupport = selectRandom _callers;
				
				//Select closest objective 
				_sortedMissionUncompletedObjectives = [_missionUncompletedObjectives, [], {(getPos (_x#0)) distance (getPos _callerForSupport)}, "ASCEND"] call BIS_fnc_sortBy;
				_locationToAttack = getPos (_sortedMissionUncompletedObjectives#0#0);

				//Spawn multiples squads
				for [{_iteration = 0}, {_iteration < _missionDifficulty}, {_iteration = _iteration + 1}] do
				{	
					//(format ["iteration %1, difficulty %2", _iteration, _missionDifficulty]) remoteExec ["systemChat", 0, true]; //Display message to every client
					_unitsGroup = [_callerForSupport, _locationToAttack, blufor] call  doSpawnAttackSquad;

					//Cycle missions
					[_unitsGroup] spawn 
					{
						params ["_unitsGroup"];

						sleep 600;
						while {count (units _unitsGroup) != 0} do 
						{
							_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];

							if (count _missionUncompletedObjectives != 0) then 
							{
								_sortedMissionUncompletedObjectives = [_missionUncompletedObjectives, [], {(getPos (_x#0)) distance (getPos (leader _unitsGroup))}, "ASCEND"] call BIS_fnc_sortBy;
								[_unitsGroup, getPos (_sortedMissionUncompletedObjectives#0#0)] call doAttack;
							};
							sleep 600;
						};
					};
				};

				//Send message
				[{["STR_RPG_HC_NAME", "STR_RPG_HC_FRIENDLY_SQUAD", mapGridPosition (_locationToAttack)] call doDialog}] remoteExec ["call", blufor];
				sleep (300 + random 300);
			};
		};
	};
};


//To test
//[] execVM 'engine\doAmbiantWar.sqf';
