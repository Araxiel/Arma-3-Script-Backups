diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";
aDebugMessages = true;

ar_fnc_spawnInsertionSquadScript = [spawnPoint, opforBase, [flagOne,flagTwo]] execVM "scripts\ar_fnc_spawnInsertionSquad.sqf";

execVM "scripts\missionScripts.sqf";