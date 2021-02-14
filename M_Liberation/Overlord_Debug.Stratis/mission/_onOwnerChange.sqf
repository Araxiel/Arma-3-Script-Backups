// Script being executed on captured sector

if !( isServer ) exitWith {
	//Remote execute on the server
	_this remoteExec[ _fnc_scriptName, 2 ];
};

params [
	['_sector', objNull],
	['_owner', sideUnknown],
	['_oldOwner', sideUnknown],
	['_location', objNull]
];

diag_log format ["%1 capped by %2!", _location, _owner];

if !( _owner isEqualTo sideUnknown ) then {
	_trigger_unlock = format["%1_owner%2_v",_location,_owner]; // eg: area_hangars_ownerWEST_v
	call compile format [ "%1 = true", _trigger_unlock];

	if (str(_location) == 'area_hangars' && _owner == WEST) then {
		[WEST,area_hangar_respawn_point,"str_area_hangars" call BIS_fnc_localize] call BIS_fnc_addRespawnPosition; 
		diag_log "hangar_capped.sqf gonna be called";
		execVM "sectors\hangar_capped.sqf";
	};
	if (str(_location) == 'area_tower' && _owner == WEST) then {
		[WEST,area_tower_respawn_point,"str_area_tower" call BIS_fnc_localize] call BIS_fnc_addRespawnPosition; 
		execVM "sectors\tower_capped.sqf";
	};

	if ( missionNamespace getVariable "sector_locations" findIf { _x == _location } > -1 && _owner == WEST) then {
		[_location,_sector] execVM "phase_cap.sqf";
	};
};