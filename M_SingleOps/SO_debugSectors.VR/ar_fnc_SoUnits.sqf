// Forked off from my (unfinished) mapPopulations ar_fnc_mapPopulation.sqf

fnc_SoPop_DebugMarker = {
	// for the debug markers
	// _debugMarker = [_debugMarkerPos, _debugMarkerType, _debugMarkercolor, _debugMarkerText, _debugMarkerDir] call fnc_SoPop_DebugMarker;
	// [objNull, "mil_destroy", "ColorYellow", "text"] call fnc_SoPop_DebugMarker;
	params [
		[ "_debugMarkerPos", objNull],
		[ "_debugMarkerType", "mil_destroy"],
		[ "_debugMarkercolor", "ColorYellow"],
		[ "_debugMarkerText", ""],
		[ "_debugMarkerAlpha", 0.9],
		[ "_debugMarkerDir", 0]
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
		_debugMarker setMarkerDir _debugMarkerDir;
	};
	_debugMarker;
};

fnc_SoPop_areaDebugMarker = {
	// for the debug markers
	// _debugMarker = [_debugMarkerPos, _debugMarkerShape, _debugMarkerAxis, _debugMarkercolor, _debugMarkerText, _debugMarkerBrush, _debugMarkerAlpha] call fnc_SoPop_areaDebugMarker;
	// _debugMarker = [_spawnPos, "ELLIPSE", _spawnArea, "ColorGreen"] call fnc_SoPop_areaDebugMarker;

	params [
		[ "_debugMarkerPos", objNull ], 
		[ "_debugMarkerShape", "ELLIPSE" ], 
		[ "_debugMarkerAxis", [150,150] ], 
		[ "_debugMarkercolor", "ColorYellow" ], 
		[ "_debugMarkerText", "" ], 
		[ "_debugMarkerBrush", "Border" ], 
		[ "_debugMarkerAlpha", 0.9 ] 
	];
	private "_debugMarker";

	if (missionNamespace getVariable ['aDebugMessages',false]) then {
		_debugMarkerPos = _debugMarkerPos call BIS_fnc_position;
		_debugMarkerId = round(random 50000)+100000; 
		_debugMarker = createMarker [format["_USER_DEFINED %1",_debugMarkerId], _debugMarkerPos]; 
		_debugMarker setMarkerShape "ELLIPSE";
		_debugMarker setMarkerSize _debugMarkerAxis;
		_debugMarker setMarkerColor _debugMarkercolor;
		_debugMarker setMarkerText _debugMarkerText;
		_debugMarker setMarkerBrush "Border";
		_debugMarker setMarkerAlpha _debugMarkerAlpha;
	};
	_debugMarker;
};

fnc_SoPop_DefaultRandomInfantryArrays = {
	//	[_randomInfantryArray] = [_side] call fnc_SoPop_DefaultRandomInfantryArrays;
	//	Returns an array of infantry units of a side, formatted to be used in selectRandomWeighted.
	//	Does not include Squad Leaders or Officers or Special Forces (WIP?), but does include team leaders
	// 	Usage:
	//	["B_T_soldier_F",7,"B_T_Soldier_GL_F",4,"B_T_Soldier_AR_F",4] = [blufor] call fnc_SoPop_DefaultRandomInfantryArrays;

	params [
		["_side", blufor]
	];

	private _randomInfantryArray = [];
	switch (_side) do {
		case opfor: {
			_randomInfantryArray = [
				"O_T_Soldier_F", 7,
				"O_T_Soldier_GL_F", 4,
				"O_T_Soldier_AR_F", 4,
				"O_T_medic_F", 4,
				"O_T_Soldier_A_F", 3, //ammobearer
				"O_T_HeavyGunner_F", 3,
				"O_T_soldier_M_F", 2, //marksman
				"O_T_Soldier_lite_F", 3,
				"O_T_Soldier_TL_F", 3,
				"O_T_engineer_F", 1,
				"O_T_Soldier_AA_F", 1,
				"O_T_Soldier_LAT_F", 4, // rpg
				"O_T_Soldier_HAT_F", 3,	// metis
				"O_T_Soldier_AT_F", 2	// atgm
			];
		};
		case independent: {
			_randomInfantryArray = [
				"I_soldier_F", 7,
				"I_Soldier_GL_F", 4,
				"I_Soldier_AR_F", 4,
				"I_medic_F", 4,
				"I_Soldier_A_F", 3, //ammobearer
				"I_Soldier_M_F", 2, //marksman
				"I_Soldier_lite_F", 3,
				"I_Soldier_TL_F", 3,
				"I_engineer_F", 1,
				"I_Soldier_AA_F", 1,
				"I_Soldier_LAT_F", 4, // nlaw
				"I_Soldier_LAT2_F", 4,	// maaws
				"I_Soldier_AT_F", 2		// atgm
			];
		};
		case blufor: {
			_randomInfantryArray = [
				"B_T_Soldier_F", 6,
				"B_T_Soldier_GL_F", 4,
				"B_T_Soldier_AR_F", 4,
				"B_T_medic_F", 4,
				"B_T_Soldier_A_F", 3, //ammobearer
				"B_T_HeavyGunner_F", 3,
				"B_T_soldier_M_F", 2, //marksman
				"B_T_Soldier_lite_F", 3,
				"B_T_Soldier_TL_F", 3,
				"B_T_engineer_F", 1,
				"B_T_Soldier_AA_F", 1,
				"B_T_Soldier_LAT_F", 4, // nlaw
				"B_T_Soldier_LAT2_F", 4,	// maaws
				"B_T_Soldier_AT_F", 2		// atgm
			];
		};
	};
	_randomInfantryArray
};

fnc_SoPop_DefaultSideLeader = {
	//	_className = [_side, _officerAllowed] call fnc_SoPop_DefaultSideLeader;
	//	Returns a string with the class name of a leader-type infantry unit. If _officerAllowed is TRUE, then there's a small chance leader can be an officer.
	// 	Usage:
	//	"B_T_officer_F" = [blufor] call fnc_SoPop_DefaultSideLeader;
	//	"B_T_Soldier_SL_F" = [blufor, FALSE] call fnc_SoPop_DefaultSideLeader;

	params [
		["_side", blufor],
		["_officerAllowed", TRUE]
	];
	
	private _leaderClass = "";
	switch (_side) do {
		case opfor: {
			if (_officerAllowed) then {
				_leaderClass = selectRandomWeighted ["O_T_Soldier_SL_F", 5, "O_T_officer_F", 1];
			} else {
				_leaderClass = "O_T_Soldier_SL_F";
			};
		};
		case independent: {
			if (_officerAllowed) then {
				_leaderClass = selectRandomWeighted ["I_Soldier_SL_F", 5, "I_officer_F", 1];
			} else {
				_leaderClass = "I_Soldier_SL_F";
			};
		};
		case blufor: {
			if (_officerAllowed) then {
				_leaderClass = selectRandomWeighted ["B_T_Soldier_SL_F", 5, "B_T_officer_F", 1];
			} else {
				_leaderClass = "B_T_Soldier_SL_F";
			};
		};
	};
	_leaderClass
};

fnc_SoPop_DefaultVehicleArrays = {
	//	[_pickedVehicle, _kind] = [_side, _kind] call fnc_SoPop_DefaultVehicleArrays;
	//	Returns an array with a string at #0 with a vehicle of a given side and type, and returns the type at #1.
	// 	Usage:
	//	["O_T_APC_Tracked_02_cannon_F", 3] = [blufor, 3] call fnc_SoPop_DefaultVehicleArrays;
	//	([blufor, 3] call fnc_SoPop_DefaultVehicleArrays)#0;
	//	_kind values:
	//	-1 = Random, 1 = Cars, 2 = Trucks, 3 = APCs, 4 = Tanks
	//					leaving 0 free for _kind, to keep it unified with 0 type meaining infantry group

	params [
		["_side", blufor],
		["_kind", -1]
	];

	if (_kind == 0) exitWith {
			["_kind is %1, meaning infantry, nothing will spawn. Mistake?",_kind] call BIS_fnc_error;
			//if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_kind is %1, meaning infantry, nothing will spawn. Mistake?',_kind];};
	};
	if (_kind == -1) then {
		_kind = selectRandomWeighted [1,4, 2,3, 3,2, 4,1];	// [cars,w, trucks,w, apcs,w, tanks,w]
	};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_kind : %1',_kind];};

	private "_pickedVehicle";
	switch (_kind) do {
		case 1: { 
		// cars/jeeps
			switch (_side) do {
				case opfor: {
					_pickedVehicle = selectRandomWeighted [
						"O_T_MRAP_02_hmg_F", 5,
						"O_T_MRAP_02_gmg_F", 1,
						"O_T_LSV_02_armed_F", 3
					];
				};
				case independent: {
					_pickedVehicle = selectRandomWeighted [
						"I_MRAP_03_hmg_F", 4,
						"I_MRAP_03_gmg_F", 1
					];
				};
				case blufor: {
					_pickedVehicle = selectRandomWeighted [
						"B_T_MRAP_01_hmg_F", 5,
						"B_T_MRAP_01_gmg_F", 1,
						"B_T_LSV_01_armed_F", 3
					];
				};
			};
		};
		case 2: { 
		// trucks
			switch (_side) do {
				case opfor: {
					_pickedVehicle = selectRandomWeighted [
						"O_T_Truck_03_covered_F", 1,
						"O_T_Truck_02_covered_F", 3
					];
				};
				case independent: {
					_pickedVehicle = "I_Truck_02_covered_F";
				};
				case blufor: {
					_pickedVehicle = "B_T_Truck_01_covered_F";
				};
			};
		};
		case 3: { 
		// apcs
			switch (_side) do {
				case opfor: {
					_pickedVehicle = selectRandomWeighted [
						"O_T_APC_Tracked_02_cannon_F", 1,
						"O_T_APC_Wheeled_02_rcws_v2_F", 2
					];
				};
				case independent: {
					_pickedVehicle = selectRandomWeighted [
						"I_APC_tracked_03_cannon_F", 1,
						"I_APC_Wheeled_03_cannon_F", 2
					];
				};
				case blufor: {
					_pickedVehicle = selectRandomWeighted [
						"B_T_APC_Wheeled_01_cannon_F", 2,
						"B_T_APC_Tracked_01_rcws_F", 1
					];
				};
			};
		};
		case 4: { 
		// tanks
			switch (_side) do {
				case opfor: {
					_pickedVehicle = selectRandomWeighted [
						"O_T_MBT_04_cannon_F", 3,
						"O_T_MBT_04_command_F", 1,
						"O_T_MBT_02_cannon_F", 7
					];
				};
				case independent: {
					_pickedVehicle = "I_MBT_03_cannon_F";
				};
				case blufor: {
					_pickedVehicle = selectRandomWeighted [
						"B_T_MBT_01_TUSK_F", 1,
						"B_T_MBT_01_cannon_F", 6
					];
				};
			};
		};
	};

	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_pickedVehicle : %1',_pickedVehicle];};
	_pickedVehicleArray = [_pickedVehicle, _kind];
	_pickedVehicleArray

};

// turns the type number into a readable string
fnc_SoPop_typeStringer = {
	params [ ["_type", ""] ];
	private _typeString = "";
	switch (_type) do {
		case 0: { _typeString = "Infantry" };
		case 1: { _typeString = "Car" };
		case 2: { _typeString = "Truck" };
		case 3: { _typeString = "APC" };
		case 4: { _typeString = "Tank" };
	};
	_typeString
};

// turns the job number into a readable string
fnc_SoPop_jobStringer = {
	params [ ["_job", ""] ];
	private _jobstring = "";
	switch (_job) do {
		case 1: { _jobstring = "Defense" };
		case 2: { _jobstring = "Attack" };
		default { _jobstring = "Initial"};
	};
	_jobstring
};

// janitor to clear out deleted groups every 10 sec
fnc_SoPop_janitor = {

	params [
		["_director", SoPopDirector]
	];

	_executeTime = 10; // 10 seconds
	_count = 0;
	
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log '- _janitor -';};
	_janitor = {

		params [
			["_director", SoPopDirector]
		];

		private ["_array","_varName"];
		_varName = "groupsOpfor";
		_array = _director getVariable _varName;
		for "_i" from 0 to 3 do { 
			_tmpArray = (_array #0) - [grpNull];
			_array set [0,_tmpArray];
			_director setVariable [_varName , _array];
		};
		_varName = "groupsBlufor";
		_array = _director getVariable _varName;
		for "_i" from 0 to 3 do { 
			_tmpArray = (_array #0) - [grpNull];
			_array set [0,_tmpArray];
			_director setVariable [_varName , _array];
		};
		_varName = "groupsGuer";
		_array = _director getVariable _varName;
		for "_i" from 0 to 3 do { 
			_tmpArray = (_array #0) - [grpNull];
			_array set [0,_tmpArray];
			_director setVariable [_varName , _array];
		};
	};

	// Clockwork
	_realTickTime = 0; // declare the local variable for the loop compare.

	while {true} do // loops for entire duration that mission/server is running.
	{
		_ticksBegin = round(diag_TickTime); // tick time begin.
		if (_realTickTime >= _executeTime) then // check _realTickTime against _executeTime.
		{
			[_director,0,0,0] call _janitor; // call the function.
			_realTickTime = 0; // reset the timer back to 0 to allow counting to 300 again.
		};
		uiSleep 1; // sleep for one second.
		_ticksEnd = round(diag_TickTime); // tick time end.
		_ticksEndLoop = round(_ticksEnd - _ticksBegin); // get 'real' (rounded) tick time due to loop latency/calls.
		_realTickTime = _realTickTime + _ticksEndLoop; // increase the tick counter.
	};
};

// spawns the director
fnc_SoPop_director = {
	_SoPopDirector_group = createGroup sideLogic;
	SoPopDirector = _SoPopDirector_group createUnit ["Curator_F", [5717,6994,0], [], 0, "FORM"];
	SoPopDirector setVariable ["groupsOpfor", [ [],[],[] ] ];
	SoPopDirector setVariable ["groupsBlufor",[ [],[],[] ] ];
	SoPopDirector setVariable ["groupsGuer",[ [],[],[] ] ];
	// jobs array order;
	// [[mapSpawn],[objectiveDefense],[objectiveAttack]]
	[SoPopDirector] spawn fnc_SoPop_janitor;
};

fnc_SoPop_spawnVehicleUnit = {
	//	_group = [_spawn, _ao, _job, _side, _vehicleClassArray, _maxPassengerAmount, _code, _director] call fnc_SoPop_spawnVehicleUnit;
	//	DESC
	// 	Usage:
	//	_group = [homeOPFOR, ao, 0, OPFOR, ([OPFOR,2] call fnc_SoPop_DefaultVehicleArrays)] call fnc_SoPop_spawnVehicleUnit;

	params [
		["_spawn", objNull],
		["_ao", objNull],
		["_job", 0],
		["_side", OPFOR],
		["_vehicleClassArray", ["",0]],	// ["class name of vehicle", vehicle type (apc, tank etc.)] 
		["_maxPassengerAmount", -1],
		["_code", {}],
		["_director", SoPopDirector]
	];

	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '- fnc_SoPop_spawnVehicleUnit Start -';};
	//-
	if (_maxPassengerAmount == -1) then {
		_maxPassengerAmount = 17;
	};

	// spawn position selection
	_spawnPos = _spawn call BIS_fnc_position;
	_specificSpawn = [_spawnPos, 0, ((triggerArea _spawn #0)+(triggerArea _spawn #1))/2, 8, 0] call BIS_fnc_findSafePos;	// find a safe spawn spot
			//maxDist is the average of the length and the width of the trigger

	// sets AO to be spawn zone, if no AO is set
	if ( _ao == objNull ) then {
		_ao = _spawn;
	};

	// vehicle spawning
	_result = [_specificSpawn, random(360), _vehicleClassArray#0, _side] call BIS_fnc_spawnVehicle;
	_result params ["_vehicle", "_crew", "_group"]; 
	_group deleteGroupWhenEmpty true;

	// passenger spawning
	private _spawnedPassengerAmount = 0;
	while {(_vehicle emptyPositions "cargo" >= 1) && (_spawnedPassengerAmount < _maxPassengerAmount)} do { // as long as there is an empty spot AND _maxPassengerAmount not reached
		_passenger = _group createUnit [selectRandomWeighted ([side _group] call fnc_SoPop_DefaultRandomInfantryArrays), getPos _vehicle, [], 0, "CARGO"];	// creates a random infantry from the _caller's side's list set by fnc_defaultRandomInfantryArrays
		_passenger moveInAny _vehicle;
		_spawnedPassengerAmount = _spawnedPassengerAmount+1;
		//if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_spawnedPassengerAmount : %1',_spawnedPassengerAmount];};
		//if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['emptyPositions : %1',_vehicle emptyPositions "cargo"];};
	};

	_group setCombatMode "RED"; // set's group to open fire (default), and engage at will

	// save group to director
	private "_varname";
	switch (_side) do {
		case "BLUFOR": { _varname = "groupsBlufor" };
		case "independent": { _varname = "groupsGuer" };
		default { _varname = "groupsOpfor" };
	};

	private _directorGroupArray = _director getVariable _varname;
	// [[mapSpawn],[objectiveDefense],[objectiveAttack]]
	(_directorGroupArray #_job) pushBack _group;
	_director setVariable [_varname, _directorGroupArray];	// saves the group to the director

    _group setVariable ["SoPopType", _vehicleClassArray#1];	// saves the group's type ("tank", "apc" etc.)
    _group setVariable ["SoPopJob", _job];	// saves the group's job
    _group setVariable ["SoPopGroupAO", _ao];	// saves the AO to the group
	[_group, _ao] spawn fnc_SoPop_giveOrders;

	[getPos leader _group, "mil_destroy", "ColorBlue", format ["Spawn for %2 %3 Group %1", _group, [_job] call fnc_SoPop_jobStringer,[_vehicleClassArray#1] call fnc_SoPop_typeStringer] ] call fnc_SoPop_DebugMarker;

	_group
	
};

fnc_SoPop_spawnInfantryUnit = {
	//	_group = [_spawn, _ao, _job, _side, _amount, _leaderClass, _code, _director] call fnc_SoPop_spawnInfantryUnit;
	//	DESC
	// 	Usage:
	//	_group = [homeOPFOR, ao, 0, OPFOR, 7] call fnc_SoPop_spawnInfantryUnit;

	params [
		["_spawn", objNull],
		["_ao", objNull],
		["_job", 0],
		["_side", OPFOR],
		["_amount", 6],
		["_leaderClass", ""],
		["_code", {}],
		["_director", SoPopDirector]
	];

	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '- fnc_SoPop_spawnVehicleUnit Start -';};
	//-
	if (_leaderClass == "") then {
		_leaderClass = [_side] call fnc_SoPop_DefaultSideLeader;
	};
	// spawn position selection
	_spawnPos = _spawn call BIS_fnc_position;
	_specificSpawn = [_spawnPos, 0, ((triggerArea _spawn #0)+(triggerArea _spawn #1))/2, 8, 0] call BIS_fnc_findSafePos;	// find a safe spawn spot
			//maxDist is the average of the length and the width of the trigger
	
	// spawn leader
	private _group = createGroup [_side, true];
	_leader = _group createUnit [_leaderClass, _specificSpawn,[], 0, "FORM"];

	// spawn squad
	private _spawnedUnits = 0;
	while {_spawnedUnits < _amount} do {
		_currentSquaddie = _group createUnit [selectRandomWeighted ([side _group] call fnc_SoPop_DefaultRandomInfantryArrays), _specificSpawn, [], 0, "FORM"];	// creates a random infantry from the _caller's side's list set by fnc_defaultRandomInfantryArrays

		_spawnedUnits = _spawnedUnits+1;
		//if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_spawnedPassengerAmount : %1',_spawnedPassengerAmount];};
		//if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['emptyPositions : %1',_vehicle emptyPositions "cargo"];};
	};
	_group setCombatMode "RED"; // set's group to open fire (default), but engage at will

	// save group to director
	private "_varname";
	switch (_side) do {
		case "BLUFOR": { _varname = "groupsBlufor" };
		case "independent": { _varname = "groupsGuer" };
		default { _varname = "groupsOpfor" };
	};

	private _directorGroupArray = _director getVariable _varname;
	// [[patrol],[guard],[station],[travel]]
	(_directorGroupArray #_job) pushBack _group;
	_director setVariable [_varname, _directorGroupArray];	// saves the group to the director

    _group setVariable ["mapPopType", 0];	// saves the group's type ("tank", "apc" etc.)
    _group setVariable ["mapPopJob", _job];	// saves the group's job
    _group setVariable ["mapPopGroupAO", _ao];	// saves the AO to the group
	[_group, _ao] spawn fnc_SoPop_giveOrders;

	[getPos leader _group, "mil_destroy", "ColorBlue", format ["Spawn for %2 %3 Group %1", _group, [_job] call fnc_SoPop_jobStringer,[0] call fnc_SoPop_typeStringer] ] call fnc_SoPop_DebugMarker;

	_group
};

// TODO
fnc_SoPop_giveOrders = {
	params [
		["_group", grpNull],
		["_ao", ao],
		["_blacklist", ["water"]]
	];
	private _job = _group getVariable "mapPopJob";

	switch ( _job) do {
		// guard
		case 1: {
			_group setSpeedMode "LIMITED";
			_group setCombatBehaviour "SAFE";
			// if group is infantry, will use the defend task, if vehicle will patrol the nearby area
			if (_group getVariable ["mapPopType",0] == 0) then {
				[_group, getpos leader _group] call BIS_fnc_taskDefend;
				// moves the marke 10 north for readability
				_mrkpos = getpos leader _group;
				_mrkpos set [1, getpos leader _group #1 + 20];
				[_mrkpos, "hd_arrow_noShadow", "ColorOrange", format["%1 Guard-Defends Here",_group], 0.9, 180] call fnc_mapPop_DebugMarker;
			} else {
    			[_group, getPos leader _group, 300] call BIS_fnc_taskPatrol;
				// moves the marke 10 north for readability
				_mrkpos = getpos leader _group;
				_mrkpos set [1, getpos leader _group #1 + 20];
				[_mrkpos, "hd_arrow_noShadow", "ColorOrange", format["%1 Guard-Patrols Here",_group], 0.9, 180] call fnc_mapPop_DebugMarker;
			};
		};
		// station
		case 2: {
			_group setSpeedMode "LIMITED";
			_group setCombatBehaviour "SAFE";
			// if group is infantry, will use the defend task, if vehicle will just stand there
			if (_group getVariable ["mapPopType",0] == 0) then {
				[_group, getpos leader _group] call BIS_fnc_taskDefend;
				// moves the marke 10 north for readability
				_mrkpos = getpos leader _group;
				_mrkpos set [1, getpos leader _group #1 + 20];
				[_mrkpos, "hd_arrow_noShadow", "ColorOrange", format["%1 Station-Defends Here",_group], 0.9, 180] call fnc_mapPop_DebugMarker;
			} else {
				// moves the marke 10 north for readability
				_mrkpos = getpos leader _group;
				_mrkpos set [1, getpos leader _group #1 + 20];
				[_mrkpos, "hd_arrow_noShadow", "ColorOrange", format["%1 Stationed Here",_group], 0.9, 180] call fnc_mapPop_DebugMarker;
			};
		};
		// travel
		case 3: {

		};
		// patrol
		default {
			while {combatBehaviour _group == "COMBAT"} do {
				sleep 40;
			};
			sleep (random 40 + 30);
			//	reformats the trigger pos and area into a usable format of [[x,y,z], [a, b, angle, rect]], or [[0,0,0], [0,0,0,-1]]
			private _aoPos = getPos _ao;
			private _aoArea = triggerArea _ao;
			private _aoAreaArray = [_aoPos, _aoArea];
			// sends stuff to the group as variables, so the setWaypointStatements has this data to work with.
			_group setVariable ["aoAreaArray", _aoAreaArray];
			_group setVariable ["aoBlacklist", _blacklist];

			_wpPos = [[_aoAreaArray], ["water", _blacklist]] call BIS_fnc_randomPos;
			_wpPos = [_wpPos, 0, 10, 4, 0, 30] call BIS_fnc_findSafePos;	// get a random (accessible) spot for the first WP

			_wp = _group addWaypoint [_wpPos, 0];
			_wp setWaypointType "MOVE";
			// infantry is more chill hike, vehicles will go normal speed but maybe safe maybe aware
			if (_group getVariable ["mapPopType",0] == 0) then {
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointBehaviour "SAFE";
			} else {
				_wp setWaypointSpeed "NORMAL";
				if (selectRandom[TRUE,FALSE]) then {
					_wp setWaypointBehaviour "SAFE";
				} else {
					_wp setWaypointBehaviour "AWARE";
				};
			};
			_wp setWaypointCompletionRadius 1000;
			_wp setWaypointStatements ["true", "[group this, group this getVariable 'mapPopGroupAO'] spawn fnc_mapPop_giveOrders"];
			[waypointPosition _wp, "mil_destroy", "ColorYellow", format["WP for %1",_group]] call fnc_mapPop_DebugMarker;
		};
	};

};