diag_log "----------- MAP START -------------------------------------------------------------------------------------------------------------------------";

execVM "scripts\randomWeather2.sqf";
execVM "scripts\sandboxFunctions.sqf";
execVM "scripts\maintenanceTimer.sqf";
execVM "scripts\initFunctions.sqf";

{
	deleteMarker _x;
} forEach ((getMissionLayerEntities "Debug Markers") select 1);

_handleMedicalContainers = [] spawn {
	TAG_flag_medicalContainersActive = true;
	while {TAG_flag_medicalContainersActive} do {
		_containers = [];
		waitUntil {
			sleep 60;
			_containers = vehicles select {typeOf _x isEqualTo "B_Slingload_01_Medevac_F" AND alive _x};
			!(_containers isEqualTo [])
		};
		{
			_x setVariable ["ace_medical_isMedicalFacility", true, true];
		} forEach _containers;
	}
};

_addStores = [] spawn {
	// [object,buyables set,cargospace,vehiclespawn,shopname,action description,condition,position,distance,action path,account] call grad_lbm_fnc_addInteraction
	[WEST,500] call grad_lbm_fnc_setFunds;
	[storeBase,"MainStuff",arsenalBoxBase,deliverySpotBase,"Base Requisition Menu","Requisition Equipment",{side player == WEST},[0,0,0],["_distance",3],["ACE_MainActions"],WEST] call grad_lbm_fnc_addInteraction;
	[storeFOB,"MainStuff",arsenalBoxFob,deliverySpotFob,"FOB Requisition Menu","Requisition Equipment",{side player == WEST},[0,0,0],["_distance",3],["ACE_MainActions"],WEST] call grad_lbm_fnc_addInteraction;
	
	[storeAirstrip,"AirportStore",arsenalBoxAirstrip,deliverySpotAirstrip,"Airstrip Requisition Menu","Requisition Planes",{side player == WEST},[0,0,0],["_distance",3],["ACE_MainActions"],WEST] call grad_lbm_fnc_addInteraction;
};