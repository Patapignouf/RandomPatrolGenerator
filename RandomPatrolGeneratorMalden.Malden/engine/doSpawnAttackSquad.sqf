params ["_caller", "_locationToAttack", "_side"];

_AvalaibleInitAttackPositions = [_locationToAttack, 1000, 1500, 3] call getListOfPositionsAroundTarget;
_AvalaibleInitAttackPositionsToMove = selectRandom _AvalaibleInitAttackPositions;
_attackSquad = createGroup (_side);
for [{_i = 0}, {_i < 10}, {_i = _i + 1}] do
{
	//Spawn bot
	private _bot = [_caller, "random", "Infantry"] call doAddBot;

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