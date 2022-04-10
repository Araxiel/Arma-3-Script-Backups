_spawnPos = homeOPFOR call BIS_fnc_position;
_spawnArea = [triggerArea homeOPFOR #0,triggerArea homeOPFOR #1];
_debugMarker = [_spawnPos, "ELLIPSE", _spawnArea, "ColorGreen", "homeOPFOR"] call fnc_mapPop_areaDebugMarker;

_spawnPos = ao call BIS_fnc_position;
_spawnArea = [triggerArea ao #0,triggerArea ao #1];
_debugMarker = [_spawnPos, "ELLIPSE", _spawnArea, "ColorRed", "ao"] call fnc_mapPop_areaDebugMarker;
