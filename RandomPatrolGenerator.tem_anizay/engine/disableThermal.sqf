// Thermal goggles management
addMissionEventHandler ["Draw3D",  
{  
 if (currentVisionMode player isEqualTo 2) then  
 {  
  if ((!(currentweapon player in ["CUP_launch_Javelin","launch_I_Titan_short_F","launch_O_Titan_short_F","launch_B_Titan_short_F","launch_Titan_short_F","launch_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_F"])||(cameraView != "GUNNER")) && (player == vehicle player)) then 
  { 
   if (isNil "A3W_thermalOffline") then  
   {  
	"A3W_thermalOffline" cutText ["THERMAL IMAGING OFFLINE", "BLACK", 0.001, false];  
	A3W_thermalOffline = true;  
   };  
  }; 
 } 
 else  
 {  
  if (!isNil "A3W_thermalOffline") then  
  {  
   "A3W_thermalOffline" cutText ["", "PLAIN", 0.001, false];  
   A3W_thermalOffline = nil;  
  };  
 }; 
}];
