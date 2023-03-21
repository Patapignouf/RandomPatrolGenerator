class playerRespawnMenu
{
	idd = 8000;
	class ControlsBackground
	{
		class Background: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.117436 * safezoneH + safezoneY;
			w = 45 * GUI_GRID_CENTER_W;
			h = 15 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.5,0.5,0.5,0.8};
		};

		class Background2: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.117436 * safezoneH + safezoneY;
			w = 45 * GUI_GRID_CENTER_W;
			h = 1.5 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.5,0.5,0.5,1};
		};
	};
	class Controls
	{
		//Title of GUI
		class RscText_8001: RscText
		{
			idc = 8001;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Respawn menu"; //--- ToDo: Localize;
			x = 0.459686 * safezoneW + safezoneX;
			y = 0.017436 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		//Start respawn button
		class RespawnOnStart: RscButton
		{
			idc = 8200;
			text = "Respawn at start position";
			x = GUI_GRID_CENTER_X + 5 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};

		//Leader respawn button
		class RespawnOnLeader: RscButton
		{
			idc = 8201;
			text = "Respawn on team leader";
			x = GUI_GRID_CENTER_X + 25 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
	};
};
