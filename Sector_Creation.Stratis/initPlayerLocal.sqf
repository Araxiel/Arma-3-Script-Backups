
//initPlayerLocal.sqf

//Although this uses BIS_fnc_moduleSector_sectors it does not cause an error
//but does fail silently each frame due to the nature of events

//Test actions for spawning some sectors

//My test version
player addAction [ "Create My Sector", {
		params [ "_target", "_caller", "_id", "_args","_location" ];	
		[[area_hangars,area_tower,area_field]] execVM "_sector_maker.sqf";
		debug_sector_spawned = true;
	},
	nil,
	2,
	true,
	true,
	"",
	"!debug_sector_spawned"
];
/*
//Create a sector with, trigger size, capturable by west only and onOwnerChanged code
player addAction [ "Create Sector Extra", {
		params [ "_target", "_caller", "_id", "_args" ];

		[
			//position
			getPosATL _caller,
			//Sector Name
			format[ "Sector %1", count( missionNamespace getVariable [ "BIS_fnc_moduleSector_sectors", [] ] ) ],
			//Secot Designation
			format[ "%1", count( missionNamespace getVariable [ "BIS_fnc_moduleSector_sectors", [] ] ) ],
			//Trigger dimensions
			[ 5, 50, 0, true ],
			//Sides that can capture
			[ west ],
			//Default owning side
			sideUnknown,
			//Code as STRING called when sector owner changes
			"
				params[ '_sector', '_owner', '_oldOwner' ];

				if !( _owner isEqualTo sideUnknown ) then {
					format[ '%1 captured by %2 from %3', _sector, _owner, _oldOwner ] remoteExec [ 'hint', _owner ];
				};
			"
		] call LARs_fnc_spawnSector;
	}
];

//Create a sector with, trigger size, capturable by west only, onOwnerChanged code, score and task
player addAction [ "Create Sector with Tasks", {
		params [ "_target", "_caller", "_id", "_args" ];

		[
			//position
			getPosATL _caller,
			//Sector Name
			format[ "Sector %1", count( missionNamespace getVariable [ "BIS_fnc_moduleSector_sectors", [] ] ) ],
			//Secot Designation
			format[ "%1", count( missionNamespace getVariable [ "BIS_fnc_moduleSector_sectors", [] ] ) ],
			//Trigger dimensions
			[ 20, 20, 0, false ],
			//Sides that can capture
			[ west ],
			//Default owning side
			sideUnknown,
			//Code as STRING called when sector owner changes
			"
				params[ '_sector', '_owner', '_oldOwner' ];

				if !( _owner isEqualTo sideUnknown ) then {
					format[ '%1 captured by %2 from %3', _sector, _owner, _oldOwner ] remoteExec [ 'hint', _owner ];
				};
			",
			//Score reward
			10,
			//all sides other than owner receive task
			3,
			//Task title
			"Capture %1",
			//Task description
			"Capture %1 %3"
		] call LARs_fnc_spawnSector;
	}
];
*/