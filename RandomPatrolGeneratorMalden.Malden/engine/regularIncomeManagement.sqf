_timeToSleep = missionNamespace getVariable "missionRespawnParam";

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