ars_fnc_enemyKilled = {

	params [
		['_unit', objNull],
		['_killer', objNull],
		['_instigator', objNull]
	];

	//TODO squadmembers of players, and fellow players in vehicle
	if (isPlayer _instigator) then {
		[_instigator, crb_defaultCRperKill] call grad_moneymenu_fnc_addFunds;
		if (player == _instigator) then {
			systemChat format["You got cr%1 for eliminating %2", crb_defaultCRperKill, gettext (configfile >> "CfgVehicles" >> typeOf(_unit) >> "displayName")];
		};
	};
	
	if (isPlayer _instigator) then {
		[_instigator, crb_defaultCRperKill] call grad_moneymenu_fnc_addFunds;
		if (player == _instigator) then {
			systemChat format["You got cr%1 for eliminating %2", crb_defaultCRperKill, gettext (configfile >> "CfgVehicles" >> typeOf(_unit) >> "displayName")];
		};
	};

};

as_acea_dismissUnit = ["Dismiss","Dismiss Unit","",{deleteVehicle _target;},{true}] call ace_interact_menu_fnc_createAction;

_action = ["toFOB","Travel to FOB","",{_player setPos (getPos respawnFob);},{true}] call ace_interact_menu_fnc_createAction;
[storeBase, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
_action = ["toBase","Travel to Base","",{_player setPos (getPos respawnBase);},{true}] call ace_interact_menu_fnc_createAction;
[storeFOB, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;