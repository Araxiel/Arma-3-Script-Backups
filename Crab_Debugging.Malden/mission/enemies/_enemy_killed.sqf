params [
	['_unit', objNull],
	['_killer', objNull],
	['_instigator', objNull]
];

//hint format["%1 killed\nKiller: %2\nInstigator:%3",_unit,_killer,_instigator];

if (isPlayer _instigator) then {
	[_instigator, 10] call grad_moneymenu_fnc_addFunds;
	hint format["Instigator %1 got $10",_instigator];
};