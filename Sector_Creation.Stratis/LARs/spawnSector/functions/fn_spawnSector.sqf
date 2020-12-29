
/*****
******
	Original file: fn_spawnSector.sqf
	Written by Larrow
	Sunday, 4 December 2018
	Originally posted @:https://forums.bohemia.net/forums/topic/181264-sector-module-scripting/?do=findComment&comment=3294957
******
	You are free to modifiy and distribute this file as long as this header is kept intact
******
	Description: Spawn a module sector
******
	0: _pos (Array, Object, Marker, Group, Location) - Position to spawn sector at

	//Anything from here on are optional parameters

	1: _name (String) - Name of sector as shown on map
	2: _designation (String) - Designation shown on both map and in sectors ui
	3: _sectorArea (Array, Object "Trigger" or "LocationArea_F") - Sectors trigger area in [ radius X, radius Y, direction, isRectangle ] see setTriggerArea OR an existing trigger or locationArea_F( with trigger attached, same as a default setup in the editor )
	4: _sides (Array) - Array of sides that can capture the sector, if [] used sides will be [east,west,resistance,civilian], if nil defaults to [east,west], not available through editor attributes and is usually defined by syncing side logics to the sector module
	5: _defaultOwner (Number, Side) - Initial owner of the sector when created, for no owner use either sideUnknown or -1
	6: _onOwnerChange (String) - Code as STRING that runs when a sector is captured, code is passed [ _sector, _owner, _oldOwner ] in _this, code is also run at sector initialisation _owner will be default owner and _oldOwner will be sideUnknown

	//Score award
	7: _scoreReward (Number) - Score given to side for capturing sector

	//Tasks and rewards
	8: _taskOwner (Number) - 0 = no task, 1 = everyone, 2 = default owner, 3 = all but default owner
	9: _taskTitle (String) - Task title, use %1 to insert sector name
	10: _taskDescription (String) - Task Description, use %1 to inser sector name, %2 to insert sector rewards ( vehicles and respawn positions, these will need to be created seperately and synced with a existing trigger that is passed in param 3 ), %3 for capture costs description

	//Capture limits and coef cost, these are the same as the attributes that can be seen when viewing a sectors attributes in the editor
	11: _ownerLimit (Number) - Range <0-1> that a side must be dominent to cpature sector
	12: _costInfantry (Number) - Ratio of how fast Infantry will capture area
	13: _costWheeled (Number) - Ratio of how fast Wheeled vehicles will capture area
	14: _costTracked (Number) - Ratio of how fast Tracked vehicles will capture area
	15: _costWater (Number) - Ratio of how fast Naval vehicles will capture area
	16: _costAir (Number) - Ratio of how fast Air vehicles will capture area
	17: _costPlayers (Number) - Ratio of how fast Players will capture area

	//Values not available through editor attributes
	18: _captureCoef (Number) - ?Some Time based coef added to scores
******
******/


//if we are not the server
if !( isServer ) exitWith {
	//Remote execute on the server
	_this remoteExec[ _fnc_scriptName, 2 ];
};

params[
	//Position to place sector
	[ "_pos", objNull, [ [], objNull, "", grpNull, locationNull ], [ 2, 3 ] ],
	//Name as shown on map
	[ "_name", "", [ "" ] ],
	//Designation as shown on map/sector ui icon
	[ "_designation", "", [ "" ] ],

	//Sector trigger area in [ radius X, radius Y, direction, isRectangle, radiusZ ] see setTriggerArea
	[ "_sectorArea", [ 50, 50, 0, false ], [ [], objNull ] ],
	//Sides competing for sector
	[ "_sides", [ east, west ], [ [] ] ],
	//Initial default owner, must be in competing sides
	[ "_defaultOwner", -1, [ 0, sideUnknown ] ],
	//Code as STRING that is run when sector changes ownership
	[ "_onOwnerChange", "true", [ "" ] ],

	//score awarded to capturing side
	[ "_scoreReward", 0, [ 0 ] ],

	//Sector task and rewards
	[ "_taskOwner", 0, [ 0 ] ],//0 - no task, 1 - everyone, 2 - default owner, 3 - all but default owner
	[ "_taskTitle", "", [ "" ] ],
	[ "_taskDescription", "", [ "" ] ],

	//Optional Sector capture coefs and costs
	[ "_ownerLimit", 0, [ 0 ] ],
	[ "_costInfantry", 1, [ 0 ] ],
	[ "_costWheeled", 1, [ 0 ] ],
	[ "_costTracked", 1, [ 0 ] ],
	[ "_costWater", 1, [ 0 ] ],
	[ "_costAir", 1, [ 0 ] ],
	[ "_costPlayers", 1, [ 0 ] ],

	//Not avaiable in editor attributes
	[ "_captureCoef", 0.05, [ 0 ] ]
];

_pos = _pos call BIS_fnc_position;
if ( _pos in [ [0,0,0], [] ] ) exitWith { "Creating Sector error: Bad position" call BIS_fnc_error };

if ( _defaultOwner isEqualType sideUnknown ) then {
	if ( _defaultOwner isEqualTo sideUnknown ) then {
		_defaultOwner = -1;
	}else{
		_defaultOwner = _defaultOwner call BIS_fnc_sideID;
	};
};

//If the user has passed a trigger OR location instead of a trigger area definition
if ( _sectorArea isEqualType objNull ) then {
	_sectorArea = switch ( typeOf _sectorArea ) do {
		case "EmptyDetector" : {
			_location = createGroup sideLogic createUnit [ "LocationArea_F", getPosATL _sectorArea, [], 0, "CAN_COLLIDE" ];
			_location synchronizeObjectsAdd[ _sectorArea ];
			str ( _location call BIS_fnc_netId );
		};
		case "LocationArea_F" : {
			str ( _sectorArea call BIS_fnc_netId );
		};
		default {
			[ 50, 50, 0, false ];
		};
	};
}else{
	//lets make sure area definition is correct
	_sectorArea params[
		[ "_radiusX", 50, [ 0 ] ],
		[ "_radiusY", 50, [ 0 ] ],
		[ "_dir", 0, [ 0 ] ],
		[ "_isRect", false, [ true ] ],
		[ "_radiusZ", -1 ]
	];

	_sectorArea = [ _radiusX, _radiusY, _dir, _isRect ];
};

//Create the sector logic
"ModuleSector_F" createUnit [ _pos, createGroup sideLogic, format[ "
	this setvariable [ 'BIS_fnc_initModules_disableAutoActivation', false ];
	this setVariable [ 'name', '%1' ];
	this setVariable [ 'Designation', '%2' ];
	this setVariable [ 'OwnerLimit', '%4' ];
	this setVariable [ 'OnOwnerChange', %5 ];
	this setVariable [ 'CaptureCoef', '%6' ];
	this setVariable [ 'CostInfantry', '%7' ];
	this setVariable [ 'CostWheeled', '%8' ];
	this setVariable [ 'CostTracked', '%9' ];
	this setVariable [ 'CostWater', '%10' ];
	this setVariable [ 'CostAir', '%11' ];
	this setVariable [ 'CostPlayers', '%12' ];
	this setVariable [ 'DefaultOwner', '%13' ];
	this setVariable [ 'TaskOwner', '%14' ];
	this setVariable [ 'TaskTitle', %15 ];
	this setVariable [ 'taskDescription', %16 ];
    this setVariable [ 'ScoreReward', '%17' ];
	this setVariable [ 'Sides', %18 apply{ _x call BIS_fnc_sideType }];

	if ( %3 isEqualType '' ) then {
		this synchronizeObjectsAdd[ %3 call BIS_fnc_objectFromNetID ];
	}else{
		this setVariable [ 'objectArea', %3 ];
	};
",	_name, _designation, _sectorArea, _ownerLimit, str _onOwnerChange, _captureCoef, _costInfantry, _costWheeled, _costTracked, _costWater, _costAir, _costPlayers, _defaultOwner, _taskOwner, str _taskTitle, str _taskDescription, _scoreReward, _sides apply { _x call BIS_fnc_sideID } ]];



