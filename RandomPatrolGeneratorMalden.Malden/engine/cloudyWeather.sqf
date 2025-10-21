// //Close admin menu
_mainDisplay = (findDisplay 60000);
_mainDisplay closeDisplay 1;

//Setup weather 
//Setup weather
0 setOvercast 0.6;  
0 SetRain 0;  
0 SetLightnings 1;  
skipTime 24;
999999 setOvercast 0.6;  
999999 SetRain 0;
999999 SetLightnings 1;   
skipTime -24;

forceWeatherChange;