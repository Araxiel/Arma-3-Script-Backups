// execVM "ar_fnc_VlsDefender.sqf";

fnc_spawnVlsDefender = {
	/* 	
		[_pos,_dir,_allowReload] spawn fnc_spawnVlsDefender;
		Spawns a defender armed with cruise missiles
		Example:
		[_pos,_dir] spawn fnc_spawnVlsDefender;
	*/

	params [
		['_pos', [0,0,0]],
		['_dir', 0],
		['_allowReload', true]	//optional
	];

	// spawn defender
	private _spawnPos = _pos getPos [5, _dir];
	_spawnPos = [_spawnPos, 0, 3, 2] call BIS_fnc_findSafePos;
	private _defender = [_spawnPos, _dir, "B_SAM_System_03_F", WEST] call BIS_fnc_spawnVehicle;
	_defender params ["_defenderVehicle", "_defenderCrew", "_defenderGroup"]; 
	_defenderGroup deleteGroupWhenEmpty true;

	_defenderVehicle setDir _dir;

	// adds the hellfire missiles
	_defenderVehicle addWeaponTurret ["weapon_VLS_01", [0]];  
	_defenderVehicle addMagazineTurret ["magazine_Missiles_Cruise_01_x18", [0], 4]; 
	_defenderVehicle setMagazineTurretAmmo ["magazine_Missiles_Cruise_01_x18",4,[0]];  
	_defenderVehicle removeMagazineTurret ["magazine_Missile_mim145_x4", [0]];  
	_defenderVehicle removeWeaponTurret ["weapon_mim145Launcher", [0]];
	_defenderVehicle setAutonomous false;

	[_defenderVehicle,	["Sand",1], true] call BIS_fnc_initVehicle;	// gives it the sand color

	// adds the free reload action, still has the condition in reloadVlsDefenderCondition
	if (_allowReload) then 
	{
		reloadVlsDefender = {
			_unit = _this #0; 
			_unit setMagazineTurretAmmo ["magazine_Missiles_Cruise_01_x18", 4, [0]]; 
		};

		_action = ["ResetDefender","Reload VLS Defender","",{ [_target] call reloadVlsDefender;},{[_target] call reloadVlsDefenderCondition}] call ace_interact_menu_fnc_createAction;
		[_defenderVehicle, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	};
	
};

// simple check function, to see if one can reset the ammo
reloadVlsDefenderCondition = {
	_return = missionNamespace getVariable ["freeVlsDefenderReload", false];
	_return
};

fnc_unpackContainerIntoDefender = {
	/* 	
		[_target,_player] spawn fnc_unpackContainerIntoDefender
		Turns a container into a Defender. Required/intended to be called from an ACE Action.
	*/
	params ["_target", "_player"];
	
	_pos = _target call BIS_fnc_position;
	_dir = getDir _player;

	deleteVehicle _target;
	[_pos,_dir] spawn fnc_spawnVlsDefender;
};

fnc_unpackVlsDefenderDone = {
	/* 	
		Ace Progress done
	*/
	_target = _this #0 #0;
	_player = _this #0 #1;
	[_target, _player] spawn fnc_unpackContainerIntoDefender;

};

fnc_unpackVlsDefenderStart = {
	/* 	
		The ACE action's code, starting the progressbar
	*/
	params ["_target", "_player", "_params"];
	_unpackTime = 12;	// for testing reasons
	
	_target setVariable ["canBeUnpacked",false];

	[_unpackTime, [_target,_player], fnc_unpackVlsDefenderDone,{_this #0 #0 setVariable ["canBeUnpacked",true];},"Unpacking VLS Defender"] call ace_common_fnc_progressBar;
};

// simple condition check
unpackVlsDefenderActionCondition = {
	params ["_target", "_player", "_params"];
	_target getVariable ["canBeUnpacked",true];
};

// Setups the ACE action.
unpackVlsDefenderAction = [
	"UnpackDefender","Unpack VLS Defender",
	"\A3\Static_F_Sams\SAM_System_03\Data\UI\SAM_System_03_picture_CA.paa",
	fnc_unpackVlsDefenderStart,
	unpackVlsDefenderActionCondition
]	 call ace_interact_menu_fnc_createAction;

// some debug
fnc_debugSpawnVlsDefenderContainer = {
	// [player] spawn fnc_debugSpawnVlsDefenderContainer;
	params [
		['_obj', objNull]
	];
	_dir = getDir _obj;
	_pos = getPos _obj;
	private _spawnPos = _pos getPos [5, _dir];

	_container = "B_Slingload_01_Cargo_F" createVehicle _spawnPos;
	_container setDir (_dir+90);

	clearItemCargoGlobal _container;
	clearMagazineCargoGlobal _container;
	clearWeaponCargoGlobal _container;
	clearBackpackCargoGlobal _container;

	[_container, 0, ["ACE_MainActions"], unpackVlsDefenderAction] call ace_interact_menu_fnc_addActionToObject; // the actual implementation of the script
};

if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log '- VlsDefenderScripting init -';};