// execVM "sectors\hangar_capped.sqf";
diag_log "hangar_capped.sqf running";

private ['_result'];

_result = [getPos chopper_spawn, (getPos chopper_spawn) getDir hangar_helipad, 'B_Heli_Transport_01_F', WEST] call BIS_fnc_spawnVehicle;
_result params ["_vehicle", "_crew", "_group"];
_result #2 deleteGroupWhenEmpty true;
//_result #0 setVehiclePosition [ getPos chopper_spawn, chopper_spawn, 0, "FLY"];

[_result #0, ["Green",1]] call BIS_fnc_initVehicle;

_infantry_group = [getPos default_spawn_location, WEST, 5] call BIS_fnc_spawnGroup;
_infantry_group deleteGroupWhenEmpty true;

{
	_x assignAsCargo _result #0;
	_x moveInCargo _result #0;
} forEach units _infantry_group;

_wp1 = _result #2 addWaypoint [getPos hangar_helipad, 0];
[_result #2, getPos hangar_helipad, hangar_helipad] spawn BIS_fnc_wpLand;
_wp2 = _result #2 addWaypoint [getPos chopper_exit, 0];
_wp2 setWaypointType "UNLOAD";
_wp1_inf = _infantry_group addWaypoint [getPos hangar_helipad, 0];
_wp1_inf setWaypointType "GETOUT";
_wp2_inf = _infantry_group addWaypoint [getPos area_hangars, 0];
_wp2_inf setWaypointType "MOVE";
_wp3 = _result #2 addWaypoint [getPos chopper_exit, 0];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList; deleteVehicle hangar_bluesmoke"];