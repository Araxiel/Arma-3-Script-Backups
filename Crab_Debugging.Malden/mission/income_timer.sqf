_executeTime = 15; // 15 seconds
_count = 0;

_passive_income = {
	//params [_locationArray];

	_playercountMultiplier = 1;
	_allPlayers = call BIS_fnc_listPlayers;
	if ((count _allPlayers) >= 6) then { _playercountMultiplier = 0.50};
	_playercountMultiplier = 2-(count _allPlayers)/4;

	_crb_baseIncome = missionNamespace getVariable "crb_baseIncome";
	_crb_gainedIncome = missionNamespace getVariable "crb_gainedIncome";
	_income = _crb_baseIncome + _crb_gainedIncome;
	_income = _income * (missionNamespace getVariable "crb_incomeMultiplier") * _playercountMultiplier;

	_allPlayers = call BIS_fnc_listPlayers;
	{
		[_x, _income] call grad_moneymenu_fnc_addFunds;
	} forEach _allPlayers;

	_count = _count + 1;
	// Hint for debugging
	// hintSilent format["Income: +%1\nCount:%2",_income,_count];

};

// Clockwork
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