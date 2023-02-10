
class DialogCivilian
{
	idd = 10000;
	class ControlsBackground
	{
		class Background: RscText
		{
			idc = -1;
			x = 0.229686 * safezoneW + safezoneX;
			y = 0.617436 * safezoneH + safezoneY;
			w = 45 * GUI_GRID_CENTER_W;
			h = 15 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,1,0.9};
		};
	};
	class Controls
	{
		
		//Close button
		class CloseButton: RscButton
		{
			idc = 10200;
			text = "Close";
			x = GUI_GRID_CENTER_X + 15 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 30 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
	};
};
