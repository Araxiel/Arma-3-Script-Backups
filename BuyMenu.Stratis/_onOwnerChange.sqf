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

if !( _owner isEqualTo sideUnknown ) then {
	diag_log format ["%1 capped by %2 from %3!", _location, _owner, _oldOwner];
	_trigger_unlock = format["%1_owner%2_v",_location,_owner]; // eg: loc_alpha_ownerWEST_v
	call compile format [ "%1 = true", _trigger_unlock];

	if ( missionNamespace getVariable "sector_locations" findIf { _x == _location } > -1 && _owner == WEST) then {

		[_location,_sector] execVM "phase_cap.sqf";
	};
};