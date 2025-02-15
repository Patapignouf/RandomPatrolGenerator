
class DialogSetupLocationParams
{
	idd = 10000;
	class ControlsBackground
	{
		class Background: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.117436 * safezoneH + safezoneY;
			w = 55 * GUI_GRID_CENTER_W;
			h = 30 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,0.5};
		};

		class Background2: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.117436 * safezoneH + safezoneY;
			w = 55 * GUI_GRID_CENTER_W;
			h = 1.5 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.8,0.5,0,1};
		};
	};
	class Controls
	{
		
		//Title of GUI
		class RscText_6001: RscText
		{
			idc = -1;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Random Patrol Generator Location"; //--- ToDo: Localize;
			x = 0.459686 * safezoneW + safezoneX;
			y = 0.017436 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};

		//Validate button
		class ClickMe: RscButton
		{
			idc = 10200;
			text = "Next";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
	};
};
