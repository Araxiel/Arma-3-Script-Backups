diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";
missionNamespace setVariable ["aDebugMessages", true];

_handle = [] execVM "ar_fnc_SoPop.sqf";
waitUntil { isNull _handle };
_handle = [] execVM "ar_fnc_SoSectors.sqf";
waitUntil { isNull _handle };
//[] execVM "ar_fnc_mapPopDebug.sqf";

//[] call fnc_SoPop_director;
// [[patrol],[guard],[station],[travel]]
//SoPopDirector setVariable ["groupsOpforTarget", [ [2],[0],[0],[0] ] ];
//[OPFOR] call fnc_SoPop_startSpawn;

_currentSector = sectorA;
_currentSector setVariable ["sides", [west,east]];
_currentSector setVariable ["sides", [west,east]];
_currentSector setVariable ["owner", east];
_currentSector setVariable ["name", "Sector Arizona"];
_currentSector setVariable ["designation", "A"];
_currentSector setVariable ["bis_fnc_addscriptedeventhandler_ownerchanged", [{[_this #0,_this #1, _this #2] spawn fnc_SOsectorCaptured}]];
_currentSector setVariable ["ownerLimit", 0.7];
_currentSector setVariable ["costInfantery", 1];
_currentSector setVariable ["costVehicle", 2];
_currentSector setVariable ["costTracked", 4];
_currentSector setVariable ["costWater", 1];
_currentSector setVariable ["costAir", 2];
_currentSector setVariable ["costPlayer", 2];

_currentSector = sectorB;
_currentSector setVariable ["sides", [west,east]];
_currentSector setVariable ["sides", [west,east]];
_currentSector setVariable ["owner", east];
_currentSector setVariable ["name", "Sector Boston"];
_currentSector setVariable ["designation", "B"];
_currentSector setVariable ["bis_fnc_addscriptedeventhandler_ownerchanged", [{[_this #0,_this #1, _this #2] spawn fnc_SOsectorCaptured}]];
_currentSector setVariable ["ownerLimit", 0.7];
_currentSector setVariable ["costInfantery", 1];
_currentSector setVariable ["costVehicle", 2];
_currentSector setVariable ["costTracked", 4];
_currentSector setVariable ["costWater", 1];
_currentSector setVariable ["costAir", 2];
_currentSector setVariable ["costPlayer", 2];