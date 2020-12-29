/*****

	Script to send an order to the function make the sectors, using an object as reference.

	[_locations,_amount,_sides,_defaultOwner] execVM "_scripts\sector_maker.sqf";
	
	0: _locations (Object Array, Object)  - Location something should be dropped off near at.
	// Optional Parameters
	1: _amount (Number)  		 - Amount of sectors that should be made. Default is all. || Default: -1
	2: _trigger_area (Trigger) 	 - Trigger || Default: objNull
	3: _sides (Sides Array) 	 - Array containing the sides that can capture it. || Default: [west, east, resistance]
	4: _defaultOwner (Side) 	 - Default owner || Default: sideUnknow

	Example:
	[[loc_alpha,loc_beta],-1,[100,100,0,false],[WEST]] execVM "_scripts\sector_maker.sqf";

******/

if !( isServer ) exitWith {
	//Remote execute on the server
	_this remoteExec[ _fnc_scriptName, 2 ];
};

params [
	['_locations', objNull],
	['_amount', -1],
	['_sides', [west, east, resistance]],
	['_defaultOwner', -1, [ 0, sideUnknown ] ],
	['_trigger_area', [ 80, 80, 0, false ], [ [], objNull ] ]
];

private['_location','_locations_array','_area'];

// initializing the array
_locations_array = [];

// checking if _locations are an array or just a single location
if !("ARRAY" == typeName _locations) then {
	_locations_array set [0, _locations];
} else {
	_locations_array = _locations
};
// if amount is -1 or larger than the array (or not Scalar), make amount the entire array 
if ("SCALAR" != typeName _amount) then {
	_amount = count _locations_array;
} else {
	if (_amount == -1 or _amount >= count _locations_array) then {
		_amount = count _locations_array;
	};
};
// set's _defaultOwner to sideUnknown as a fallback
if ( _defaultOwner isEqualType sideUnknown ) then {
	if ( _defaultOwner isEqualTo sideUnknown ) then {
		_defaultOwner = -1;
	}else{
		_defaultOwner = _defaultOwner call BIS_fnc_sideID;
	};
};

//return array set-up
_sector_array = [];

for "_i" from 0 to _amount-1 do
{
	// for debugging
	diag_log format ["Starting Sector Array: %1", _locations_array];
	// select a random element from the array
	_location = selectRandom _locations_array;
	diag_log format ["%1 creation started!", _location];

	_sector = [
		//name
		str(_location),
		//position
		_location call BIS_fnc_position,
		//Sector Name, generated from stringTable 
		format[ "str_%1",_location] call BIS_fnc_localize,
		//Sector Designation, using first letter of Sector Name
		format[ "str_%1",_location] call BIS_fnc_localize select [0, 1],
		//Trigger dimensions
		_trigger_area,
		//Sides that can capture
		_sides,
		//Default owning side (e.g. sideUnknown)
		_defaultOwner,
		//Code as STRING called when sector owner changes
		format ["
			params[ '_sector', '_owner', '_oldOwner','_location'];
			[_sector, _owner, _oldOwner, %1] execVM 'Mission\_onOwnerChange.sqf';", _location
		],
		1,
		// Task block
		0,
		"",
		"",
		// _ownerLimit
		0.5,
		// costs - Inf/Wheel/Track/Water/Air/Player
		1,2,4,1,0,0.5
	] call LARs_fnc_spawnSector;
	//remove current location from array
	_locations_array = _locations_array - [_location];
	diag_log format ["%1 creation finished!", _location];
	// add to return array
	_sector_array pushBack _sector;
	//just a sleep to mitigate lag
	sleep 0.1;
};
diag_log format["%1",_sector_array];
diag_log "--- Sectors created ---";
_sector_array