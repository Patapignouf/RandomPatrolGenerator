if (isServer) then 
{
	//Wait mission to start
	sleep 300;

	while {sleep (random 300); true; missionNameSpace getVariable ["enableAmbiantArtillery", 0] == 1} do {


		//Determine position
		_basePosition = getPos (selectRandom AllPlayers);

		_position = [[[_basePosition, 400]], [[_basePosition, 70]]] call BIS_fnc_randomPos;

		// //Hint to artillery call
		// [[_position], {params ["_position"]; ["STR_RPG_HC_NAME", "STR_RPG_HC_ARTILLERY", mapGridPosition _position] call doDialog}] remoteExec ["spawn", blufor]; 

		// //Play random radio sound
		// [] spawn {
		// 	playMusic ["RadioAmbient5", 1];
		// 	sleep 4;
		// 	playMusic "";
		// };

		//Simulate waiting for shots
		sleep (3 + random 2);

		//Call random shots waves
		for [{_i = 0}, {_i < 2}, {_i = _i + 1}] do
		{
			[_position] spawn {
				params ["_position"];
				sleep (random 4);
				[_position, "Sh_82mm_AMOS", 15, 1, 5, { false}, 0, 500, 5] spawn BIS_fnc_fireSupportVirtual;
			};
		};
	};
};


//To test
//[] execVM 'engine\doAmbiantArtillery.sqf';
