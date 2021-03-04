/*****
******
	Original file: _scripts\ar_fnc_heloRandomCargoDeliveryBlufor.sqf
	Written by Araxiel
******
	You are free to modifiy and distribute this file as long as this header is kept intact.
******
	Description: Spawns a Huron carrying a piece of cargo, dropping it at a nearby empty spot, and leaving again. Cargo is various logistical stuff. Returns an array containing the array of helicopters and the cargo.
******

	[[_helos],[_objects]] = [_pos,_amount,_spawn,_distance,_cargo,_potentialType,_vehicleLock,_debug] spawn ar_fnc_heloRandomCargoDeliveryBlufor;
	Example:
	[player] spawn ar_fnc_heloRandomCargoDeliveryBlufor;
	[player,4,helo_spawn,70,"B_Slingload_01_Medevac_F"] spawn ar_fnc_heloRandomCargoDeliveryBlufor;
	[player,3,objNull,50,"",0,True,True] spawn ar_fnc_heloRandomCargoDeliveryBlufor;
	_array = [player,4,objNull,"",2] spawn ar_fnc_heloRandomCargoDeliveryBlufor;

	0: _pos (Array, Object, Marker, Group, Location)  	- Location something should be dropped off near at.
	// Optional Parameters
	1: _amount (Number)  		 						- Amount of Hurons that should be called in. || Default: 1
	2: _spawn (Array, Object, Marker, Group, Location)  - Location the helicopters should spawn at. || If objNull is used, choses a random spot some 2500 meters away || Default: objNull
	3: _distance (Number) 	 	 						- Maximum distance to look for a safe spot, IF using random spawn || Default: 50
	4: _cargo (String) 			 						- Specific className of an object that should be carried. || Default: ""
	5: _potentialType (Number)  						- What type of cargo can be carried. || 0 = Everything / 1 = Only cargo / 2 = Only logistical vehicles. || Default: 0
	6: _vehicleLock (Bool) 	 							- Should the vehicle be locked || Default: True
	7: _debug (Bool) 	 								- For debugging (adds markers etc.) overwrites missionNamespace's "debugMode" value, if that exists || Default: False

	returned:
		[[_helos],[_objects]]

******
	Add script by running - execVM "_scripts\ar_fnc_heloRandomCargoDeliveryBlufor.sqf" -
******
******/
ar_fnc_heloRandomCargoDeliveryBlufor = {

if !( isServer ) exitWith {
	//Remote execute on the server
	"ar_fnc_heloRandomCargoDeliveryBlufor Warning: Not run on server" call BIS_fnc_error;
};

private _error = false;
params [
	['_pos', objNull],
	['_amount', 1],
	['_spawn', [0,0,0]],
	['_distance', 50],
	['_cargo', ""],
	['_potentialType', 0],
	['_vehicleLock', true],
	['_debug',(missionNamespace getVariable ["debugMode",false])]
];

private ['_marker','_markerId','_heloArray','_objectArray','_returnArray'];

// Security check if _pos is invalid or unassigned
_pos = _pos call BIS_fnc_position;
if ( _pos in [ [0,0,0], [] ] ) exitWith { "ar_fnc_heloRandomCargoDeliveryBlufor Error: Bad position" call BIS_fnc_error };

// if no spawnpoint is set, create random location far away
_spawn = _spawn call BIS_fnc_position;
if ( _spawn in [ [0,0,0], [] ] ) then {
	_spawn = [[[_pos, 2500]],[[_pos, 2400]]] call BIS_fnc_randomPos;
    // marker for debugging purposes
	if (_debug) then {
		_markerId = round(random 5000); 
		_marker = createMarker [format["_USER_DEFINED %1",_markerId], _spawn]; 
		_marker setMarkerType "mil_start"; 
		_marker setMarkerColor "ColorYellow"; 
	};
};

//_spawn set [2,300];
if (_debug) then { diag_log format["Helo Spawn at: %1",_spawn]; };

// potential cargo type
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

_boxesWeight = [
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

// potential vehicles
_vehicles = [
	"B_MRAP_01_F",
	"B_LSV_01_unarmed_F"
];

_vehiclesWeight = [
	1,	//B_MRAP_01_F
	1	//B_LSV_01_unarmed_F
];
//return array set-up
_returnArray = [];
_heloArray = [];
_objectArray = [];

if (_debug) then { diag_log "-- Helo's inbound! --"; };	// just a debug confirmation

for "_i" from 0 to _amount-1 do {
	private ["_selectedCargo"];

	if (_debug) then { diag_log format["Helo #%1 creation started!",_i+1]; };	// just a debug confirmation
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

	if (_cargo != "") then { _selectedCargo = _cargo} else {	// if cargo is set then skip, otherwise of potential type is selected, select a random one of that type 
		if (_potentialType == 1) then {
			_selectedCargo = _boxes selectRandomWeighted _boxesWeight;
		};
		if (_potentialType == 2) then {
			_selectedCargo = _vehicles selectRandomWeighted _vehiclesWeight;
			_k = false;
		};
		// or if neither cargo nor type is selected, go completely random
		if (_potentialType == 0) then {
			private _r = false;
			private ['_rk','_rw'];
			_r = selectRandom [true,true,false];	// make it a 2-1 likelyhood ratio for boxes-to-vehicles
			if _r then { _rk = _boxes; _rw = _boxesWeight } else { _rk = _vehicles; _rw = _vehiclesWeight; _k = false };
			_selectedCargo = _rk selectRandomWeighted _rw;
		};
	};
	// Create cargo
	_cargo_obj = _selectedCargo createVehicle _spawn;
	_result #0 setSlingLoad _cargo_obj;
	if !_k then {	// if vehicle, lock it
		if _vehicleLock then {
			_cargo_obj lock true; 
		};
	};
	if (_debug) then { diag_log format["Cargo type for Helo #%2 selected: %1!",_selectedCargo,_i+1]; };	// just a debug confirmation

	// Waypoint
	_wp = _result #2 addWaypoint [_drop, 0];
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointCombatMode "GREEN";
	_wp setWaypointType "UNHOOK";
	_wp2 = _result #2 addWaypoint [_spawn, 0];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList;"];
	// move and space out spawn a little bit so no crashing into each other
	sleep (10 + round (random 10));
	_spawn set [1, _spawn #1 + 10 + random 10];
	if (_debug) then { diag_log format["New Spawn at: %1",_spawn]; };	// just a debug confirmation
	// add to array
	_heloArray pushBack _result #0;
	_objectArray pushBack _cargo_obj;
};
//if _error exitWith {"Creating Dopzone error: No safe position" call BIS_fnc_error};
if (_debug) then { diag_log "Helos created"; };	// just a debug confirmation
_returnArray = [_heloArray, _objectArray];
if (_debug) then { diag_log format["%1",_returnArray]; };	// just a debug confirmation
_returnArray

};