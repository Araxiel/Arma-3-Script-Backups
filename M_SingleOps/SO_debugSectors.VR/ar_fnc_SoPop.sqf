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
	//	[_selectedType,_selectedSubType] = [_searchKind, _searchTypeTags, _searchSubTypeTags] call fnc_SoPop_selectUnitFromTags;
	//	Uses input tags, to return a random unit. #0 is the unit type, #1 is the subtype
	// 	Usage:
	//	[missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry", missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry" >> "OpforT] = ["Infantry", ["basic","defense"],["EAST","tropical"] ] call fnc_SoPop_selectUnitFromTags;
	//	_selectedUnitFromTags = ["Infantry", ["basic","defense"],["EAST","tropical"] ] call fnc_SoPop_selectUnitFromTags;
	//	
	//	_searchKind values: Infantry, Vehicles

	params [
		["_searchKind", ["Infantry"] ],
		["_searchTypeTags", [] ],
		["_searchSubTypeTags", [] ]
	];

	private ["_searchTypeCondition","_searchSubTypeCondition"];
	// set
	if (count _searchTypeTags > 0) then {
		// string assembly
		_searchTypeCondition = _searchTypeTags apply {format ["'%1' in getArray (_x >> 'tags')",_x]};
		_searchTypeCondition = _searchTypeCondition joinString " && ";
	} else {
		_searchTypeCondition = "true";
	};

	if (count _searchSubTypeTags > 0) then {
		// string assembly
		_searchSubTypeCondition = _searchSubTypeTags apply {format ["'%1' in getArray (_x >> 'tags')",_x]};
		_searchSubTypeCondition = _searchSubTypeCondition joinString " && ";
	} else {
		_searchSubTypeCondition = "true";
	};

	// selection
	_potentialTypes = _searchTypeCondition configClasses (missionConfigFile >> "CfgSoPop" >> "Units" >> _searchKind);
	_selectedType = selectRandom _potentialTypes; // missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry"
	_potentialSubTypes = _searchSubTypeCondition configClasses (_selectedType);
	_selectedSubType = selectRandom _potentialSubTypes; // missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry" >> "OpforT"

	_return = [_selectedType,_selectedSubType];
	_return
};

fnc_SoPop_spawnSelectUnitFromTags = {
	//	_group = [_spawn,_selectedType,_selectedTypeTags,_selectedSubType,_selectedSubTypeTags,_director] call fnc_SoPop_spawnSelectUnitFromTags;
	//	Intended to be used together with and after fnc_SoPop_selectUnitFromTags. Spawns inputed unit. Needs tags and config.
	// 	Usage:
	//	[spawn1, _selectedUnitFromTags #0, _typeTags, _selectedUnitFromTags #1, _subTypeTags, SoPopDirector] call fnc_SoPop_spawnSelectUnitFromTags;
	//	_group = [_spawnTrigger, _selectedUnitFromTags #0, _typeTags, _selectedUnitFromTags #1, _subTypeTags] call fnc_SoPop_spawnSelectUnitFromTags;
	//	

	params [
		["_spawn", objNull ],
		["_selectedType", configNull ],
		["_selectedTypeTags", [] ],
		["_selectedSubType", configNull ],
		["_selectedSubTypeTags", [] ],
		["_director", SoPopDirector ]
	];
	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '-- fnc_SoPop_spawnSelectedUnitFromTags Start --';};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_selectedType : %1', configName _selectedType];};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_selectedSubType : %1', configName _selectedSubType];};

	_leaderClass = [_selectedSubType >> "leader", "STRING", ""] call CBA_fnc_getConfigEntry;
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_leaderClass : %1',_leaderClass];};
	_units = [_selectedSubType >> "units", "ARRAY", ""] call CBA_fnc_getConfigEntry;
	//grunts
	_gruntAmount = [_selectedSubType >> "randomGrunts", "NUMBER", "0"] call CBA_fnc_getConfigEntry;
	_searchGruntTypesCondition = _selectedSubTypeTags apply {format ["'%1' in getArray (_x >> 'tags')",_x]};
	_searchGruntTypesCondition = _searchGruntTypesCondition joinString " && ";
	_potentialGruntTypes = _searchGruntTypesCondition configClasses (missionConfigFile >> "CfgSoPop" >> "RandomUnitArrays" >> "Grunts");
	_selectedGruntTypes = selectRandom _potentialGruntTypes; // 'missionConfigFile >> "CfgSoPop" >> "Units" >> "Infantry" >> "Sentry" >> "OpforT"
	_gruntArray = [_selectedGruntTypes >> "weightArray", "ARRAY", "0"] call CBA_fnc_getConfigEntry;

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

	[getPos leader _group, "mil_destroy", "ColorBlue", format ["Spawn for %2 %3 Group %1", _group, [_job] call fnc_mapPop_jobStringer,[0] call fnc_mapPop_typeStringer] ] call fnc_mapPop_DebugMarker;
	if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '-- fnc_SoPop_spawnSelectedUnitFromTags Done --';};
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
		typeOf _x == "B_T_Soldier_lite_F"||
		typeOf _x == "I_Soldier_lite_F"
		};
	_designatedRadioman = _groupArray select _radiomanArrayID;
	private "_radio";
	switch (side _designatedRadioman) do {
		case "EAST": { _radio = "B_RadioBag_01_black_F"};
		case "WEST": { _radio = "B_RadioBag_01_mtp_F"};
		case "GUER": { _radio = "B_RadioBag_01_digi_F"};
		default { _radio = "B_RadioBag_01_black_F"};
	};
	removeBackpack _designatedRadioman;
	_designatedRadioman addBackpack _radio;
};