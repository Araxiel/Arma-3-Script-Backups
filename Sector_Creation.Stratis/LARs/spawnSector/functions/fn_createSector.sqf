
if !( isServer ) exitWith {};

createCenter sideLogic;

[
	//position
	[ 500, 500, 0 ],
	//Sector Name
	"Sector 1",
	//Sector Designation
	"1"
] call LARs_fnc_spawnSector;

[
	//position
	[ 1000, 1000, 0 ],
	//Sector Name
	"Sector 2",
	//Sector Designation
	"2"
] call LARs_fnc_spawnSector;

[
	//position
	[ 1500, 1500, 0 ],
	//Sector Name
	"Sector 3",
	//Sector Designation
	"3"
] call LARs_fnc_spawnSector;

diag_log "CreateSector run!!!";