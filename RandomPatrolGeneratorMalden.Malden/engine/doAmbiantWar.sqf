#include "..\GUI\botteamGUI\botteamFunctions.sqf"

if (isServer) then 
{
	_missionDifficulty = missionNamespace getVariable ["missionDifficultyParam", 1];

	while {sleep 600; true; missionNameSpace getVariable ["enableAmbiantWar", 0] == 1} do {
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
				//Spawn multiples squads
				for [{_i = 0}, {_i < _missionDifficulty}, {_i = _i + 1}] do
				{				
					[selectRandom _callers, _locationToAttack, blufor] execVM 'engine\doSpawnAttackSquad.sqf';
				};

				//Send message
				_textToSpeech = format ["A friendly squad will attack %1, could you support them ?", mapGridPosition (_locationToAttack)];
				[[format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >High Command</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1</t>", _textToSpeech], "PLAIN DOWN", -1, true, true]] remoteExec ["titleText", blufor, true];

				sleep (1200 + random 600);
			};
		};
	};
};


//To test
//[] execVM 'engine\doAmbiantWar.sqf';
