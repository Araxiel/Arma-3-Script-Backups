//	ar_fnc_spawnInsertionSquadScript = [_spawnPoint, _baseArea, _objectives] execVM "scripts\ar_fnc_spawnInsertionSquad.sqf";
// 	then:
// 	waitUntil { scriptDone ar_fnc_spawnInsertionSquadScript };
// 	[kajman, 1, ["ACE_SelfActions"], spawnInsertionSquad] call ace_interact_menu_fnc_addActionToObject;
// 	[kajman, 1, ["ACE_SelfActions"], tellSquadToLeave] call ace_interact_menu_fnc_addActionToObject;

params [
	['_spawnPoint', objNull],
	['_baseArea', objNull],
	['_objectives', []]
];

_spawnPoint = _spawnPoint call BIS_fnc_position;

// spawn squad
fnc_spawnInsertionSquad = {
	params ["_target", "_player", "_params"];
	private _spawnPoint = _params #1;

	_safeSpawnPoint = [_spawnPoint, 0, 10, 5, 0] call BIS_fnc_findSafePos;	// find a safe spot
    _group = [_safeSpawnPoint, EAST, 8] call BIS_fnc_spawnGroup;

	//{
	//	_x assignAsCargo _target;
	//	_x orderGetIn _target;
	//} forEach _group;

	_wp = _group addWaypoint [_target,0];
	_wp waypointAttachVehicle _target;
	_wp setWaypointType "GETIN";

	// sets the variable to true, but sets a timer to reset it later
	_target setVariable ["summonedSquad", true];
	[_target] spawn {
		params ["_target"];
		sleep 60;
		_target setVariable ["summonedSquad", nil];
	};
};

fnc_spawnInsertionSquadCondition = {
	params ["_target", "_player", "_params"];
	private _baseArea = _params #0;

	_target inArea _baseArea 	// must be in trigger
	&& !(_target getVariable ["summonedSquad",false])	// and summonedSquad must be false
	&& (_target emptyPositions "cargo" >= 7);	// and must have free space
};

spawnInsertionSquad = [
	"spawnInsertionSquad","Summon Insertion Squad",
	"",
	fnc_spawnInsertionSquad,
	fnc_spawnInsertionSquadCondition,
	{},
	[_baseArea, _spawnPoint]
] call ace_interact_menu_fnc_createAction;

// Tell squad to leave 

fnc_tellSquadToLeave = {
	params ["_target", "_player", "_params"];
	private _objectives = _params #0;

	_cargo = assignedCargo _target;
	_group = group (_cargo #0);
	{
		commandGetOut _x;
	} forEach units _group;
	_group leaveVehicle _target;

	_wp = _group addWaypoint [[_target, 0, 10, 0, 0] call BIS_fnc_findSafePos,10];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 10;

    _nearestObjective = [_objectives, _target] call BIS_fnc_nearestPosition;
	if ((_nearestObjective distance _player) > 600) then {
		_nearestObjective = getPos _target;
	};
	_wp = _group addWaypoint [_nearestObjective,10];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 100;
	_wp = _group addWaypoint [_nearestObjective,10];
	_wp setWaypointType "SAD";
};

fnc_tellSquadToLeaveCondition = {
	params ["_target", "_player", "_params"];
	private _objectives = _params #0;
	private _baseArea = _params #1;

	_nearestObjective = [_objectives, _target] call BIS_fnc_nearestPosition;

	!(_target inArea _baseArea)
	&& (_target emptyPositions "cargo" < 8);	// and must have somone in cargo space
	//&& (_nearestObjective distance _player) < 600; // and must be in range
};

tellSquadToLeave = [
	"tellSquadToLeave","Unload Squad",
	"",
	fnc_tellSquadToLeave,
	fnc_tellSquadToLeaveCondition,
	{},
	[_objectives, _baseArea]
] call ace_interact_menu_fnc_createAction;

if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log '- ar_fnc_spawnInsertionSquad init -';};