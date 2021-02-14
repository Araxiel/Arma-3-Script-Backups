diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

aDebugMessages = true;

initFunctions = {
	execVM "ar_fn_flares\ar_fn_flares.sqf";
};

[] spawn {
	while {true} do {
		[] spawn initFunctions;
		sleep 2;
	}
};

reactionGroupsOPFORArray = [];
reactionGroupsAlwaysOPFORArray = [];
//
reactionGroupsOPFORArray pushBack (group reactionLSV);
reactionGroupsAlwaysOPFORArray pushBack (group reactionHelo);
//
{
	_startingPos = getPos (leader _x);
	_x setVariable ["reactionGroupStartingPos", _startingPos];
} forEach reactionGroupsOPFORArray + reactionGroupsAlwaysOPFORArray;