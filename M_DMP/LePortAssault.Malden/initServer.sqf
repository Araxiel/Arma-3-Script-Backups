diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

execVM "scripts\maintenanceTimer.sqf";
execVM "scripts\araaceFunctions.sqf";
execVM "scripts\randomWeather2.sqf";
execVM "scripts\missionScripts.sqf";
execVM "scripts\sandboxFunctions.sqf";

if ((["aDebugMessages", 1] call BIS_fnc_getParamValue) == 1) then 
{
	aDebugMessages = true;
} else {
	aDebugMessages = false;
	{
		_x setMarkerAlpha 0;
	} forEach ((getMissionLayerEntities "Debug Markers") select 1);
	{
		_x enableSimulationGlobal false;
		hideObjectGlobal _x;
	} forEach ((getMissionLayerEntities "Debug Objects") select 0);
};

_addStores = [] spawn {
	// [object,buyables set,cargospace,vehiclespawn,shopname,action description,condition,position,distance,action path,account] call grad_lbm_fnc_addInteraction
	[baseScreen,"BaseStore",baseRequistionBox,baseBuyPoint,"Requisition Menu","Requisition Equipment",{side player == independent},[0,0,0],["_distance",3],["ACE_MainActions"],independent] call grad_lbm_fnc_addInteraction;
	[heloScreen,"HelipadStore",helipadBox,helipadSpot,"Helo Requisition Menu","Requisition Helicopters",{side player == independent},[0,0,0],["_distance",3],["ACE_MainActions"],independent] call grad_lbm_fnc_addInteraction;
};

// Init global variables
private "_incomeMultiplier";
switch (["incomeMultiplier", 2] call BIS_fnc_getParamValue) do {
	case 1: { _incomeMultiplier = 0.5 };
	case 2: { _incomeMultiplier = 1 };
	case 3: { _incomeMultiplier = 1.25 };
	case 4: { _incomeMultiplier = 1.5 };
	case 5: { _incomeMultiplier = 1.2 };
	case 6: { _incomeMultiplier = 3 };
	case 7: { _incomeMultiplier = 5 };
	case 8: { _incomeMultiplier = 10 };
	default { _incomeMultiplier = 1 };
};
asb_incomeMultiplier = _incomeMultiplier;

[independent,["startingFunds", 500] call BIS_fnc_getParamValue] call grad_lbm_fnc_setFunds;

asb_defaultCRperKill = 8;

//	income TODO?
asb_baseIncome = 100;
asb_gainedIncome = 0;

// init tickets
[independent, ["startingTickets", 10] call BIS_fnc_getParamValue] call BIS_fnc_respawnTickets;