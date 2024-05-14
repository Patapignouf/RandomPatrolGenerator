
class DialogSetupParams
{
	idd = 6000;
	class ControlsBackground
	{
		class Background: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.117436 * safezoneH + safezoneY;
			w = 45 * GUI_GRID_CENTER_W;
			h = 30 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,0.5};
		};

		class Background2: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.117436 * safezoneH + safezoneY;
			w = 45 * GUI_GRID_CENTER_W;
			h = 1.5 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.2,0.2,0.2,1};
		};
	};
	class Controls
	{
		//Validate button
		class ClickMe: RscButton
		{
			idc = 6200;
			text = "Next";
			onButtonClick = "[_this] execVM 'GUI\setupGUI\startGUIMenu.sqf';";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};

		//Title of GUI
		class RscText_6001: RscText
		{
			idc = 6001;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Random Patrol Generator Setup"; //--- ToDo: Localize;
			x = 0.459686 * safezoneW + safezoneX;
			y = 0.017436 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		////////////////////
		//Faction settings//
		////////////////////

		//War Era select
		class RscText_6006: RscText
		{
			idc = 6006;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "War era selection"; //--- ToDo: Localize;
			x = 0.26 * safezoneW + safezoneX;
			y = 0.11 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6104: RscCombo
		{
			idc = 6104;
			text = "War era selection Combo"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};


		//Faction blufor select
		class RscText_6002: RscText
		{
			idc = 6002;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Blufor faction selection"; //--- ToDo: Localize;
			x = 0.26 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6100: RscCombo
		{
			idc = 6100;
			text = "Blufor faction Select Combo"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Faction opfor select
		class RscText_6003: RscText
		{
			idc = 6003;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Opfor faction selection"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.21 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6101: RscCombo
		{
			idc = 6101;
			text = "Faction Select Combo"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Faction ind select
		class RscText_6004: RscText
		{
			idc = 6004;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Independent faction selection"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6102: RscCombo
		{
			idc = 6102;
			text = "Faction Select Combo"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.40 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Faction civ select
		class RscText_6005: RscText
		{
			idc = 6005;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Civilian faction selection"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6103: RscCombo
		{
			idc = 6103;
			text = "Faction Select Combo"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};


		//IronMan  select
		class RscText_6012: RscText
		{
			idc = 6012;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Ironman mode"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6110: RscCombo
		{
			idc = 6110;
			text = "Ironman Select Combo"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.50 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Reespawn param  select
		class RscText_6016: RscText
		{
			idc = -1;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Respawn"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.41 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};
		
		class RscCombo_6116: RscCombo
		{
			idc = 6114;
			text = "Respawn param"; //--- ToDo: Localize;
			x = 0.261406 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};


		////////////////////
		//Mission settings//
		////////////////////

		//Enable armed aicraft select
		class RscText_6007: RscText
		{
			idc = 6007;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Enable armed aicraft"; //--- ToDo: Localize;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.11 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6105: RscCombo
		{
			idc = 6105;
			text = "Enable armed aicraft Combo"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};


		//Enable armored vehicle select
		class RscText_6008: RscText
		{
			idc = 6008;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Enable armored vehicle selection"; //--- ToDo: Localize;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6106: RscCombo
		{
			idc = 6106;
			text = "Enable armored vehicle Select Combo"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Enable campaign select
		class RscText_6009: RscText
		{
			idc = 6009;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Enable campaign mode"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.21 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6107: RscCombo
		{
			idc = 6107;
			text = "Enable campaign Combo"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Mission length select
		class RscText_6010: RscText
		{
			idc = 6010;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Mission length"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6108: RscCombo
		{
			idc = 6108;
			text = "Mission length Combo"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.40 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Mission difficutly select
		class RscText_6011: RscText
		{
			idc = 6011;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Number of opfor"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.31 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6109: RscCombo
		{
			idc = 6109;
			text = "Mission difficutly Combo"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.45 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Starting intel
		class RscText_6013: RscText
		{
			idc = -1;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Starting intel"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6112: RscCombo
		{
			idc = 6112;
			text = "Starting intel Combo"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.50 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};

		//Starting AI Difficulty
		class RscText_6014: RscText
		{
			idc = -1;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "AI Skills"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.41 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_6115: RscCombo
		{
			idc = 6113;
			text = "AI Skills"; //--- ToDo: Localize;
			x = 0.551406 * safezoneW + safezoneX;
			y = 0.55 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
	};

};

/* #Qydyne
$[
	1.063,
	["Test",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1001,"",[2,"Test1",["1.15 * GUI_GRID_W + GUI_GRID_X","3.27 * GUI_GRID_H + GUI_GRID_Y","12 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"",[2,"Test1C",["1.39 * GUI_GRID_W + GUI_GRID_X","4.73 * GUI_GRID_H + GUI_GRID_Y","10.5 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[2,"Titre",["13.5 * GUI_GRID_W + GUI_GRID_X","1 * GUI_GRID_H + GUI_GRID_Y","14 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[2,"ButtonVal",["27.97 * GUI_GRID_W + GUI_GRID_X","21.78 * GUI_GRID_H + GUI_GRID_Y","11 * GUI_GRID_W","2 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[2,"Test2",["1 * GUI_GRID_W + GUI_GRID_X","7 * GUI_GRID_H + GUI_GRID_Y","12 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2101,"",[2,"Test2C",["1.5 * GUI_GRID_W + GUI_GRID_X","8.5 * GUI_GRID_H + GUI_GRID_Y","10.5 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
