//being run on initServer.sqf

// array with all locations
sector_locations = [
	// Phase 0
	loc_lbeach1,
	loc_lbeach2,
	loc_lbeach3,
	loc_lbeach4,
	loc_lbeach5,
	loc_strigla,
	loc_nidasos,
	// Phase 0+1
	loc_molosair,
	loc_iraklia,
	// Phase 1
	loc_molos,
	loc_sofia,
	loc_sofpp,
	// Phase 2
	loc_pefkas,
	loc_pefkas2,
	loc_almyra,
	loc_paros
];
//publicVariable "sector_locations";
// creating unlock variables
{
	// e.g. area_hangars_ownerWEST_v
	private ['_v'];
	_v = format [ "%1_ownerWEST_v", _x];
	call compile format [ "%1 = false", _v];
	//publicVariable call compile str(_v);
	_v = format [ "%1_ownerEAST_v", _x];
	call compile format [ "%1 = false", _v];
	//publicVariable call compile str(_v);
	_v = format [ "%1_ownerUNKNOWN_v", _x];
	call compile format [ "%1 = false", _v];
	//publicVariable call compile str(_v);
} forEach sector_locations;

// array with all locations
locations_phase_0 = [
	loc_lbeach1,
	loc_lbeach2,
	loc_lbeach3,
	loc_lbeach4,
	loc_lbeach5,
	loc_strigla,
	loc_nidasos
];
locations_phase_0_plus = [
	loc_molosair,
	loc_iraklia
];

locations_phase_0_and_1 = locations_phase_0 + locations_phase_0_plus;

locations_phase_1 = [
	loc_molos,
	loc_molosair,
	loc_iraklia,
	loc_sofia
];