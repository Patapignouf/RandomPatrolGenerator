// //Close admin menu
_mainDisplay = (findDisplay 60000);
_mainDisplay closeDisplay 1;

//Setup weather
0 setOvercast 1;  
0 SetRain 0;  
0 SetLightnings 1;  
skipTime 24;
forceWeatherChange;

999999 SetRain 0;
999999 SetLightnings 1;   
skipTime -24;

