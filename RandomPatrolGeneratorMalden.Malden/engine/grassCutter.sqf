//null=[thistrigger,50,50] execvm "cutter.sqf"
_trig = _this select 0;
_xpos = _this select 1;
_ypos = _this select 2;
_start = getpos _trig;
 
waitUntil {not(isNil "BIS_fnc_init")}; // waits until functions are ready 
for "_x" from -_xpos to  _xpos step 4 do
{
	for "_i" from -_ypos to _ypos step 4 do
		{
			_newpos = [(_start select 0) +_x,(_start select 1)+_i,0];    
			if ( [_trig, _newpos] call BIS_fnc_inTrigger) then 
			{                
				null = createVehicle ["Land_ClutterCutter_large_F",_newpos,[],0,"can_collide"]; // creates the grass cutter       
			};
		};
};


deleteVehicle _trig;