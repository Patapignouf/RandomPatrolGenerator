//Close admin menu
_mainDisplay = (findDisplay 60000);
_mainDisplay closeDisplay 1;

//Clear weather without transition
0 setOvercast 0;
0 setRain 0;
forceWeatherChange;

//Force no rain for a long time
999999 setRain 0;