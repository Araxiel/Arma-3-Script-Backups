params [
	['_sector', objNull],
	['_owner', sideUnknown],
	['_oldOwner', sideUnknown]
];


//if (!( _owner isEqualTo sideUnknown) && (serverTime > 5 ) ) then {	// making sure to not be an initial
if (!( _owner isEqualTo sideUnknown) && (Time > 5 ) ) then {	// making sure to not be an initial - DEBUG SINGLEPLAYER

	diag_log format ["%1 capped by %2!", _sector, _owner];	// just some debug info

	if (_oldOwner isEqualTo opfor) then {
		sectors_opfor = sectors_opfor - [_sector];		// remove from opfor array

		// progression
		if (_sector == sector_alpha) then {
			execVM "mission\sectors\alpha_capped.sqf";
		};
		if (_sector == sector_beta) then {
			execVM "mission\sectors\beta_capped.sqf";
		};
		// DEBUG, change value to be higher, and/or maybe specific sectors
		if ((count sectors_blufor) > 1) then {
			crb_footholdEstablished = true;
			execVM "mission\setup_waves.sqf";
		};
	};
	if (_oldOwner isEqualTo blufor) then {
		sectors_blufor = sectors_blufor - [_sector];	// remove from blufor array
		[_sector] execVM "mission\enemies\sector_garrison.sqf";	// spawn some guys nearby to reinforce the sector		

	};

	//	add sector to the list of owned sector by that side
	if (_owner isEqualTo blufor) then {
		sectors_blufor pushBack _sector;
	};
	if (_owner isEqualTo opfor) then {
		sectors_opfor pushBack _sector;
	};

	// check if no blufor sectors remaining
	if (count sectors_blufor == 0 && crb_footholdEstablished && (serverTime > 5 || time > 5 ) ) then {
    	["LOST_SECTORS", false] spawn BIS_fnc_endMissionServer;
	};

};