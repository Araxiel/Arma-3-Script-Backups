diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

execVM "scripts\maintenanceTimer.sqf";
execVM "scripts\araaceFunctions.sqf";
execVM "scripts\missionFunctions.sqf";
execVM "scripts\ar_fn_takeNVG.sqf";
execVM "scripts\ar_fn_flares\ar_fn_flares.sqf";

if ((["aDebugMessages", 1] call BIS_fnc_getParamValue) == 1) then 
{
	aDebugMessages = true;
} else {
	aDebugMessages = false;
	{
		deleteMarker _x;
	} forEach ((getMissionLayerEntities "Debug Markers") select 1);
};