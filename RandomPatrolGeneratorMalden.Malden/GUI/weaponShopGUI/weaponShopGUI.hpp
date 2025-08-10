class weaponShopGUI
{
	idd = 60000;
	class controlsBackground
	{
		class back: RscText
		{
			colorBackground[] = {0,0,0,0.8};
			x = -16.5 * GUI_GRID_W + 0.5;
			y = -6.5 * GUI_GRID_H + 0.5;
			w = 33 * GUI_GRID_W;
			h = 15.5 * GUI_GRID_H;
		};
		class title: RscStructuredText
		{
			idc = 59999;
			text = "STR_GUI_BASE_TITLE"; //--- ToDo: Localize;
			colorBackground[]={0.8,0.5,0,1};
			x = -16.5 * GUI_GRID_W + 0.5;
			y = -7.6 * GUI_GRID_H + 0.5;
			w = 33 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
	class controls
	{
		#define W_LNB (32 * GUI_GRID_W)
		class lnbEntries: RscListNBox
		{
			idc = 60002;
			columns[] = {0, 1.5/6, 3.5/6, 5/6};
			x = -16 * GUI_GRID_W + 0.5;
			y = -5 * GUI_GRID_H + 0.5;
			w = W_LNB;
			h = 12 * GUI_GRID_H;
			rowHeight = 0.10; 
		};
		class grpSortBtns: RscControlsGroup
		{
			idc = 602300;
			x = -16 * GUI_GRID_W + 0.5;
			y = -6 * GUI_GRID_H + 0.5;
			w = W_LNB;
			h = 1 * GUI_GRID_H;
			class Controls
			{
				class btnSortCol0: RscButtonTextOnly
				{
					idc = 602399;
					text = "STR_GUI_BASE_ICON";
					style=ST_LEFT;
					colorFocused[]={1,1,1,0.5};
					colorFocused2[]={1,1,1,0.1};
					period=1.2;
					x = 0;
					y = 0;
					w = 2.5/6 * W_LNB;
					h = GUI_GRID_H;
				};
				class btnSortCol1: RscButtonTextOnly
				{
					idc = 602400;
					text = "STR_GUI_BASE_NAME";
					style=ST_LEFT;
					colorFocused[]={1,1,1,0.5};
					colorFocused2[]={1,1,1,0.1};
					period=1.2;
					x = 1.5/6 * W_LNB;
					y = 0;
					w = 2.5/6 * W_LNB;
					h = GUI_GRID_H;
				};
				class btnSortCol2: btnSortCol1
				{
					idc = 602401;
					text = "STR_GUI_BASE_TYPE";
					x = 3.5/6 * W_LNB;
				};
				class btnSortCol3: btnSortCol1
				{
					idc = 602402;
					text = "STR_GUI_BASE_TOKEN";
					x = 5/6 * W_LNB;
					w = 1/6 * W_LNB;
				};
			};
		};
		class btnCancel: RscButtonMenuCancel
		{
			x = 8 * GUI_GRID_W + 0.5;
			y = 7.5 * GUI_GRID_H + 0.5;
			w = 8 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class btnOK: RscButtonMenuOK
		{
			idc = 60001;
			text = "STR_GUI_BASE_UNLOCK";
			x = -16 * GUI_GRID_W + 0.5;
			y = 7.5 * GUI_GRID_H + 0.5;
			w = 8 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};