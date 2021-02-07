cbr_fnc_enemyKilled = {

	params [
		['_unit', objNull],
		['_killer', objNull],
		['_instigator', objNull]
	];

	//hint format["%1 killed\nKiller: %2\nInstigator:%3",_unit,_killer,_instigator];

	//TODO squadmembers of players, and fellow players in vehicle
	if (isPlayer _instigator) then {
		[_instigator, crb_defaultCRperKill] call grad_moneymenu_fnc_addFunds;
		if (player == _instigator) then {
			systemChat format["You got cr%1 for eliminating %2", crb_defaultCRperKill, gettext (configfile >> "CfgVehicles" >> typeOf(_unit) >> "displayName")];
		};
	};

	// return CP value back to director
	private ["_cpValue","_commandPointsCurrent"];
	_commandPointsCurrent = crb_director getVariable "commandPointsCurrent";
	_cpValue = _unit getVariable ["unitCommandPointCost", 0];
	crb_director setVariable ["commandPointsCurrent", _commandPointsCurrent + _cpValue];
};