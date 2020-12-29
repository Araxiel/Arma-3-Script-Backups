_location = player;

_cargo_types = [
	"B_Slingload_01_Cargo_F (huron_con)",
	"Land_FoodSacks_01_cargo_brown_F",
	"CargoNet_01_barrels_F",
	"CargoNet_01_box_F",
	"B_CargoNet_01_ammo_F",
	"B_Slingload_01_Medevac_F"
];

_cargo_types_weight = [
	3,
	1,
	2,
	2,
	2,
	1
];

for "_i" from 0 to 1 do {
	_helo_cargo_drop = [getPos _location, 0, 150, 5, 2, 0.15, 0,[], [getPos _location, getPos _location]] call BIS_fnc_findSafePos;  
	_helo_cargo_drop pushback 0.1; 
	_obj = "VR_3DSelector_01_exit_F" createVehicle _helo_cargo_drop; 
	_obj setPos _helo_cargo_drop; 
	
	_result = [getPos helo_spawn, (getPos helo_spawn) getDir _helo_cargo_drop, "B_Heli_Transport_03_unarmed_F", WEST] call BIS_fnc_spawnVehicle;  
	_result params ["_vehicle", "_crew", "_group"];  
	_result #2 deleteGroupWhenEmpty true;  
	
	_selected_cargo_type = _cargo_types selectRandomWeighted _cargo_types_weight;
	_cargo = _selected_cargo_type createVehicle getPos helo_spawn;
	_result #0 setSlingLoad _cargo;
	diag_log format["Cargo type selected: %1",_selected_cargo_type];

	_wp = _result #2 addWaypoint [_helo_cargo_drop, 0];  
	_wp setWaypointType "UNHOOK";
	_wp2 = _result #2 addWaypoint [getPos helo_spawn, 0];  
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList;"];
	sleep 10;
};
diag_log "Helos created";