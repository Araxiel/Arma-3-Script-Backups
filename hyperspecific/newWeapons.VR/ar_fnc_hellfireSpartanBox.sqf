fnc_spawnHellfireSpartan = {
	/* 	
		[_pos,_dir,_allowReload] spawn fnc_spawnHellfireSpartan;
		Spawns a Spartan armed with ACE Hellfire missiles, ontop a platform.
		Example:
		[_pos,_dir] spawn fnc_spawnHellfireSpartan;
	*/

	params [
		['_pos', [0,0,0]],
		['_dir', 0],
		['_allowReload', true]	//optional
	];

	// spawn platform
	private _spawnPos = _pos getPos [5, _dir];
	_spawnPos = [_spawnPos, 0, 3, 2] call BIS_fnc_findSafePos;
	private _platform = "CargoPlaftorm_01_brown_F" createVehicle _spawnPos;
	_platform setDir _dir;
	_platform setPos (getPos _platform vectorAdd [0,0,-6.2]);
    _platform allowDamage false;

	[_platform] spawn {
		_platform = _this #0;
		sleep 3;
		_platform animate ["panel_3_rotate", 2.2];
	};

	// spawn spartan
	_spawnPos = [_pos, 0, 20, 2] call BIS_fnc_findSafePos;
	private _spartan = [_spawnPos, _dir, "B_SAM_System_01_F", WEST] call BIS_fnc_spawnVehicle;
	_spartan params ["_spartanVehicle", "_spartanCrew", "_spartanGroup"]; 
	_spartanGroup deleteGroupWhenEmpty true;

	_spartanVehicle setDir _dir;
	_spartanVehicle attachTo [_platform, [0,0,5.5]];

	// adds the hellfire missiles
	_spartanVehicle addWeaponTurret ["Laserdesignator_mounted", [0]]; 
	_spartanVehicle addMagazineTurret ["Laserbatteries", [0],1];
	_spartanVehicle addWeaponTurret ["ace_hellfire_launcher_L", [0]]; 
	_spartanVehicle addMagazineTurret ["6Rnd_ACE_Hellfire_AGM114L", [0],7];
	_spartanVehicle addWeaponTurret ["ace_hellfire_launcher_N", [0]]; 
	_spartanVehicle addMagazineTurret ["6Rnd_ACE_Hellfire_AGM114N", [0],7];
	_spartanVehicle addWeaponTurret ["ace_hellfire_launcher", [0]]; 
	_spartanVehicle addMagazineTurret ["6Rnd_ACE_Hellfire_AGM114K", [0],7];
	_spartanVehicle removeWeaponTurret ["weapon_rim116Launcher", [0]]; 
	_spartanVehicle removeMagazineTurret ["magazine_Missile_rim116_x21", [0]];
	_spartanVehicle setAutonomous false; // so the spartan doesn't blow its load

	[_spartanVehicle,	["Sand",1], true] call BIS_fnc_initVehicle;	// gives it the sand color

	// adds the free reload action, still has the condition in reloadHellfireSamCondition
	if (_allowReload) then 
	{
		reloadHellfireSam = {
			_unit = _this #0; 
			_unit setMagazineTurretAmmo ["6Rnd_ACE_Hellfire_AGM114L", 6, [0]]; 
			_unit setMagazineTurretAmmo ["6Rnd_ACE_Hellfire_AGM114N", 6, [0]]; 
			_unit setMagazineTurretAmmo ["6Rnd_ACE_Hellfire_AGM114K", 6, [0]];
		};

		_action = ["ResetHellfire","Reload Hellfire Spartan","",{ [_target] call reloadHellfireSam;},{[_target] call reloadHellfireSamCondition}] call ace_interact_menu_fnc_createAction;
		[_spartanVehicle, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	};

	// "decorations"
	// barrier left
	_spawnPos = [_pos, 0, 10, 2] call BIS_fnc_findSafePos;
	private _barrierLeft = "Land_HBarrier_3_F" createVehicle _spawnPos;
	_barrierLeft attachTo [_platform, [-2.1,-0.1,4.5]];
	_barrierLeft setVectorDirAndUp [[1,0,0], [0,0,1]];
	// barrier right
	_spawnPos = [_pos, 0, 10, 2] call BIS_fnc_findSafePos;
	private _barrierRight = "Land_HBarrier_3_F" createVehicle _spawnPos;
	_barrierRight attachTo [_platform, [2.1,-0.1,4.5]];
	_barrierRight setVectorDirAndUp [[1,0,0], [0,0,1]];
	// barrier front
	_spawnPos = [_pos, 0, 10, 2] call BIS_fnc_findSafePos;
	private _barrierFront = "Land_HBarrier_5_F" createVehicle _spawnPos;
	_barrierFront attachTo [_platform, [0,2.2,4.5]];
	// generator
	_spawnPos = [_pos, 0, 10, 2] call BIS_fnc_findSafePos;
	private _generator = "Land_PortableGenerator_01_sand_F" createVehicle _spawnPos;
	_generator attachTo [_platform, [2.2,-2,4.15]];
	_generator setVectorDirAndUp [[1,0.2,0], [0,0,1]];
	// laptop
	_spawnPos = [_pos, 0, 10, 2] call BIS_fnc_findSafePos;
	private _laptop = "Land_Laptop_03_sand_F" createVehicle _spawnPos;
	_laptop attachTo [_generator, [0.3,-0.1,0.55]];
    _laptop setObjectTextureGlobal [1, "a3\props_f_argo\items\electronics\data\laptop_02_screen_co.paa"]
	
};

// simple check function, to see if one can reset the ammo
reloadHellfireSamCondition = {
	_return = missionNamespace getVariable ["freeSamReload", false];
	_return
};

fnc_unpackContainerIntoSpartan = {
	/* 	
		[_target,_player] spawn fnc_unpackHellfireSpartanDone
		Turns a container into a Hellfire Spartan on a platform. Required/intended to be called from an ACE Action.
	*/
	params ["_target", "_player"];
	
	_pos = _target call BIS_fnc_position;
	_dir = getDir _player;

	deleteVehicle _target;
	[_pos,_dir] spawn fnc_spawnHellfireSpartan;
};

fnc_unpackHellfireSpartanDone = {
	/* 	
		Ace Progress done
	*/
	_target = _this #0 #0;
	_player = _this #0 #1;
	[_target, _player] spawn fnc_unpackContainerIntoSpartan;

};

fnc_unpackHellfireSpartanStart = {
	/* 	
		The ACE action's code, starting the progressbar
	*/
	params ["_target", "_player", "_params"];
	_unpackTime = 8;	// for testing reasons
	
	_target setVariable ["canBeUnpacked",false];

	[_unpackTime, [_target,_player], fnc_unpackHellfireSpartanDone,{_this #0 #0 setVariable ["canBeUnpacked",true];},"Unpacking Hellfire Spartan"] call ace_common_fnc_progressBar;
};

// simple condition check
// TODO Reloadable if vehicle ammo nearby?
unpackHellfireSpartanActionCondition = {
	params ["_target", "_player", "_params"];
	_target getVariable ["canBeUnpacked",true];
};

// Setups the ACE action.
unpackHellfireSpartanAction = [
	"UnpackHellfire","Unpack Hellfire Spartan",
	"\A3\Static_F_Jets\SAM_System_01\Data\UI\SAM_System_01_picture_CA.paa",
	fnc_unpackHellfireSpartanStart,
	unpackHellfireSpartanActionCondition
]	 call ace_interact_menu_fnc_createAction;

// some debug
fnc_debugSpawnHellfireSpartanContainer = {
	// [player] spawn fnc_debugSpawnHellfireSpartanContainer;
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

	[_container, 0, ["ACE_MainActions"], unpackHellfireSpartanAction] call ace_interact_menu_fnc_addActionToObject; // the actual implementation of the script
};

if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log '- hellfireSpartanScripting init -';};