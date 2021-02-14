// execVM "mission\setupWaves.sqf";
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log "mission\setupWaves.sqf";
}; // debugging message

crb_fnc_spawnWaveFootsoldiers = {

	if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
		diag_log format["-- crb_fnc_spawnWaveFootsoldiers started --"];
	}; // debugging message

	params [
		['_specificSpawn',[0,0,0]],
		['_nearestSector',objNull],
		['_director', crb_director]
	];
	private ["_returnArray","_squadSizeMax", "_squadSizeMedian"];

	_currentCP = _director getVariable "commandPointsCurrent";

	if (_currentCP <= 4) then {
		_squadSizeMax = 4;
		_squadSizeMedian = 4;
	} else {
		if (_currentCP >= 9) then {
			_squadSizeMax = 9;
			_squadSizeMedian = 6;
		} else {
			_squadSizeMax = _currentCP;
			_squadSizeMedian = _currentCP;
		};
	};
	_squadSize = floor (random [4, _squadSizeMedian, _squadSizeMax]);

	_payedCostTotal = _squadSize;	// basic inf is 1 cp
	_payedCostPerSoldier = _payedCostTotal/_squadSize; // divide the total cost equally among the soldiers
	// subtract from CP
	_director setVariable ["commandPointsCurrent", _currentCP - _payedCostTotal];	

	_spawnedGroup = [_specificSpawn, EAST, _squadSize] call BIS_fnc_spawnGroup; // spawns the squad
 
	_vehicle = objNull;
	_transporter = [objNull];
	_helo = false;

	_returnArray = [_spawnedGroup, _payedCostPerSoldier, _vehicle, _transporter, _helo];
	if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
		diag_log format["-- crb_fnc_spawnWaveFootsoldiers finished _returnArray: %1 --", _returnArray];
	}; // debugging message
	_returnArray
};

crb_fnc_spawnWaveArmedCar = {

	if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
		diag_log format["-- crb_fnc_spawnWaveArmedCar started --"];
	}; // debugging message

	params [
		['_specificSpawn',[0,0,0]],
		['_nearestSector',objNull],
		['_director', crb_director]
	];
	private ["_returnArray","_vehicleClass"];

	_currentCP = _director getVariable "commandPointsCurrent";

	// select which specific vehicle
	_vehicleClass = selectRandomWeighted [
		"O_MRAP_02_hmg_F",3,
		"O_MRAP_02_gmg_F",1
	];
	// spawning vehicle
	_spawnedResult = [_specificSpawn, _specificSpawn getDir (getPos (_nearestSector)), _vehicleClass, EAST] call BIS_fnc_spawnVehicle;
	_spawnedResult params ["_vehicle", "_crew", "_group"]; 

	// calculate cost
	_payedCostTotal = 6;	// armed car is 6 cp
	if (_vehicleClass == "O_MRAP_02_gmg_F") then {_payedCostTotal = _payedCostTotal + 1 }; // make the grenade one more expensive
	_payedCostPerSoldier = _payedCostTotal/(count (units (_spawnedResult #2))); // divide the total cost equally among the soldiers

	// subtract from CP
	_director setVariable ["commandPointsCurrent", _currentCP - _payedCostTotal];

	_spawnedGroup = _spawnedResult #2;
	_vehicle = _spawnedResult #0;
	_transporter = [objNull];
	_helo = false;

	_returnArray = [_spawnedGroup, _payedCostPerSoldier, _vehicle, _transporter, _helo];
	if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
		diag_log format["-- crb_fnc_spawnWaveArmedCar finished _returnArray: %1 --", _returnArray];
	}; // debugging message
	_returnArray
};

crb_fnc_spawnWaveTruck = {

	if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
		diag_log format["-- crb_fnc_spawnWaveTruck started --"];
	}; // debugging message

	params [
		['_specificSpawn',[0,0,0]],
		['_nearestSector',objNull],
		['_director', crb_director]
	];
	private ["_returnArray","_vehicleClass"];

	_currentCP = _director getVariable "commandPointsCurrent";

	// select which specific vehicle
	_vehicleClass = selectRandom [
		"O_Truck_03_transport_F", // Typhoon
		"O_Truck_03_covered_F",
		"O_Truck_02_transport_F",	// Zamak
		"O_Truck_02_covered_F"
	];
	// spawning vehicle
	_spawnedResult = [_specificSpawn, _specificSpawn getDir (getPos (_nearestSector)), _vehicleClass, EAST] call BIS_fnc_spawnVehicle;
	_spawnedResult params ["_vehicle", "_crew", "_group"];

	_spawnedResult #2 deleteGroupWhenEmpty true;

	if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
		diag_log format["Truck spawned with _spawnedResult: %1", _spawnedResult];
	}; // debugging message

	_spawnedGroup = [_specificSpawn, EAST, 10] call BIS_fnc_spawnGroup; // spawns the squad
	{
		_x assignAsCargo _spawnedResult #0;
		_x moveInCargo _spawnedResult #0;
	} forEach units _spawnedGroup;

	// calculate cost
	_payedCostTotal = 10;	// truck is 10 cp, meaning each soldier is worth a bit less (because they might all get blown up ASAP)

	_payedCostPerSoldier = _payedCostTotal/((count units _spawnedGroup)+(count units (_spawnedResult #2))); // divide the total cost equally among the soldiers + the crew

	// subtract from CP
	_director setVariable ["commandPointsCurrent", _currentCP - _payedCostTotal];

	_vehicle = _spawnedResult #0;
	_transporter = _spawnedResult;
	_helo = false;

	if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
		diag_log format[" _spawnedResult: %1", _spawnedResult];
	}; // debugging message

	_returnArray = [_spawnedGroup, _payedCostPerSoldier, _vehicle, _transporter, _helo];
	if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
		diag_log format["-- crb_fnc_spawnWaveTruck finished _returnArray: %1 --", _returnArray];
	}; // debugging message
	_returnArray
};

crb_fnc_startWaves = {

	params [
		['_director',crb_director]
	];

	while {crb_wavesRunning} do {	// set crb_wavesRunning to false to abort spawning instantly

		while {!(_director getVariable "waveInProgress")} do {	//	wave spawning is in progress

		_currentCP = _director getVariable "commandPointsCurrent";

			while {_director getVariable "commandPointsCurrent" >= 4} do {	//	director has command points left to spend

				// select random spawn
				private ["_selectedSpawn","_group","_squadTypesWeight","_squadTypeSelected","_spawnedGroup","_payedCostPerSoldier","_vehicle","_transporter","_helo","_spawnedUnitArray","_nearestSector","_nearestSectorArea","_nearestSectorRadius", "_specificSpawn", "_payedCostPerSoldier"];
				_selectedSpawn = selectRandom (missionNamespace getVariable "spawnpointsEnemyNormal");
				_specificSpawn = [getPos _selectedSpawn, 0, 40, 5, 0] call BIS_fnc_findSafePos;	// finds a safe position near spawn point
				// TODO if helo select helo-spawns

				// selects the nearest sector
				_nearestSector = [sectorsBlufor, _specificSpawn] call BIS_fnc_nearestPosition;	

				// get current CP
				private ["_currentCP"];
				_currentCP = _director getVariable "commandPointsCurrent";
				
				// squad types and selector, including safeguard using a type's cost to not get into negative CP
				if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
					diag_log format["_currentCP: %1", _currentCP];
				};
				
				_squadTypesWeight = (_director getVariable "_squadTypesWeight");
				if (_currentCP <= 4) then {
					_tempArray = [];
					for "_i" from 0 to (count _squadTypesWeight)-2 do {
						_tempArray pushBack _i+1;
					};
					{ _squadTypesWeight set [_x, 0] } forEach _tempArray;
				};
				if (_currentCP <= 6) then {
					_tempArray = [];
					for "_i" from 0 to (count _squadTypesWeight)-3 do {
						_tempArray pushBack _i+2;
					};
					{ _squadTypesWeight set [_x, 0] } forEach _tempArray;
				};
				if (_currentCP <= 10) then {
					_tempArray = [];
					for "_i" from 0 to (count _squadTypesWeight)-4 do {
						_tempArray pushBack _i+3;
					};
					{ _squadTypesWeight set [_x, 0] } forEach _tempArray;
				};
				if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
					diag_log format["_squadTypes: %1 | _squadTypesWeight: %2", _director getVariable "_squadTypes", _squadTypesWeight];
				};
				_squadTypeSelected = (_director getVariable "_squadTypes") selectRandomWeighted _squadTypesWeight; // actual selector

				// function selector
				if (_squadTypeSelected isEqualTo "footSoldiers") then {
					_spawnedUnitArray = [_specificSpawn, _nearestSector, _director] call crb_fnc_spawnWaveFootsoldiers;
				};
				if (_squadTypeSelected isEqualTo "armedCar") then {
					_spawnedUnitArray = [_specificSpawn, _nearestSector, _director] call crb_fnc_spawnWaveArmedCar;
				};
				if (_squadTypeSelected isEqualTo "truck") then {
					_spawnedUnitArray = [_specificSpawn, _nearestSector, _director] call crb_fnc_spawnWaveTruck;
				};

				if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
					diag_log format["_spawnedUnitArray: %1", _spawnedUnitArray];
				};
				// return array variable setter
				_spawnedGroup 		 = _spawnedUnitArray #0;
				_payedCostPerSoldier = _spawnedUnitArray #1;
				_vehicle 			 = _spawnedUnitArray #2;
				_transporter 		 = _spawnedUnitArray #3;
				_helo 				 = _spawnedUnitArray #4;
				
				// adds the event handlers
				{ 
					_x setVariable ["unitCommandPointCost",_payedCostPerSoldier];
					_x addEventHandler ["Killed", { 
						params ["_unit", "_killer", "_instigator", "_useEffects"]; 
						[_unit,_killer,_instigator] spawn cbr_fnc_enemyKilled; 
					}];
					_x addEventHandler ["Deleted", {
						params ["_entity"];
						[_entity] spawn cbr_fnc_enemyDeleted; 
					}];
				} forEach units _spawnedGroup;
				
				// get the sector's area, and select the shorter side, for radius
				_nearestSectorArea = _nearestSector getVariable "objectArea";	
				if (_nearestSectorArea #0 >= _nearestSectorArea #1) then {
					_nearestSectorRadius = _nearestSectorArea #1;
				} else {
					_nearestSectorRadius = _nearestSectorArea #0;
				};
				
				// add various group options
				_spawnedGroup deleteGroupWhenEmpty true;
				_spawnedGroup allowFleeing 0;	// no fleeing
				_spawnedGroup setVariable ["groupTargetSector",_nearestSector];
				crb_opforAttackGroups pushback _spawnedGroup;	// add to attack group array
				// waypoints
				// basic waypoint if footsoldiers with no vehicle
				if (isNull _vehicle) then {
					private ["_wp","_wp1"];
					// add waypoint to nearest sector, and set it to complete as soon as approaching the sector area
					_wp = _spawnedGroup addWaypoint [getPos (_nearestSector), 0];
					_wp setWaypointCompletionRadius _nearestSectorRadius*6;
					_wp setWaypointType "MOVE";
					_wp setWaypointBehaviour "SAFE";
					_wp setWaypointSpeed "NORMAL";
					_wp = _spawnedGroup addWaypoint [getPos (_nearestSector), 0]; 
					_wp setWaypointType "SAD";
					_wp setWaypointBehaviour "COMBAT";
				};
				// if a vehicle, but not a transporter and not a helo
				if (!(isNull _vehicle) AND (isNull (_transporter #0)) AND !_helo) then {
					private ["_wp","_wp1"];
					// add waypoint to nearest sector, and set it to complete as soon as approaching the sector area
					_wp = _spawnedGroup addWaypoint [getPos (_nearestSector), 0];
					_wp setWaypointCompletionRadius _nearestSectorRadius*6;
					_wp setWaypointType "MOVE";
					_wp setWaypointBehaviour "SAFE";
					_wp1 = _spawnedGroup addWaypoint [getPos (_nearestSector), 0];
					_wp1 setWaypointType "SAD";
					_wp1 setWaypointBehaviour "COMBAT";
				};
				// if a vehicle and a transporter, but not a helo
				if (!(isNull _vehicle) AND !(isNull (_transporter #0)) AND !_helo) then {
					private ["_wp","_wp1"];
					// add waypoint to nearest sector, and set it to complete as soon as approaching the sector area
					_wp = _spawnedGroup addWaypoint [getPos (_nearestSector), 0];
					_wp setWaypointCompletionRadius (_nearestSectorRadius*6)-100;
					_wp setWaypointType "MOVE";
					_wp setWaypointBehaviour "SAFE";
					_wp1 = _spawnedGroup addWaypoint [getPos (_nearestSector), 0];
					_wp1 setWaypointType "SAD";
					_wp1 setWaypointBehaviour "COMBAT";

					// transporter crew
					{ 
						_x setVariable ["unitCommandPointCost",_payedCostPerSoldier];
						_x addEventHandler ["Killed", { 
							params ["_unit", "_killer", "_instigator", "_useEffects"]; 
							[_unit,_killer,_instigator] spawn cbr_fnc_enemyKilled; 
						}];
						_x addEventHandler ["Deleted", {
							params ["_entity"];
							[_entity] spawn cbr_fnc_enemyDeleted; 
						}];
					} forEach units (_transporter #2);

					_wp = _transporter #2 addWaypoint [getPos (_nearestSector), 0];
					_wp setWaypointCompletionRadius _nearestSectorRadius*6;
					_wp setWaypointType "TR UNLOAD";
					_wp setWaypointBehaviour "SAFE";
					_wp setWaypointCombatMode "GREEN";
					_wp1 = _transporter #2 addWaypoint [_specificSpawn, 20];
					_wp1 setWaypointCompletionRadius 100;
					_wp1 setWaypointType "MOVE";
					_wp1 setWaypointSpeed "FULL";
					_wp1 setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList;"];
				};
				
				if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
					diag_log format["Spawned %1 at %2, attacking %3", _squadTypeSelected, _selectedSpawn, _nearestSector];
				}; // debugging message

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
		_currentCP = _director getVariable "commandPointsCurrent";
		if (_currentCP >= (_director getVariable "commandPointsBase")*0.85) then {
			_director setVariable ["waveInProgress", false];
		};
		sleep 10;

	};	// if waves stopped are running
};

if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log "- crb_fnc_startWaves function initialized -";
}; // debugging message
