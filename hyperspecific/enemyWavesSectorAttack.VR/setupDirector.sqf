// execVM "mission\setupDirector.sqf";
if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log '- setupDirector -';};

_assaultDirector_group = createGroup sideLogic;
assaultDirector = _assaultDirector_group createUnit ["Curator_F", [0,0,0], [], 0, "FORM"];

assaultDirector setVariable ["commandPointsBase", (missionNamespace getVariable ["_defaultCommandPoints", 50])]; // TODO set commandPointsBase somewhere else, potentially parameter, and increase over time
assaultDirector setVariable ["commandPointsCurrent", (assaultDirector getVariable "commandPointsBase")];
assaultDirector setVariable ["waveInProgress", false];
_assaultTypes = [
	"footSoldiers",
	"armedCar",
	"truck"
];
_assaultTypesWeight = [
	1,
	2,
	3
];
_assaultGroupsPool = [_assaultTypes] + [_assaultTypesWeight];
assaultDirector setVariable ["assaultGroupsPool", _assaultGroupsPool];

execVM "arx_fnc_enemyStartGarrison.sqf";

if (missionNamespace getVariable ['aDebugMessages',false]) then { diag_log '- setupDirector.sqf Done -';};