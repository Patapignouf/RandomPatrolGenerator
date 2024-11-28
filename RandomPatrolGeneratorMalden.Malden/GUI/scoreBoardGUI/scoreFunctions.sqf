//To test 
//#include "GUI\scoreBoardGUI\scoreFunctions.sqf"
//[5,"RPG_ranking_infantry_kill"] call doDisplayScore;

[["RPG_ranking_infantry_kill","infantry kill"],
					["RPG_ranking_vehicle_kill","vehicle kill"],
					["deathNumber","death"],
					["RPG_ranking_suppress","suppress"],
					["RPG_ranking_heal","heal"],
					["RPG_ranking_repair","repair"],
					["RPG_ied_defuse","IED defuse"],
					["RPG_ranking_intel_collect","intel collect"],
					["RPG_ranking_objective_complete","objective complete"]
					];

doDisplayScore = {
	params ["_score", "_type"];

	with uiNamespace do
	{
		[_score, _type] spawn
		{
			params ["_score", "_type"];

			ctrl = findDisplay 46 ctrlCreate ["RscStructuredText", -1];

			ctrl ctrlSetPosition [0,0,0,0.1];
			ctrl ctrlCommit 0;
			_scoreText = "";

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
				ctrl ctrlSetStructuredText parseText format ["<t color='#00ff00' size='1.5'>+ %1 </t><t color='#FFFFFF' size='1.5'>%2</t>", _score, _scoreText];
			};
			if (_type == "RPG_ranking_player_death") then 
			{
				ctrl ctrlSetStructuredText parseText format ["<t color='#ff0000' size='1.5'> %1 </t><t color='#FFFFFF' size='1.5'>%2</t>", _score, _scoreText];
			};

			ctrl ctrlSetPosition [0.5, 0.4, ctrlTextWidth ctrl, 0.1];
			ctrl ctrlCommit 0;

			waitUntil {ctrlCommitted ctrl};
			sleep 1;

			ctrlDelete ctrl;
		};
	};
};



