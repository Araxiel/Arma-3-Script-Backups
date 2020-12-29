//initPlayerLocal.sqf

// Just some debug action to spawn a sector
debug_sector_spawned = false;

player addAction [ "Create My Sector", {
		params [ "_target", "_caller", "_id", "_args","_location" ];	
		[[area_alpha]] execVM "mission\_sector_maker.sqf";
		debug_sector_spawned = true;
	},
	nil,
	2,
	true,
	true,
	"",
	"!debug_sector_spawned"
];