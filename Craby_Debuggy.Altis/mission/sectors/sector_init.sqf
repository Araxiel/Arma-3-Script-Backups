// 1, 2 = road
spawnpointsEnemyNormal = [spawnHostile_1, spawnHostile_2];
// 3 = distant
spawnpointsEnemyDistant = [spawnHostile_3];
// all spawns
spawnpointsEnemy = [];
spawnpointsEnemy append spawnpointsEnemyNormal;
spawnpointsEnemy append spawnpointsEnemyDistant;

// All sectors
sectorsAll = [ sectorAlpha, sectorBeta, sectorGamma, sectorDelta, sectorEpsilon ];
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log str(sectorsAll);
};
// Sectors Array Inits
sectorsOpfor = [];
sectorsBlufor = [];
sectorsUnknown = [];

sleep 1;
{
	if (_x getVariable "owner"  == EAST) then {
		sectorsOpfor pushBack _x;
	};
	if (_x getVariable "owner"  == WEST) then {
		sectorsBlufor pushBack _x;
	};
	if (_x getVariable "owner"  == sideUnknown) then {
		sectorsUnknown pushBack _x;
	};
} forEach sectorsAll;

//TODO put sector income
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log "-- Sectors init finished --";
};