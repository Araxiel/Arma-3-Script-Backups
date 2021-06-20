arax_fnc_pandurRespawn = {
	params [
		['_newVehicle', objNull],
		['_oldVehicle', objNull]
	];

	[
		_newVehicle,
		["showCamonetHull",0,"showBags",1,"showBags2",1,"showTools",1,"showSLATHull",0], 
		true
	] call BIS_fnc_initVehicle;

};


fnc_spawnRadar = {
	[getPos indRadarSpot, getDir indRadarSpot, "I_E_Radar_System_01_F", independent] call BIS_fnc_spawnVehicle;
};