ars_fnc_enemyKilled = {

	params [
		['_unit', objNull],
		['_killer', objNull],
		['_instigator', objNull]
	];

	//TODO squadmembers of players, and fellow players in vehicle
	if (isPlayer _instigator) then {
		_gainedCR = asb_defaultCRperKill * asb_incomeMultiplier;
		[independent, _gainedCR] call grad_moneymenu_fnc_addFunds;
		if (player == _instigator) then {
			systemChat format["Your side got cr%1 for eliminating %2", asb_defaultCRperKill, gettext (configfile >> "CfgVehicles" >> typeOf(_unit) >> "displayName")];
		};
	};

};

as_acea_dismissUnit = ["Dismiss","Dismiss Unit","",{deleteVehicle _target;},{true}] call ace_interact_menu_fnc_createAction;

// teleport
_actionToHeliport = ["toHeliport","Travel to Heliport","",{_player setPos (getPos heloTeleportSpot);},{true}] call ace_interact_menu_fnc_createAction;
_actionToBase = ["toBase","Travel to Base","",{_player setPos (getPos baseTeleportSpot);},{true}] call ace_interact_menu_fnc_createAction;
_actionToDock = ["toBase","Travel to Dock","",{_player setPos (getPos dockTeleportSpot);},{true}] call ace_interact_menu_fnc_createAction;

[basePhone, 0, ["ACE_MainActions"], _actionToHeliport] call ace_interact_menu_fnc_addActionToObject;
[basePhone, 0, ["ACE_MainActions"], _actionToDock] call ace_interact_menu_fnc_addActionToObject;
[heloPhone, 0, ["ACE_MainActions"], _actionToBase] call ace_interact_menu_fnc_addActionToObject;
[heloPhone, 0, ["ACE_MainActions"], _actionToDock] call ace_interact_menu_fnc_addActionToObject;
[dockPhone, 0, ["ACE_MainActions"], _actionToHeliport] call ace_interact_menu_fnc_addActionToObject;
[dockPhone, 0, ["ACE_MainActions"], _actionToBase] call ace_interact_menu_fnc_addActionToObject;