diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

income_multiplier = 1.2;
base_income = 100;
gained_income = 0;
execVM "mission\income_timer.sqf";
execVM "mission\sectors\sector_init.sqf";

// Init global variables
foothold_established = true;