fnc_SOsectorCaptured = {
	params [
		["_module", objNull],
		["_ownerSide", sideUnknown],
		["_previousOwnerSide", sideUnknown]
	];

	if (_ownerSide == west) then {
		
	};
	hint format ["Sector:%1, Owner:%2", _module, _ownerSide];
};