// execVM "mission\setupDirector.sqf";
if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log "mission\setupDirector.sqf";
}; // debugging message

_crb_director_group = createGroup sideLogic;
crb_director = _crb_director_group createUnit ["Curator_F", [5717,6994,0], [], 0, "FORM"];

crb_wavesRunning = true;
crb_director setVariable ["commandPointsBase", (missionNamespace getVariable "crb_defaultCommandPoints")]; // TODO set commandPointsBase somewhere else, potentially parameter, and increase over time
crb_director setVariable ["commandPointsCurrent", (crb_director getVariable "commandPointsBase")];
crb_director setVariable ["currentWave", 1];
crb_director setVariable ["waveInProgress", false];
_squadTypes = [
	"footSoldiers",
	"armedCar",
	"truck"
];
_squadTypesWeight = [
	1,
	2,
	3
];
crb_director setVariable ["_squadTypes", _squadTypes];
crb_director setVariable ["_squadTypesWeight", _squadTypesWeight];

if ((missionNamespace getVariable ["debugMessages",false]) == true) then {
	diag_log "- crb_director spawned -";
}; // debugging message

execVM "mission\setupWaves.sqf";

[crb_director] spawn crb_fnc_startWaves;