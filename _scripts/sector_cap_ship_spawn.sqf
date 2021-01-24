
if !( isServer ) exitWith {
	//Remote execute on the server
	_this remoteExec[ _fnc_scriptName, 2];
};

params [
	['_pos',[0,0,0]]
];

_pos = _pos call BIS_fnc_position;
if ( _pos in [ [0,0,0], [] ] ) exitWith { "Creating Sjip error: Bad position" call BIS_fnc_error };

// ship creation
for "_i" from 0 to 1 do {
	_sea_landing_pos = [_pos, 0, 150, 5, 2, 0, 1,[], [_pos, _pos]] call BIS_fnc_findSafePos;  
	_sea_landing_pos pushback 0.1; 
	_obj = "Sign_Sphere200cm_F" createVehicle _sea_landing_pos; 
	_obj setPos _sea_landing_pos; 

	private _shiptype = "B_Boat_Armed_01_minigun_F";	
	if ( activatedAddons findIf { _x == "rksla3_lcvpmk5" } > -1 ) then {
		_shiptype = selectRandom ["rksla3_lcvpmk5","rksla3_lcvpmk5_viv"];
	};

	//_result = [getPos sea_spawn, (getPos sea_spawn) getDir _sea_landing_pos, "B_Boat_Armed_01_minigun_F", WEST] call BIS_fnc_spawnVehicle;  
	_result = [getPos sea_spawn, (getPos sea_spawn) getDir _sea_landing_pos, _shiptype, WEST] call BIS_fnc_spawnVehicle;
	_result params ["_vehicle", "_crew", "_group"];  
	_result #2 deleteGroupWhenEmpty true;  
	
	_wp = _result #2 addWaypoint [_sea_landing_pos, 0];  
	_wp setWaypointType "MOVE";
	sleep 20;
};
diag_log "Ships created";