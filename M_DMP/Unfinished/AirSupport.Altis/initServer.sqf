diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

execVM "scripts\maintenanceTimer.sqf";
execVM "scripts\araaceFunctions.sqf";
execVM "scripts\randomWeather2.sqf";
execVM "scripts\missionScripts.sqf";

if ((["aDebugMessages", 1] call BIS_fnc_getParamValue) == 1) then 
{
	aDebugMessages = true;
} else {
	aDebugMessages = false;
	{
		_x setMarkerAlpha 0;
	} forEach ((getMissionLayerEntities "Debug Markers") select 1);
	{
		_x enableSimulationGlobal false;
		hideObjectGlobal _x;
	} forEach ((getMissionLayerEntities "Debug Objects") select 1);
};