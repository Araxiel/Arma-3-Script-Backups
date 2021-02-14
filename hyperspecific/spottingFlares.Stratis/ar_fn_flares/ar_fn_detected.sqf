ar_fn_detectedFlareResponse = {
	/*	
		[thisList,true] spawn ar_fn_detectedFlareResponse;
		To stop: missionNameSpace setVariable ["startFlares",false];

		Tiny little function put inside the activation of "Detected By Opfor" trigger.
	*/
	params [
		["_triggerList", []],
		["_reactionGroups", true]
	];

	_fnc_debugMarkers = {
		// for the debug markers
		// _debugMarker = [_debugMarkerPos, _debugMarkerType, _debugMarkercolor, _debugMarkerText] call _fnc_debugMarkers;
		// [objNull, "mil_destroy", "ColorYellow", "text"] call _fnc_debugMarkers;
		params [
			[ "_debugMarkerPos", objNull],
			[ "_debugMarkerType", "mil_destroy"],
			[ "_debugMarkercolor", "ColorYellow"],
			[ "_debugMarkerText", ""],
			[ "_debugMarkerAlpha", 0.9]
		];
		private ["_debugMarker"];

		if (missionNamespace getVariable ['aDebugMessages',false]) then {
			_debugMarkerPos = _debugMarkerPos call BIS_fnc_position;
			_debugMarkerId = round(random 50000)+100000; 
			_debugMarker = createMarker [format["_USER_DEFINED %1",_debugMarkerId], _debugMarkerPos]; 
			_debugMarker setMarkerType _debugMarkerType; 
			_debugMarker setMarkerColor _debugMarkercolor;
			_debugMarker setMarkerText _debugMarkerText;
			_debugMarker setMarkerAlpha _debugMarkerAlpha;
		};
		_debugMarker
	};

	missionNameSpace setVariable ["startFlares", true];
	if (count _triggerList > 0) then
	{
		private ["_randomTarget"];
		_randomTarget = selectRandom _triggerList;
		if ( sunOrMoon < 1) then 
		{
			_mortarArray = [_randomTarget] call ar_fn_closestMortarOpfor;
			if (count _mortarArray > 0) then 
			{
				[_mortarArray #0, _randomTarget, 200, 10, 15, 5, 180] spawn fnc_inaccurateArtyFlare;
			};
		};
		_reactionGroupsArray = missionNameSpace getVariable ["reactionGroupsOPFORArray", []]; // for now only OPFOR
		if ( _reactionGroups && (count _reactionGroupsArray > 0) ) then 
		{
			_situationPos = _randomTarget call BIS_fnc_position;
			_nearestGroup = [_reactionGroupsArray, _situationPos] call BIS_fnc_nearestPosition;	// TODO multiple units?
			_alwaysReactionGroupArray = missionNameSpace getVariable ["reactionGroupsAlwaysOPFORArray", []];
			_selectedGroupsArray = [_nearestGroup] + _alwaysReactionGroupArray;
			if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['_selectedGroupsArray : %1',_selectedGroupsArray];};
			// give them the waypoint
			{
				_wp = _x addWaypoint [_situationPos, 0];
				_wp setWaypointCompletionRadius 500;
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointSpeed "FULL";
				_wp = _x addWaypoint [_situationPos, 0]; 
				_wp setWaypointType "SAD";
				_wp setWaypointBehaviour "COMBAT";
				_startingPos = _x getVariable ["reactionGroupStartingPos", getPos (leader _x)];
				[_x, "mil_circle", "ColorYellow", "Reaction Group", 0.7] call _fnc_debugMarkers;
				_wp = _x addWaypoint [_startingPos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointSpeed "FULL";
				if ( (vehicle leader _x) isKindOf "Helicopter") then 
				{
					_wp setWaypointStatements ["true", "
						if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['- Reaction Helo %1 Returning to Base',_x];};
					"];
					_wp = _x addWaypoint [_startingPos, 0];
					_wp setWaypointType "SCRIPTED";
					_wp setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
				};
			} forEach _selectedGroupsArray;

		};
	};
};