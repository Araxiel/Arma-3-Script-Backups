// Sector Capping DEBUG MISSION Init
diag_log "------------------------- MISSION START --------------------------------------------------------------------------------------------------";

sector_locations = [loc_alpha,loc_beta,loc_gamma];
unlock_varname_list = [];
{
	// e.g. area_hangars_ownerWEST_v
	private ['_v'];
	_v = format [ "%1_ownerWEST_v", _x];
	call compile format [ "%1 = false", _v];
	unlock_varname_list = unlock_varname_list + [_v];
	//publicVariable call compile str(_v);
	_v = format [ "%1_ownerEAST_v", _x];
	call compile format [ "%1 = false", _v];
	//publicVariable call compile str(_v);
	_v = format [ "%1_ownerUNKNOWN_v", _x];
	call compile format [ "%1 = false", _v];
	//publicVariable call compile str(_v);
} forEach sector_locations;