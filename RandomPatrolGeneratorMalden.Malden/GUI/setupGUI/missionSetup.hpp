class DialogSetupParams
{
    idd = 6000;
    class ControlsBackground
    {
        // Main window background
        class Background: RscText
        {
            idc = -1;
            x = 0.20 * safezoneW + safezoneX;
            y = 0.08 * safezoneH + safezoneY;
            w = 0.60 * safezoneW;
            h = 0.64 * safezoneH;
			colorBackground[] = {1,1,1,0.5};
        };

        // Upper title banner
        class Background2: RscText
        {
            idc = -1;
            x = 0.20 * safezoneW + safezoneX;
            y = 0.08 * safezoneH + safezoneY;
            w = 0.60 * safezoneW;
            h = 0.04 * safezoneH;
            colorBackground[] = {0.8, 0.5, 0, 1};
        };
    };

    class Controls
    {
        // Main GUI title
        class RscText_6001: RscText
        {
            idc = 6001;
            text = "Random Patrol Generator Setup";
            x = 0.22 * safezoneW + safezoneX;
            y = 0.085 * safezoneH + safezoneY;
            w = 0.50 * safezoneW;
            h = 0.03 * safezoneH;
            colorText[] = {1, 1, 1, 1};
            font = "PuristaBold";
            sizeEx = 0.035;
        };

        ////////////////////
        // LEFT COLUMN (Factions & Core)
        ////////////////////

        // War Era select
        class RscText_6006: RscText
        {
            idc = 6006;
            text = "War era selection";
            x = 0.23 * safezoneW + safezoneX;
            y = 0.135 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6104: RscCombo
        {
            idc = 6104;
            x = 0.23 * safezoneW + safezoneX;
            y = 0.16 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Blufor faction select
        class RscText_6002: RscText
        {
            idc = 6002;
            text = "Blufor faction selection";
            x = 0.23 * safezoneW + safezoneX;
            y = 0.195 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6100: RscCombo
        {
            idc = 6100;
            x = 0.23 * safezoneW + safezoneX;
            y = 0.22 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Opfor faction select
        class RscText_6003: RscText
        {
            idc = 6003;
            text = "Opfor faction selection";
            x = 0.23 * safezoneW + safezoneX;
            y = 0.255 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6101: RscCombo
        {
            idc = 6101;
            x = 0.23 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Independent faction select
        class RscText_6004: RscText
        {
            idc = 6004;
            text = "Independent faction selection";
            x = 0.23 * safezoneW + safezoneX;
            y = 0.315 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6102: RscCombo
        {
            idc = 6102;
            x = 0.23 * safezoneW + safezoneX;
            y = 0.34 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Civilian faction select
        class RscText_6005: RscText
        {
            idc = 6005;
            text = "Civilian faction selection";
            x = 0.23 * safezoneW + safezoneX;
            y = 0.375 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6103: RscCombo
        {
            idc = 6103;
            x = 0.23 * safezoneW + safezoneX;
            y = 0.40 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Ironman mode select
        class RscText_6012: RscText
        {
            idc = 6012;
            text = "Ironman mode";
            x = 0.23 * safezoneW + safezoneX;
            y = 0.435 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6110: RscCombo
        {
            idc = 6110;
            x = 0.23 * safezoneW + safezoneX;
            y = 0.46 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Respawn param select
        class RscText_6016: RscText
        {
            idc = -1;
            text = "Respawn";
            x = 0.23 * safezoneW + safezoneX;
            y = 0.495 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6116: RscCombo
        {
            idc = 6114;
            x = 0.23 * safezoneW + safezoneX;
            y = 0.52 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };


        ////////////////////
        // RIGHT COLUMN (Mission Settings)
        ////////////////////

        // Enable armed aircraft select
        class RscText_6007: RscText
        {
            idc = 6007;
            text = "Enable armed aircraft";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.135 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6105: RscCombo
        {
            idc = 6105;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.16 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Enable armored vehicle select
        class RscText_6008: RscText
        {
            idc = 6008;
            text = "Enable armored vehicle selection";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.195 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6106: RscCombo
        {
            idc = 6106;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.22 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Enable campaign select
        class RscText_6009: RscText
        {
            idc = 6009;
            text = "Enable campaign mode";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.255 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6107: RscCombo
        {
            idc = 6107;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Mission length select
        class RscText_6010: RscText
        {
            idc = 6010;
            text = "Mission length";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.315 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6108: RscCombo
        {
            idc = 6108;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.34 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Number of opfor select
        class RscText_6011: RscText
        {
            idc = 6011;
            text = "Number of opfor";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.375 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6109: RscCombo
        {
            idc = 6109;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.40 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // Starting intel
        class RscText_6013: RscText
        {
            idc = -1;
            text = "Starting intel";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.435 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6112: RscCombo
        {
            idc = 6112;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.46 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };

        // AI Skills
        class RscText_6014: RscText
        {
            idc = -1;
            text = "AI Skills";
            x = 0.52 * safezoneW + safezoneX;
            y = 0.495 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };
        class RscCombo_6115: RscCombo
        {
            idc = 6113;
            x = 0.52 * safezoneW + safezoneX;
            y = 0.52 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.025 * safezoneH;
        };


        ////////////////////
        // BOTTOM BUTTONS
        ////////////////////

        // Advanced Game button
        class AdvancedButton: RscButton
        {
            idc = 6201;
            text = "Game Setup";
            x = 0.23 * safezoneW + safezoneX;
            y = 0.57 * safezoneH + safezoneY;
            w = 0.11 * safezoneW;
            h = 0.03 * safezoneH;
        };

        // Advanced Opfor button
        class AdvancedOpforButton: RscButton
        {
            idc = 6202;
            text = "Opfor Setup";
            x = 0.355 * safezoneW + safezoneX;
            y = 0.57 * safezoneH + safezoneY;
            w = 0.11 * safezoneW;
            h = 0.03 * safezoneH;
        };

        // Advanced Mission button
        class AdvancedMissionButton: RscButton
        {
            idc = 6203;
            text = "Mission Setup";
            x = 0.48 * safezoneW + safezoneX;
            y = 0.57 * safezoneH + safezoneY;
            w = 0.11 * safezoneW;
            h = 0.03 * safezoneH;
        };

        // Validate button (Next)
        class ClickMe: RscButton
        {
            idc = 6200;
            text = "Next";
            onButtonClick = "normalClose = true; [true] execVM 'GUI\setupGUI\startGUIMenu.sqf';";
            x = 0.605 * safezoneW + safezoneX;
            y = 0.57 * safezoneH + safezoneY;
            w = 0.165 * safezoneW;
            h = 0.03 * safezoneH;
            colorBackground[] = {0.8, 0.5, 0, 1}; // Accent color matching the main theme for the primary button
        };
    };
};