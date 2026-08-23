  ______________________________________
 |	        			|
 |	      P H R O N K ' S		|
 |	     F U R N I T U R E		|
 |					|
 |		BY: PHRONK		|
 |	       				| v0.7		20JUN2021
_|______________________________________|_______________________
[ D E S C R I P T I O N ]					|
-----------------------						|
Script to dynamically spawn furniture in houses around players. |
								|
								|
								|
[ F E A T U R E S ]						|
-------------------------					|
• No mods required!						|
								|
• No DLCs required!						|
								|
• Compatible with any map which uses buildings from:		|
	- Altis							|
	- Livonia						|
	- Malden						|
	- Stratis						|
	- Tanoa							|
								|
• Compatible with single-player, client-host, and dedicated	|
								|
• Spawns furniture in houses when player is close enough	|
								|
• Furniture layouts are made with AI pathing/buildingPos in mind|
								|
• Despawns furniture when player leaves the house's range	|
								|
• Includes an EASY to configure script file 	("CFG.sqf")	|
								|
________________________________________________________________|_______________________
[ C H A N G E - L O G ]									|
-------------------------								|
• Added: New server-side looping script 'clean.sqf'					|
• Added: Persistent furniture layouts (WIP)						|
• Added: New setting in 'CFG.sqf' to adjust furniture activation range			|
• Added: New furniture layouts for Altis, Malden, and Stratis: (8)			|
	• Land_Cargo_Patrol_V1_F							|
	• Land_Cargo_Patrol_V2_F							|
	• Land_Cargo_Patrol_V3_F							|
	• Land_Cargo_Patrol_V4_F							|
	• Land_GuardHouse_01_F								|
	• Land_i_Shed_Ind_03_F								|
	• Land_i_Shed_Ind_F								|
	• Land_FuelStation_01_workshop_F						|
• Added: New furniture layouts for Tanoa: (4)						|
	• Land_FuelStation_01_shop_F							|
	• Land_Shed_01_F								|
	• Land_House_Native_01_F							|
	• Land_House_Native_02_F							|
• Added: New furniture layouts for Livonia: (21)					|
	• Land_House_1W01_F								|
	• Land_House_1W02_F								|
	• Land_House_1W03_F								|
	• Land_House_1W04_F								|
	• Land_House_1W05_F								|
	• Land_House_1W06_F								|
	• Land_House_1W08_F								|
	• Land_House_1W09_F								|
	• Land_House_1W10_F								|
	• Land_House_1W11_F								|
	• Land_House_2W02_F								|
	• Land_House_2W03_F								|
	• Land_House_2W04_F								|
	• Land_House_2B03_F								|
	• Land_House_2B04_F								|
	• Land_Barn_02_F								|
	• Land_Shed_13_F								|
	• Land_VillageStore_01_F							|
	• Land_Camp_House_01_brown_F							|
	• Land_i_Shed_Ind_old_F								|
											|
											|
• Changed: Script is completely proximity based without triggers			|
• Changed: House furniture function is called with an isNil to force scheduler		|
• Changed: PF Supported houses have a 100% chance to spawn furniture			|
• Changed: Blacklisting a specific house or an area of houses				|
• Rebuilt: Furniture layout for large office building (Land_Offices_01_V1_F)		|
• Tweaked: Height limit increased to infinite, up from 99 meters			|
• Tweaked: Players in vehicles excluded from activating PF triggers			|
• Tweaked: 'PF_Houses' variable moved to the 'init.sqf' in the PF folder		|
• Fixed: Elevation detection was slightly broken					|
• Fixed: Bug which caused furniture to spawn multiple times in houses			|
• Fixed: Sometimes PF_Houses variable wouldn't load and broke script on init		|
• Fixed: Functions were being initialized twice						|
• Fixed: Floating bed in flower shop, for Land_i_Shop_01_V1_F				|
• Fixed: Floating PC monitor in Land_Offices_01_V1_F					|
• Fixed: Desk protruding through wall in Land_i_House_Small_02_V1			|
• Fixed: Some floating objects in Land_i_House_Big_02_V1_F				|
• Fixed: '_chair13' sinking through floor in Land_i_Shop_02_V1_F - RESTAURANT		|
• Fixed: Wooden crates were blocking a buildingPos in Land_i_Shed_Ind_F			|
• Fixed: Undefined variable '_pcMon1' in Land_Offices_01_V1_F				|
• Fixed: Flickering textures on some vehicles						|
• Fixed: Hid several selections on vehicles (Lights, clan logo, etc.)			|
											|
• Optimized: Converted most furniture simpleObjects to superSimpleObjects		|
• Optimized: Replaced attachTo with setPos+modelToWorld					|
• Optimized: Code is executed server-side						|
• Optimized: Script no longer spawns helipads for every building			|
• Optimized: Replaced while{true}do with waitUntil					|
• Optimized: Code is no longer executed on duplicates in list of nearby houses		|
• Optimized: Houses collected via pushBackUnique, with arrayIntersect			|
• Optimized: Reduced number of objects spawned in layouts				|
• Optimized: getDir _b is executed only once, instead of for every object		|
• Optimized: Removed all sleeps in individual furniture scripts				|
• Optimized: Script calls furniture scripts, instead of spawning them			|
• Optimized: Code to setDir objects merged into a single forEach			|
• Optimized: PF variable is no longer a global variable					|
• Optimized: Replaced private variables in furniture functions with local ones		|
• Optimized: Replaced getPosATL _x with _x, in nearestObjects[]				|
• Optimized: Replaced private with params in some cases					|
• Optimized: Replaced select with # in some cases					|
• Optimized: Replaced a forEach within a forEach, with a count				|
• Optimized: Replaced preprocessFileLineNumbers with preprocessFile			|
• Optimized: Replaced preprocessFileLineNumbers with loadFile				|
• Optimized: Shortened some furniture variable names					|
											|
• Removed: Location-based blacklisting							|
• Removed: PF_Chance setting from 'CFG.sqf'						|
• Removed: PF_Optimize setting from 'CFG.sqf'						|
• Removed: 'PF.sqf' script								|
• Removed: #include reference in 'init.sqf'						|
• Removed: Crates from Land_i_Shed_Ind_F						|
• Removed: Unused "CUP" folder								|
• Removed: Land_i_Shop_01_V2 from list to search thru (Center pos of model is bad)	|
											|
________________________________________________________________________________________|
[ T O    D O    L I S T ]								|
-------------------------								|
• Finish support for Tanoa buildings							|
• Finish support for Livonia buildings							|
• Include support for SOG:PF buildings							|
• Create many more furniture layouts for Tanoa houses/shops				|
• Create at least 1 furniture layout for all Livonia buildings				|
• Create at least 1 furniture layout for 33 more Tanoa buildings			|
• Create at least 1 furniture layout for some of the CUP buildings			|
• Create furniture layouts for abandoned buildings					|
• Create more types of shops:								|
	• Hardware store								|
	• Grocery store									|
	• Statue / sculpture store (Pottery too)					|
	• Car dealership								|
	• Bank										|
	• Real-estate									|
	• Military recruitment office							|
	• Bar										|
	• Pressure washer stall								|
	• Stall selling gas (Barrels / canisters)					|
• Automatic support of CUP furniture objects						|
• Conduct another optimization pass (Reduce number of objects spawned)			|
• Create a client-side version								|
											|
________________________________________________________________________________________|
[ K N O W N   B U G S ]									|
-------------------------								|
 • Vectors on some objects, such as tools on pegboard, are not properly rotated		|
											|
________________________________________________________________________________________|
[ I N S T A L L A T I O N ]
-------------------------
1. Move the "PF" folder from downloaded file, to your mission	folder.
EXAMPLE: "Documents\ArmA 3 - Other Profiles\<profile>\missions\myMission.VR"



2. Copy & Paste below code into your mission's "init.sqf":

   if(isServer)then{PFrun=false;[]spawn compileFinal(preprocessFile"PF\init.sqf")};



3. Done!


[OPTIONAL] 4. The "CFG.sqf" file in the "PF" folder is the settings file.

	PF_BlacklistObj = ["land_slum_01_f"]; //List of building CLASSNAMES to avoid spawning furniture in

________________________________________________________________________
[ C R E D I T S ]							|
-------------------------						|
	Phronk: Script Creator						|
	Bohemia Interactive: Models, textures, configs, and BIS_fnc	|
									|
	[CONTRIBUTORS]							|
	1. Metalman10 [EXP]: Optimized initialization of functions	|
									|
	[SPECIAL THANKS]						|
	To the Arma 3 community "Task Force Ronin" for testing		|
									|
________________________________________________________________________|
[ C O N T A C T ]							|
-------------------------						|
Need help?  Want to report a bug?  Comments?  Send me a message on the 	|
BI forums or YouTube!							|
________________________________________________________________________|
[ D I S C L A I M E R ]							|
----------------------------						|
As author of this script, I grant permission to all scripters/mission	|
designers to modify this script to their liking for PERSONAL USE.  	|
This includes granted permission to individuals and ArmA groups to host |
a mission using the script on a server.  HOWEVER, I DO NOT consent	|
publishing ANY VERSION of the script as their own.  """"""		|
									|
If you've made major changes to the script and wish to publish it,	|
PLEASE CONTACT ME FIRST FOR PERMISSION TO BE GRANTED!			|
									|
Thank you and enjoy!							|
Phronk   (A.K.A.  Hustler)						|
________________________________________________________________________|