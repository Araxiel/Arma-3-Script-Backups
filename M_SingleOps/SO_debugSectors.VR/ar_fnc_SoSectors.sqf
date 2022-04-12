fnc_SOsectorCaptured = {
	params [
		["_sector", objNull],
		["_ownerSide", sideUnknown],
		["_previousOwnerSide", sideUnknown]
	];
	
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_sector : %1',_sector];};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_ownerSide : %1',_ownerSide];};
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_previousOwnerSide : %1',_previousOwnerSide];};
	_previousRealOwnerSide = _sector getVariable "previousRealOwnerSide";
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['previousPreviousOwnerSide : %1',_previousRealOwnerSide];};

	if ( _ownerSide == sideUnknown ) then {
		_sector setVariable ["previousRealOwnerSide",_previousOwnerSide];
	};

	if (_sector == sectorA) then {
		if (_ownerSide == east && _previousRealOwnerSide == west) then {
			[] spawn {
				sleep 10;
				["EndFailureAirport", false] call BIS_fnc_endMission;
			};
		};
		if (_ownerSide == west && _previousRealOwnerSide == east) then {
			[] spawn {
				sleep 10;
				["EndFailureAirport", false] call BIS_fnc_endMission;
			};
		};
	};

};