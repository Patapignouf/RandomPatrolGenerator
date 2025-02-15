class teamManagement
{
	idd = 70000;
	
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
			idc = 69999;
			text = "Team manager"; //--- ToDo: Localize;
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
			idc = 70002;
			columns[] = {0, 1/6, 2/6};
			x = -16 * GUI_GRID_W + 0.5;
			y = -5 * GUI_GRID_H + 0.5;
			w = W_LNB;
			h = 12 * GUI_GRID_H;
		};
		class grpSortBtns: RscControlsGroup
		{
			idc = 2300;
			x = -16 * GUI_GRID_W + 0.5;
			y = -6 * GUI_GRID_H + 0.5;
			w = W_LNB;
			h = 1 * GUI_GRID_H;
			class Controls
			{
				class btnSortCol0: RscButtonTextOnly
				{
					idc = 2399;
					text = "Icon";
					style=ST_LEFT;
					colorFocused[]={1,1,1,0.5};
					colorFocused2[]={1,1,1,0.1};
					period=1.2;
					x = 0;
					y = 0;
					w = 1/8 * W_LNB;
					h = GUI_GRID_H;
				};
				class btnSortCol1: RscButtonTextOnly
				{
					idc = 702400;
					text = "Group";
					style=ST_LEFT;
					colorFocused[]={1,1,1,0.5};
					colorFocused2[]={1,1,1,0.1};
					period=1.2;
					x = 1/6 * W_LNB;
					y = 0;
					w = 1/8 * W_LNB;
					h = GUI_GRID_H;
				};
				class btnSortCol2: btnSortCol1
				{
					idc = 702401;
					text = "Members";
					x = 2/6 * W_LNB;
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
		class btnCreate: RscButtonMenuOK
		{
			idc = 70003;
			text = "Create group";
			x = -5 * GUI_GRID_W + 0.5;
			y = 7.5 * GUI_GRID_H + 0.5;
			w = 8 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class btnOK: RscButtonMenuOK
		{
			idc = 70001;
			text = "Join group";
			x = -16 * GUI_GRID_W + 0.5;
			y = 7.5 * GUI_GRID_H + 0.5;
			w = 8 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};