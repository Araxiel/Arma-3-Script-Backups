diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

aDebugMessages = true;

initFunctions = {
	execVM "ar_fn_flares.sqf";
	execVM "ar_fn_closestMortarOpfor.sqf";
	execVM "ar_fn_detected.sqf";
};

[] spawn {
	while {true} do {
		[] spawn initFunctions;
		sleep 2;
	}
};
