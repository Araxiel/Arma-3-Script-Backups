diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

aDebugMessages = true;

initFunctions = {
	execVM "ar_fn_flares.sqf";
};

[] spawn {
	while {true} do {
		[] spawn initFunctions;
		sleep 2;
	}
};
