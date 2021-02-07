diag_log "mission\enemies\sector_garrison.sqf";

params [
	['_sector', objNull]
];

// spawn garrison
_selected_spawn = [spawnpoints_enemy_road, getPos _sector] call BIS_fnc_nearestPosition;
for "_i" from 0 to 2 do
{
	_group = [getPos _selected_spawn, EAST, 5] call BIS_fnc_spawnGroup;
	_group deleteGroupWhenEmpty true;

	{
		_x addEventHandler ["Killed", { 
			params ["_unit", "_killer", "_instigator", "_useEffects"]; 
			[_unit,_killer,_instigator] spawn cbr_fnc_enemyKilled; 
		}];
	} forEach units _group;
	
	_wp = _group addWaypoint [getPos _sector, 20];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 10;
	if ((_i+1) % 3 == 0) then {
		_wp setWaypointStatements ["true", format["[group this,getPos %1] call BIS_fnc_taskDefend;",_sector]];
		diag_log "Defender Squad";
	}
	else {
		_wp setWaypointStatements ["true", format["[group this, getPos %1, 500] call BIS_fnc_taskPatrol;;",_sector]];
		diag_log "Patrol Squad";
	};
	crb_opforGarrisonGroups pushback _group;
};

// Move units to next blufor point;	
// TODO, keep units here until reinforcements arrive
_sector_area = _sector getVariable "objectArea";	// get sector area
_units_in_sector = allUnits inAreaArray [ getPos (_sector), _sector_area # 0, _sector_area # 1, _sector_area # 2, _sector_area # 3];	// create array with all units in the sector
_next_sector = [sectors_blufor, getPos _sector] call BIS_fnc_nearestPosition;	// select nearest blufor sector

diag_log format["Non-Garrison guys in %1 are moving towards %2", _sector, _next_sector]; // debugging

private ["_group_array"]; _group_array = [];
// create array containing the groups
{
	if (side _x == opfor) then {
		_group_array pushBack (group (leader _x));
	};
} forEach _units_in_sector;

_group_array = _group_array arrayIntersect _group_array;	// remove duplicates
_group_array = _group_array - crb_opforGarrisonGroups; // remove groups that are also in crb_opforGarrisonGroups

// give waypoint order
if !(_next_sector isEqualTo [0,0,0]) then {
	{
		_wp = _x addWaypoint [getPos _next_sector, 5]; 
		_wp setWaypointType "MOVE";
	} forEach _group_array;
};