
class DialogSetupParams
{
	idd = 6000;
	class ControlsBackground
	{
		class Background: RscText
		{
			idc = -1;
			x = GUI_GRID_CENTER_X;
			y = GUI_GRID_CENTER_Y;
			w = 40 * GUI_GRID_CENTER_W;
			h = 25 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,0.5};
		};
	};
	class Controls
	{
		//Validate button
		class ClickMe: RscButton
		{
			idc = 6200;
			text = "Generate Patrol";
			onButtonClick = "[_this] execVM 'GUI\startGUIMenu.sqf';";
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
			y = 0.117436 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
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
