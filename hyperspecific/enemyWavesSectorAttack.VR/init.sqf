missionNamespace setVariable ["aDebugMessages", true];
missionNamespace setVariable ["aDebugMode", true];
if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log '- ---- -';};
if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '- Mission Start -';};
execVM "setupDirector.sqf";
if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '- Init Done -';};
