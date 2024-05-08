class PlayerLoadoutSetup
{
	idd = 7000;
	class ControlsBackground
	{
		class Background: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.117436 * safezoneH + safezoneY;
			w = 45 * GUI_GRID_CENTER_W;
			h = 19 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.5,0.5,0.5,0.8};
		};

		class Background2: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.117436 * safezoneH + safezoneY;
			w = 45 * GUI_GRID_CENTER_W;
			h = 1.5 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,0,0,1};
		};
	};
	class Controls
	{
		//Close button
		class CloseButton: RscButton
		{
			idc = 7200;
			text = "Close";
			x = GUI_GRID_CENTER_X + 15 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 10 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};

		//Arsenal button
		class ArsenalButton: RscButton
		{
			idc = 7201;
			text = "Arsenal";
			x = GUI_GRID_CENTER_X + 25 * GUI_GRID_CENTER_W;
			y = 0.25 * safezoneH + safezoneY;
			w = 10 * GUI_GRID_CENTER_W;
			h = 0.0219952 * safezoneH;
		};

		//Title of GUI
		class RscText_7001: RscText
		{
			idc = 7001;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Player Loadout Setup"; //--- ToDo: Localize;
			x = 0.459686 * safezoneW + safezoneX;
			y = 0.017436 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		//Save button
		class SaveButton: RscButton
		{
			idc = 7202;
			text = "Save loadout";
			x = GUI_GRID_CENTER_X + 5 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};

		//Load button
		class LoadButton: RscButton
		{
			idc = 7203;
			text = "Load loadout";
			x = GUI_GRID_CENTER_X + 25 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};

		//Clear button
		class ClearItemsButton: RscButton
		{
			idc = 7204;
			text = "Clear items";
			x = 0.701406 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 5 * GUI_GRID_CENTER_W;
			h = 0.0219952 * safezoneH;
		};


		//Clear button
		class 3DForceOpticsButton: RscButton
		{
			idc = 7205;
			text = "3D for CUP Optics";
			x = 0.701406 * safezoneW + safezoneX;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 5 * GUI_GRID_CENTER_W;
			h = 0.0219952 * safezoneH;
		};

		//Rank button
		class RankButton: RscButton
		{
			idc = 7206;
			text = "Show rank";
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = 0.18 * safezoneH + safezoneY;
			w = 5 * GUI_GRID_CENTER_W;
			h = 0.0219952 * safezoneH;
		};		
		
		//Name of player
		class RscText_7002: RscText
		{
			idc = 7002;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "PlayerName"; //--- ToDo: Localize;
			x = GUI_GRID_CENTER_X + 15 * GUI_GRID_CENTER_W;
			y = 0.07 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		//Load default button
		class LoadDefaultButton: RscButton
		{
			idc = 7207;
			text = "Load default";
			x = GUI_GRID_CENTER_X + 15 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 8 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};

		////////////////////
		//Faction settings//
		////////////////////

		//War Era select
		class RscText_7006: RscText
		{
			idc = 7006;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Class selection"; //--- ToDo: Localize;
			x = 0.26 * safezoneW + safezoneX;
			y = 0.11 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		class RscCombo_7104: RscCombo
		{
			idc = 7100;
			text = "Class selection"; //--- ToDo: Localize;
			x = 0.271406 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
	};
};
