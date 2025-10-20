// //Close admin menu
// _mainDisplay = (findDisplay 60000);
// _mainDisplay closeDisplay 1;

//Setup weather 
0 setOvercast (random 1); 
0 SetRain (random 1);  
0 SetLightnings (random 1);  
//86400 SetFog (random 1);  
0 SetWaves (random 1); 
skipTime 24; 
0 setOvercast (random 1); 
0 SetRain (random 1);  
0 SetLightnings (random 1);  
//86400 SetFog (random 1);  
0 SetWaves (random 1); 
skipTime -24;

forceWeatherChange;