if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log "mission\sectors\sector_capped.sqf";
};

params [
	['_sector', objNull],
	['_owner', sideUnknown],
	['_oldOwner', sideUnknown]
];