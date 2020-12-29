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
_empty_pos = [_pos, 0, 80, 15, 0, 0.15, 0,[], [_pos, _pos]] call BIS_fnc_findSafePos;	// find safe position nearby
_empty_pos pushBack 0;
"Land_HelipadEmpty_F" createVehicle _empty_pos;	// makes Helipad
// Respawn marker
_marker = createMarker [format["%1_respawn_marker",_pos], _empty_pos];
_marker setMarkerType "mil_circle";
_marker setMarkerColor "ColorWEST";
_respawn = [WEST,_empty_pos,format["%1 spawn",_pos]] call BIS_fnc_addRespawnPosition;
// Make a 3D marker
_empty_pos_float = _empty_pos;
_empty_pos_float set [2, 20];
"VR_3DSelector_01_exit_F" createVehicle _empty_pos_float;
// Call Helo Drop
[_pos,1,objNull,50,"",0,"","",true,true] execVM "scripts\helo_random_cargo_delivery.sqf";