diag_log "mission\enemies\sector_garrison.sqf";

params [
	['_sector', objNull]
];

// spawn garrison
_selected_spawn = [spawnpointsEnemyRoad, getPos _sector] call BIS_fnc_nearestPosition;
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
_sectorArea = _sector getVariable "objectArea";	// get sector area
_unitsInSector = allUnits inAreaArray [ getPos (_sector), _sectorArea # 0, _sectorArea # 1, _sectorArea # 2, _sectorArea # 3];	// create array with all units in the sector
_nextSector = [sectorsBlufor, getPos _sector] call BIS_fnc_nearestPosition;	// select nearest blufor sector

diag_log format["Non-Garrison guys in %1 are moving towards %2", _sector, _nextSector]; // debugging

private ["_groupArray"]; _groupArray = [];
// create array containing the groups
{
	if (side _x == opfor) then {
		_groupArray pushBack (group (leader _x));
	};
} forEach _unitsInSector;

_groupArray = _groupArray arrayIntersect _groupArray;	// remove duplicates
_groupArray = _groupArray - crb_opforGarrisonGroups; // remove groups that are also in crb_opforGarrisonGroups

// give waypoint order
if !(_nextSector isEqualTo [0,0,0]) then {
	{
		_wp = _x addWaypoint [getPos _nextSector, 5]; 
		_wp setWaypointType "MOVE";
	} forEach _groupArray;
};