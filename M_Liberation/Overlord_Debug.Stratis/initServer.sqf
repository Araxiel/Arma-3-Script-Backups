diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

TAG_fnc_createTrigger = {
	params[ "_pos", "_area" ];

	//Create a trigger
	_trigger = createVehicle [ "EmptyDetector", _pos, [], 0, "CAN_COLLIDE" ];
	//Set trigger area
	_trigger setTriggerArea _area;

	//May want to make sure all clients and servers triggers are the same dimensions
	//just in case they are used for something else as setTriggerArea is a local command
	//Shouldnt matter just for a sector as everthing is handled server side
	//[ _trigger, _area ] remoteExec [ "setTriggerArea", 0 ];

	_trigger
};

unlock_varname_list = [];

income_multiplier = 10.2;
base_income = 100;
gained_income = 0;
execVM "mission\timer.sqf";