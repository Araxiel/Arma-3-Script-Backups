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

fnc_SoPop_selectUnitFromTags = {
	//	[_selectedType,_selectedSubType] = [_searchKind, _searchTypeTags, _searchSubTypeTags, _budget] call fnc_SoPop_selectUnitFromTags;
	//	Uses input tags, to return a random unit. #0 is the unit type, #1 is the subtype
	// 	Usage:
	//	[missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry", missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry" >> "OpforT] = ["Infantry", ["basic","defense"],["EAST","tropical"], 2] call fnc_SoPop_selectUnitFromTags;
	//	_selectedUnitFromTags = ["Infantry", ["basic","defense"],["EAST","tropical"],6] call fnc_SoPop_selectUnitFromTags;
	//	_selectedUnitFromTags = ["Vehicles", ["armed","car"],["EAST","arid"],-1] call fnc_SoPop_selectUnitFromTags;
	//	
	//	_searchKind values: Infantry, Vehicles

	params [
		["_searchKind", ["Infantry"] ],		// basic type, like "Infantry" or "Vehicles"
		["_searchTypeTags", [] ],			// tags array like ["basic","defense"]
		["_searchSubTypeTags", [] ],		// tags array like ["EAST","arid"]
		["_budget", -1 ]					// budget available for search, aka max cost of a unit; optional, unlimited if left at -1
	];

	private ["_searchTypeCondition","_searchSubTypeCondition"];
	// set
	if (count _searchTypeTags > 0) then {	// if input _searchTypeTags are not empty
		// string assembly
		// turns each entry in the _searchTypeTags array (aka each tag) into a string works as a condition. So "basic" turns into "'basic' in getArray (_x >> 'tags')"
		_searchTypeCondition = _searchTypeTags apply {format ["'%1' in getArray (_x >> 'tags')",_x]};
		// if there is a budget, appends a condition that compares the budget number with the cost entry in the config class 	
		if !(_budget == -1) then {
			_searchTypeCondition pushBack (format ["getNumber (_x >> 'cost') <= %1",_budget])
		};
		// joins all the tag condition strings into one big condition
		_searchTypeCondition = _searchTypeCondition joinString " && ";
		// So ["basic","defense"] and a _budget of 8, turns into: 'basic' in getArray (_x >> 'tags') && 'defense' in getArray (_x >> 'tags') && getNumber (_x >> 'cost') <= 8
	} else {
		_searchTypeCondition = "true";
		// if no tags are given, all tags are accepted
	};


	if (count _searchSubTypeTags > 0) then {
		// string assembly
		_searchSubTypeCondition = _searchSubTypeTags apply {format ["'%1' in getArray (_x >> 'tags')",_x]};
		_searchSubTypeCondition = _searchSubTypeCondition joinString " && ";
	} else {
		_searchSubTypeCondition = "true";
	};

	// selection
	// this command searches through all classes that satisfy the condition; the condition is the assembled string up there
	_potentialTypes = _searchTypeCondition configClasses (missionConfigFile >> "CfgSoPop" >> "Units" >> _searchKind);
	// the command returns an array containing every match, the following selects a random one.
	_selectedType = selectRandom _potentialTypes; // missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry"
	// ditto for subType
	_potentialSubTypes = _searchSubTypeCondition configClasses (_selectedType);
	_selectedSubType = selectRandom _potentialSubTypes; // missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry" >> "OpforT"

	_return = [_selectedType,_selectedSubType];
	_return
};

fnc_SoPop_selectUnitFromTagsDebugSelection = {
	// _x = [10,"Infantry", ["defense"],["EAST"],8] call fnc_SoPop_selectUnitFromTagsDebugSelection; _x
	params [
		["_queries", 10 ],					// how many times it should run
		["_searchKind", ["Infantry"] ],		// basic type, like "infantry" or "vehicle"
		["_searchTypeTags", [] ],			// tags array like ["basic","defense"]
		["_searchSubTypeTags", [] ],		// tags array like ["basic","defense"]
		["_budget", -1 ]					// available budget for each search (individual per search, not total); optional, unlimited if left at -1
	];
	private _returnArray = [];
	private _queryCurrentNum = 0;
	while {_queryCurrentNum < _queries} do {
		_selectedUnitFromTags = [_searchKind, _searchTypeTags,_searchSubTypeTags,_budget] call fnc_SoPop_selectUnitFromTags;
		_selectedUnit = configName (_selectedUnitFromTags #0);
		_selectedSubUnit = configName (_selectedUnitFromTags #1);
		_selectedUnitName = _selectedUnit + ":" + _selectedSubUnit + endl;
		_returnArray pushBack _selectedUnitName;
		_queryCurrentNum = _queryCurrentNum + 1;
	};
	diag_log _returnArray;
	_returnArray
};

fnc_SoPop_spawnInfantrySelectedUnitFromTags = {
	//	_group = [_spawn,_selectedType,_selectedTypeTags,_selectedSubType,_selectedSubTypeTags,_gruntTypeTags,_director] call fnc_SoPop_spawnInfantrySelectedUnitFromTags;
	//	Intended to be used together with and after fnc_SoPop_selectUnitFromTags. Spawns inputed unit. Needs tags and config.
	// 	Usage:
	//	[spawn1, _selectedUnitFromTags #0, _typeTags, _selectedUnitFromTags #1, _subTypeTags] call fnc_SoPop_spawnInfantrySelectedUnitFromTags;
	//	_group = [_spawnTrigger, _selectedUnitFromTags #0, _typeTags, _selectedUnitFromTags #1, _subTypeTags] call fnc_SoPop_spawnInfantrySelectedUnitFromTags;
	//	

	params [
		["_spawn", objNull ],				// trigger area
		["_selectedType", configNull ],		// config entry, like FullSquad
		["_selectedTypeTags", [] ],			// tags array like ["basic","defense"]
		["_selectedSubType", configNull ],	// config entry, like OpforT
		["_selectedSubTypeTags", [] ],		// tags array like ["EAST","tropical"]
		["_gruntTypeTags", [] ],			// tags array like ["EAST","tropical"]; optional, if not set just gonna use _selectedSubTypeTags
		["_director", SoPopDirector ]		// director logic; optional
	];
	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '-- fnc_SoPop_spawnInfantrySelectedUnitFromTags Start --';};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_selectedType : %1', configName _selectedType];};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_selectedSubType : %1', configName _selectedSubType];};

	_leaderClass = [_selectedSubType >> "leader", "STRING", ""] call CBA_fnc_getConfigEntry;
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_leaderClass : %1',_leaderClass];};
	_units = [_selectedSubType >> "units", "ARRAY", "[]"] call CBA_fnc_getConfigEntry;
	//grunts
	if (count _gruntTypeTags == 0) then {
		_gruntTypeTags = _selectedSubTypeTags;
	};
	_gruntAmount = [_selectedSubType >> "randomGrunts", "NUMBER", "0"] call CBA_fnc_getConfigEntry;
	_searchGruntTypesCondition = _gruntTypeTags apply {format ["'%1' in getArray (_x >> 'tags')",_x]};
	_searchGruntTypesCondition = _searchGruntTypesCondition joinString " && ";
	_potentialGruntTypes = _searchGruntTypesCondition configClasses (missionConfigFile >> "CfgSoPop" >> "RandomUnitArrays" >> "Grunts");
	_selectedGruntTypes = selectRandom _potentialGruntTypes; // 'missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry" >> "OpforT"
	_gruntArray = [_selectedGruntTypes >> "weightArray", "ARRAY", "[]"] call CBA_fnc_getConfigEntry;

	_spawnPos = _spawn call BIS_fnc_position;
	_specificSpawn = [_spawnPos, 0, ((triggerArea _spawn #0)+(triggerArea _spawn #1))/2, 8, 0] call BIS_fnc_findSafePos;	// find a safe spawn spot
			//maxDist is the average of the length and the width of the trigger

	private "_side";
	if ("WEST" in _selectedSubTypeTags) then {_side = WEST ;};
	if ("EAST" in _selectedSubTypeTags) then {_side = EAST ;};
	if ("GUER" in _selectedSubTypeTags) then {_side = independent ;};
	if ("CIV" in _selectedSubTypeTags) then {_side = civilian ;};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_side : %1',_side];};

	// leader
	private _group = createGroup [_side, true];
	if !(_leaderClass == "") then {
		if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log 'Leader Spawned';};
		_leader = _group createUnit [_leaderClass, _specificSpawn,[], 0, "FORM"];
	};
	// units
	if (count _units > 0) then {
		{
			_currentSquaddie = _group createUnit [_x, _specificSpawn, [], 0, "FORM"];
			if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log 'Squaddie Spawned';};
		} forEach _units;
	};
	// spawn grunts
	if (_gruntAmount > 0) then {
		private _spawnedGrunts = 0;
		while {_spawnedGrunts < _gruntAmount} do {
			_currentSquaddie = _group createUnit [selectRandomWeighted _gruntArray, _specificSpawn, [], 0, "FORM"];
			_spawnedGrunts = _spawnedGrunts+1;
			if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log 'Grunt Spawned';};
		};
	};

	private _code = [_selectedSubType >> "code", "STRING", ""] call CBA_fnc_getConfigEntry;
	if !(_code == "") then {
		_codeCompiled = call compile _code;
		[_group,_selectedType,_selectedSubType] call _codeCompiled;
		if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['code run: %1',_codeCompiled];};
	};

	// save group to director
	private "_varname";
	switch (_side) do {
		case "BLUFOR": { _varname = "groupsBlufor" };
		case "independent": { _varname = "groupsGuer" };
		default { _varname = "groupsOpfor" };
	};

	/*
		private _directorGroupArray = _director getVariable _varname;
		// [[patrol],[guard],[station],[travel]]
		(_directorGroupArray #_job) pushBack _group;
		_director setVariable [_varname, _directorGroupArray];	// saves the group to the director
	*/

	_group setVariable ["SoPopTypeConfig", _selectedType];	// saves the group's type ("tank", "apc" etc.)
	_group setVariable ["SoPopSubTypeConfig", _selectedSubType];	// saves the group's type ("tank", "apc" etc.)
	_group setVariable ["SoPopGroupSpawnArea", _spawn];	// saves the spawn to the group

	//[getPos leader _group, "mil_destroy", "ColorBlue", format ["Spawn for %2 %3 Group %1", _group, [_job] call fnc_mapPop_jobStringer,[0] call fnc_mapPop_typeStringer] ] call fnc_mapPop_DebugMarker;
	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '-- fnc_SoPop_spawnInfantrySelectedUnitFromTags Done --';};
	_group
};

fnc_SoPop_spawnVehicleSelectedUnitFromTags = {
	// _group = [_spawnTrigger, _selectedUnitFromTags #0, _typeTags, _selectedUnitFromTags #1, _subTypeTags] call fnc_SoPop_spawnInfantrySelectedUnitFromTags;

	params [
		["_spawn", objNull ],				// trigger area
		["_selectedType", configNull ],		// config entry, like CarArmed
		["_selectedTypeTags", [] ],			// tags array like ["attack","armed"]
		["_selectedSubType", configNull ],	// config entry, like MrapHmgT
		["_selectedSubTypeTags", [] ],		// tags array like ["EAST","tropical","machinegun"]
		["_randomize", true ],				// boolean if vehicle attributes (like camo-netting etc.) should be randomized (if available); optional
		["_spawnGrunts", true ],			// boolean if passenger grunts should be spawned; optional
		["_director", SoPopDirector ]		// director logic; optional
	];

	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '-- fnc_SoPop_spawnVehicleSelectedUnitFromTags Start --';};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_selectedType : %1', configName _selectedType];};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_selectedSubType : %1', configName _selectedSubType];};

	_vehicle = [_selectedSubType >> "vehicle", "STRING", ""] call CBA_fnc_getConfigEntry;
	//grunts
	_gruntAmount = [_selectedSubType >> "randomGrunts", "NUMBER", "0"] call CBA_fnc_getConfigEntry;
	_gruntTypeTags = [_selectedSubType >> "gruntTags", "ARRAY", "[]"] call CBA_fnc_getConfigEntry;
	_searchGruntTypesCondition = _gruntTypeTags apply {format ["'%1' in getArray (_x >> 'tags')",_x]};
	_searchGruntTypesCondition = _searchGruntTypesCondition joinString " && ";
	_potentialGruntTypes = _searchGruntTypesCondition configClasses (missionConfigFile >> "CfgSoPop" >> "RandomUnitArrays" >> "Grunts");
	_selectedGruntTypes = selectRandom _potentialGruntTypes; // 'missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry" >> "OpforT"
	_gruntArray = [_selectedGruntTypes >> "weightArray", "ARRAY", "[]"] call CBA_fnc_getConfigEntry;

	_spawnPos = _spawn call BIS_fnc_position;
	_specificSpawn = [_spawnPos, 0, ((triggerArea _spawn #0)+(triggerArea _spawn #1))/2, 8, 0] call BIS_fnc_findSafePos;	// find a safe spawn spot
			//maxDist is the average of the length and the width of the trigger

	private "_side";
	if ("WEST" in _selectedSubTypeTags) then {_side = WEST ;};
	if ("EAST" in _selectedSubTypeTags) then {_side = EAST ;};
	if ("GUER" in _selectedSubTypeTags) then {_side = independent ;};
	if ("CIV" in _selectedSubTypeTags) then {_side = civilian ;};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_side : %1',_side];};

	// leader
	private _group = createGroup [_side, true];
    _resultVehicle = [_specificSpawn, 0, _vehicle, _group] call BIS_fnc_spawnVehicle;
	_resultVehicle params ["_vehicle", "_crew", "_group"];

	private _spawnedPassengerAmount = 0;
	while {(_vehicle emptyPositions "cargo" >= 1) && (_spawnedPassengerAmount < _gruntAmount)} do { // as long as there is an empty spot AND _gruntAmount not reached
		_currentSquaddie = _group createUnit [selectRandomWeighted _gruntArray, getPos _vehicle, [], 0, "CARGO"];
	    _currentSquaddie moveInCargo _vehicle;
		_spawnedPassengerAmount = _spawnedPassengerAmount+1;
		if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_spawnedPassengerAmount : %1',_spawnedPassengerAmount];};
	};

	private _code = [_selectedSubType >> "code", "STRING", ""] call CBA_fnc_getConfigEntry;
	if !(_code == "") then {
		_codeCompiled = call compile _code;
		[_group,_selectedType,_selectedSubType] call _codeCompiled;
	};

	// save group to director
	private "_varname";
	switch (_side) do {
		case "BLUFOR": { _varname = "groupsBlufor" };
		case "independent": { _varname = "groupsGuer" };
		default { _varname = "groupsOpfor" };
	};

	_group setVariable ["SoPopTypeConfig", _selectedType];	// saves the group's type ("tank", "apc" etc.)
	_group setVariable ["SoPopSubTypeConfig", _selectedSubType];	// saves the group's type ("tank", "apc" etc.)
	_group setVariable ["SoPopGroupSpawnArea", _spawn];	// saves the spawn to the group

	//[getPos leader _group, "mil_destroy", "ColorBlue", format ["Spawn for %2 %3 Group %1", _group, [_job] call fnc_mapPop_jobStringer,[0] call fnc_mapPop_typeStringer] ] call fnc_mapPop_DebugMarker;
	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '-- fnc_SoPop_spawnInfantrySelectedUnitFromTags Done --';};
	_group

};
//-------------------------------------------------------------
// dedicated unit functions

fnc_OfficerRetinue = {
	params [
		["_group", grpNull],
		["_selectedType", configNull ],
		["_selectedSubType", configNull ]
	];
	_groupArray = units _group;
	_radiomanArrayID = _groupArray findIf {
		typeOf _x == "O_Soldier_lite_F" ||
		typeOf _x == "O_T_Soldier_F"	||
		typeOf _x == "B_Soldier_lite_F"	||
		typeOf _x == "B_T_Soldier_F"    ||
		typeOf _x == "I_Soldier_lite_F"
	};
	_designatedRadioman = _groupArray select _radiomanArrayID;
	private "_radio";
	switch (side _designatedRadioman) do {
		case EAST:			{ _radio = "B_RadioBag_01_black_F"};
		case WEST: 			{ _radio = "B_RadioBag_01_mtp_F"};
		case independent: 	{ _radio = "B_RadioBag_01_digi_F"};
		default 			{ _radio = "B_RadioBag_01_black_F"};
	};
	removeBackpack _designatedRadioman;
	_designatedRadioman addBackpack _radio;
};