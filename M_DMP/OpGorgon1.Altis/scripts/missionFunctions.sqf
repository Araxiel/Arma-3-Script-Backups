araxdmp_fnc_samChoser = {
	private ["_samKillTasksArray","_usedSamArray"];
	if ((["EnableSamMission", 1] call BIS_fnc_getParamValue) == 1) then {
		_usedSamArray = [];
		_samKillTasksArray = ["killSam1In","killSam2In","killSam3In","killSam4In"];

		_rng = selectRandom [1,1,2,2,2,3];
		if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_rng : %1',_rng];};
		for "_i" from 1 to _rng do { 

			_selectedSam = "";
			_selectedSam = selectRandom _samKillTasksArray;
			_samKillTasksArray = _samKillTasksArray - [_selectedSam];
			if (missionNamespace getVariable ['aDebugMessages',false]) then {
				diag_log Format ['_selectedSam : %1',_selectedSam];
				diag_log Format ['_samKillTasksArray : %1',_samKillTasksArray];
			};

			if (_selectedSam == "killSam1In") then {
				_currentSam = killSam1Target;
				_currentSam enableSimulationGlobal true;
				_currentSam hideObjectGlobal false;
				_usedSamArray pushBack _currentSam;
			};
			if (_selectedSam == "killSam3In") then {
				_currentSam = killSam3Target;
				_currentSam enableSimulationGlobal true;
				_currentSam hideObjectGlobal false;
				_usedSamArray pushBack _currentSam;
			};
			if (_selectedSam == "killSam4In") then {
				_currentSam = killSam4Target;
				_currentSam enableSimulationGlobal true;
				_currentSam hideObjectGlobal false;
				_usedSamArray pushBack _currentSam;
			};
			if (_selectedSam == "killSam2In") then {
				_currentSam = killSam2Target;
				_currentSam enableSimulationGlobal true;
				_currentSam hideObjectGlobal false;
				_usedSamArray pushBack _currentSam;
				//killRadarTarget enableSimulationGlobal true;
				//killRadarTarget hideObjectGlobal false;
			};

			dmpGoCodes pushBack _selectedSam;
			publicVariable "dmpGoCodes";

		};
		missionNamespace setVariable ["usedSamArray", _usedSamArray];
	} else {
		missionNamespace setVariable ["safeAirspace", true];
	};
	
};

araxdmp_fnc_samKilled = {
	_usedSamArray = missionNamespace getVariable 'usedSamArray';
	if (count _usedSamArray <= 0) then {
		missionNamespace setVariable ["safeAirspace", true];
		if ((["EnableSamMission", 1] call BIS_fnc_getParamValue) == 1) then {
			//saveGame;
		};
	};
};

arax_fnc_supportCalled = {
	// [_type] call arax_fnc_supportCalled;
	// ["sentinel"] call arax_fnc_supportCalled;
	// var: "sentinalCalls"
	//
	// example condition: missionNamespace getVariable ['safeAirspace',false] && (missionNameSpace getVariable ["sentinelCalls",0]) < (["ParamMaxSentinel", 5] call BIS_fnc_getParamValue)

	params[
		["_type","sentinel"],
		["_unit",objNull]
	];

	_name = format ["%1Calls",_type];

	_callAmount = missionNameSpace getVariable [_name,0];
	_callAmount = _callAmount + 1 ;
	missionNameSpace setVariable [_name,_callAmount];
	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['%1: %2',_name,_callAmount];};

};

arax_fnc_disableUvConnection = {
	{
		_x disableUAVConnectability [destroyerHammer, true];
		_x disableUAVConnectability [destroyerVLS, true];
	} forEach call BIS_fnc_listPlayers;
};
[] spawn arax_fnc_disableUvConnection;

arax_fnc_airdropCheck = {
	private ["_return"];
	_param = ["UnsafeSupplyDrop", false] call BIS_fnc_getParamValue;
	if 
	(
		(_param == 1)
	)
		then
	{
		_return = true;
	} else 
	{
		_return = missionNamespace getVariable ['safeAirspace',false];
	};
	_return
};

arax_fnc_hideArsenalBoxSpawn = {
	private ["_param"];
	_param = ["ArsenalBox", 1] call BIS_fnc_getParamValue;
	if (_param == 0) then 
	{
		{
			deleteVehicle _x;
		} forEach [arsenalHelo, arsenalSlingload, arsenalBox];
	};
};

[] spawn arax_fnc_hideArsenalBoxSpawn;

arax_fnc_uvHelp = {
	private ["_param"];
	_param = ["UVHelp", 1] call BIS_fnc_getParamValue;
	// {"UGV Stomper","UGCV Stomper RCWS","AR-2 Darter","MQ-12 Falcon","None"};
	_deleteArray = [uvStomper,uvStomperSling,uvStomperHelo,uvStomperArmed,uvStomperArmedSling,uvStomperArmedHelo,uvFalcon];
	switch (_param) do {
		case 1: { 
			_deleteArray = _deleteArray - [uvStomper,uvStomperSling,uvStomperHelo];
		};
		case 2: { 
			_deleteArray = _deleteArray - [uvStomperArmed,uvStomperArmedSling,uvStomperArmedHelo];
		};
		case 3: { 
			reconUVOperator addBackpack "B_UAV_01_backpack_F";
		};
		case 4: { 
			_deleteArray = _deleteArray - [uvFalcon];
		};
		case 5: { };
	};

	if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_deleteArray : %1',_deleteArray];};
	{ deleteVehicle _x;	} forEach _deleteArray;

};

[] spawn arax_fnc_uvHelp;

arax_fnc_attachAceHiChemlight = {

	/*
		[_object,_attachPos,_color,_infinite, _flare] spawn arax_fnc_attachAceHiChemlight;
		[arsenalBox,[0,0,0.82],"Green"] spawn arax_fnc_attachAceHiChemlight;
		_color = "Green", "Blue", "Red", "White", "Yellow", "IR", "Orange"
		_infinite = Only works for chemlights.
		---- Flares WIP ---- _flare = Switches to flares instead. Color options for flares are: "Green", "Red", "White", "Yellow"
	*/

	params [
		["_object",objNull],
		["_attachPos",[0,0,0.82]],
		["_color","Green"],
		["_infinite",false]
		//["_flare",false]
	];
	private ["_chemcolor"];
	
	if (_infinite) then 
	{
		switch (_color) do {
			case "Green": { _chemcolor = "ACE_G_Chemlight_HiGreen_Infinite" };
			case "Blue": { _chemcolor = "ACE_G_Chemlight_HiBlue_Infinite" };
			case "Red": { _chemcolor = "ACE_G_Chemlight_HiRed_Infinite" };
			case "White": { _chemcolor = "ACE_G_Chemlight_HiWhite_Infinite" };
			case "Yellow": { _chemcolor = "ACE_G_Chemlight_HiYellow_Infinite" };
			case "IR": { _chemcolor = "ACE_G_Chemlight_IR" };
			case "Orange": { _chemcolor = "ACE_G_Chemlight_UltraHiOrange_Infinite" };
			default { _chemcolor = "ACE_G_Chemlight_HiGreen" };
		};
	} else 
	{
		switch (_color) do {
			case "Green": { _chemcolor = "ACE_G_Chemlight_HiGreen" };
			case "Blue": { _chemcolor = "ACE_G_Chemlight_HiBlue" };
			case "Red": { _chemcolor = "ACE_G_Chemlight_HiRed" };
			case "White": { _chemcolor = "ACE_G_Chemlight_HiWhite" };
			case "Yellow": { _chemcolor = "ACE_G_Chemlight_HiYellow" };
			case "IR": { _chemcolor = "ACE_G_Chemlight_IR" };
			case "Orange": { _chemcolor = "ACE_G_Chemlight_UltraHiOrange" };
			default { _chemcolor = "ACE_G_Chemlight_HiGreen" };
		};
	};

	/* WIP
	if (_flare) then 
	{
		switch (_color) do {
			case "Green": { _chemcolor = "ACE_G_Handflare_Green" };
			case "Red": { _chemcolor = "ACE_G_Handflare_Red" };
			case "White": { _chemcolor = "ACE_G_Handflare_White" };
			case "Yellow": { _chemcolor = "ACE_G_Handflare_Yellow" };
			default { _chemcolor = "ACE_G_Handflare_Green" };
		};
	};
	*/
	_chemmy = _chemcolor createVehicle getPos _object;
	_chemmy attachTo [_object,_attachPos];
};

[infiltrationHeloVehicle,[0,0,-0.1],"Red"] spawn arax_fnc_attachAceHiChemlight;