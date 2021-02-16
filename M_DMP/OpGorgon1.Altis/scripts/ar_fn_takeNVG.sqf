ar_fn_takeNVG = {

	{
		if (side _x == OPFOR ) then 
		{
			_x removePrimaryWeaponItem "acc_pointer_IR";
			_x addPrimaryWeaponItem "acc_flashlight";
			_x enableGunLights "Auto";
			if !( _x getVariable ["hasNVG",false] ) then 
			{
				_x unassignItem "NVGoggles_OPFOR";
				_x removeItem "NVGoggles_OPFOR";
				_x enableGunLights "ForceOn";
			};
		};
	} forEach allUnits;

};

[] spawn ar_fn_takeNVG;