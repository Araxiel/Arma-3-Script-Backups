// [_sector, _sectorCommandPoints,_kindWeight] spawn arx_fnc_enemyStartGarrison;
// [sc_alpha, 20,[1,10,6]] spawn arx_fnc_enemyStartGarrison;
arx_fnc_enemyStartGarrison = {
	params [
		['_sector', objNull],
		['_sectorCommandPoints',-1],
		['_kindWeight',[3,2,1]]
	];
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['arx_fnc_enemyStartGarrison for %1 started',_sector getVariable "name"];};

	private _garrisonGroups = [];
	private _garrisonGroupsVehicles = [];
	private ["_sectorCommandPoints", "_sectorPos", "_sectorArea"];

	// if set to -1 then use actual number, otherwise use passed value
	if (_sectorCommandPoints == -1) then {
		_sectorCommandPoints = _sector getVariable ["sectorCommandPoints", 30];
	};

	_sectorPos = _sector call BIS_fnc_position;	// get sector pos
	_sectorArea = _sector getVariable "objectArea";	// get sector area

	while {_sectorCommandPoints > 5} do {
		private ["_safeSpawnPoint","__kind"];
		_safeSpawnPoint = [_sectorPos, 0, 40, 5, 0] call BIS_fnc_findSafePos;	// find a safe spot
		
		// setting weight to 0 if cos of that kind exceeds the available pool.
		if (_sectorCommandPoints < 20) then {
			_kindWeight set [2, 0];
		};
		if (_sectorCommandPoints < 10) then {
			_kindWeight set [2, 0];
			_kindWeight set [1, 0];
		};

		_kind = ["inf","jeep","apc"] selectRandomWeighted _kindWeight;

		switch (_kind) do {
			case "inf": {	// spawn multiple small squads
				private ["_squadAmount","_squadSize"];
				_squadAmount = floor(random [2, 3, 4]);
				for "_i" from 1 to _squadAmount do {	// random amount of squads
					private "_group";
					_squadSize = 5;
					switch (_squadAmount) do {	// the more there are squads, the smaller the squads, with an average of like 12 dudes.
						case 2: { _squadSize = floor(random [3, 5, 6]) };
						case 3: { _squadSize = floor(random [3, 4, 5]) };
						case 4: { _squadSize = floor(random [2, 2, 3]) };
						default { _squadSize = 5};
					};
					_group = [_safeSpawnPoint, EAST, _squadSize] call BIS_fnc_spawnGroup;
					_group deleteGroupWhenEmpty true;

					// "(_i+1) mod 3 == 0" translates to "every third squad"
					if ((_i+1) mod 3 == 0) then {
						if ((missionNamespace getVariable ["aDebugMessages",false]) == true) then { diag_log "Defender Squad"; };
						[_group, _sectorPos] call BIS_fnc_taskDefend;
					}
					else {
						if ((missionNamespace getVariable ["aDebugMessages",false]) == true) then { diag_log "Patrol Squad"; };
						[_group, _sectorPos, (_sectorArea #0)+((_sectorArea #0)/4)] call BIS_fnc_taskPatrol;	// patrol at 125% of the sector area
					};
					_garrisonGroups pushback _group;
					_sectorCommandPoints = _sectorCommandPoints - _squadSize;
					if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['Spawned %2-men squad for %1',_sector getVariable "name", _squadSize];};
				};
				if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['Spawned %2 squads for %1',_sector getVariable "name", _squadAmount];};
			};
			case "jeep": {	// spawn patroling jeep
				private ["_selectedVehicle","_commandPointCost", "_result", "_extraRange"];
				_selectedVehicle = [
					"O_MRAP_02_gmg_F",
					"O_MRAP_02_hmg_F",
					"O_LSV_02_armed_F",
					"O_LSV_02_AT_F"
				] selectRandomWeighted [2,6,4,1];

				_result = [_safeSpawnPoint, random(360), _selectedVehicle, east] call BIS_fnc_spawnVehicle;
				_result params ["_vehicle", "_crew", "_group"]; 
				_result #2 deleteGroupWhenEmpty true;

				_extraRange = selectRandom [0.1, 0.75, 3];

				[_result #2, _sectorPos, (_sectorArea #0)+((_sectorArea #0)*_extraRange)] call BIS_fnc_taskPatrol;	// patrol at _extraRange of the sector area

				_garrisonGroups pushback _result #2;
				_garrisonGroupsVehicles pushback _result #0;
				switch (_selectedVehicle) do {
					case "O_MRAP_02_gmg_F": { _commandPointCost = 13 };
					case "O_MRAP_02_hmg_F": { _commandPointCost = 10 };
					case "O_LSV_02_armed_F": { _commandPointCost = 8 };
					case "O_LSV_02_AT_F": { _commandPointCost = 8 };
					default { _commandPointCost = 10 };
				};
				_sectorCommandPoints = _sectorCommandPoints - _commandPointCost;
				if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['Spawned %2 for %1',_sector getVariable "name", _selectedVehicle];};
			};
			case "apc": {	// spawn apc
				private ["_selectedVehicle","_commandPointCost", "_result", "_extraRange", "_wp", "_rPatrol"];
				_selectedVehicle = [
					"O_APC_Wheeled_02_rcws_v2_F",
					"O_APC_Tracked_02_cannon_F",
					"O_APC_Tracked_02_AA_F"
				] selectRandomWeighted [8,4,1];

				_result = [_safeSpawnPoint, random(360), _selectedVehicle, east] call BIS_fnc_spawnVehicle;
				_result params ["_vehicle", "_crew", "_group"]; 
				_result #2 deleteGroupWhenEmpty true;

				_rPatrol = [true,false] selectRandomWeighted [1,2];
				if _rPatrol then {
					_extraRange = selectRandom [0, 0, 0.5];
					[_result #2, _sectorPos, (_sectorArea #0)+((_sectorArea #0)*_extraRange)] call BIS_fnc_taskPatrol;	// patrol at _extraRange of the sector area
				} else {
					_wp =_result #2 addWaypoint [_safeSpawnPoint,0];
					_wp setWaypointBehaviour "AWARE";
				};

				_garrisonGroups pushback _result #2;
				_garrisonGroupsVehicles pushback _result #0;
				switch (_selectedVehicle) do {
					case "O_APC_Wheeled_02_rcws_v2_F": { _commandPointCost = 18 };
					case "O_APC_Tracked_02_cannon_F": { _commandPointCost = 22 };
					case "O_APC_Tracked_02_AA_F": { _commandPointCost = 20 };
					default { _commandPointCost = 20 };
				};
				_sectorCommandPoints = _sectorCommandPoints - _commandPointCost;
				if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['Spawned %2 for %1',_sector getVariable "name", _selectedVehicle];};
			};
		};

	};

	_garrisonGroupsSet = (_sector getVariable ["garrisonGroups",[]]) + _garrisonGroups; // adds newly spawned groups to the list, if for some reason there's already groups in there 
	_sector setVariable ["garrisonGroups", _garrisonGroupsSet];	// sets array containing all garrison groups
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['Current garrisonGroups: %1',_sector getVariable "garrisonGroups"]};
	_sector setVariable ["garrisonGroupsVehicles", _garrisonGroupsVehicles];	// sets array containing all garrison vehicles
	// command point subtraction
	if (_sectorCommandPoints == -1) then {
		_sector setVariable ["sectorCommandPoints", _sectorCommandPoints];	// sets sector's command points
		if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['Current sectorCommandPoints: %1',_sector getVariable "sectorCommandPoints"]};
	};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['arx_fnc_enemyStartGarrison for %1 done',_sector getVariable "name"];};
};

// [_sector] call arx_fnc_debug_killGarrison;
arx_fnc_debug_killGarrison = {
	params [
		['_sector', objNull]
	];
	private _garrisonGroups = _sector getVariable ["garrisonGroups",[]];
	private _garrisonGroupsVehicles = _sector getVariable ["garrisonGroupsVehicles",[]];

	{
		{
			_x setDamage 1;
		} forEach units _x;
	} forEach _garrisonGroups;
	{
		_x setDamage 1;
	} forEach _garrisonGroupsVehicles;
};