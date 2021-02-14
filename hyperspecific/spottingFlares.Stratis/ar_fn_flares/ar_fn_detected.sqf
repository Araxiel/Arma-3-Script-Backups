ar_fn_detectedFlareResponse = {
	/*	
		[thisList] spawn ar_fn_detectedFlareResponse;
		To stop: missionNameSpace setVariable ["startFlares",false];
	*/
	params [
		["_triggerList", []]
	];
	missionNameSpace setVariable ["startFlares", true];
	if ( sunOrMoon < 1 && (count _triggerList > 0) ) then {
		_randomTarget = selectRandom _triggerList;
		_mortarArray = [_randomTarget] call ar_fn_closestMortarOpfor;
		if (count _mortarArray > 0) then {
			[_mortarArray #0, _randomTarget, 200, 10, 15, 5, 180] spawn fnc_inaccurateArtyFlare;
		};
	};
};