//initPlayerLocal.sqf

// Just some debug action to spawn a sector
debug_sector_spawned = false;

player addAction [ "Create My Sector", {
		params [ "_target", "_caller", "_id", "_args","_location" ];
		_returned_sectors = [[area_alpha,area_beta],-1,[10,10,0,false]] execVM "_scripts\sector_maker.sqf";
		diag_log format["Returned Sectors: %1",_returned_sectors];
		debug_sector_spawned = true;
	},
	nil,
	2,
	true,
	true,
	"",
	"!debug_sector_spawned"
];