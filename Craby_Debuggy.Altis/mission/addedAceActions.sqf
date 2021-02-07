_action = ["ToAirport","Travel to Airport","",{_player setPos (getpos(airport_buyscreen));},{true}] call ace_interact_menu_fnc_createAction;
[beta_obj_buyscreen, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

action_dismiss_unit = ["Dismiss","Dismiss Unit","",{deleteVehicle _target;},{true}] call ace_interact_menu_fnc_createAction;