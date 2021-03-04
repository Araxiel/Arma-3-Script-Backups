fnc_spawnHellfireSpartan = {
	// [_container] call fnc_spawnHellfireSpartan;

	params [
		['_pos', objNull],
		['_dir', objNull],
		['_allowReload', true]
	];

	_hellfireSamComp = [
		["B_SAM_System_01_F",[0.144043,2.42419,-0.07481],0,1,0,[0,0],"","",true,false], //sam
		["CargoPlaftorm_01_brown_F",[0.11377,1.39087,-6.447],0,1,0,[0,0],"","",true,false],
		["Land_HBarrier_3_F",[-2.01709,3.59509,0.000189781],90,1,0,[0,-0],"","",true,false], //b left
		["Land_HBarrier_3_F",[2.31006,3.62903,0.000189781],90,1,0,[0,-0],"","",true,false], //b right
		["Land_HBarrier_5_F",[2.34863,4.95105,0.000189781],180,1,0,[0,0],"","",true,false],	//b front
		["Land_PortableGenerator_01_sand_F",[2.13916,0.73291,0.0429363],90.9469,1,0,[-0.704475,2.0866],"","",true,false],
		["Land_Laptop_03_sand_F",[2.16992,-0.0457764,0.762444],340.914,1,0,[2.2956,-0.0448662],"","",true,false]
	];

	_pos = [_pos, 0, 10, 2] call BIS_fnc_findSafePos;

	_compArray = [_pos, _dir, _hellfireSamComp] call BIS_fnc_ObjectsMapper;
	private _launcher = _compArray #0;

	createVehicleCrew _launcher;
	_launcher addWeaponTurret ["ace_hellfire_launcher_L", [0]]; 
	_launcher addMagazineTurret ["6Rnd_ACE_Hellfire_AGM114L", [0],7];
	_launcher addWeaponTurret ["ace_hellfire_launcher_N", [0]]; 
	_launcher addMagazineTurret ["6Rnd_ACE_Hellfire_AGM114N", [0],7];
	_launcher addWeaponTurret ["ace_hellfire_launcher", [0]]; 
	_launcher addMagazineTurret ["6Rnd_ACE_Hellfire_AGM114K", [0],7];
	_launcher removeWeaponTurret ["weapon_rim116Launcher", [0]]; 
	//_launcher removeMagazineTurret ["magazine_Missile_rim116_x21", [0]];
	_launcher setAutonomous false;

	[_launcher,	["Sand",1], true] call BIS_fnc_initVehicle;

	if (_allowReload) then 
	{
		reloadHellfireSam = {
			_unit = _this #0; 
			_unit setMagazineTurretAmmo ["6Rnd_ACE_Hellfire_AGM114L", 6, [0]]; 
			_unit setMagazineTurretAmmo ["6Rnd_ACE_Hellfire_AGM114N", 6, [0]]; 
			_unit setMagazineTurretAmmo ["6Rnd_ACE_Hellfire_AGM114K", 6, [0]];
		};

		reloadHellfireSamCondition = {
			_return = missionNamespace getVariable ["SamReloadAllowed", false];
			_return
		};

		_action = ["ResetHellfire","Reload Hellfire Spartan","",{ [_target] call reloadHellfireSam;},reloadHellfireSamCondition] call ace_interact_menu_fnc_createAction;
		[_launcher, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	};

	//attachments and positioning
	private _platform = _compArray #1;
	private _barrierLeft = _compArray #2;
	private _barrierRight = _compArray #3;
	private _barrierFront = _compArray #4;
	private _generator = _compArray #5;
	private _laptop = _compArray #6;

	_launcher attachTo [_platform, [0,0,5.5]];
	_barrierLeft attachTo [_platform, [-2.1,-0.1,4.5]];
	_barrierLeft setVectorDirAndUp [[1,0,0], [0,0,1]];
	_barrierRight attachTo [_platform, [2.1,-0.1,4.5]];
	_barrierRight setVectorDirAndUp [[1,0,0], [0,0,1]];
	_barrierFront attachTo [_platform, [0,2.2,4.5]];
	_generator attachTo [_platform, [1.4,-1.8,4.1]];
	_generator setVectorDirAndUp [[1,0.2,0], [0,0,1]];
	_laptop attachTo [_generator, [0.3,-0.1,0.55]];

	_platform animate ["panel_3_rotate", 2.2];

};

fnc_unpackHellfireSpartan = {
	// [] spawn fnc_unpackHellfireSpartan;
	// [_container,_player] spawn fnc_unpackHellfireSpartan;

	params [
		['_container', objNull],
		['_player', objNull]
	];
	private ['_dir','_pos'];

	if !(isNull _player) then {
		_dir = getDir _player;
	} else {
		_dir = getDir player;
	};
	if !(isNull _container) then {
		_pos = _container call BIS_fnc_position;
	} else {
		_container = nearestObject [player, "B_Slingload_01_Cargo_F"];
		_pos = _container call BIS_fnc_position;
	};

	deleteVehicle _container;
	[_pos,_dir] spawn fnc_spawnHellfireSpartan;

};

fnc_unpackHellfireSpartanStart = {
	// [_target,_player] spawn fnc_unpackHellfireSpartanStart;
	params [
		['_container', objNull],
		['_player', objNull]
	];
	[1, [], {[_container,_player] spawn fnc_unpackHellfireSpartan},{""},"Unpacking Hellfire Spartan"] call ace_common_fnc_progressBar;
};

fnc_unpackHellfireSpartanAction = ["UnpackHellfire","Unpack Hellfire Spartan","",{ [_target,_player] spawn fnc_unpackHellfireSpartanStart;},{true}] call ace_interact_menu_fnc_createAction;

fnc_debugSpawnHellfireSpartanContainer = {
	// [player] spawn fnc_debugSpawnHellfireSpartanContainer;
	params [
		['_obj', objNull]
	];
	_dir = getDir _obj;
	_pos = getPos _obj;
	_pos = [_pos, 0, 10, 2] call BIS_fnc_findSafePos;

	_container = "B_Slingload_01_Cargo_F" createVehicle _pos;
	[_container, 0, ["ACE_MainActions"], fnc_unpackHellfireSpartanAction] call ace_interact_menu_fnc_addActionToObject;
};