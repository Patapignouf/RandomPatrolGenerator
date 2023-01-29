
class DialogSetupObjectivesParams
{
	idd = 9000;
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
	};
	class Controls
	{
		//Validate button
		class ClickMe: RscButton
		{
			idc = 9200;
			text = "Generate Patrol";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
	};
};
