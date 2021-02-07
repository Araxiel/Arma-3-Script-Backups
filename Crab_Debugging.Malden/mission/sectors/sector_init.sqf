// 1, 2 = road
spawnpoints_enemy_road = [spawn_hostile_1, spawn_hostile_2];
// 3 = distant
spawnpoints_enemy_distant = [spawn_hostile_3];
// all spawns
spawnpoints_enemy = [];
spawnpoints_enemy append spawnpoints_enemy_road;
spawnpoints_enemy append spawnpoints_enemy_distant;

// All sectors
sectors_all = [sector_alpha,sector_beta,sector_gamma,sector_delta];
diag_log str(sectors_all);
// Sectors Array Inits
sectors_opfor = [];
sectors_blufor = [];
sectors_unknown = [];

sleep 1;
{
	if (_x getVariable "owner"  == EAST) then {
		sectors_opfor pushBack _x;
	};
	if (_x getVariable "owner"  == WEST) then {
		sectors_blufor pushBack _x;
	};
	if (_x getVariable "owner"  == sideUnknown) then {
		sectors_unknown pushBack _x;
	};
} forEach sectors_all;

//TODO put sector income

diag_log "-- Sectors init finished --";