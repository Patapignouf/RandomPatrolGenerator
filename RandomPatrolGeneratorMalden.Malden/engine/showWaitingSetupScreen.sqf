//Show loading message
[] spawn {
	_randomPos = [nil, ["water"]] call BIS_fnc_randomPos;
	_randomPos set [2,_randomPos#2+100];
	_camera = "camera" camCreate (_randomPos);
	_camera cameraEffect ["Internal", "back"];

	while {isNil "missionGenerated"} do 
	{
		//Disable player drowning
		player setOxygenRemaining 100;

		//Show loading screen
		_camera camPrepareTarget ([[[_randomPos, 200]], []] call BIS_fnc_randomPos);
		_randomPos = [nil, ["water"]] call BIS_fnc_randomPos;
		_randomPos set [2,_randomPos#2+100];
		_camera camPreparePos (_randomPos);
		_camera camPreload 3;
		_camera camCommitPrepared 400;
		[format ["<t size='1.2'>Please wait while mission is generating</t><br/><t size='1.1'>%2</t><br/><br/><img size=8 align='bottom' valign='bottom' image='%1'/>", format ["a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_%1_co.paa",selectRandom [16,59,118,106,98,62,76,93,75,64,122,87,70,14,104,108,111,123,20,92,63,41,65,68,22,91,72,30,31,80,32,47,27,18,46,121]], missionNameSpace getVariable ["missionSetupMessage", ""]],0,0,10,0.5,0,0] spawn BIS_fnc_dynamicText;
		//cutText [format ["<t size='1.2'>Please wait while mission is generating</t><br/><t size='1.1'>%2</t><br/><br/><img size=20 align='bottom' valign='bottom' image='%1'/>", format ["a3\missions_f_aow\data\img\artwork\landscape\showcase_aow_picture_%1_co.paa",selectRandom [16,59,118,106,98,62,76,93,75,64,122,87,70,14,104,108,111,123,20,92,63,41,65,68,22,91,72,30,31,80,32,47,27,18,46,121]], missionNameSpace getVariable ["missionSetupMessage", ""]], "PLAIN", 0.5, true, true];
		uiSleep 4;

	};
	_camera cameraEffect ["terminate", "back"];
	camDestroy _camera;
};

waitUntil {!isNil "missionGenerated"};
["",0,0,10,0.5,0,0] spawn BIS_fnc_dynamicText;