diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

execVM "mission\income_timer.sqf";
execVM "mission\janitor_timer.sqf";
execVM "mission\sectors\sector_init.sqf";

execVM "mission\addedAceActions.sqf";
execVM "mission\enemies\enemy_killed.sqf";

// Init global variables
//	mission
crb_footholdEstablished = true;
//	director
crb_wavesRunning = false;
crb_opforGarrisonGroups = [];
crb_opforAttackGroups = [];
crb_defaultCommandPoints = 8;
crb_defaultCRperKill = 10;
//	income
crb_incomeMultiplier = 1.2;
crb_baseIncome = 100;
crb_gainedIncome = 0;