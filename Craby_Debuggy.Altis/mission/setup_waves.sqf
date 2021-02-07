diag_log "mission\setup_waves.sqf";
// execVM "mission\setup_waves.sqf";

_crb_director_group = createGroup sideLogic;
crb_director = _crb_director_group createUnit ["Curator_F", [5717,6994,0], [], 0, "FORM"];

crb_wavesRunning = true;
crb_director setVariable ["commandPointsBase", (missionNamespace getVariable "crb_defaultCommandPoints")]; // TODO set commandPointsBase somewhere else, potentially parameter, and increase over time
crb_director setVariable ["commandPointsCurrent", (crb_director getVariable "commandPointsBase")];
crb_director setVariable ["currentWave", 1];
crb_director setVariable ["waveInProgress", false];

crb_fnc_startWaves = {

	params [
		['_director',crb_director]
	];

	while {crb_wavesRunning} do {	// set crb_wavesRunning to false to abort spawning instantly
		private ["_currentCP"];
		_currentCP = _director getVariable "commandPointsCurrent";
		while {!(_director getVariable "waveInProgress")} do {	//	wave spawning is in progress

			while {_director getVariable "commandPointsCurrent" > 0} do {	//	director has command points left to spend

				// TODO Variety
				// select random spawn
				private ["_selectedSpawn","_group","_squadSize","_nearestSectorArea","_nearestSectorRadius", "_specificSpawn", "_payedCostPerSoldier"];
				_selectedSpawn = selectRandom (missionNamespace getVariable "spawnpointsEnemy");

				// subtract unit cost
				_currentCP = _director getVariable "commandPointsCurrent";
				_squadSize = floor (random [2, 3, _currentCP]);	// TODO
				_payedCostTotal = _squadSize; // currently just size for inf TODO
				_director setVariable ["commandPointsCurrent", _currentCP - _payedCostTotal];	// subtract available CP

				_specificSpawn = [getPos _selectedSpawn, 0, 40, 5, 0] call BIS_fnc_findSafePos;	//finds a safe position near spawn point

				_group = [_specificSpawn, EAST, _squadSize] call BIS_fnc_spawnGroup; // TODO spawns the squad
				_group deleteGroupWhenEmpty true;
				_group allowFleeing 0;	// no fleeing
				crb_opforAttackGroups pushback _group;	// add to attack group array

				_payedCostPerSoldier = _payedCostTotal/(count units _group); // TODO, for now simply divide the total cost equally among the soldiers
				
				{ 
					_x setVariable ["unitCommandPointCost",_payedCostPerSoldier];
					_x addEventHandler ["Killed", { 
						params ["_unit", "_killer", "_instigator", "_useEffects"]; 
						[_unit,_killer,_instigator] spawn cbr_fnc_enemyKilled; 
					}];
				} forEach units _group;

				_nearestSector = [sectorsBlufor, getPos (leader _group)] call BIS_fnc_nearestPosition;	// selects the nearest sector
				// select the shorter size, for radius
				_nearestSectorArea = _nearestSector getVariable "objectArea";	
				if (_nearestSectorArea #0 >= _nearestSectorArea #1) then {
					_nearestSectorRadius = _nearestSectorArea #1;
				} else {
					_nearestSectorRadius = _nearestSectorArea #0;
				};
				_wp1 = _group addWaypoint [getPos (_nearestSector), _nearestSectorRadius]; // add waypoint to nearest sector, and set it to complete as soon as sector area is reached
				_wp1 setWaypointType "MOVE";
				_wp2 = _group addWaypoint [getPos (_nearestSector), 5]; 
				_wp2 setWaypointType "SAD";

				diag_log format["Spawned %1 doods at %2, moving towards %3", _squadSize, _selectedSpawn, _nearestSector]; // debugging
				sleep 2;

			};	// if director ran out of command points
			// increase current wave number
			_director setVariable ["waveInProgress", true];
			_currentWave = _director getVariable "currentWave";
			hint format["Wave #%1 spawned!",_currentWave];
			_director setVariable ["currentWave", _currentWave + 1];

			sleep 10;

		};	// if waves stop being in progress
		// if most of the command points have returned and are near the base, restart wave spawning
		if (_currentCP >= (_director getVariable "commandPointsBase")-3) then {
			_director setVariable ["waveInProgress", false];
		};
		sleep 10;

	};	// if waves stopped are running
};

[crb_director] spawn crb_fnc_startWaves;