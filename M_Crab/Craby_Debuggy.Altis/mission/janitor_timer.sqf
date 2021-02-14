_executeTime = 5; // 5 seconds
_count = 0;

_janitor = {
	crb_opforGarrisonGroups = crb_opforGarrisonGroups - [grpNull];
	crb_opforAttackGroups = crb_opforAttackGroups - [grpNull];
};

// Clockwork
_realTickTime = 0; // declare the local variable for the loop compare.

while {true} do // loops for entire duration that mission/server is running.
{
	_ticksBegin = round(diag_TickTime); // tick time begin.
	if (_realTickTime >= _executeTime) then // check _realTickTime against _executeTime.
	{
		[0,0,0] call _janitor; // call the function.
		_realTickTime = 0; // reset the timer back to 0 to allow counting to 300 again.
	};
	uiSleep 1; // sleep for one second.
	_ticksEnd = round(diag_TickTime); // tick time end.
	_ticksEndLoop = round(_ticksEnd - _ticksBegin); // get 'real' (rounded) tick time due to loop latency/calls.
	_realTickTime = _realTickTime + _ticksEndLoop; // increase the tick counter.
};