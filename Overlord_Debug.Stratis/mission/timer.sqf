_executeTime = 10; // 10 seconds
_count = 0;

_passive_income = {
	//params [_locationArray];

	_base_income = missionNamespace getVariable "base_income";
	_gained_income = missionNamespace getVariable "gained_income";
	_income = _base_income + _gained_income;
	_income = _income * (missionNamespace getVariable "income_multiplier");

	_allPlayers = call BIS_fnc_listPlayers;
	{
		[_x, _income] call grad_moneymenu_fnc_addFunds;
	} forEach _allPlayers;

	_count = _count + 1;
	hintSilent format["Income: +%1\nCount:%2",_income,_count,lineBreak];

};

_realTickTime = 0; // declare the local variable for the loop compare.

while {true} do // loops for entire duration that mission/server is running.
{
	_ticksBegin = round(diag_TickTime); // tick time begin.
	if (_realTickTime >= _executeTime) then // check _realTickTime against _executeTime.
	{
		[0,0,0] call _passive_income; // call the function.
		_realTickTime = 0; // reset the timer back to 0 to allow counting to 300 again.
	};
	uiSleep 1; // sleep for one second.
	_ticksEnd = round(diag_TickTime); // tick time end.
	_ticksEndLoop = round(_ticksEnd - _ticksBegin); // get 'real' (rounded) tick time due to loop latency/calls.
	_realTickTime = _realTickTime + _ticksEndLoop; // increase the tick counter.
};