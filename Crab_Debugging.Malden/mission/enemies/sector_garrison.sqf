diag_log "sectors\sector_garrison.sqf";

params [
	['_sector', objNull]
];

// spawn garrison
_selected_spawn = [spawnpoints_enemy_road, getPos _sector] call BIS_fnc_nearestPosition;
_group = [getPos _selected_spawn, EAST, 3] call BIS_fnc_spawnGroup;
_group deleteGroupWhenEmpty true;

{
	_x addEventHandler ["Killed", { 
		params ["_unit", "_killer", "_instigator", "_useEffects"]; 
		[_unit,_killer,_instigator] execVM "mission\enemies\_enemy_killed.sqf"; 
	}];
} forEach units _group;
 
_wp = _group addWaypoint [getPos _sector, 20]; 
_wp setWaypointType "MOVE";

// Move units to next blufor point
_sector_area = _sector getVariable "objectArea";	// got sector area
_units_in_sector = allUnits inAreaArray [ getPos (_sector), _sector_area # 0, _sector_area # 1, _sector_area # 2, _sector_area # 3];	// create array with all units in the sector
_next_sector = [sectors_blufor, getPos _sector] call BIS_fnc_nearestPosition;	// select nearest blufor sector

_group_array = [];
// create array containing the actual groups
{
	if (side _x == opfor) then {
		_group_array pushBack (group (leader _x));
	};
} forEach _units_in_sector;

_group_array = _group_array arrayIntersect _group_array;	// remove duplicates

// give waypoint order
if !(_next_sector isEqualTo [0,0,0]) then {
	{
		_wp = _x addWaypoint [getPos _next_sector, 5]; 
		_wp setWaypointType "MOVE";
	} forEach _group_array;
};