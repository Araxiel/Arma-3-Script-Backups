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

addComponentsCondition = (
	([independent] call grad_lbm_fnc_getFunds) > 10
);
addComponentsResult = {
	params ["_target", "_player", "_type"];
	[side _player, -10] call grad_lbm_fnc_addFunds;
};

["Land_RepairDepot_01_green_F", 4, addComponentsCondition, addComponentsResult] execVM "scripts\ar_fnc_addComponentsActions.sqf";
addAddComponentActions = {
	params ["_target"];
	[_target, 0, ["ACE_MainActions"], addSlatAction] call ace_interact_menu_fnc_addActionToObject;
	[_target, 0, ["ACE_MainActions"], addCamoAction] call ace_interact_menu_fnc_addActionToObject;
};