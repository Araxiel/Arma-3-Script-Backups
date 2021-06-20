arax_fnc_kajmanRespawn = {
	params [
		['_newVehicle', objNull],
		['_oldVehicle', objNull]
	];

	[
		_newVehicle,
		["Black",1], 
		true
	] call BIS_fnc_initVehicle;

};

waitUntil { scriptDone ar_fnc_spawnInsertionSquadScript };
[kajman, 1, ["ACE_SelfActions"], spawnInsertionSquad] call ace_interact_menu_fnc_addActionToObject;
[kajman, 1, ["ACE_SelfActions"], tellSquadToLeave] call ace_interact_menu_fnc_addActionToObject;