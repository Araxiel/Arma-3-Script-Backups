ar_fn_closestMortarOpfor = {
	//	_mortarArray = [_source] call ar_fn_closestMortarOpfor;
	params [
		["_source", objNull]
	];
	_pos = _source call BIS_fnc_position;
	_returnArray = nearestObjects [_pos, ["O_Mortar_01_F"], 4000];
	_returnArray
};