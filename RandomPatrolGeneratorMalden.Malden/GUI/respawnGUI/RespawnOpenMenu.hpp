class RscTitles {
    class TAG_RscHealPrompt {
        idd = 8000;
        duration = 10;
        fadeIn = 0.1;
        fadeOut = 0.3;
        onLoad = "uiNamespace setVariable ['TAG_HealPrompt_Display', _this select 0];";

        class controls {
            class TAG_Background: RscText {
                idc = 8000;
                // Centré horizontalement : safezoneX + (0.5 * safezoneW) - (moitié de la largeur)
                x = 0.43 * safezoneW + safezoneX; 
                // En bas : safezoneY + safezoneH - (hauteur + marge)
                y = 0.90 * safezoneH + safezoneY; 
                w = 0.14 * safezoneW;
                h = 0.06 * safezoneH;
                backgroundColor[] = {0.1, 0.1, 0.1, 0.8};
            };
            
            class TAG_TextLabel: RscStructuredText {
                idc = 8001; 
                text = "<t align='center' size='1.1' font='RobotoCondensedBold' color='#00E676'>Respawn Menu</t><br/><t align='center' size='0.8'>Change class and more</t>";
                // Légèrement décalé par rapport au fond pour créer une marge interne
                x = 0.435 * safezoneW + safezoneX;
                y = 0.905 * safezoneH + safezoneY;
                w = 0.13 * safezoneW;
                h = 0.05 * safezoneH;
                
                onMouseEnter = "((_this select 0) displayCtrl 8000) ctrlSetBackgroundColor [0.2, 0.6, 0.2, 0.9];";
                onMouseExit = "((_this select 0) displayCtrl 8000) ctrlSetBackgroundColor [0.1, 0.1, 0.1, 0.8];";
            };
        };
    };
    class TAG_RscPunishPrompt {
        idd = 9000;
        duration = 10;
        fadeIn = 0.1;
        fadeOut = 0.3;
        onLoad = "uiNamespace setVariable ['TAG_PunishPrompt_Display', _this select 0];";

        class controls {
            class TAG_Background: RscText {
                idc = 9000;
                // Centré horizontalement : safezoneX + (0.5 * safezoneW) - (moitié de la largeur)
                x = 0.43 * safezoneW + safezoneX; 
                // En bas : safezoneY + safezoneH - (hauteur + marge)
                y = 0.90 * safezoneH + safezoneY; 
                w = 0.14 * safezoneW;
                h = 0.06 * safezoneH;
                backgroundColor[] = {0.1, 0.1, 0.1, 0.8};
            };
            
            class TAG_TextLabel: RscStructuredText {
                idc = 9001; 
                text = "<t align='center' size='1.1' font='RobotoCondensedBold' color='#00E676'>Click here to punish</t><br/><t align='center' size='0.8'>Change class and more</t>";
                // Légèrement décalé par rapport au fond pour créer une marge interne
                x = 0.435 * safezoneW + safezoneX;
                y = 0.500 * safezoneH + safezoneY;
                w = 0.13 * safezoneW;
                h = 0.05 * safezoneH;
                
                onMouseEnter = "((_this select 0) displayCtrl 8000) ctrlSetBackgroundColor [0.2, 0.6, 0.2, 0.9];";
                onMouseExit = "((_this select 0) displayCtrl 8000) ctrlSetBackgroundColor [0.1, 0.1, 0.1, 0.8];";
            };
        };
    };
};