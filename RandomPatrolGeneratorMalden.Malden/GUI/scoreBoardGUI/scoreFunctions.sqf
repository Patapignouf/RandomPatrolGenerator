//To test 
//#include "GUI\scoreBoardGUI\scoreFunctions.sqf"
//[5,"RPG_ranking_infantry_kill"] call doDisplayScore;

doDisplayScore = {
	params ["_score", "_type","_scoreParam1"];


	//Initialize custom param to avoid null reference
	if (isNil "_scoreParam1") then 
	{
		_scoreParam1 = "";
	} else 
	{
		if (typeName _scoreParam1 == "STRING") then 
		{

		} else 
		{
			_scoreParam1 = str _scoreParam1;
		};
	};

	with uiNamespace do
	{
		[_score, _type, _scoreParam1] spawn
		{
			params ["_score", "_type", "_scoreParam1"];


			_ctrl = findDisplay 46 ctrlCreate ["RscStructuredText", -1];

			_ctrl ctrlSetPosition [0,0,0,0.1];
			_ctrl ctrlCommit 0;
			_scoreText = "";
			_baseY=0.04;

			//Define position of the current score to display
			_numberOfScoreDisplay = player getVariable ["scoreDisplayNumber", 0];
			player setVariable ["scoreDisplayNumber", _numberOfScoreDisplay+1]; //Prepare next score position

			//Show specific type
			switch (_type) do
			{
				case "RPG_ranking_infantry_kill":
				{
					_scoreText = "Infantry kill";
				};
				case "RPG_ranking_vehicle_kill":
				{
					_scoreText = "Vehicle kill";
				};
				case "RPG_ranking_suppress":
				{
					_scoreText = "Enemy suppress";
				};
				case "RPG_ranking_heal":
				{
					_scoreText = "Heal";
				};
				case "RPG_ranking_repair":
				{
					_scoreText = "Repair";
				};
				case "RPG_ied_defuse":
				{
					_scoreText = "IED Defuse";
				};
				case "RPG_ranking_intel_collect":
				{
					_scoreText = "Intel Collect";
				};
				case "RPG_ranking_objective_complete":
				{
					_scoreText = "Objective";
				};
				case "RPG_ranking_player_death":
				{
					_scoreText = "Penalty";
				};
				default
				{
					
				};
			};
			
			//Don't show text if XP type is not supported
			if (_scoreText != "") then 
			{
				_ctrl ctrlSetStructuredText parseText format ["<t color='#00ff00' size='1.2'>+ %1 </t><t color='#FFFFFF' size='1.3'>%2</t>", _score, _scoreText];
			};
			if (_type == "RPG_ranking_player_death") then 
			{
				_ctrl ctrlSetStructuredText parseText format ["<t color='#ff0000' size='1.3'> %1 </t><t color='#FFFFFF' size='1.3'>%2</t>", _score, _scoreText];
			};
			if (_type == "RPG_ranking_infantry_kill" && _scoreParam1 != "") then 
			{
				_ctrl ctrlSetStructuredText parseText format ["<t color='#00ff00' size='1.3'>+ %1 </t><t color='#FFFFFF' size='1.3'>%2  %3m</t>", _score, _scoreText, _scoreParam1];
			};

			_ctrl ctrlSetPosition [0.6, 0.4+_baseY*_numberOfScoreDisplay, ctrlTextWidth _ctrl, 0.1];
			_ctrl ctrlCommit 0;

			waitUntil {ctrlCommitted _ctrl};
			uiSleep 2.5;

			_numberOfScoreDisplay = player getVariable ["scoreDisplayNumber", 0];
			player setVariable ["scoreDisplayNumber", (_numberOfScoreDisplay-1) max 0];

			ctrlDelete _ctrl;
		};
	};
};