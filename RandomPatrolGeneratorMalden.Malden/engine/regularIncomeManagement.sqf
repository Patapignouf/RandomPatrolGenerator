_timeToSleep = missionNamespace getVariable "missionRespawnParam";

//Add minimum of 10 mins to get income
if (_timeToSleep < 600) then 
{
	_timeToSleep = 600;
};

sleep _timeToSleep;

while {sleep _timeToSleep; !(missionNamespace getVariable ["isEndMissionRunning", false])} do 
{
	//Increment spawn credit counter Vehicle
	bluforVehicleAvalaibleSpawnCounter = missionNamespace getVariable "bluforVehicleAvalaibleSpawn";
	independentVehicleAvalaibleSpawnCounter = missionNamespace getVariable "independentVehicleAvalaibleSpawn";

	if (bluforVehicleAvalaibleSpawnCounter <500 || independentVehicleAvalaibleSpawnCounter <500) then 
	{
		[] call doIncrementVehicleSpawnCounter; 
	};
};