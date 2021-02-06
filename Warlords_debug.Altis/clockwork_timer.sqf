_executeTime = 5; // 15 seconds

_addActionUavCrew = {

	{
		if (count crew _x == 0 ) then {
			createVehicleCrew (_x);
			(_x) setVehicleReceiveRemoteTargets true;
			(_x) setVehicleReportRemoteTargets true;
			(_x) setVehicleReportOwnPosition true;
		};
		(_x) setVehicleReceiveRemoteTargets true;
		(_x) setVehicleReportRemoteTargets true;
		(_x) setVehicleReportOwnPosition true;
	} forEach allUnitsUAV;

};

// Clockwork
_realTickTime = 0; // declare the local variable for the loop compare.

while {true} do // loops for entire duration that mission/server is running.
{
	_ticksBegin = round(diag_TickTime); // tick time begin.
	if (_realTickTime >= _executeTime) then // check _realTickTime against _executeTime.
	{
		[0,0,0] call _addActionUavCrew; // call the function.
		_realTickTime = 0; // reset the timer back to 0 to allow counting to 300 again.
	};
	uiSleep 1; // sleep for one second.
	_ticksEnd = round(diag_TickTime); // tick time end.
	_ticksEndLoop = round(_ticksEnd - _ticksBegin); // get 'real' (rounded) tick time due to loop latency/calls.
	_realTickTime = _realTickTime + _ticksEndLoop; // increase the tick counter.
};