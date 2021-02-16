//
_unit = killSam2Target;
//
_usedSamArray = missionNamespace getVariable 'usedSamArray';
_usedSamArray = _usedSamArray - [_unit];
missionNamespace setVariable ["usedSamArray", _usedSamArray];

//saveGame;

[] spawn araxdmp_fnc_samKilled;