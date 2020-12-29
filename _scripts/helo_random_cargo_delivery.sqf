/*****
******
	Original file: _scripts\helo_random_cargo_delivery.sqf
	Written by Araxiel
******
	You are free to modifiy and distribute this file as long as this header is kept intact
******
	Description: Spawns a Huron carrying a piece of cargo, dropping it at a nearby empty spot, and leaving again. Cargo is various logistical stuff. Returns an array containing the array of helicopters and the cargo.
******

	[[_helos],[_objects]] = [_pos,_amount,_spawn,_distance,_cargo,_potential_kind,_cargo_init,_helo_init,_vehicle_lock,_debug] execVM "_scripts\helo_random_cargo_delivery.sqf";
	Example:
	[player] execVM "_scripts\helo_random_cargo_delivery.sqf";
	[player,4,helo_spawn,70,"B_Slingload_01_Medevac_F"] execVM "_scripts\helo_random_cargo_delivery.sqf";
	[player,3,objNull,50,"",0,"","",True,True] execVM "_scripts\helo_random_cargo_delivery.sqf";
	_array = [player,4,objNull,"",2] execVM "_scripts\helo_random_cargo_delivery.sqf";

	0: _pos (Array, Object, Marker, Group, Location)  - Location something should be dropped off near at.
	// Optional Parameters
	1: _amount (Number)  		 - Amount of Hurons that should be called in. || Default: 1
	2: _spawn (Array, Object, Marker, Group, Location)  - Location the helicopters should spawn at. || If objNull is used, choses a random spot some 2500 meters away || Default: objNull
	3: _distance (Number) 	 	 - Maximum distance to look for a safe spot, IF using random spawn || Default: 50
	4: _cargo (String) 			 - Specific className of an object that should be carried. || Default: ""
	5: _potential_kind (Number)  - What type of cargo can be carried. || 0 = Everything / 1 = Only cargo / 2 = Only logistical vehicles. || Default: 0
	6: _cargo_init (String) 	 - Init code on cargo || Default: ""
	7: _helo_init (String) 	 	 - Init code on helicopter || Default: ""
	8: _vehicle_lock (Bool) 	 - Should the vehicle be locked || Default: True
	9: _debug (Bool) 	 		 - Should the vehicle be locked || Default: False

	returned:
		[[_helos],[_objects]]

******
******/

if !( isServer ) exitWith {
	//Remote execute on the server
	_this remoteExec[ _fnc_scriptName, 2];
};

private _error = false;
params [
	['_pos', objNull],
	['_amount', 1],
	['_spawn', [0,0,0]],
	['_distance', 50],
	['_cargo', ""],
	['_potential_kind', 0],
	['_cargo_init', ""],
	['_helo_init', ""],
	['_vehicle_lock', true],
	['_debug',false]
];

private ['_marker','_marker_id','_helo_array','_object_array','_return_array'];

_pos = _pos call BIS_fnc_position;
if ( _pos in [ [0,0,0], [] ] ) exitWith { "Creating Helo error: Bad position" call BIS_fnc_error };

_spawn = _spawn call BIS_fnc_position;
if ( _spawn in [ [0,0,0], [] ] ) then {
	_spawn = [[[_pos, 2500]],[[_pos, 2400]]] call BIS_fnc_randomPos;
    _marker_id = round(random 5000); 
    _marker = createMarker [format["_USER_DEFINED %1",_marker_id], _spawn]; 
    _marker setMarkerType "mil_start"; 
    _marker setMarkerColor "ColorYellow"; 
};

//_spawn set [2,300];
diag_log format["Helo Spawn at: %1",_spawn];

_boxes = [
	"B_Slingload_01_Cargo_F",
	"Land_FoodSacks_01_cargo_brown_F",
	"CargoNet_01_barrels_F",
	"CargoNet_01_box_F",
	"B_CargoNet_01_ammo_F",
	"B_Slingload_01_Medevac_F",
	"B_Slingload_01_Ammo_F",
	"B_Slingload_01_Fuel_F",
	"B_Slingload_01_Repair_F",
	"B_supplyCrate_F"
];

_boxes_weight = [
	5,	//B_Slingload_01_Cargo_F
	1,	//Land_FoodSacks_01_cargo_brown_F
	2,	//CargoNet_01_barrels_F
	3,	//CargoNet_01_box_F
	3,	//B_CargoNet_01_ammo_F
	1,	//B_Slingload_01_Medevac_F
	1,	//B_Slingload_01_Ammo_F
	1,	//B_Slingload_01_Fuel_F
	1,	//B_Slingload_01_Repair_F
	1	//B_supplyCrate_F
];

_vehicles = [
	"B_MRAP_01_F",
	"B_LSV_01_unarmed_F"
];

_vehicles_weight = [
	1,	//B_MRAP_01_F
	1	//B_LSV_01_unarmed_F
];
//return array set-up
_return_array = [];
_helo_array = [];
_object_array = [];

diag_log "-- Helo's inbound! --";
for "_i" from 0 to _amount-1 do {
	private ["_selected_cargo"];
	diag_log format["Helo #%1 creation started!",_i+1];
	//Select a safe spot nearby
	_drop = [_pos, 0, _distance, 5, 0, 0.20, 0,[], [_pos, _pos]] call BIS_fnc_findSafePos;
	//if (_drop == [worldSize / 2, worldsize / 2]) exitWith { _error = true };
	_drop pushback 0.1;
	if _debug then {
		_obj = "VR_3DSelector_01_exit_F" createVehicle _drop; // for debugging
	};
	//diag_log "Drop created!";
	
	// Create Helo
	_result = [_spawn, _spawn getDir _drop, "B_Heli_Transport_03_unarmed_F", WEST] call BIS_fnc_spawnVehicle;  
	_result params ["_vehicle", "_crew", "_group"]; 
	_result #2 deleteGroupWhenEmpty true;
	//diag_log format["Helo #%1 created!",_i+1];
	
	// Select cargo
	private _k = true;	// _k is true if boxes
	if (_cargo != "") then { _selected_cargo = _cargo} else {
		if (_potential_kind == 1) then {
			_selected_cargo = _boxes selectRandomWeighted _boxes_weight;
		};
		if (_potential_kind == 2) then {
			_selected_cargo = _vehicles selectRandomWeighted _vehicles_weight;
			_k = false;
		};
		if (_potential_kind == 0) then {
			private _r = false;
			private ['_rk','_rw'];
			_r = selectRandom [true,true,false];
			if _r then { _rk = _boxes; _rw = _boxes_weight } else { _rk = _vehicles; _rw = _vehicles_weight; _k = false };
			_selected_cargo = _rk selectRandomWeighted _rw;
		};
	};
	// Create cargo
	_cargo_obj = _selected_cargo createVehicle _spawn;
	_result #0 setSlingLoad _cargo_obj;
	if !_k then {
		if _vehicle_lock then {
			_cargo_obj lock true; 
		};
	};
	diag_log format["Cargo type for Helo #%2 selected: %1!",_selected_cargo,_i+1];

	// Waypoint
	_wp = _result #2 addWaypoint [_drop, 0];
	_wp setWaypointType "UNHOOK";
	_wp2 = _result #2 addWaypoint [_spawn, 0];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList;"];
	// move and space out spawn a little bit so no crash
	sleep (10 + round (random 10));
	_spawn set [1, _spawn #1 + 10 + random 10];
	diag_log format["New Spawn at: %1",_spawn];
	// add to array
	_helo_array pushBack _result #0;
	_object_array pushBack _cargo_obj;
};
if _error exitWith {"Creating Dopzone error: No safe position" call BIS_fnc_error};
diag_log "Helos created";
_return_array = [_helo_array, _object_array];
diag_log format["%1",_return_array];
_return_array