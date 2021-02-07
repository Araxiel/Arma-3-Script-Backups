//initPlayerLocal.sqf

// Just some debug action
debug_action = true;

player addAction [ "Create My Sector", {
		debug_action = false;
	},
	nil,
	2,
	true,
	true,
	"",
	"!debug_action"
];