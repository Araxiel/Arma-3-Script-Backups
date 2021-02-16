araxdmp_fnc_samChoser = {
	private ["_samKillTasksArray","_usedSamArray"];
	if (["EnableSamMission", 1] call BIS_fnc_getParamValue == 1) then {
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
		if (["EnableSamMission", 1] call BIS_fnc_getParamValue == 1) then {
			//saveGame;
		};
	};
};

araxdmp_fnc_stealthUavBomberCalled = {

	params["_unit"];

	_stealthUavBomberCalls = missionNameSpace getVariable ["stealthUavBomberCalls",0];
	_stealthUavBomberCalls = _stealthUavBomberCalls + 1 ;
	missionNameSpace setVariable ["stealthUavBomberCalls",_stealthUavBomberCalls];

};

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

arax_fnc_setMissionAmount = {
	private ["_return"];
	_param = ["SetMissionAmount", -1] call BIS_fnc_getParamValue;
	if ( _param != -1 ) then
	{
		_value = _param;
		_return = format["%1,%1",_value];
	} else 
	{
		_return = "1,3"
	};
	_return
};

arax_fnc_ArsenalBoxSpawn = {
	
};


ArsenalBox
UVHelp