
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log "mission\enemies\sector_garrison.sqf";
};

params [
	['_sector', objNull]
];

_selected_spawn = [spawnpointsEnemyNormal, getPos _sector] call BIS_fnc_nearestPosition;

_roadPoint = [getPos (_selected_spawn), 100] call BIS_fnc_nearestRoad;
_roadPoint = getPos _roadPoint;
_roadPoint = [_roadPoint, 0, 25, 5, 0] call BIS_fnc_findSafePos;
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log format["_roadPoint: %1", _roadPoint];
};

_truckModelsArray = [
	"O_Truck_03_transport_F", // Typhoon
	"O_Truck_03_covered_F",
	"O_Truck_02_transport_F",	// Zamak
	"O_Truck_02_covered_F"
];
_truckModel = selectRandom _truckModelsArray;
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log format["Model: %1", _truckModel];
};

private ["_truck","_truckVehicle","_truckGroup"];
_truck = [_roadPoint, _roadPoint getDir _sector, _truckModel, EAST] call BIS_fnc_spawnVehicle;
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log format["Truck: %1", _truck];
};
_truck params ["_vehicle", "_crew", "_group"];
_truckVehicle = _truck #0;
_truckGroup = _truck #2;
_truckGroup deleteGroupWhenEmpty true;
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log format["_truckVehicle: %1 | _truckGroup: %2 ", _truckVehicle, _truckGroup];
};

for "_i" from 0 to 2 do {

	_specificSpawn = [_roadPoint, 0, 40, 5, 0] call BIS_fnc_findSafePos;	// find a safe spot
	_group = [_specificSpawn, EAST, 4] call BIS_fnc_spawnGroup;
	_group deleteGroupWhenEmpty true;

	{
		_x assignAsCargo _truckVehicle;
		_x moveInCargo _truckVehicle;
		_x addEventHandler ["Killed", { 
			params ["_unit", "_killer", "_instigator", "_useEffects"]; 
			[_unit,_killer,_instigator] spawn cbr_fnc_enemyKilled; 
		}];
	} forEach units _group;
	
	_wp = _group addWaypoint [getPos _sector, 20];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 10;
	if ((_i+1) % 3 == 0) then {
		_wp setWaypointStatements ["true", format["[group this, getPos %1] call BIS_fnc_taskDefend;",_sector]];
		if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
			diag_log "Defender Squad";
		};
	}
	else {
		_wp setWaypointStatements ["true", format["[group this, getPos %1, 500] call BIS_fnc_taskPatrol;;",_sector]];
				if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
			diag_log "Patrol Squad";
		};
	};
	crb_opforGarrisonGroups pushback _group;
};

_wp = _truckGroup addWaypoint [getPos _sector, 20];
_wp setWaypointType "TR UNLOAD";
_wp = _truckGroup addWaypoint [_roadPoint, 20];
_wp setWaypointType "MOVE";
_wp setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList;"];

// Move units to next blufor point;	
// TODO, keep units here until reinforcements arrive
_sectorArea = _sector getVariable "objectArea";	// get sector area
_unitsInSector = allUnits inAreaArray [ getPos (_sector), _sectorArea # 0, _sectorArea # 1, _sectorArea # 2, _sectorArea # 3];	// create array with all units in the sector
_nextSector = [sectorsBlufor, getPos _sector] call BIS_fnc_nearestPosition;	// select nearest blufor sector

if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log format["Non-Garrison guys in %1 are moving towards %2", _sector, _nextSector]; // debugging
};

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