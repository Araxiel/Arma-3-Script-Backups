//server starting
diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

// function for the original example
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

// for the action
debug_sector_spawned = false;
publicVariable "debug_sector_spawned";

// array with all locations
sector_locations = [area_hangars,area_tower,area_field];
publicVariable "sector_locations";
// creating unlock variables
{
	// e.g. area_hangars_ownerWEST_v
	private ['_v'];
	_v = format [ "%1_ownerWEST_v", _x];
	call compile format [ "%1 = false", _v];
	publicVariable call compile str(_v);
	_v = format [ "%1_ownerEAST_v", _x];
	call compile format [ "%1 = false", _v];
	publicVariable call compile str(_v);
	_v = format [ "%1_ownerUNKNOWN_v", _x];
	call compile format [ "%1 = false", _v];
	publicVariable call compile str(_v);
} forEach sector_locations;