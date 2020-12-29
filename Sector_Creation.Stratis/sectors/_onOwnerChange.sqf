private[ '_sector', '_owner', '_oldOwner','_location'];

_sector = _this # 0;
_owner = _this # 1;
_oldOwner = _this # 2;
_location = _this # 3;

diag_log format ["%1 capped by %2!", _location, _owner];

if !( _owner isEqualTo sideUnknown ) then {
	_trigger_unlock = format["%1_owner%2_v",_location,_owner]; // eg: area_hangars_ownerWEST_v
	diag_log format ["unlock: %1", _trigger_unlock];
	call compile format [ "%1 = true", _trigger_unlock];
	publicVariable call compile str(_trigger_unlock);

	if (str(_location) == 'area_hangars' && _owner == WEST) then {
		[WEST,area_hangar_respawn_point,"str_area_hangars" call BIS_fnc_localize] call BIS_fnc_addRespawnPosition; 
		diag_log "hangar_capped.sqf gonna be called";
		execVM "sectors\hangar_capped.sqf";
	};
	if (str(_location) == 'area_tower' && _owner == WEST) then {
		[WEST,area_tower_respawn_point,"str_area_tower" call BIS_fnc_localize] call BIS_fnc_addRespawnPosition; 
		execVM "sectors\tower_capped.sqf";
	};
};