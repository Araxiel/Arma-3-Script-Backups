
	waitUntil {!isNull player};

	fn_Draw3Dsectors = {
		_data = "";
		{
			_name = _x getVariable [ "name", "Not Set" ];
			_dist = _x distance player;
			_data = format[ "%1\n%2 - %3", _data, _name, _dist ];
		} forEach BIS_fnc_moduleSector_sectors;
		hintSilent _data;
	};


	private ["_addNew"];

	_addNew = ["BIS_id", "onEachFrame", "fn_Draw3Dsectors"] call BIS_fnc_addStackedEventHandler;

	true
