onGoingDetection = true;
//
reactionGroupsOPFORArray = [];
reactionGroupsAlwaysOPFORArray = [];
//
reactionGroupsOPFORArray = [reactionGroup_1,reactionGroup_2,reactionGroup_3,reactionGroup_4];
reactionGroupsAlwaysOPFORArray pushBack (group reactionHelo);
//
{
	_startingPos = getPos (leader _x);
	_x setVariable ["reactionGroupStartingPos", _startingPos];
} forEach reactionGroupsOPFORArray + reactionGroupsAlwaysOPFORArray;

//
if (missionNamespace getVariable ['aDebugMessages',false]) then {diag_log Format ['reactionGroupsOPFORArray : %1',reactionGroupsOPFORArray];};