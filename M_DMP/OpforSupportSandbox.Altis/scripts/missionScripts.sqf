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

fnc_spawnHelicrew = {
	params ["_target", "_player", "_params"];
    group _player createUnit ["O_helicrew_F", getPos opforBaseShedSpawn, [], 0, "FORM"];
};

spawnHelicrewman = [
	"SpawnHelicrewman","Summon Helicopter Crew",
	"",
	fnc_spawnHelicrew,
	{true}
] call ace_interact_menu_fnc_createAction;

[buyScreen, 0, ["ACE_MainActions"], spawnHelicrewman] call ace_interact_menu_fnc_addActionToObject;

waitUntil { scriptDone ar_fnc_spawnInsertionSquadScript };
{
	[_x, 1, ["ACE_SelfActions"], spawnInsertionSquad] call ace_interact_menu_fnc_addActionToObject;
	[_x, 1, ["ACE_SelfActions"], tellSquadToLeave] call ace_interact_menu_fnc_addActionToObject;
} forEach [kajmanOne,kajmanTwo];