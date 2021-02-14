//if we are not the server
if !( isServer ) exitWith {
	//Remote execute on the server
	_this remoteExec[ _fnc_scriptName, 2 ];
};

params [
	['_pos',[0,0,0]]
];

_pos = _pos call BIS_fnc_position;
if ( _pos in [ [0,0,0], [] ] ) exitWith { "Creating Box error: Bad position" call BIS_fnc_error };

_obj = "Box_CSAT_Uniforms_F" createVehicle _pos;

clearItemCargo _obj;
[_obj] call grad_moneymenu_fnc_setStorage;
[_obj, 500] call grad_moneymenu_fnc_addFunds;
