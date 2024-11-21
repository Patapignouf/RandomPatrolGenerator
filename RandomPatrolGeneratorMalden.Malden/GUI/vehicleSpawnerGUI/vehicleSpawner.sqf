params ["_VehicleAvalaibleSpawn","_UnarmedVehicle","_ArmedVehicle","_ArmoredVehicle","_UnarmedVehicleChopper","_ArmedChopper","_Drone","_FixedWing","_Boat"];
disableSerialization;

//Create GUI
createDialog "vehicleSpawner";
["onLoad", (findDisplay 50000), _VehicleAvalaibleSpawn, _UnarmedVehicle, _ArmedVehicle, _ArmoredVehicle, _UnarmedVehicleChopper, _ArmedChopper, _Drone, _FixedWing, _Boat] execVM 'GUI\vehicleSpawnerGUI\loadVehicleSpawner.sqf';