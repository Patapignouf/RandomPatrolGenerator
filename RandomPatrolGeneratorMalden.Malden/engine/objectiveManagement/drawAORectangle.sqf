params ["_position", "_triggerArea"];

myEHParams = [_position,_triggerArea];

//Display area of operation
if (!isServer || hasInterface) then 
{
	(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{
			(_this select 0) drawRectangle [
			myEHParams#0,
			(myEHParams#1)#0,
			(myEHParams#1)#1,
			0,
			[0,0,1,1],
			""
		];
	}];
};