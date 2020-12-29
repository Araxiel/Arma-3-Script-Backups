// execVM "sectors\tower_capped.sqf";
diag_log "tower_capped.sqf running";

apc_respawn = [WEST,tower_spawn_apc,"APC"] call BIS_fnc_addRespawnPosition;
_eh = tower_spawn_apc addEventHandler ["killed", {execVM "sectors\destroyed_respawn_apc.sqf"}];