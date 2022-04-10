diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";
missionNamespace setVariable ["aDebugMessages", true];

_handle = [] execVM "ar_fnc_mapPopulation.sqf";
waitUntil { isNull _handle };
[] execVM "ar_fnc_mapPopDebug.sqf";

[] call fnc_mapPop_director;
// [[patrol],[guard],[station],[travel]]
mapPopDirector setVariable ["groupsOpforTarget", [ [2],[0],[0],[0] ] ];
[OPFOR] call fnc_mapPop_startSpawn;