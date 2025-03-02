params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];

//Log player's death
diag_log format ["Player %1 is dead", name player];


//reset respawn timer
if (missionNameSpace getVariable ["enableSelfRespawnTimer", 0] == 0) then 
{
	//No self respawn timer (directed by the server)
	setPlayerRespawnTime 99999999;
	addMissionEventHandler ["EachFrame",
		{
			if (!alive player) then 
			{
				_currentRespawnTimer = missionNamespace getVariable "missionRespawnParam";
				_currentCounter = _currentRespawnTimer - (round (serverTime) % _currentRespawnTimer);
				hintSilent format["Respawn : %1", [(_currentCounter/60)+.01,"HH:MM"] call BIS_fnc_timetostring]
			};
		}
	];

} else 
{
	_respawnTimer = missionNamespace getVariable "missionRespawnParam";
	setPlayerRespawnTime (_respawnTimer);
	_initialCountDown = [_respawnTimer, false] call BIS_fnc_countDown;
	addMissionEventHandler ["EachFrame",
		{
			if (!alive player) then 
			{
				hintSilent format["Respawn : %1", [(([0, false] call BIS_fnc_countdown)/60)+.01,"HH:MM"] call BIS_fnc_timetostring]
			};
		}
	];
};


//Update dead counter 
player setVariable ["deathNumber", (player getVariable ["deathNumber", 0])+1, true];

//Add experience penalty on death
[{[-10, 1] call doUpdateRankWithPenalty}] remoteExec ["call", player];

//Add player to a dead player base | This will block disconnection/connection method to respawn 
_deadPlayerList = missionNamespace getVariable "deadPlayer";
_deadPlayerList pushBack (name player);
missionNamespace setVariable ["deadPlayer", _deadPlayerList, true];

//Start spectator mod only ally players
["Terminate"] call BIS_fnc_EGSpectator;
["Initialize", [player, [playerSide] , true, false ]] call BIS_fnc_EGSpectator;

if (isMultiplayer) then 
{
	if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
		[player, true] call TFAR_fnc_forceSpectator;
		player setVariable ["tf_voiceVolume",1,true];
	};
};

//Wait before display respawn advices
//reset respawn timer
if (missionNameSpace getVariable ["enableSelfRespawnTimer", 0] == 1) then 
{
	[_respawnTimer] spawn 
	{
		params ["_respawnTimer"];

		uiSleep 20;

		//Show information about respawn settings
		_title = "You will respawn on one of these conditions : ";
		_textToSpeech = format ["<br /> - Wait %1 seconds <br /> - Wait for a call reinforcement from your allies<br /> - Wait for an objective accomplishment",  _respawnTimer];
		titleText [format ["<t align = 'center' shadow = '2' color='#0046ff' size='1.5' font='PuristaMedium' >System</t><br /><t color='#ffffff' size='1.5' font='PuristaMedium' shadow = '2' >%1<t align = 'center'>%2</t></t>", _title, _textToSpeech], "PLAIN DOWN", -1, true, true];
	};
};
