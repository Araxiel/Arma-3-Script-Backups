// Sector Capping DEBUG MISSION Cap done
if !( isServer ) exitWith {
	//Remote execute on the server
	_this remoteExec[ _fnc_scriptName, 2];
};

params [
	['_pos', objNull],
	['_sector', objNull]
];

_pos = _pos call BIS_fnc_position;

diag_log format ["%1 sector at %2", _sector, _pos];
_empty_pos = [_pos, 0, 80, 15, 0, 0.15, 0,[], [_pos, _pos]] call BIS_fnc_findSafePos;
_empty_pos pushBack 0;
diag_log "Position found";
"Land_HelipadEmpty_F" createVehicle _empty_pos;
diag_log "Helipad made";
_marker = createMarker [format["%1_respawn_marker",_pos], _empty_pos];
_marker setMarkerType "mil_circle";
_marker setMarkerColor "ColorWEST";
diag_log "Marker made";
_respawn = [WEST,_empty_pos,format["%1 spawn",_pos]] call BIS_fnc_addRespawnPosition;
diag_log "Respawn made";
_empty_pos_float = _empty_pos;
_empty_pos_float set [2, 4];
"VR_3DSelector_01_exit_F" createVehicle _empty_pos_float;
diag_log "Selector made";

[_pos,3,helo_spawn,50,"",0,"","",true,true] execVM "scripts\helo_random_cargo_delivery.sqf";
[_pos] execVM "scripts\sector_cap_ship_spawn.sqf";
