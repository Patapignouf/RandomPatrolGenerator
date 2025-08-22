params ["_target"];

if((!isNull _target) && {alive _target} && {count crew _target == 0} && {_target isKindOf 'Landvehicle' || _target isKindOf 'Air' || _target isKindOf 'Ship'})then {
	_target setVectorUp [0, 0, 1];
	['Flipped vehicle!',0,0.7,2,0] spawn bis_fnc_dynamictext;
} else 
{
	['Vehicle must be empty and OK',0,0.7,2,0] spawn bis_fnc_dynamictext;
};


//script from https://epochmod.com/forum/topic/45028-vehicle-flip/
//With little modifications