if (isServer) then 
{
	_missionDifficulty = missionNamespace getVariable ["missionDifficultyParam", 1];

	while {sleep 300; true; missionNameSpace getVariable ["enableAmbiantWar", 0] == 1} do {
		_missionUncompletedObjectives = missionNamespace getVariable ["missionUncompletedObjectives",[]];

		if (count  _missionUncompletedObjectives != 0 && count (allUnits select {side _x == blufor && isPlayer _x == false}) < (6*_missionDifficulty)) then 
		{
			_locationToAttack = getPos ((selectRandom _missionUncompletedObjectives)#0);

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
				_callerForSupport = selectRandom _callers;
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
								//hint format ["IA Will attack %1", getPos (_sortedMissionUncompletedObjectives#0#0)];
								[_unitsGroup, getPos (_sortedMissionUncompletedObjectives#0#0)] call doAttack;
							};
							sleep 600;
						};
					};
				};

				//Send message
				_textToSpeech = format ["A friendly squad will attack %1, could you support them ?", mapGridPosition (_locationToAttack)];
				[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", blufor, true];

				sleep (300 + random 300);
			};
		};
	};
};


//To test
//[] execVM 'engine\doAmbiantWar.sqf';
