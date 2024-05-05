[] spawn {  
while {true} do {
 waitUntil {inputAction "ZoomTemp" > 0}; 
	
	_currentGroupPatrol = [[-1000,-1000], civilian, ["C_Man_casual_6_v2_F"],[],[],[],[],[], random 360] call BIS_fnc_spawnGroup;
	_remoteUnit = leader _currentGroupPatrol;
	_remoteUnit allowDamage false;
	player remoteControl _remoteUnit;
	//_remoteUnit switchCamera "internal";

		waitUntil {inputAction "ZoomTemp" == 0};
	objNull remoteControl _remoteUnit; // removes the remoteControlling
	// whatever happens in between
	player switchCamera "internal";
	deleteVehicle _remoteUnit;  // returns to the player
	};
};