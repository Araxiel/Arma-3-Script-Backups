missionNamespace setVariable ["aDebugMessages", true];
missionNamespace setVariable ["freeSamReload", true];
missionNamespace setVariable ["freeVlsDefenderReload", true];
execVM "ar_fnc_hellfireSpartanBox.sqf";
execVM "ar_fnc_VlsDefender.sqf";