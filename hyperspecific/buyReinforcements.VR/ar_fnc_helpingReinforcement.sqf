fnc_aoSAD = {

	params [
		["_group", grpNull]
	];

	_fnc_debugMarkers = {
		// for the debug markers
		// _debugMarker = [_debugMarkerPos, _debugMarkerType, _debugMarkercolor, _debugMarkerText] call _fnc_debugMarkers;
		// [objNull, "mil_destroy", "ColorYellow", "text"] call _fnc_debugMarkers;
		params [
			[ "_debugMarkerPos", objNull],
			[ "_debugMarkerType", "mil_destroy"],
			[ "_debugMarkercolor", "ColorYellow"],
			[ "_debugMarkerText", ""],
			[ "_debugMarkerAlpha", 0.9]
		];
		private ["_debugMarker"];

		if (missionNamespace getVariable ['aDebugMessages',false]) then {
			_debugMarkerPos = _debugMarkerPos call BIS_fnc_position;
			_debugMarkerId = round(random 50000)+100000; 
			_debugMarker = createMarker [format["_USER_DEFINED %1",_debugMarkerId], _debugMarkerPos]; 
			_debugMarker setMarkerType _debugMarkerType; 
			_debugMarker setMarkerColor _debugMarkercolor;
			_debugMarker setMarkerText _debugMarkerText;
			_debugMarker setMarkerAlpha _debugMarkerAlpha;
		};
		_debugMarker
	};

    _wpPos = [[_group getVariable "aoAreaArray"], ["water", _group getVariable "aoBlacklist"]] call BIS_fnc_randomPos;
	_wpPos = [_wpPos, 0, 10, 2, 0, 30] call BIS_fnc_findSafePos;	// get a random (accessible) spot for the WP

	_wp = _group addWaypoint [_wpPos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCompletionRadius 50;
	_wp setWaypointStatements ["true", "[group this] spawn fnc_aoSAD"];
	[waypointPosition _wp, "mil_destroy", "ColorYellow", format["SAD WP for %1",_group]] call _fnc_debugMarkers;
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['New SAD for group: %1',_group];};
};

fnc_summonAoInfantrySAD = {
	//	_group = [_spawn, _side, _aoPos, _aoArea, _blacklist] call fnc_summonAoInfantrySAD;
	// 	Usage:
	//	[indySpawn, independent, getPos aoTrigger, triggerArea aoTrigger, []] call fnc_summonAoInfantrySAD;

	params [
		["_spawn", objNull],
		["_side", sideUnknown],
		["_aoPos", [0,0,0]],
		["_aoArea", [0,0,0,false,-1]],
		["_blacklist", []]	// optional
	];

	_fnc_debugMarkers = {
		// for the debug markers
		// _debugMarker = [_debugMarkerPos, _debugMarkerType, _debugMarkercolor, _debugMarkerText] call _fnc_debugMarkers;
		// [objNull, "mil_destroy", "ColorYellow", "text"] call _fnc_debugMarkers;
		params [
			[ "_debugMarkerPos", objNull],
			[ "_debugMarkerType", "mil_destroy"],
			[ "_debugMarkercolor", "ColorYellow"],
			[ "_debugMarkerText", ""],
			[ "_debugMarkerAlpha", 0.9]
		];
		private "_debugMarker";

		if (missionNamespace getVariable ['aDebugMessages',false]) then {
			_debugMarkerPos = _debugMarkerPos call BIS_fnc_position;
			_debugMarkerId = round(random 50000)+100000; 
			_debugMarker = createMarker [format["_USER_DEFINED %1",_debugMarkerId], _debugMarkerPos]; 
			_debugMarker setMarkerType _debugMarkerType; 
			_debugMarker setMarkerColor _debugMarkercolor;
			_debugMarker setMarkerText _debugMarkerText;
			_debugMarker setMarkerAlpha _debugMarkerAlpha;
		};
		_debugMarker;
	};

	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '- aoInfantry Start -';};

	_specificSpawn = [_spawn, 0, 40, 5, 0] call BIS_fnc_findSafePos;	// find a safe spawn spot
	_group = [_specificSpawn, _side, 7] call BIS_fnc_spawnGroup;
	_group deleteGroupWhenEmpty true;

	//	reformats the trigger pos and area into a usable format of [[x,y,z], [a, b, angle, rect]], or [[0,0,0], [0,0,0,-1]]
	private _aoAreaArray = [_aoPos, _aoArea];
	// sends stuff to the group as variables, so the setWaypointStatements has this data to work with.
    _group setVariable ["aoAreaArray", _aoAreaArray];
    _group setVariable ["aoBlacklist", _blacklist];

    _wpPos = [[_aoAreaArray], ["water", _blacklist]] call BIS_fnc_randomPos;
	_wpPos = [_wpPos, 0, 10, 2, 0, 30] call BIS_fnc_findSafePos;	// get a random (accessible) spot for the first WP

	_wp = _group addWaypoint [_wpPos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCompletionRadius 1000;
	_wp setWaypointStatements ["true", "[group this] spawn fnc_aoSAD"];
	[waypointPosition _wp, "mil_destroy", "ColorYellow", format["First WP for %1",_group]] call _fnc_debugMarkers;

	_group
};

fnc_boughtHelp = {
	//	_group = [_spawn, _side, _aoPos, _aoArea, _blacklist] call fnc_summonAoInfantrySAD;
	// 	Usage:
	//	[indySpawn, independent, getPos aoTrigger, triggerArea aoTrigger, []] call fnc_summonAoInfantrySAD;

	params [
		["_spawn", objNull],
		["_caller", objNull],
		["_kind", "car"],
		["_side", blufor],
		["_code", {}]
	];

	_fnc_debugMarkers = {
		// for the debug markers
		// _debugMarker = [_debugMarkerPos, _debugMarkerType, _debugMarkercolor, _debugMarkerText] call _fnc_debugMarkers;
		// [objNull, "mil_destroy", "ColorYellow", "text"] call _fnc_debugMarkers;
		params [
			[ "_debugMarkerPos", objNull],
			[ "_debugMarkerType", "mil_destroy"],
			[ "_debugMarkercolor", "ColorYellow"],
			[ "_debugMarkerText", ""],
			[ "_debugMarkerAlpha", 0.9]
		];
		private "_debugMarker";

		if (missionNamespace getVariable ['aDebugMessages',false]) then {
			_debugMarkerPos = _debugMarkerPos call BIS_fnc_position;
			_debugMarkerId = round(random 50000)+100000; 
			_debugMarker = createMarker [format["_USER_DEFINED %1",_debugMarkerId], _debugMarkerPos]; 
			_debugMarker setMarkerType _debugMarkerType; 
			_debugMarker setMarkerColor _debugMarkercolor;
			_debugMarker setMarkerText _debugMarkerText;
			_debugMarker setMarkerAlpha _debugMarkerAlpha;
		};
		_debugMarker;
	};
	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '- fnc_boughtHelp Start -';};

	_spawnPos = _spawn call BIS_fnc_position;
	_callerPos = _caller call BIS_fnc_position;
	_specificSpawn = [_spawnPos, 0, 40, 5, 0] call BIS_fnc_findSafePos;	// find a safe spawn spot

	private "_pickedVehicle";
	private _passengers = 0;
	switch (_kind) do {
		case "car": { 
		// cars/jeeps
			switch (_side) do {
				case "opfor": {
					_pickedVehicle = selectRandomWeighted [
						"O_MRAP_02_hmg_F", 5,
						"O_MRAP_02_gmg_F", 1,
						"O_LSV_02_armed_F", 3
					];
				};
				case "independent": {
					_pickedVehicle = selectRandomWeighted [
						"I_MRAP_03_hmg_F", 4,
						"I_MRAP_03_gmg_F", 1
					];
				};
				default {
					_pickedVehicle = selectRandomWeighted [
						"B_MRAP_01_hmg_F", 5,
						"B_MRAP_01_gmg_F", 1,
						"B_LSV_01_armed_F", 3
					];
				};
			};
		};
		case "truck": { 
		// trucks
			switch (_side) do {
				case "opfor": {
					_pickedVehicle = selectRandomWeighted [
						"O_Truck_03_covered_F", 1,
						"O_Truck_02_covered_F", 3
					];
				};
				case "independent": {
					_pickedVehicle = "I_Truck_02_covered_F";
				};
				default {
					_pickedVehicle = "B_Truck_01_covered_F";
				};
			};
			_passengers = 13;
		};
		case "apc": { 
		// apcs
			switch (_side) do {
				case "opfor": {
					_pickedVehicle = selectRandomWeighted [
						"O_APC_Tracked_02_cannon_F", 1,
						"O_APC_Wheeled_02_rcws_v2_F", 3
					];
				};
				case "independent": {
					_pickedVehicle = selectRandomWeighted [
						"I_APC_tracked_03_cannon_F", 1,
						"I_APC_Wheeled_03_cannon_F", 2
					];
				};
				default {
					_pickedVehicle = selectRandomWeighted [
						"B_APC_Wheeled_01_cannon_F", 2,
						"B_APC_Tracked_01_rcws_F", 1
					];
				};
			};
			_passengers = 7;
		};
		case "tank": { 
		// tanks
			switch (_side) do {
				case "opfor": {
					_pickedVehicle = selectRandomWeighted [
						"O_MBT_04_cannon_F", 2,
						"O_MBT_04_command_F", 1,
						"O_MBT_02_cannon_F", 6
					];
				};
				case "independent": {
					_pickedVehicle = "I_MBT_03_cannon_F";
				};
				default {
					_pickedVehicle = selectRandomWeighted [
						"B_MBT_01_TUSK_F", 1,
						"B_MBT_01_cannon_F", 6
					]
				};
			};
		};
	};

	_result = [_specificSpawn, _specificSpawn getDir _callerPos, _pickedVehicle, _side] call BIS_fnc_spawnVehicle;
	_result params ["_vehicle", "_crew", "_group"]; 
	_group deleteGroupWhenEmpty true;

	if (_passengers > 0) then {
		for "_i" from 0 to (_passengers-1) do {
			// which side
			switch (_side) do {
				case "opfor": {
					_pickedUnitClass = selectRandomWeighted [
						"O_MRAP_02_hmg_F", 5,
						"O_MRAP_02_gmg_F", 1,
						"O_LSV_02_armed_F", 3
					];
				};
				case "independent": {
					_pickedUnitClass = selectRandomWeighted [
						"I_MRAP_03_hmg_F", 4,
						"I_MRAP_03_gmg_F", 1
					];
				};
				default {
					_pickedUnitClass = selectRandomWeighted [
						"B_MRAP_01_hmg_F", 5,
						"B_MRAP_01_gmg_F", 1,
						"B_LSV_01_armed_F", 3
					];
				};
			};
			// creation
    		_group createUnit [_pickedUnitClass, getPos _vehicle, [], 0, "CARGO"];
		};
	};

    _group setVariable ["helpCaller", _caller];	// saves the caller as a variable for the group

	_wpPos = [_callerPos, 0, 10, 2, 0, 30] call BIS_fnc_findSafePos;	// get a random (accessible) spot for the WP

	_wp = _group addWaypoint [_wpPos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCompletionRadius 500;
	[waypointPosition _wp, "mil_destroy", "ColorYellow", format["Reinforcement Spot %1",_group]] call _fnc_debugMarkers;

	_group
};