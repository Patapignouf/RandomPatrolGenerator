params ["_caller", "_locationToAttack", "_side"];

_AvalaibleInitAttackPositions = [_locationToAttack, 800, 1300, 3] call getListOfPositionsAroundTarget;
_AvalaibleInitAttackPositionsToMove = selectRandom _AvalaibleInitAttackPositions;
_attackSquad = createGroup (_side);
_missionDifficulty = missionNamespace getVariable ["missionDifficultyParam", 1];
for [{_i = 0}, {_i < 5}, {_i = _i + 1}] do
{
	//Spawn bot
	_currentFaction = 0;
	if (side _caller == independent) then 
	{
		//Independent
		_currentFaction = indFaction;

	} else 
	{
		//Blufor
		_currentFaction = bluFaction;
	};


	private _bot = [_caller, _currentFaction, "random", "Infantry"] call doAddBot;

	//If successfull bot spawn
	if (!isNull _bot) then 
	{
		[_bot] joinSilent _attackSquad; 

		//Move bot near attack position  
		_bot setPos ([_AvalaibleInitAttackPositionsToMove, 1, 10, 3, 0, 20, 0] call BIS_fnc_findSafePos);

		//Clean bot
		[_bot] spawn 
		{	
			params ["_bot"];

			//Delete bot the optimize server after 30 minutes
			sleep 2500;
			deleteVehicle _bot;
		};
	};
};
// ask squad to attack position 
[_attackSquad, _locationToAttack] execVM 'enemyManagement\behaviorEngine\doAttack.sqf';